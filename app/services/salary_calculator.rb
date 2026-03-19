class SalaryCalculator

  def initialize(employee)
    @employee = employee
  end

  def calculate
    gross = @employee.salary.to_f
    tds = calculate_tds
    net_salary = gross - tds

    {
      gross_salary: gross,
      tds: tds.to_f,
      net_salary: net_salary.to_f
    }
  end

  private

  def calculate_tds
    country = @employee.country
    gross = @employee.salary

    case country
    when 'India'
      (gross * 10) / 100
    when 'United States'
      (gross * 12) / 100
    else
      0
    end
  end
end