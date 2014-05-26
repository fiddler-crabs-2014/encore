require 'spec_helper'

feature "User can view their own page" do
  before do
    visit '/'
    valid_facebook_login_setup
    click_link "Sign in with Facebook"
  end

  scenario "when logged in" do
    click_link "Jared Rader"

    expect(page).to have_content("Jared Rader")
  end

end
