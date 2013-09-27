$:.unshift(File.dirname(__FILE__))

require 'uri'
require 'active_resource'

require 'mozu_api/version'
require 'mozu_api/header_string'
require 'mozu_api/response_headers'
require 'mozu_api/connection'
require 'mozu_api/json_format'
require 'mozu_api/base'
require 'mozu_api/tenant_session'

require 'mozu_api/resources/tenant_base'
require 'mozu_api/resources/platform/applications/auth_ticket'
require 'mozu_api/resources/platform/tenants'
require 'mozu_api/resources/commerce/catalog/storefront/products'

#TODO Remove everything below
#ActiveResource::Logger = Logger.new(STDOUT)
MozuApi::Base.logger = Logger.new(STDOUT)
ActiveSupport::Notifications.subscribe("request.active_resource") do |*args|
  puts args.inspect
end