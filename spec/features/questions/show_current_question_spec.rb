require 'rails_helper'

feature 'Show current question', %q{
  If user open question, he seen this
  question and all answers for this questions.
} do

  given(:user) { create :user }
  given(:answer) { create :answer }

  scenario 'Authenticated user seen current questions' do
    answer
    sign_in user

    visit questions_path
    click_on answer.question.title

    expect(page).to have_text answer.question.title
    expect(page).to have_text answer.question.body
    expect(page).to have_text answer.body
  end

  scenario 'Non authenticated user seen current questions' do
    answer

    visit questions_path
    click_on answer.question.title

    expect(page).to have_text answer.question.title
    expect(page).to have_text answer.question.body
    expect(page).to have_text answer.body
  end
end