require 'zuora'
require 'artifice'
require 'digest/md5'
require 'factory_girl'
# require "rspec"

Dir["#{File.dirname(__FILE__)}/../spec/support/**/*.rb"].sort.each { |ext| require ext }
Dir["#{File.dirname(__FILE__)}/../spec/factories/*.rb"].sort.each { |ext| require ext }

RSpec.configure do |c|
  #c.fail_fast = true
end

def generate_key
  Digest::MD5.hexdigest("#{Time.now}-#{rand}")
end

def zuora_namespace(uri)
  Zuora::Api.instance.client.soap.namespace_by_uri(uri)
end

def zns
  zuora_namespace('http://api.zuora.com/')
end

def ons
  zuora_namespace('http://object.api.zuora.com/')
end


