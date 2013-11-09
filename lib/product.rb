class Product < Request
  def byId(id)
    self.build('get', "/products/#{id}", user)
    return self.getxml    
  end

  def listAll(site, type=nil)
    url = "/products/list?site=#{site}"
    url = type == nil ? url : url +"&type=#{type}"
    self.build('get', url)
    return self.getxml    
  end

  def listRecurring(site)
    self.listAll(site, type="RECURRING")
  end

  def listStandard(site)
    self.listAll(site, type="STANDARD")
  end

#json = res.code == 200 ? JSON.parse(res.body) : ''  
end
