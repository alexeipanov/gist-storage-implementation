require 'rails_helper'

RSpec.describe "Fragments", type: :request do

  it "routes to #index" do
    get "/fragments"
    expect(response).to render_template(:index)
  end

  it "routes to #create" do
    post "/fragments", params: { fragment:
      { value: 'It was just drizzling still, not enough to soak me through immediately as I reached for the house key hat was always hidden under the eaves by the door, and locked up.', private: false }
    }
    expect(response).to redirect_to('/fragments/1')
  end

end
