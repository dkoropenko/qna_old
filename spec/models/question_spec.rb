require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "Associations" do
    it { should have_many(:answers).dependent(:destroy) }
    it { should belong_to :user }
    it { should have_many :attachments }
    it { should accept_nested_attributes_for :attachments }
  end

  describe "Validation" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :user_id }

    it { should validate_length_of(:title).is_at_least(5) }
    it { should validate_length_of(:body).is_at_least(10) }
  end

  describe 'Instance Methods' do
    let!(:user) { create :user }
    let(:another_user) { create :user }
    let(:question) { create :question, user: user }

    it 'Belongs swould be true if user owner' do
      expect(question.belongs? user).to eq true
    end

    it 'Belongs swould be false if user is not owner' do
      expect(question.belongs? another_user).to eq false
    end
  end
end
