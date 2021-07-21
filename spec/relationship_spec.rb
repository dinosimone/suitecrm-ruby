require "spec_helper"

describe SuiteCRM::Relationship do
  context "relationship" do
    before do
      SuiteCRM.configure do |config|
        config.api_url = ENV["API_URL"]
        config.token_url = ENV["TOKEN_URL"]
        config.client_id = ENV["CLIENT_ID"]
        config.client_secret = ENV["CLIENT_SECRET"]

        @create_contact_data = {
          data: {
            type: "Contacts",
            attributes: {
              last_name: "API Tester"
            }
          }
        }

        @create_event_data = {
          data: {
            type: "FP_events",
            attributes: {
              name: "Another Fake Event"
            }
          }
        }
      end
    end

    it "gets module relationships" do
      VCR.use_cassette "gets relationships for a module", record: :none do
        create_contact_response = SuiteCRM::Module.create(@create_contact_data)
        create_event_response = SuiteCRM::Module.create(@create_event_data)
        create_relationship_response = SuiteCRM::Relationship.create(
          "Contacts",
          create_contact_response["data"]["id"],
          {
            data: {
              type: "FP_events",
              id: create_event_response["data"]["id"]
            }
          }
        )

        get_relationship_response = SuiteCRM::Relationship.get(
          "Contacts", create_contact_response["data"]["id"], "fp_events_contacts"
        )

        expect(create_relationship_response["meta"]["message"]).to eq("FP_events " \
          "with id #{create_event_response["data"]["id"]} has been added to " \
          "Contact with id #{create_contact_response["data"]["id"]}")

        expect(get_relationship_response["data"].first["type"]).to eq("FP_events")
      end
    end

    it "deletes module relationship" do
      VCR.use_cassette "deletes module relationship", record: :none do
        create_contact_response = SuiteCRM::Module.create(@create_contact_data)
        create_event_response = SuiteCRM::Module.create(@create_event_data)
        create_relationship_response = SuiteCRM::Relationship.create(
          "Contacts",
          create_contact_response["data"]["id"],
          {
            data: {
              type: "FP_events",
              id: create_event_response["data"]["id"]
            }
          }
        )
        delete_response = SuiteCRM::Relationship.delete(
          "Contacts",
          create_contact_response["data"]["id"],
          "fp_events_contacts",
          create_event_response["data"]["id"]
        )

        expect(delete_response["meta"]["message"]).to eq("Relationship has " \
          "been deleted between Contact with id " \
          "#{create_contact_response["data"]["id"]} and FP_events with id " \
          "#{create_event_response["data"]["id"]}")
      end
    end
  end
end
