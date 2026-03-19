class EmployeesController < ApplicationController

  before_action :set_employee, only: [:show, :update, :destroy, :salary_breakdown]

  def index
    @employees = Employee.all

    render json: @employees
  end

  def show
    render json: @employee
  end

  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  def salary_breakdown
    result = SalaryCalculator.new(@employee).calculate

    render json: result.merge(
      employee_id: @employee.id,
      full_name: @employee.full_name,
      country: @employee.country
    )
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])
  end

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end


end