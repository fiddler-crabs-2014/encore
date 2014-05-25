require 'spec_helper'

feature "Sign in with Facebook" do
  scenario "with valid omniauth" do
    visit '/'
    valid_facebook_login_setup

    click_link "Sign in with Facebook"

    expect(page).to have_content("Jared Rader")
  end
end
