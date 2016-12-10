class NodeLocationService
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_location
    locations = PlanetLocator.new.position_by_date(raw_name, current_timesamp, offset)
    Location.new(*locations)
  end

  private

  def node_attributes
    @node_attributes ||= NodeNameParser.new(name).attributes
  end

  def raw_name
    node_attributes.raw_name
  end

  def current_timesamp
    (Time.now.to_f * 1000).to_i
  end

  def offset
    (node_attributes.node_number - 1) / node_attributes.nodes_on_orbit_count.to_f * Math::PI * 2
  end
end
