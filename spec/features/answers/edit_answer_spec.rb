require_relative '../features_helper'

feature 'Answer editing', %q{
	In order to fix mistake
	As an author of Answer
	I'd like to be able to edit my answer
} do
  given(:user) { create :user }
  given(:answer) { create :answer }

  describe 'Autenticated user' do
    describe 'Edit own answer' do
      before do
        sign_in answer.user
        visit question_path answer.question
      end

      scenario 'Seen edit answer link' do
        within '.answers' do
          expect(page).to have_link 'Edit answer'
        end
      end

      scenario 'trying edit own answer with valid body', js: true do
        expect(page).to have_current_path question_path(answer.question)
        click_on 'Edit answer'

        within '.edit_answer' do
          fill_in :answer_body, with: 'Edited answer body'
          click_on 'Change answer'

          expect(page).to_not have_selector 'textarea'
        end

        within '.answers' do
          expect(page).to_not have_text answer.body
          expect(page).to have_text 'Edited answer body'
        end
      end

      scenario 'trying edit own answer with blank body', js: true do
        expect(page).to have_current_path question_path(answer.question)
        click_on 'Edit answer'

        within '.edit_answer' do
          fill_in :answer_body, with: ''
          click_on 'Change answer'

          expect(page).to have_selector 'textarea'
        end

        within '.answers' do
          expect(page).to have_text answer.body
        end

        within '#errors' do
          expect(page).to have_text 'Body can\'t be blank'
        end
      end

      scenario 'trying edit own answer with short body', js: true do
        expect(page).to have_current_path question_path(answer.question)
        click_on 'Edit answer'

        within '.edit_answer' do
          fill_in :answer_body, with: 'short'
          click_on 'Change answer'
        end

        within '.answers' do
          expect(page).to_not have_selector 'textarea'
          expect(page).to have_text answer.body
        end

        within '#errors' do
          expect(page).to have_text 'Body is too short'
        end
      end
    end

    describe 'Edit someone else answer' do
      scenario 'trying edit someome else answer' do
        sign_in user
        visit question_path answer.question

        expect(page).to_not have_link 'Edit answer'
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario 'trying edit question' do
      visit question_path answer.question

      expect(page).to_not have_link 'Edit answer'
    end
  end
end