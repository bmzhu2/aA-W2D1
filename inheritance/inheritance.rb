class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss, employees = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end

  
end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss, employees)
    @employees = employees
    super
  end

  def bonus(multiplier)
    sum = 0
    employees.each do |emp|
      sum += emp.salary
    end

    sum * multiplier
  end

end