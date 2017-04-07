class Employee
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :ssn, :birthdate

  def initialize(input_options)
    @id = input_options['id']
    @first_name = input_options['fn']
    @last_name = input_options['ln']
    @email = input_options['email']
    @ssn = input_options['ssn']
    @birthdate = input_options['birthdate']
  end

  def self.find(the_id)
    employee_hash = Unirest.get("#{ENV['API_BASE_URL']}/employees/#{the_id}").body
    return Employee.new(employee_hash)
  end

  def self.all
    all_employees = Unirest.get("#{ENV['API_BASE_URL']}/employees").body
    employees_objects = []
    all_employees.each do |employee|
      employees_objects << Employee.new(employee)
    end
    employees_objects
  end


  def self.create(input_hash)
    employee = Unirest.post("#{ENV['API_BASE_URL']}/employees",
                  headers:{ "Accept" => "application/json" },
                  parameters: input_hash
                ).body
    employee
  end

  def update(input_hash)
    employee = Unirest.put("#{ENV['API_BASE_URL']}/employees/#{id}",
              headers:{ "Accept" => "application/json" },
              parameters:{ :first_name => input_hash[:first_name],
                           :email => input_hash[:email],
                           :last_name => input_hash[:last_name],
                           :birthdate => input_hash[:birthdate],
                           :ssn => input_hash[:ssn]
                         }
            ).body
  end

  def destroy
    Unirest.delete("#{ENV['API_BASE_URL']}/employees/#{id}")
  end
end




