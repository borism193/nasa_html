require 'uri'
require 'net/http'
require 'openssl'
require 'json'

def pedir_datos(direccion)
    url = URI(direccion)
    https = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = https.request(request)

    return JSON.parse(response.read_body)
end 

puts pedir_datos('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY')
