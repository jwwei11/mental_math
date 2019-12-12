# == Schema Information
#
# Table name: results
#
#  id             :integer          not null, primary key
#  correct_answer :integer
#  first_number   :integer
#  operation      :integer
#  second_number  :integer
#  user_answer    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  setting_id     :integer
#

class Result < ApplicationRecord
  validates :correct_answer, :presence => true, :numericality => { only_integer: true}
  validates :first_number, :presence => true, :numericality => { only_integer: true}
  validates :operation, :presence => true, :inclusion => { in: [0, 1, 2, 3]}
  validates :second_number, :presence => true, :numericality => { only_integer: true}
  validates :user_answer, :numericality => { only_integer: true}, :allow_nil => true
  belongs_to :setting 

end
