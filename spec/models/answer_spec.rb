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

require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject { described_class.new }

  context 'model validations and associations' do
    it { should validate_presence_of :body }
    it { should belong_to :user }
    it { should belong_to :question }
  end
end
