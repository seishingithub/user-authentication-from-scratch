require 'spec_helper'
require 'capybara/rspec'

Capybara.app = Application

feature 'Homepage' do
  scenario 'Shows the welcome message' do
    visit '/'
    expect(page).to have_content 'You are not logged in.'
    click_link('Register')

    fill_in('email', with: "joe@example.com")
    fill_in('password', with: "1234")
    click_button('Register')
    expect(page).to have_content 'Welcome, joe@example.com'
    click_link('Logout')
    expect(page).to have_content 'You are not logged in.'

  end
end