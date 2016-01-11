class NoApplesError < StandardError; end

class AppleTree
  attr_accessor :height, :age, :apples, :alive

  def initialize
    @height = 1
    @age = 0
    @apples = []
    @alive = true
  end

  def age!
    @age += 1
    if @age >= 100 then @alive = false end
    if @alive == true
      if @height < 30 then @height += 1 end
      if @age >= 5 then self.add_apples end
    end    
  end

  def add_apples
    apples_produced = rand(100..200)
    for i in 0..apples_produced
      @apples.push(Apple.new("red", rand(1.5..3.5)))
    end
  end

  def any_apples?
    if @apples.count >= 1 then true else false end
  end

  def pick_an_apple!
    raise NoApplesError, "This tree has no apples" unless self.any_apples?
     apple = @apples.shift
     apple
  end

  def dead?
    !@alive
  end
end

class Fruit
  attr_reader :has_seeds
  def initialize
    @has_seeds = true
  end
end

class Apple < Fruit
  attr_accessor :color, :diameter
  def initialize(color = "red", diameter = 2.5)
    super()
    @color = color
    @diameter = diameter
  end
end

#THERES ONLY ONE THING YOU NEED TO EDIT BELOW THIS LINE
# avg_diameter (line 58) will raise an error.
# it should calculate the diameter of the apples in the basket

def tree_data
  tree = AppleTree.new

  tree.age! until tree.any_apples?

  puts "Tree is #{tree.age} years old and #{tree.height} feet tall"

  until tree.dead?
    basket = []
    # It places the apple in the basket
    while tree.any_apples?
      basket << tree.pick_an_apple!
    end

    diameter_sum = 0

    basket.each do |apple|
      diameter_sum += apple.diameter
    end

    avg_diameter = diameter_sum / basket.count# It's up to you to calculate the average diameter for this harvest.

    puts "Year #{tree.age} Report"
    puts "Tree height: #{tree.height} feet"
    puts "Harvest:     #{basket.size} apples with an average diameter of #{avg_diameter} inches"
    puts ""

    # Ages the tree another year
    tree.age!
  end

  puts "Alas, the tree, she is dead!"
end

# Uncomment this line to run the script, but BE SURE to comment it before you try to run your tests!
 #tree_data
