# spec/requests/salary_metrics_spec.rb
require 'rails_helper'

RSpec.describe "SalaryMetrics", type: :request do
  describe "GET /salary_metrics" do
    it "returns salary stats for a country" do
      Employee.create!(full_name: "A", job_title: "Software Developer", country: "India", salary: 10000)
      Employee.create!(full_name: "B", job_title: "Software Engineer", country: "India", salary: 20000)

      get "/salary_metrics", params: { country: "India" }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json["min_salary"]).to eq(10000.0)
      expect(json["max_salary"]).to eq(20000.0)
      expect(json["avg_salary"]).to eq(15000.0)
    end
  end

  describe "GET /salary_metrics" do
    it "returns avg salary for job title" do
      Employee.create!(full_name: "A", job_title: "Software Engineer", country: "India", salary: 10000)
      Employee.create!(full_name: "B", job_title: "Software Engineer", country: "United States", salary: 30000)

      get "/salary_metrics", params: { job_title: "Engineer" }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json["avg_salary"]).to eq(20000.0)
    end
  end
end