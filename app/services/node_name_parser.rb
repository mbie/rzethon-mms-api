class NodeNameParser
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def raw_name
    name.scan(/\b[^\d\W]+/).first.try(:downcase).try(:to_sym)
  end

  def node_number
    numbers_scan.first.to_i
  end

  def nodes_on_orbit_count
    numbers_scan.second.to_i
  end

  def attributes
    { raw_name: raw_name, node_numeber: node_numeber, nodes_on_orbit_count: nodes_on_orbit_count }
  end

  private 

  def numbers_scan
    name.scan(/\d+/)
  end
end
