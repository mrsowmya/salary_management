require 'rails_helper'

RSpec.describe "Salary Breakdown API", type: :request do

  describe "GET /employees/:id/salary_breakdown" do
    it 'calculates salary for India' do
      employee = Employee.create!(
        full_name: "Sowmya",
        job_title: "Engineer",
        country: "India",
        salary: 100000
      )

      get "/employees/#{employee.id}/salary_breakdown"

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json["tds"]).to eq(10000.0)
      expect(json["net_salary"]).to eq(90000.0)
    end

    it 'calculates salary for United States' do
      employee = Employee.create!(
        full_name: "Sowmya",
        job_title: "Engineer",
        country: "United States",
        salary: 100000
      )

      get "/employees/#{employee.id}/salary_breakdown"

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json["tds"]).to eq(12000.0)
      expect(json["net_salary"]).to eq(88000.0)
    end

    it 'calculates salary for Other Contries' do
      employee = Employee.create!(
        full_name: "Sowmya",
        job_title: "Engineer",
        country: "Japan",
        salary: 100000
      )

      get "/employees/#{employee.id}/salary_breakdown"

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json["tds"]).to eq(0)
      expect(json["net_salary"]).to eq(100000.0)
    end
  end
end