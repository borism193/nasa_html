require 'uri'
require 'net/http'
require 'openssl'
require 'json'
url_n = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=0&'
key = 'sGjBghxX5smgQFWXgCX4pc4qVfFLL4cHwcVabceH'


def pedir_datos(direccion,llave)
    url = URI("#{direccion}&api_key=#{llave}")
    https = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = https.request(request)

    return JSON.parse(response.read_body)
end

puts pedir_datos(url_n,key)