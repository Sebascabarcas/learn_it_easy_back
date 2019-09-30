require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before { get '/users' }
    it 'should return OK' do
      # byebug
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe 'with data in the DB' do
    let!(:users) { create_list(:user, 10) }
    before { get '/users' }
    it 'should return all the users' do
      # byebug
      # get '/users'
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(users.size)
    end
  end

  describe 'GET /users/{id}' do
    let!(:user) { create(:user) }
    it 'should return all the users' do
      get "/users/#{user.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /users' do
    it 'should return OK' do
      # byebug
      req_payload = {
        user: {
          name: 'Sebastian Andres',
          first_lastname: 'Cabarcas',
          second_lastname: 'García',
          email: 'sebascabarcas@gmail.com',
          password: '123456',
          role: 'student'
        }
      }
      post '/users', params: req_payload
      payload = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(payload).to_not be_empty
    end
  end

  # describe 'PUT /users' do
  #     let!(:user){create(:user)}
  #     it 'should return OK' do
  #         get "/users/#{user.id}"
  #         # byebug
  #         payload = JSON.parse(response.body)
  #         expect(payload).to be_empty
  #         expect(response).to have_http_status(200)
  #     end
  # end
end
