# Create a class Dessert with getters and setters for name and calories.
# The constructor should accept arguments for name and calories.

# Define instance methods healthy?, which returns true if and only
# if a dessert has less than 200 calories, and delicious?,
# which returns true for all desserts.

# Create a class JellyBean that inherits from Dessert.
# The constructor should accept a single argument giving
# the jelly bean's flavor; a newly-created jelly bean
# should have 5 calories and its name should be the flavor
# plus "jelly bean", for example, "strawberry jelly bean".

# Add a getter and setter for the flavor.

# Modify delicious? to return false if the flavor is licorice,
# but true for all other flavors. The behavior of delicious?
# for non-jelly-bean desserts should be unchanged.

# class: Dessert
# attributes: name, calories
class Dessert
  attr_accessor :name, :calories

  def initialize(name, calories)
    @name = name
    @calories = calories
  end
  def healthy?
    @calories < 200
  end
  def delicious?
    true
  end
end

class JellyBean < Dessert
  attr_reader :flavor

  def initialize(flavor)
    @flavor = flavor
    super(jellybean_name(flavor), 5)
  end

  def flavor=(new_flavor)
    @flavor = new_flavor
    @name = jellybean_name(new_flavor)
  end
  def delicious?
    true && @flavor != 'licorice'
  end

  private :jellybean_name

  def jellybean_name(flavor)
    "#{flavor} jelly bean"
  end
end

# a = Dessert.new('ice cream', 200)
#
# puts a.name
# puts a.calories
# puts a.name = 'Ice Cream'
# puts a.name
# puts a.calories
# puts a.calories = -100
# puts a.calories = 200.00
# puts a.name + ' is not healthy' unless a.healthy?
#
# b = JellyBean.new('licorice')
# puts b.name + ' is not delicious' unless b.delicious?
# b.flavor = 'ginger'
# puts b.name + ' is delicious' if b.delicious?
# b.flavor = 'licorice'
# puts b.name + ' is not delicious' unless b.delicious?
#
