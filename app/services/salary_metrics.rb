class SalaryMetrics

  def initialize(params = {})
    @params = params
  end

  def fetch
    return { error: 'Provide country or job_title' } unless filter_present?

    data = query_result
    return { error: 'No data found' } if data.blank? || data['avg_salary'].blank?

    build_response(data)
  end

  private

  attr_reader :params

  def filter_present?
    params[:country].present? || params[:job_title].present?
  end

  def employees
    scope = Employee.where(country: params[:country]) if params[:country].present?
    scope = Employee.where(job_title: params[:job_title]) if params[:job_title].present?

    scope
  end

  def query_result
    if params[:country].present?
      employees.select('MIN(salary) AS min_salary, MAX(salary) AS max_salary, AVG(salary) AS avg_salary').first
    else
      employees.select('AVG(salary) AS avg_salary').first
    end
  end

  def build_response(data)
    if params[:country].present?
      {
        country: params[:country],
        min_salary: data['min_salary'].to_f,
        max_salary: data['max_salary'].to_f,
        avg_salary: data['avg_salary'].to_f
      }
    else
      {
        job_title: params[:job_title],
        avg_salary: data['avg_salary'].to_f
      }
    end
  end
end
