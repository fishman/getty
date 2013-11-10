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

    def largest_image_authorizations(token, options={})
      image_ids = options[:image_ids] || []
      response = connection.post do |req|
        req.url "download/GetLargestImageDownloadAuthorizations"
        req.body = {
          :RequestHeader => {
            :Token => token,
            # :CoordinationId => ""
          },
          :GetLargestImageDownloadAuthorizationsRequestBody =>  {
            :Images => image_ids.collect { |ii| { :ImageId => ii } }
            # :Images => image_ids
          }
        }

      end
      return_error_or_body(response, response.body.GetLargestImageDownloadAuthorizationsResult)
    end

    def download_image(token, options={})
      download_tokens = options[:download_tokens] || []
      response = connection.post do |req|
        req.url "download/CreateDownloadRequest"
        req.body = {
          :RequestHeader => {
            :Token => token,
            # :CoordinationId => "MyUniqueId"
          },
          :CreateDownloadRequestBody =>
          { :DownloadItems =>
            download_tokens.collect { |dt| { :DownloadToken => dt } }
          }
        }
      end
      return_error_or_body(response, response.body.CreateDownloadRequestResult)
    end

    def search(token, options={})
      query = options[:query] || ""
      limit = options[:limit] || 25
      response = connection.post do |req|
        req.url "search/SearchForImages"
        req.body = {
          :RequestHeader => { :Token => token},
          :SearchForImages2RequestBody => {
            :Query => { :SearchPhrase => query},
            :ResultOptions => {
              :ItemCount => limit,
              :ItemStartNumber => 1
            },
            :Filter => { :ImageFamilies => ["creative"] }
          }
        }
      end
      return_error_or_body(response, response.body.SearchForImagesResult)
    end
  end
end

