require 'helper'

class TestClient < Test::Unit::TestCase

  context "when configuring the client at a class level" do
    should "use the class-assigned attributes for new instances" do
      Getty.configure do |config|
        config.system_id = 'awesome'
        config.system_pwd = 'sauce'
        config.user_name = 5551234
        config.user_pwd = 5551234
      end
      client = Getty::Client.new
      client.system_id.should == 'awesome'
      client.system_pwd.should == 'sauce'
      client.user_name.should == 5551234
      client.user_pwd.should == 5551234
    end
  end

  context "when instantiating a client instance" do
    should "use the correct url for api requests" do
      @client = Getty::Client.new
      @client.api_url.should == 'https://connect.gettyimages.com/v1'
    end
  end 

end
