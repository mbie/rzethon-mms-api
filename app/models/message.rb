# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uuid       :uuid             not null
#

class Message < ApplicationRecord
  validates :content, presence: true
end
