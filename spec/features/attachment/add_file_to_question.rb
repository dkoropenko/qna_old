require_relative '../features_helper'

feature 'Add files to question', %q{
	In order to illustrate my question
	As an question's author
	I'd like to be able to attach file
} do

	describe 'Authenticated user' do
		given(:user) { create :user }
		given!(:question) { create :question, user: user }

		before do
			sign_in user			
		end

		scenario 'User add file when asks question' do
			visit new_question_path
			fill_in 'Title', with: 'Test question title'
			fill_in 'Body', with: 'Test question body'
			attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

			click_on 'Create'

			expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
		end

		scenario 'User add file when changed question', js: true do
			visit question_path question

			click_on 'Edit question'

			within '.edit_question' do
				fill_in :question_title, with: 'New long question title'
				fill_in :question_body, with: 'New long question body'
				attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
				click_on 'Change question'

				expect(page).to_not have_selector 'textarea'
			end

			expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/2/spec_helper.rb'
		end
	end
end
