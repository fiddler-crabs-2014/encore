require 'spec_helper'

feature "User can sign out" do
  before do
    visit '/'
    valid_facebook_login_setup
    click_link "Sign in with Facebook"
  end

  scenario "when signed in" do
    click_link "Sign Out"

    expect(page).to_not have_content("Jared Rader")
  end
end
