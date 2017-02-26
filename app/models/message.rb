# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  uuid        :uuid(16)         not null
#  content     :string           not null
#  source      :string           not null
#  destination :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Message < ApplicationRecord
  include ActiveUUID::UUID
  validates :content, :source, :destination, presence: true
  scope :current, -> { all }
end
