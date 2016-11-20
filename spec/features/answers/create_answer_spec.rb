require 'rails_helper'

feature 'Create new Answer', %q{
  When user visit current question
  and if he log in!
  He can write new answer for question
} do

  given(:user) { create :user }
  given(:question) { create :question }

  scenario 'Authenticated user create new answer for questions' do
    sign_in user

    visit question_path question
    fill_in 'Body', with: 'New answer body'
    click_button 'Create answer'

    expect(page).to have_current_path question_path question
    expect(page).to have_text 'New answer body'
  end
  scenario 'Non authenticated user can not create new answer for questions' do
    visit question_path question

    expect(page).to_not have_selector :link_or_button, 'Create answer'
  end
end