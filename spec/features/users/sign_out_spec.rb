require_relative '../features_helper.rb'

feature 'User can logout', %q{
  When user sign he can logout
  and exit form system.
} do

  given(:user) { create :user }
  scenario 'Authenticated user logout' do
    sign_in user
    page.driver.submit :delete, destroy_user_session_path, {}
    expect(page).to have_text 'Signed out successfully'
  end
end