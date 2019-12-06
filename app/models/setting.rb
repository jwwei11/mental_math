# == Schema Information
#
# Table name: settings
#
#  id                :integer          not null, primary key
#  addition          :boolean
#  division          :boolean
#  lower_digit_limit :integer
#  multiplication    :boolean
#  subtraction       :boolean
#  upper_digit_limit :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  owner_id          :integer
#

class Setting < ApplicationRecord
  belongs_to :owner, :class_name => "User"
  has_many :scores, :dependent => :destroy 
end
