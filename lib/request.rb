require 'httparty'
require 'json'
require 'colorize'
require 'awesome_print'

Request = Struct.new(:method, :url, :user) do
  BASE_URL = 'https://api.clickbank.com/rest/1.3'
  def call(verbose = false)
    headers = {}
    headers['Accept'] = 'application/json'
    headers['Authorization'] = user.auth_header if user[:authorization].nil?
    headers['Authorization'] = user[:authorization] unless user[:authorization].nil?

    dest = BASE_URL + url

    res = HTTParty.send(method.downcase.to_s, dest, :headers => headers)

    json = res.code == 200 ? JSON.parse(res.body) : ''
#    if (verbose == true)
      puts "\n+++++REQUEST (begin) -----------------------------------------------------------------------------------------".yellow
      puts " Date:           #{Time.now}".blue
      puts " Test:           #{$test_title}"
      puts " Request:        #{method.upcase} #{dest}".blue
      puts " Authorization:  #{user.auth_header} ".blue
      puts ' Accept:         application/json'.blue
      puts " Result:         #{res.code} | #{res.message}".send(res.code < 299 ? :green : :red)
      if res.code.to_i == $expected_result.to_i
        result = "Good"
      else
        result = "Bad"
      end
      puts " Body: \n#{res.code == 200 ? JSON.pretty_generate(json) : res.body}".blue
      #ap res.body

      puts "+++++REQUEST (end) -------------------------------------------------------------------------------------------\n".yellow
 #   end
    return json
  end
  
end
