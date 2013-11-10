module Getty
  module Images

    def image_details(token, options={})
      image_ids = options[:image_ids] || []
      response = connection.post do |req|
      req.url "search/GetImageDetails"
      req.body = {
        :RequestHeader => {
          :Token => token
          # :CoordinationId => "MyUniqueId"
        },
        :GetImageDetailsRequestBody => {
          :CountryCode => "USA",
          :ImageIds => image_ids,
          :Language => "en-us"
        }
      }
      end
      return_error_or_body(response, response.body)
    end

  end
end

