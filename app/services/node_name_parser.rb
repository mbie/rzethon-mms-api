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
    ParserResult.new(raw_name, node_number, nodes_on_orbit_count)
  end

  private 

  def numbers_scan
    name.scan(/\d+/)
  end

  ParserResult = Struct.new(:raw_name, :node_number, :nodes_on_orbit_count)
end
