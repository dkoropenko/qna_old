require 'rails_helper'

feature 'Remove question', %q{
  When user authenticated, he can delete
  questions and answers if he owner. But if he not
  authenticated, he can't doing anything
} do

  given(:user) { create :user }
  given(:question) { create :question }
  scenario 'Authenticated user delete own question' do
    sign_in question.user

    visit question_path question
    click_on 'Remove question'

    expect(page).to_not have_text question.title
  end

  scenario 'Authenticated user can\'t delete other user question' do
    sign_in user

    visit question_path question

    expect(page).to_not have_selector :link_or_button, 'Remove question'
  end

  scenario 'NON Authenticated user can\'t delete any question' do
    visit question_path question

    expect(page).to_not have_selector :link_or_button, 'Remove question'
  end
end