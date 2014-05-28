require "spec_helper"

feature "Search for concerts" do
  before do
    visit root_path

    expect(page).to have_content("Re-live your favorite concerts")
  end

  scenario "with a correct band name" do
    fill_in "band", with: "Killswitch Engage"
    click_button "Search"

    expect(page).to have_content("Concerts for Killswitch Engage")
  end

  scenario "with an incorrect band name" do
    fill_in "band", with: "dsafhds"
    click_button "Search"

    expect(page).to have_content("Sorry - we couldn't find an artist with that name.")
  end

  scenario "with a band that has complex sets" do
    fill_in "band", with: "Phish"
    click_button "Search"

    expect(page).to have_content("Concerts for Phish")
  end

  scenario "with a band name that returns multiple results" do
    fill_in "band", with: "Bastille"
    click_button "Search"

    expect(page).to have_content("Concerts for Bastille")
  end
end
