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

    
  while response.code != "200"
    puts "Error coneccion re intentando"
  end

  
  json = JSON.parse(response.read_body)

  return json["photos"].map{ |filter| filter["img_src"]} #pensaba que era solo un array dentro de un hash y era un hash dentro de um array dentro de un hash 5 horas perdidas 

end


def build_web_page(img)
  html = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
  img.each do |a|
    html += "     <li><img src='#{a}'></li>\n"
  end
  html += "</ul>\n</body>\n</html>"
  return html
end


json = pedir_datos(url_n,key)
fotos = build_web_page(json) 
File.write('fotos_nasa.html', fotos)