require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "Associations" do
    it { should belong_to :question }
    it { should belong_to :user }
    it { should have_many :attachments }
  end

  describe "Validation" do
    it { should validate_presence_of :body }
    it { should validate_presence_of :question_id }
    it { should validate_presence_of :user_id }
    it { should validate_length_of(:body).is_at_least(10) }
    it { should allow_value(true, false).for(:is_best) }
    it { should accept_nested_attributes_for :attachments }
  end

  describe 'Instance Methods' do
    let!(:user) { create :user }
    let!(:question) {create :question}

    let(:answer) { create :answer, user: user, question: question }
    let(:another_answer) { create :answer, question: question }    

    it 'Belongs should be true if user owner' do
      expect(answer.belongs?user).to eq true
    end

    it 'Belongs should be false if user is not owner' do
      second_user = create :user
      expect(answer.belongs?second_user).to eq false
    end

    it 'Make asnwer best' do
      expect(answer.is_best).to eq false
      answer.make_best!
      expect(answer.reload.is_best).to eq true
    end

    it 'Make another asnwer best' do
      expect(answer.is_best).to eq false
      answer.make_best!
      expect(answer.reload.is_best).to eq true

      expect(another_answer.is_best).to eq false
      another_answer.make_best!
      expect(answer.reload.is_best).to eq false
      expect(another_answer.reload.is_best).to eq true
    end
  end
end
