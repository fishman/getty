# Getty API DRY mode
Example usage:

      Getty.configure do |config|
        config.system_id = 'id'
        config.system_pwd = 'pass'
        config.user_name = "username"
        config.user_pwd = "password"
      end
      @client = Getty::Client.new
      session = @client.create_session
      token =  session.CreateSessionResult.SecureToken
      search_results = @client.search(token, :query => "soccer", :limit => 1)

      image_ids = []
      search_results.Images.each do |sr|
        puts "#{sr.ImageId} #{sr.Artist} #{sr.Caption}"
        image_ids << sr.ImageId
      end

      details = @client.image_details(token, :image_ids => image_ids)
      details.GetImageDetailsResult.Images.each do |image_result|
        puts "#{image_result.Artist} #{image_result.Caption}"
      end

      authorizations = @client.largest_image_authorizations(token, :image_ids => image_ids)

      download_tokens = []
      authorizations.Images.each do |image| 
        image.Authorizations.each do |auth|
          download_tokens << auth.DownloadToken
        end
      end

      download = @client.download_image(token, :download_tokens => download_tokens)
      download.DownloadUrls.each do |url|
        puts url.UrlAttachment
      end


