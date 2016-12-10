# == Schema Information
#
# Table name: nodes
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  host         :string           not null
#  location_x   :decimal(16, 12)  not null
#  location_y   :decimal(16, 12)  not null
#  location_z   :decimal(16, 12)  not null
#  refreshed_at :datetime         not null
#

class Node < ApplicationRecord
  validates :name, :host, :location_x, :location_y, :location_z, :refreshed_at, presence: true
end
