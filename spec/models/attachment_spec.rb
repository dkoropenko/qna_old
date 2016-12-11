require 'rails_helper'

RSpec.describe Attachment, type: :model do
	describe Attachment do
		it { should belong_to :attachable }
	end
end
