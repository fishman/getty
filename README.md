# Getty API DRY mode
Example usage:

      Getty.configure do |config|
        config.system_id = 'idnumber'
        config.system_pwd = 'passwordhash'
        config.user_name = "ithinkthisbemashery"
        config.user_pwd = "password"
      end
      @client = Getty::Client.new
      session = @client.create_session
      session = @client.renew_session session.CreateSessionResult.SecureToken
      token =  session.RenewSessionResult.Token
      details = @client.image_details(token, :image_ids => [102284082, 88690189])
      details.GetImageDetailsResult.Images.each do |image_result|
        puts "#{image_result.Artist} #{image_result.Caption}"
      end
