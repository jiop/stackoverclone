require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { described_class.new }

  context 'model validations and associations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should belong_to :user }
  end
end
