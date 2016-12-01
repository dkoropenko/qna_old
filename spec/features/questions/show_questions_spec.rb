require_relative '../features_helper.rb'

feature 'Show all questions', %q{
  User can see all questions.
} do

  let(:user) { create :user }
  scenario 'Authenticated user seen questions' do
    sign_in user
    questions = create_questions_collection

    visit questions_path
    questions.each do |question|
      expect(page).to have_link question.title, href: question_path(question)
    end
  end

  scenario 'Non authenticated user seen questions' do
    questions = create_questions_collection

    visit questions_path
    questions.each do |question|
      expect(page).to have_link question.title, href: question_path(question)
    end
  end
end