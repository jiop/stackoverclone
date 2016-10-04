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

require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { described_class.new }

  context 'model validations and associations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should belong_to :user }
  end
end
