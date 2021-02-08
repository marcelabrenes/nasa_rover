require 'uri'
require 'net/http'
require 'json'



def request (url,token = nil)
    url = URI("#{url}?sol=40&api_key=#{token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    return JSON.parse(response.read_body)
end

#Index HTML
def build_web_page(data_hash)
    File.open('nasa_index.html', 'w') do |file|
        photos = data_hash["photos"]
        file.puts"<html>"
        file.puts"<head>"
        file.puts"<title>Mars Curiosity Rover</title>"
        file.puts"</head>"
        file.puts"<body>"
        file.puts"<h1>Mars Rover Photos</h1>"
        file.puts"<p>The following pictures where taken by Nasa's Mars Curiosity Rover an intelligent robot with a mission:</p>"
        file.puts"<h2>Discovering if the planet can contain small forms of life!</h2>"
        photos.each do |photo|
        file.puts"<img src='#{photo["img_src"]}'/>"
        file.puts"<h3>'Camera: #{photo["camera"]["name"]}'</h3>"
        file.puts"<h3>'Id: #{photo["camera"]["id"]}'</h3>"
        end
        file.puts"</body>"
        file.puts"</html>"
    end
end

nasa_array = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=40","InquLvKQTHzsJkILdqgbxgReREqxoEx8GFgsnLxi")
puts build_web_page(nasa_array)

