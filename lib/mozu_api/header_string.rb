module MozuApi
  #Used for header strings to make case sensitive headers in request
  class HeaderString < ::String
    def downcase()
      self
    end
    
    def capitalize()
      self
    end
  end
end