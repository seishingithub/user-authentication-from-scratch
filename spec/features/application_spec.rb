require 'spec_helper'
require 'capybara/rspec'

Capybara.app = Application

feature 'User Registration and Login' do
  scenario 'User registers and logs in' do
    visit '/'
    expect(page).to have_content 'You are not logged in.'
    click_link('Register')

    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "1234")
    click_button('Register')
    expect(page).to have_content 'Welcome, joe@example.com'
    click_link('Logout')
    expect(page).to have_content 'You are not logged in.'

    click_link("Login")
    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "1234")
    click_button("Login")
    expect(page).to have_content 'Welcome, joe@example.com'
  end

  scenario 'User attempts to log in with invalid email' do
    visit '/'
    expect(page).to have_content 'You are not logged in.'
    click_link('Login')
    fill_in('email', with: "susan@example")
    fill_in('password', with: "5678")
    click_button("Login")
    expect(page).to_not have_content "Welcome, susan@example.com"
  end
end