# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  body       :text
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#

# Question class handles validity and storage for Questions
class Question < ApplicationRecord
  belongs_to :user

  has_many :answers

  validates :body, presence: true, allow_blank: false
  validates :title, presence: true, allow_blank: false
end
