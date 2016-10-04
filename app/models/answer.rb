# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true, allow_blank: false
end
