module MozuApi
  class TenantSession < Struct.new(:access_token, :tenant_id, :site_group_id, :site_id)
    HEADER_ACCESS_TOKEN = HeaderString.new('x-vol-app-claims').freeze()
    HEADER_TENANT_ID = HeaderString.new('x-vol-tenant').freeze()
    HEADER_SITE_GROUP_ID = HeaderString.new('x-vol-sitegroup').freeze()
    HEADER_SITE_ID = HeaderString.new('x-vol-site').freeze()
    
    def to_headers()
      headers = {
        HEADER_ACCESS_TOKEN => self.access_token.to_s(),
        HEADER_TENANT_ID => self.tenant_id.to_s(),
        HEADER_SITE_ID => self.site_id.to_s()
      }
      #"Depending on your development store's implementation, the site group header might not be required."
      headers[HEADER_SITE_GROUP_ID] = self.site_group_id.to_s() unless self.site_group_id.nil?()
      
      return headers
    end
  end
end