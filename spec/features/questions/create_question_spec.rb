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

    fill_in 'Title', with: 'Test question title'
    fill_in 'Body', with: 'Test question body'
    click_on 'Create question'

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_text 'Test question title'
    expect(page).to have_text 'Test question body'
  end

  scenario 'Authenticated user can not create non valid question' do
    sign_in user

    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_on 'Create question'

    expect(page).to have_content 'Question not saved. Check attributes.'
  end

  scenario 'Non authenticated user creates question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
