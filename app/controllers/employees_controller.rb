class EmployeesController < ApplicationController
  def index
    @employees = Unirest.get("http://localhost:3000/api/v1/employees").body
    render 'index.html.erb'
  end

  def show
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}").body
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    employee = Unirest.post("http://localhost:3000/api/v1/employees",
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
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}").body
    render 'edit.html.erb'
  end

  def update
    employee = Unirest.put("http://localhost:3000/api/v1/employees/#{params[:id]}",
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
    Unirest.delete("http://localhost:3000/api/v1/employees/#{params[:id]}")
    redirect_to "/employees"
  end
end
