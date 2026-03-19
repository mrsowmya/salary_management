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

      employee = employees.first.id
      get "/employees/#{employee}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(employee)
    end
  end

  describe 'POST /employees' do
    it 'creates employee with valid data' do
      post '/employees', params: {
        employee: {
          full_name: 'Sowmya',
          job_title: 'Software Engineer',
          country: 'India',
          salary: '100000'
        }
      }

      expect(response).to have_http_status(:created)
    end

    it 'fails with invalid data' do
      post '/employees', params: {
        employee: {
          full_name: '',
          salary: 'abc'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT /employees/:id' do
    it 'updates employee with valid data' do
      employee = employees.last

      put "/employees/#{employee.id}", params: {
        employee: {
          job_title: 'Software Developer' 
        }
      }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['job_title']).to eq('Software Developer')
    end

    it 'fails with invalid data' do
      employee = employees.last

      put "/employees/#{employee.id}", params: {
        employee: {
          full_name: '',
          salary: 'abc'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end


end