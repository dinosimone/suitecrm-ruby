class SuiteCRM::Modules
  class << self
    def get(name, params = {})
      SuiteCRM::Connection.get "module/#{name}", params
    end
  end
end
