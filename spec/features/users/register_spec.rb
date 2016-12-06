require_relative '../features_helper.rb'

feature 'Register user', %q{
  User can register in system.
  He must input email, password and
  password confirm.
} do
  scenario 'Non authenticated user registering' do
    visit new_user_registration_path

    fill_in 'Email', with: 'some_email@test.ru'
    fill_in 'Password', with: 'very_strong_password'
    fill_in 'Password confirmation', with: 'very_strong_password'
    click_on 'Sign up'

    expect(page).to have_text 'Welcome! You have signed up successfully.'
  end
end