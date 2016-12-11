require_relative '../features_helper'

feature 'Add files to question', %q{
	In order to illustrate my question
	As an question's author
	I'd like to be able to attach file
} do
	given(:user) { create :user }

	background do
		sign_in user
		visit new_question_path
	end

	scenario 'User add file when asks question' do
		fill_in 'Title', with: 'Test question title'
		fill_in 'Body', with: 'Test question body'
		attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

		click_on 'Create'

		expect(page).to have_content 'spec_helper.rb'
	end

end
