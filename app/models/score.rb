# == Schema Information
#
# Table name: scores
#
#  id             :integer          not null, primary key
#  question_types :string
#  response_times :integer
#  total_score    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  setting_id     :integer
#

class Score < ApplicationRecord
  belongs_to :setting 
end
