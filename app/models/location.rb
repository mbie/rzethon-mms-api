Location = Struct.new(:location_x, :location_y, :location_z) do
  def attributes
    { location_x: location_x, location_y: location_y, location_z: location_z }
  end
end
