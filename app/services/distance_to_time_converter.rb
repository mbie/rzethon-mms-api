class DistanceToTimeConverter
  attr_reader :distance
  ASTRONOMICAL_UNIT = 149597870.7
  LIGHT_SPEED_AU = 299792.458 / ASTRONOMICAL_UNIT# /km per sec/

  def initialize(distance)
    @distance = distance
  end

  def time
    (distance / LIGHT_SPEED_AU).to_i
  end
end
