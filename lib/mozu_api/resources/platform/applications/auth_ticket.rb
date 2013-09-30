module MozuApi
  module Platform
    module Applications
      class AuthTicket < Base
        self.prefix = '/api/platform/applications/'
        self.element_name = 'authtickets'
        self.schema do
          string 'refresh_token', 'access_token'
          datetime 'access_token_expiration', 'refresh_token_expiration'
        end
      
        class << self
          #
          #
          #
          #POST /api/platform/applications/authtickets/
          def create(application_id, shared_secret)
            response = post(:"", {}, {'ApplicationId' => application_id, 'SharedSecret' => shared_secret}.to_json())
            instantiate_record(format.decode(response.body))
          end
          
          #
          #
          #
          #PUT /api/platform/applications/authtickets/refresh-ticket/[refreshToken]
          def refresh(refresh_token)
            response = put(:"refresh-ticket/#{URI.parser.escape(refresh_token)}")
            instantiate_record(format.decode(response.body))
          end
          
          #
          #
          #
          #DELETE /api/platform/applications/authtickets/{refreshToken}
          def delete(refresh_token)
            delete(:"#{URI.parser.escape(refresh_token)}")
            nil
          end
        end
        
        #
        #
        #
        def refresh()
          self.load(self.class.refresh(self.refresh_token).attributes)
        end
        
        #
        #
        #
        def delete()
          self.class.delete(self.refresh_token)
        end
      end
    end
  end
end