require_relative '../features_helper.rb'

feature 'Remove answer', %q{
  When user authenticated, he can delete
  answer if he owner. But if he not
  authenticated, he can't doing anything
} do

  given(:user) { create :user }
  given(:answer) { create :answer }
  scenario 'Authenticated user delete own answer', js: true do
    sign_in answer.user
    visit question_path answer.question
    click_on 'Remove answer'

    expect(page).to_not have_text answer.body
  end

  scenario 'Authenticated user can\'t delete other user answer' do
    sign_in user
    visit question_path answer.question
    expect(page).to_not have_selector :link_or_button, 'Remove answer'
  end

  scenario 'NON Authenticated user can\'t delete any question' do
    visit question_path answer.question
    expect(page).to_not have_selector :link_or_button, 'Remove answer'
  end
end