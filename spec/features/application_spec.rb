require 'spec_helper'
require 'capybara/rspec'

Capybara.app = Application

feature 'User Registration and Login' do
  scenario 'User registers and logs in' do
    visit '/'
    expect(page).to have_content 'Login to Check Order Status'
    click_link('Register')

    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "1234")
    click_button('Register')
    expect(page).to have_content "You're entered to win a month's worth of free juice, joe@example.com"
    click_link('Logout')
    expect(page).to have_content 'Login to Check Order Status'

    click_link("Login")
    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "1234")
    click_button("Login")
    expect(page).to have_content "You're entered to win a month's worth of free juice, joe@example.com"
  end

  scenario 'User attempts to log in with invalid email' do
    visit '/'
    expect(page).to have_content 'Login to Check Order Status'
    click_link('Login')
    fill_in('email', with: "susan@example")
    fill_in('password', with: "5678")
    click_button("Login")
    expect(page).to_not have_content "You're entered to win a month's worth of free juice, susan@example.com"
  end

  scenario 'User attempts to login with incorrect password' do
    visit '/'
    click_link('Register')
    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "1234")
    click_button('Register')
    click_link('Logout')

    click_link("Login")
    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "mistake")
    click_button("Login")
    expect(page).to have_content 'Email / password is invalid'
    fill_in('email', with: "joe@example.org")
    fill_in('password', with: "mistake")
    click_button("Login")
    expect(page).to have_content 'Email / password is invalid'
  end

  scenario 'Administrators can see a list of all other users' do
    visit '/'
    click_link('Register')

    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "1234")
    click_button('Register')
    click_link('Logout')
    click_link("Login")
    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "1234")
    click_button("Login")

    click_link("View all users")
    expect(page).to have_content "joe@example.com"
  end

  scenario 'User clicks on links and is taken to appropriate page' do
    visit '/'
    visit('/about')
    expect(page).to have_content "Chief Juicing Officer"

    visit('/learn')
    expect(page).to have_content "Why Cleanse with Dash Juice?"

    visit('/juices')
    expect(page).to have_content "Spicy Lemonade"

    visit('/order')
    expect(page).to have_content "Add to Cart"

    visit('/contact')
    expect(page).to have_content "Shoot us an email"
  end
end
