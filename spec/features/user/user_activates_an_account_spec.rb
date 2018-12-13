require 'rails_helper'

feature'non-validated user' do
  scenario 'can validate registration through email' do
    stub_github_api_call

    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Register'

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    user = User.last

    mail = ActionMailer::Base.deliveries
    expect(mail.count).to eq(1)

    expect(mail.first.body.encoded).to match("Visit here to activate your account.")

    # expect(mail.first.body.encoded).to match("http://localhost:3000/activation/users/#{user.id}?status=true")

    visit "http://localhost:3000/activation/users/#{user.id}?status=true"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Thank you! Your account is now activated.")

    fill_in 'session[email]', with: email
    fill_in 'session[password]', with: password

    click_on 'Log In'

    within(".Status") do
      expect(page).to have_content("Status: Active")
    end


  end
end
