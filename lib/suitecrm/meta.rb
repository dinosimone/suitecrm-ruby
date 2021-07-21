class SuiteCRM::Meta
  class << self
    def get
      SuiteCRM::Connection.get "meta/modules", {}
    end
  end
end
