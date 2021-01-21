require 'rails_helper'

RSpec.describe "Links", type: :request do
   # initialize test data
   let!(:links) { create_list(:link, 10) }
   let(:link_id) { links.first.id }
 
   # Test suite for GET /links
   describe 'GET /links' do
     # make HTTP get request before each example
     before { get '/links' }
 
     it 'returns links' do
       # Note `json` is a custom helper to parse JSON responses
       expect(json).not_to be_empty
       expect(json.size).to eq(10)
     end
 
     it 'returns status code 200' do
       expect(response).to have_http_status(200)
     end
   end
 
   # Test suite for GET /links/:id
   describe 'GET /links/:id' do
     before { get "/links/#{link_id}" }
 
     context 'when the record exists' do
       it 'returns the link' do
         expect(json).not_to be_empty
         expect(json['_id']["$oid"]).to eq(link_id.to_s)
       end
 
       it 'returns status code 200' do
         expect(response).to have_http_status(200)
       end
     end
 
     context 'when the record does not exist' do
       let(:link_id) { 100 }
 
       it 'returns status code 404' do
         expect(response).to have_http_status(404)
       end
 
       it 'returns a not found message' do
         expect(response.body).to match(/Couldn't find Link/)
       end
     end
   end
 
   # Test suite for POST /links
   describe 'POST /links' do
     # valid payload
     let(:valid_attributes) { { title: 'Vadhiv', url: 'http://vadhiv.com' } }
 
     context 'when the request is valid' do
       before { post '/links', params: valid_attributes }
 
       it 'creates a link' do
         expect(json['title']).to eq('Vadhiv')
       end
 
       it 'returns status code 201' do
         expect(response).to have_http_status(201)
       end
     end
 
     context 'when the request is invalid' do
       before { post '/links', params: { title: 'Vadhiv' } }
 
       it 'returns status code 422' do
         expect(response).to have_http_status(422)
       end
 
       it 'returns a validation failure message' do
         expect(response.body)
           .to match(/Validation failed: URL can't be blank/)
       end
     end
   end
 
   # Test suite for PUT /links/:id
   describe 'PUT /links/:id' do
     let(:valid_attributes) { { title: 'Vadhiv' } }
 
     context 'when the record exists' do
       before { put "/links/#{link_id}", params: valid_attributes }
 
       it 'updates the record' do
         expect(response.body).to be_empty
       end
 
       it 'returns status code 204' do
         expect(response).to have_http_status(204)
       end
     end
   end
 
   # Test suite for DELETE /links/:id
   describe 'DELETE /links/:id' do
     before { delete "/links/#{link_id}" }
 
     it 'returns status code 204' do
       expect(response).to have_http_status(204)
     end
   end
end
