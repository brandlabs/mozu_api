module MozuApi
  module Error
    def details()
      @details ||= {}
    end
    
    def details=(h)
      @details = h
    end
    
    def to_s()
      super().to_s() << "; Details: [#{self.details}]"
    end
  end
end