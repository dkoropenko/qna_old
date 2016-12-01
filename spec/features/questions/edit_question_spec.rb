require_relative '../features_helper'

feature 'User edited question', %q{
  Authenticated user trying edit own question.
  After that question changed, or user seen
  errors alert.
} do

  let(:question) { create :question }
  let(:other_question) { create :question }

  describe 'Authenticated user' do
    before do
      sign_in question.user
      visit question_path question
    end

    scenario 'Can see edit question link' do
      expect(page).to have_link 'Edit question'
    end

    scenario 'Trying to change question with valid data', js: true do
      click_on 'Edit question'

      within ".edit_question" do
        fill_in :question_title, with: 'New long question title'
        fill_in :question_body, with: 'New long question body'
        click_on 'Change question'

        expect(page).to_not have_selector 'textarea'
      end

      expect(page).to have_text 'New long question title'
      expect(page).to have_text 'New long question body'
      expect(page).to_not have_text question.title
      expect(page).to_not have_text question.body
    end

    scenario 'Trying to change question with blank title', js: true do
      click_on 'Edit question'

      within ".edit_question" do
        fill_in :question_title, with: ''
        fill_in :question_body, with: 'New long question body'
        click_on 'Change question'

        expect(page).to have_selector 'textarea'
      end

      expect(page).to_not have_text 'New long question body'
      expect(page).to have_text question.title
      expect(page).to have_text question.body

      within '#errors' do
        expect(page).to have_text 'Title can\'t be blank'
      end
    end

    scenario 'Trying to change question with short title', js: true do
      click_on 'Edit question'

      within ".edit_question" do
        fill_in :question_title, with: '1234'
        fill_in :question_body, with: 'New long question body'
        click_on 'Change question'

        expect(page).to have_selector 'textarea'
      end

      expect(page).to_not have_text 'New long question body'
      expect(page).to have_text question.title
      expect(page).to have_text question.body

      within '#errors' do
        expect(page).to have_text 'Title is too short'
      end
    end

    scenario 'Trying to change question with blank body', js: true do
      click_on 'Edit question'

      within ".edit_question" do
        fill_in :question_title, with: 'New long question title'
        fill_in :question_body, with: ''
        click_on 'Change question'

        expect(page).to have_selector 'textarea'
      end

      expect(page).to_not have_text 'New long question title'
      expect(page).to have_text question.title
      expect(page).to have_text question.body

      within '#errors' do
        expect(page).to have_text 'Body can\'t be blank'
      end
    end

    scenario 'Trying to change question with short body', js: true do
      click_on 'Edit question'

      within ".edit_question" do
        fill_in :question_title, with: 'New long question title'
        fill_in :question_body, with: 'short'
        click_on 'Change question'

        expect(page).to have_selector 'textarea'
      end

      expect(page).to_not have_text 'New long question title'
      expect(page).to have_text question.title
      expect(page).to have_text question.body

      within '#errors' do
        expect(page).to have_text 'Body is too short'
      end
    end

    scenario 'Trying to change someone else question' do
      visit question_path other_question.user

      expect(page).to_not have_link 'Edit question'
    end
  end

  describe 'Unauthenticated user' do
    let(:user) { create :user }
    scenario 'Trying to chenge question' do
      sign_in user
      expect(page).to have_current_path root_path
      visit question_path question

      expect(page).to_not have_link 'Edit question'
    end
  end
end