require "spec_helper"

describe SuiteCRM::Modules do
  context "modules" do
    before do
      SuiteCRM.configure do |config|
        config.api_url = ENV["API_URL"]
        config.token_url = ENV["TOKEN_URL"]
        config.client_id = ENV["CLIENT_ID"]
        config.client_secret = ENV["CLIENT_SECRET"]
      end
    end

    it "get all modules of type" do
      VCR.use_cassette "get_all_modules_of_type", record: :none do
        create_response = SuiteCRM::Module.create({
          data: {
            type: "Contacts",
            attributes: {
              last_name: "Test Person"
            }
          }
        })
        response = SuiteCRM::Modules.get("Contacts")
        expect(response["data"].any?).to eq(true)
      end
    end
  end
end
