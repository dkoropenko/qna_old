require 'rails_helper'

feature 'Show all question', %q{
  User log in and open page with
  all questions
} do

  given(:user) { create :user }
  given(:question) { create :question }

  scenario 'Authenticated user seen questions' do
    sign_in user

    question
    visit questions_path
    expect(page).to have_link question.title, href: question_path(question)
  end

  scenario 'Non authenticated user seen questions' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid_user'
    fill_in 'Password', with: 'invalid_user_password'
    click_on "Sign in"

    question
    visit questions_path
    expect(page).to have_link question.title, href: question_path(question)
  end
end