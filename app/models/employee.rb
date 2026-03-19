class Employee < ApplicationRecord
  validates :full_name, :job_title, :country, presence: true

  validates :salary, presence: true, numericality: { greater_than: 0 }
end
