class Employee < ApplicationRecord
  validates :full_name, :salary, :job_title, presence: true
end
