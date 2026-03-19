# spec/models/employee_spec.rb
require 'rails_helper'

RSpec.describe Employee, type: :model do

  it "is invalid without full_name" do
    employee = Employee.new(full_name: nil, salary: '1000000', job_title: 'Software Engineer')
    expect(employee).not_to be_valid
  end

  it "is invalid without salary" do
    employee = Employee.new(full_name: 'sowmya', salary: nil, job_title: 'Software Engineer')
    expect(employee).not_to be_valid
  end

  it "is invalid without Job Title" do
    employee = Employee.new(full_name: 'sowmya', salary: '1000000', job_title: nil)
    expect(employee).not_to be_valid
  end
 
end