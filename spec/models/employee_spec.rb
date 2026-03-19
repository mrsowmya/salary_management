# spec/models/employee_spec.rb
require 'rails_helper'

RSpec.describe Employee, type: :model do

  subject do
    described_class.new(
      full_name: 'Sowmya',
      job_title: 'Software Engineer',
      country: 'India',
      salary: 50000
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it "is invalid without full_name" do
    subject.full_name = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without salary" do
    subject.salary = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without Job Title" do
    subject.job_title = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without Country" do
    subject.country = nil
    expect(subject).not_to be_valid
  end

  it 'is expected that salary should be greater than 0' do
    subject.salary = 0
    expect(subject).not_to be_valid
  end

  it 'is expected that salary should be numeric' do
    subject.salary = 'abc'

    subject.valid?
    expect(subject.errors[:salary]).to include("is not a number")
  end
end