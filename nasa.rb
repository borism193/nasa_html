require 'uri'
require 'net/http'
require 'openssl'
require 'json'

url_n = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=0'
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

puts 

def buid_web_page(fotos)
   html = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
   html_f ="#{html}</ul>\n</body>\n</html>"

end

json = pedir_datos(url_n,key)
fotos = buid_web_page(json)
File.write('fotos_nasa.html', fotos)