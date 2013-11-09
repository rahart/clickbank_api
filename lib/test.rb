require 'awesome_print'
require './request'
require './user'
require './product'
require './analytics'

user = User.new('DEV-KEY', 'API-KEY')
a = Analytics.new(user)
ap a
ap a.SubscriptionsCompleting("username","VENDOR", 60)
ap a.SubscriptionsCanceled("username", "VENDOR", 60)
ap a.Status


ap "======================= Products"
#p = a.listAll("username")
#ap p

#r = a.listRecurring("username")
#ap r

#s = a.listStandard("username")
#ap s
