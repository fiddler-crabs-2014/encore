require 'spec_helper'

feature "Add video of song to concert", js: true do
  before do
    visit root_path

    expect(page).to have_content("Relive your favorite concerts")

    fill_in "band", with: "Killswitch Engage"
    click_button "Search"

    expect(page).to have_content("Concerts for Killswitch Engage")

    first('#concert-title').click
  end

  scenario "via ajax" do
    click_button 'Add Song', match: :first

    wait_for_ajax

    expect(page).to have_content("Song added!")
  end
end
