module MozuApi
  module Tenant
    class Base < MozuApi::Base
      class << self
        #
        # 
        #
        def tenant_session()
          if defined?(@tenant_session)
            @tenant_session
          elsif superclass != Object && superclass.tenant_session
            superclass.tenant_session
          else
            nil
          end
        end
        
        #
        # Assign current session
        #
        def tenant_session=(s)
          raise ArgumentError unless s.nil?() || s.is_a?(TenantSession)
          @tenant_session = s || TenantSession.new()
          
          #Push in additional headers
          self.headers.merge!(@tenant_session.to_headers())
          
          #Change the site URL based on the current tenant session
          if @tenant_session.tenant_id.nil?()
            self.site = ''
          else
            site = MozuApi::Base.site.dup()
            site.host = "t#{@tenant_session.tenant_id}.#{site.host}"
            self.site = site.to_s()
          end
        end
        
        #
        # Temporarily use session within block and revert to original when done
        #
        def temp(tenant_session, &block)
          original = self.tenant_session
          begin
            self.tenant_session = tenant_session
            yield
          ensure
            self.tenant_session = original
          end
        end
      end
      
      self.tenant_session = nil #Initialize
    end
  end
end