require_relative '../features_helper'

feature 'Add files to answer', %q{
	In order to illustrate my answer
	As an answer's author
	I'd like to be able to attach file
} do
	given(:user) { create :user }
	given(:question) { create :question }

	background do
		sign_in user
		visit question_path question
	end

	scenario 'User add file when answered', js: true do
		within ".answers" do
			fill_in 'Body', with: 'Test answer body'
			attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
			click_on 'Create answer'

			expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachments/file/1/spec_helper.rb'
		end		
	end
end