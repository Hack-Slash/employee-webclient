class EmployeesController < ApplicationController
  def index
    @employees = Unirest.get("#{ENV['API_BASE_URL']}/employees").body
    render 'index.html.erb'
  end

  def show
    # employee_hash = Unirest.get("#{ENV['API_BASE_URL']}/employees/#{params[:id]}").body
    # @employee =
    @employee = Employee.new(employee_hash)
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    employee = Unirest.post("#{ENV['API_BASE_URL']}/employees",
                  headers:{ "Accept" => "application/json" },
                  parameters:{ :first_name => params[:input_first_name],
                               :email => params[:input_email],
                               :last_name => params[:input_last_name],
                               :birthdate => params[:input_birthdate],
                               :ssn => params[:input_ssn]
                             }
                ).body

    redirect_to "/employees/#{employee['id']}"
  end

  def edit
    @employee = Unirest.get("#{ENV['API_BASE_URL']}/employees/#{params[:id]}").body
    render 'edit.html.erb'
  end

  def update
    employee = Unirest.put("#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
              headers:{ "Accept" => "application/json" },
              parameters:{ :first_name => params[:input_first_name],
                           :email => params[:input_email],
                           :last_name => params[:input_last_name],
                           :birthdate => params[:input_birthdate],
                           :ssn => params[:input_ssn]
                         }
            ).body
    redirect_to "/employees/#{employee['id']}"
  end

  def destroy
    # grab the employee
    # destroy the employee
    Unirest.delete("#{ENV['API_BASE_URL']}/employees/#{params[:id]}")
    redirect_to "/employees"
  end
end
