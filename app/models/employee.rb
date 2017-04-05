class Employee
  attr_accessor :id, :first_name, :last_name, :email, :ssn, :birthdate

  def initialize(input_options)
    @id = input_options['id']
    @first_name = input_options['fn']
    @last_name = input_options['ln']
    @email = input_options['email']
    @ssn = input_options['ssn']
    @birthdate = input_options['birthdate']
  end

  def self.find(the_id)
    # return ... an instance of the class employee
    employee_hash = Unirest.get("#{ENV['API_BASE_URL']}/employees/#{the_id}").body
    return Employee.new(employee_hash)
  end
end
