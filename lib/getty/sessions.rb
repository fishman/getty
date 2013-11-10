module Getty
  module Sessions

    def create_session
      response = connection.post do |req|
        req.url "session/CreateSession"
        req.body = {
          :RequestHeader =>
          {
            :Token => ""
          },
          :CreateSessionRequestBody =>
          {
            :SystemId => Getty.system_id,
            :SystemPassword => Getty.system_pwd,
            :UserName => Getty.user_name,
            :UserPassword => Getty.user_pwd
          }
        }
      end
      return_error_or_body(response, response.body.CreateSessionResult)
    end

    def renew_session(token)
      response = connection.post do |req|
        req.url "session/RenewSession"
        req.body = {
          :RequestHeader =>
          {
            :Token => token
          },
          :RenewSessionRequestBody =>
          {
            :SystemId => Getty.system_id,
            :SystemPassword => Getty.system_pwd
          }
        }
      end
      return_error_or_body(response, response.body.RenewSessionResult)
    end
  end
end

