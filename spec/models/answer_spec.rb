require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "Associations" do
    it { should belong_to :question }
    it { should belong_to :user }
  end

  describe "Validation" do
    it { should validate_presence_of :body }
    it { should validate_presence_of :question_id }
    it { should validate_presence_of :user_id }
    it { should validate_length_of(:body).is_at_least(10) }
    it { should allow_value(true, false).for(:is_best) }
  end
end
