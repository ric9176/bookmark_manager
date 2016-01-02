 require 'web_helpers'



feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario "I can't sign up without an email address" do
   expect { sign_up(email: nil) }.not_to change(User, :count)
   expect(current_path).to eq('/users')
   expect(page).to have_content('Email must not be blank')
 end

  scenario "I can't sign up with an invalid email address" do
    expect { sign_up(email: "invalid@email") }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'I cannot sign up with an existing email' do
    sign_up
    expect { sign_up }.to_not change(User, :count)
    expect(page).to have_content('Email is already taken')
  end
end

feature 'password confirmation' do
  scenario 'requires a matching confirmation password' do
  # again it's questionable whether we should be testing the model at this
  # level.  We are mixing integration tests with feature tests.
  # However, it's convenient for our purposes.
  expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end





  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content 'Password does not match the confirmation'
  end
end


feature 'User sign in' do

  let(:user) do
    User.create(email: 'user@example.com',
                password: 'secret1234',
                password_confirmation: 'secret1234')
  end

  scenario 'with correct credentials' do
    sign_in(email: user.email,   password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end

  def sign_in(email:, password:)
    visit '/sessions/new'
    fill_in 'email', with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end

end
