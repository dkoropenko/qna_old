require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many :questions }
    it { should have_many :answers }
  end

  describe "Validations" do
    it { should validate_presence_of :firstname }
    it { should validate_presence_of :lastname }

    it { should validate_length_of(:firstname).is_at_least(3) }
    it { should validate_length_of(:lastname).is_at_least(5) }
  end
end
