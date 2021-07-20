class SuiteCRM::Relationship
  class << self
    def get(name, id, related)
      SuiteCRM::Connection.get "module/#{name}/#{id}/relationships/#{related}", {}
    end

    def create(name, id, params)
      SuiteCRM::Connection.post "module/#{name}/#{id}/relationships", params
    end

    def delete(name, id, related, related_id)
      SuiteCRM::Connection.delete "module/#{name}/#{id}/relationships/#{related}/#{related_id}"
    end
  end
end
