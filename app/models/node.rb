# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  host       :string           not null
#  location_x :decimal(16, 12)  not null
#  location_y :decimal(16, 12)  not null
#  location_z :decimal(16, 12)  not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Node < ApplicationRecord
  validates :name, :host, :location_x, :location_y, :location_z, presence: true

  def location
    Location.new(location_x, location_y, location_z)
  end

  def as_json(options={})
    {
      name: name,
      host: host,
      location: {
        x: location_x,
        y: location_y,
        z: location_z,
      }
    }
  end
end
