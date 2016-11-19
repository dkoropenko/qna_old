require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an login user
  I want to be able to ask questions
} do

  given(:user) { create :user }
  scenario 'Authenticated user creates question' do
    sign_in user

    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test question'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non authenticated user creates question' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid_user'
    fill_in 'Password', with: 'invalid_user_password'
    click_on "Sign in"

    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
