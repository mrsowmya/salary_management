require 'rails_helper'

RSpec.describe "Employees API", type: :request do

  let!(:employees) do
    3.times.map do
      Employee.create!(
        full_name: 'Test User',
        job_title: 'Software Engineer',
        country: 'India',
        salary: 4000000
      )
    end
  end

  describe 'GET /employees' do
    it 'returns all the employees' do

      get '/employees'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /employees/:id' do
    it 'returns employee' do

      get "/employees/#{employees.first.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(employees.first)
    end
  end


end