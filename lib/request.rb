require 'httparty'

class Request 

  def initialize(user)
    @user = user
    @base_url  = 'https://api.clickbank.com/rest/1.3'
  end 

  def build(method, url)
    @method = method
    @url = url
  end

  def t
    puts @method
    puts @url
    puts @user
    puts @base_url
  end

  def call(accept)
    headers = {}
    headers['Accept'] = accept
    headers['Authorization'] = @user.auth_header if @user[:authorization].nil?
    headers['Authorization'] = @user[:authorization] unless @user[:authorization].nil?
    dest = @base_url + @url
    res = HTTParty.send(@method.downcase.to_s, dest, :headers => headers)
    return res
  end

  def getjson
    res = self.call('application/json')
    json = res.code == 200 ? JSON.parse(res.body) : ''
    return json
  end

  def getxml
    res = self.call('application/xml')
    return res
  end

  def getcvs
    res = self.call('text/csv')
    return res
  end

end
