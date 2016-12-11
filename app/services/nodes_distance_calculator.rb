class NodesDistanceCalculator
  attr_reader :node_1, :node_2

  def initialize(node_1, node_2)
    @node_1 = node_1.location
    @node_2 = node_2.location
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    sum_of_powers = [power_of_x_substraction, power_of_y_substraction, power_of_z_substraction].reduce(:+)
    Math.sqrt(sum_of_powers)
  end

  private

  %w(x y z).each do |location_point|
    define_method("power_of_#{location_point}_substraction") do 
      (node_2.public_send("location_#{location_point}") - node_1.public_send("location_#{location_point}"))**2
    end
  end
end
