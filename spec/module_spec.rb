require "spec_helper"

describe SuiteCRM::Module do
  context "module" do
    before do
      SuiteCRM.configure do |config|
        config.api_url = ENV["API_URL"]
        config.token_url = ENV["TOKEN_URL"]
        config.client_id = ENV["CLIENT_ID"]
        config.client_secret = ENV["CLIENT_SECRET"]

        @create_data = {
          data: {
            type: "Contacts",
            attributes: {
              last_name: "API Tester"
            }
          }
        }
      end
    end

    it "gets a specific module" do
      VCR.use_cassette "gets a specific module", record: :none do
        create_response = SuiteCRM::Module.create(@create_data)
        get_response = SuiteCRM::Module.get("Contacts", create_response["data"]["id"])
        expect(get_response["data"]["type"]).to eq("Contact")
      end
    end

    it "creates a module" do
      VCR.use_cassette "creates a module", record: :none do
        response = SuiteCRM::Module.create(@create_data)
        expect(response["data"]["attributes"]["name"]).to eq("API Tester")
      end
    end

    it "updates a module" do
      VCR.use_cassette "updates a module", record: :none do
        create_response = SuiteCRM::Module.create(@create_data)
        response = SuiteCRM::Module.update({
          data: {
            type: "Contacts",
            id: create_response["data"]["id"],
            attributes: {
              last_name: "API Tester 2"
            }
          }
        })
        expect(response["data"]["attributes"]["name"]).to eq("API Tester 2")
      end
    end

    it "deletes a module" do
      VCR.use_cassette "deletes a module", record: :none do
        create_response = SuiteCRM::Module.create(@create_data)
        response = SuiteCRM::Module.delete("Contacts", create_response["data"]["id"])
        expect(response["meta"]["message"]).to eq("Record with id #{create_response["data"]["id"]} is deleted")
      end
    end
  end
end
