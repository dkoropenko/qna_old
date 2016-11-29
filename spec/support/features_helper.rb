module FeaturesHelper

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on "Sign in"
  end

  def create_questions_collection
    result = []
    10.times { result << create(:question) }
    result
  end
end
