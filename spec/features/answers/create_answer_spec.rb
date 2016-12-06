require_relative '../features_helper.rb'

feature 'Create new Answer', %q{
  When user visit current question
  and if he sign in!
  He can write new answer for question
} do

  given!(:user) { create :user }
  given!(:question) { create :question }

  describe 'Authenticated user' do
    before do
      sign_in user
      expect(page).to have_current_path root_path
    end
    scenario 'Authenticated user create new answer for questions', js: true do
      visit question_path question

      fill_in 'answer_body', with: 'New answer body'
      click_button 'Create answer'

      expect(page).to have_current_path question_path question
      within '.answers' do
        expect(page).to have_text 'New answer body'
      end
    end

    scenario 'User try create new answer with empty data', js: true do
      visit question_path question

      fill_in 'answer_body', with: ''
      click_button 'Create answer'

      expect(page).to have_current_path question_path question
      within '#errors' do
        expect(page).to have_content "Body can\'t be blank"
      end
    end

    scenario 'User try create new answer with short data', js: true do
      visit question_path question

      fill_in 'answer_body', with: '123456'
      click_button 'Create answer'

      expect(page).to have_current_path question_path question
      within '#errors' do
        expect(page).to have_content 'Body is too short'
      end
    end
  end

  scenario 'Non authenticated user can not create new answer for questions' do
    visit question_path question

    expect(page).to have_current_path(question_path question)
    expect(page).to_not have_selector :link_or_button, 'Create answer'
  end
end