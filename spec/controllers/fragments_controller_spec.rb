require 'rails_helper'
require 'support/factory_bot'

RSpec.describe FragmentsController, type: :controller do
  let(:valid_attributes) { build :fragment }

  let(:invalid_attributes) { build :fragment, value: nil, private: nil }

  describe 'GET #index' do
    it 'returns a success response' do
      Fragment.create! valid_attributes.attributes
      get :index, params: {}
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      fragment = Fragment.create! valid_attributes.attributes
      get :show, params: { id: fragment.id }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Fragment' do
        expect { post :create, params: { fragment: valid_attributes.attributes } }.to change(Fragment, :count).by(1)
      end

      it 'renders a JSON response with the new collection' do
        post :create, params: { fragment: valid_attributes.attributes }, format: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(fragment_url(Fragment.last))
      end

      it 'renders a HTML response with the new collection' do
        post :create, params: { fragment: valid_attributes.attributes }, format: :html
        expect(response.content_type).to eq('text/html')
        expect(response.location).to eq(fragment_url(Fragment.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new collection' do
        post :create, params: { fragment: invalid_attributes.attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end

      it 'renders a HTML response with errors for the new collection' do
        post :create, params: { fragment: invalid_attributes.attributes }, format: :html
        expect(response.location).to eq(nil)
        expect(response.content_type).to eq('text/html')
      end
    end
  end
end
