class Analytics < Request

  def SubscriptionsCompleting(account, role, days)
    if days == 60
      comp = "compsixty"
    elsif days == 30
      comp = "compthirty"
    else
      abort("Days must be 60 or 30")
    end

    url = "/analytics/#{role}/subscription/details/#{comp}?account=#{account}"
    self.build('get', url)
    return self.getxml
  end  

  def SubscriptionsCanceled(account, role, days)
    if days == 60
      cancel = "cancelsixty"
    elsif days == 30
      cancel = "cancelthirty"
    else
      abort("Days must be 60 or 30")
    end

    url = "/analytics/#{role}/subscription/details/#{cancel}?account=#{account}"
    self.build('get', url)
    return self.getxml
  end  

  def Status
    url = "/analytics/status"
    self.build('get', url)
    return self.getxml
  end
  
end
