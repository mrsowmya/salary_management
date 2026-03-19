class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :full_name
      t.string :job_title
      t.string :country
      t.decimal :salary, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
