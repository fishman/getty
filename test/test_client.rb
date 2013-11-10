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

    should "create session" do
      Getty.configure do |config|
        config.system_id = '10799'
        config.system_pwd = 'vMK8LPFBcaA0JWug3VReKcN45TtzCVtqWjnuLcHbyF0='
        config.user_name = "seedhacklon_api"
        config.user_pwd = "HJARZH1p7awxi68"
      end
      @client = Getty::Client.new
      session = @client.create_session
      session = @client.renew_session session.CreateSessionResult.SecureToken
      token =  session.RenewSessionResult.Token
      details = @client.image_details(token, :image_ids => [102284082, 88690189])
      details.GetImageDetailsResult.Images.each do |image_result|
        puts "#{image_result.Artist} #{image_result.Caption}"
      end
    end
  end 

end
