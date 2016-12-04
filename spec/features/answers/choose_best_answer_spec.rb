require_relative '../features_helper'

feature 'Choose Best Answer', %q{
  Authenticated user if he is question
  owner can choose best answer. After that
  he can change his mind and shoose another
  answer.
} do

  given(:user) { create :user }
  given(:another_user) { create :user }
  given(:question) { create :question, user: user }
  given!(:answers) { create_list :answer, 5, question: question }

  describe 'Authenticated user' do
    describe 'User open own question' do
      before do
        sign_in question.user
        expect(page).to have_current_path root_path

        visit question_path question
        expect(page).to have_current_path question_path question
      end
      scenario 'Can seen link to change best answer' do
        expect(page).to have_link 'Best answer'
      end

      scenario 'Answer changed position after click on link', js: true do
        expect(page).to_not have_css '#best_answer'

        within '.answers' do

          find('tr', text: question.answers.last.body).click_link('Best answer')
          expect(page).to have_css '#best_answer', count: 1
          expect(page).to have_selector('table tr:nth-child(1)', text: question.answers.last.body)
        end
      end
    end

    describe 'User open someone else question' do
      scenario 'Can not seen link to change best answer for question' do
        sign_in another_user
        expect(page).to have_current_path root_path

        visit question_path question
        expect(page).to have_current_path question_path question

        within '.answers' do
          expect(page).to_not have_link 'Best answer'
        end
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Can not seen link to change best answer for question' do
      visit question_path question
      expect(page).to have_current_path question_path question

      within '.answers' do
        expect(page).to_not have_link 'Best answer'
      end
    end
  end
end