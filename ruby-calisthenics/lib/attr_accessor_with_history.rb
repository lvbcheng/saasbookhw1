class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name # create the attribute's getter
    attr_reader attr_name+"_history" # create bar_history getter
    class_eval %Q{
      def #{attr_name}=(value)
        unless defined? @#{attr_name}_history
          @#{attr_name}_history = [@#{attr_name}]
        else
          @#{attr_name}_history << @#{attr_name}
        end
        @#{attr_name} = value
      end
    }
  end
end

class Person
  attr_accessor_with_history :name
  def initialize(name, address)
    @name = name
    @address = address
  end
end

def test_attr_accessor_with_history
  a = Person.new('Bob', 'North Carolina')
  b = Person.new('Grant', 'South Carolina')
  puts "History is not nil on first use" unless a.name_history.nil?
  a.name = 'Bobby'
  puts "Name is unexpected after first change" unless a.name == 'Bobby'
  puts "History did not log name change" unless a.name_history == ['Bob']
  a.name = "Robert"
  puts "Name is unexpected after second change" unless a.name == 'Robert'
  puts 'History did not log second name change' unless a.name_history == ['Bob', 'Bobby']
  puts "Name history not private to the instance" unless b.name_history.nil?
  b.name = 'Garrett'
  puts "History does not affect a second instance" unless b.name_history == ['Grant']
  puts "Write does not return name" unless ((b.name = 'Garrison') == 'Garrison')
  b.name = nil
  b.name = 'Gordon'
  puts "History does not affect a second instance" unless b.name_history == ['Grant', 'Garrett','Garrison', nil]
end

test_attr_accessor_with_history

