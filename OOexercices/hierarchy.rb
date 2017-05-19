

=begin

Question 16
This exercise asks you to come up with a class design for a fake "Employee Management Application."

An employee management application has information about the employees in the company; all have a name,
a serial number, and are either full-time or part-time.

All executives and managers are full-time employees. Regular employees are Full-time employees that are
neither an executive nor a manager.

Executives receive 20 days of vacation, while managers receive 14 days. Regular employees receive 10 days
of vacation. Part-time employees get no vacation.

Full-time employees should have a #take_vacation method. Part-time employees don't have this method.

Executives work at a desk in a corner office. Managers work at a desk in a regular private office.
Regular employees have a desk in the cubicle farm. Part-time employees work in an open workspace with no reserved desk.

Managers and executives can delegate work, while other employees can not. Your program should be able
to call a #delegate method on any manager or executive; no other employees should have a #delegate method.

If you pass an employee instance to #puts, it should print information about the employee in this format:

Name: Dave
Type: Manager
Serial number: 123456789
Vacation days: 14
Desk: private office
Create a set of classes based on the description of the employee management application.
Your classes should show any inheritance relationships, module inclusions, and methods
necessary to meet the requirements.

This exercise is about designing class relationships, and how you organize your classes,
behaviors, and state. Your methods should provide the details needed to fulfill the requirements.
In some cases, you may be able to omit the method body entirely. Don't include any functionality
that we don't describe above. In particular, you don't need to show the code that fetches, adds,
deletes, or updates employees.

=end

module Vacationable
  def take_vacation
    "#{self.vacation_days} days of leave taken"
  end
end

module Delegable
  def delegate
  end
end

class Employee
  attr_reader :name, :serial_number
  def initialize(name, serial_number)
    @name =name
    @serial_number = serial_number
  end

  def to_s
    puts "Name : #{self.name}"
    puts "Type : #{self.type}"
    puts "Serial number : #{self.serial_number}"
    puts "Vacation days : #{self.vacation_days}"
    puts "desk : #{self.desk}"
  end
end

class PartTimeEmployee < Employee
  attr_reader :type
  def initialize(name, serial_number)
    super
    @type = :part_time
    @desk = "open workspace"
  end
end

class FullTimeEmployee < Employee
  attr_reader :vacation_days, :desk
  include Vacationable
end

class Executive < FullTimeEmployee
  include Delegable
  def initialize(name, serial_number)
    super
    @vacation_days = 20
    @type = :executive
    @desk = 'desk in a corner'
  end
end

class Manager < FullTimeEmployee
  include Delegable
  def initialize(name, serial_number)
    @vacation_days = 14
    @type = :manager
    @desk = 'desk in a regular private office'
  end
end

class RegularEmployee < FullTimeEmployee
  def initialize(name, serial_number)
    @vacation_days = 14
    @type = :regular
    @desk = 'desk in a cubicle farm'
  end
end