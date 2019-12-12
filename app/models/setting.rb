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
  validates :addition, :presence => true, :inclusion => { in: [true, false] }
  validates :division, :presence => true, :inclusion => { in: [true, false] }
  validates :multiplication, :presence => true, :inclusion => { in: [true, false] }
  validates :subtraction, :presence => true, :inclusion => { in: [true, false] }
  validates :lower_digit_limit, :presence => true, :numericality => { only_integer: true, less_than: 9}
  validates :upper_digit_limit, :presence => true, :numericality => { only_integer: true, greater_than:  10}
  validates :owner_id, :presence => true, :numericality => {only_integer}
  belongs_to :owner, :class_name => "User"
  has_many :results, :dependent => :destroy 
end
