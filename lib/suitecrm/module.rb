class SuiteCRM::Module
  class << self
    def get(name, id, params = {})
      SuiteCRM::Connection.get "module/#{name}/#{id}", params
    end

    def create(params)
      SuiteCRM::Connection.post "module", params
    end

    def update(params)
      SuiteCRM::Connection.patch "module", params
    end

    def delete(name, id)
      SuiteCRM::Connection.delete "module/#{name}/#{id}"
    end
  end
end
