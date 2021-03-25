require 'uri'
require 'net/http'
require 'openssl'
require 'json'

url_n = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=0["photos"]'
key = 'sGjBghxX5smgQFWXgCX4pc4qVfFLL4cHwcVabceH'


def pedir_datos(direccion,llave)
    url = URI("#{direccion}&api_key=#{llave}")
    https = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = https.request(request)

    json = JSON.parse(response.read_body)
    return json["photos"].map{ |filter| filter["img_src"]}
    
end


def build_web_page(img)
  html = "<html>\n<head>\n</head>\n<body>\n<ul>"
  html += "</ul>\n</body>\n</html>"
  return html
end


#build_web_page(pedir_datos(url,key))
json = pedir_datos(url_n,key)
#fotos = build_web_page(json) 
#File.write('fotos_nasa.html', fotos)
