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
  belongs_to :setting 
end
