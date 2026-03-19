class EmployeesController < ApplicationController

  before_action :set_employee, only: [:show]

  def index
    @employees = Employee.all

    render json: @employees
  end

  def show
    render json: @employee
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])
  end


end