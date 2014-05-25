require "spec_helper"

feature "Search for concerts" do
  before do
    visit root_path

    expect(page).to have_content("Relive your favorite concerts")
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
  # TODO - implement design to handle this test
  # scenario "with a band name that returns multiple results" do
  #   fill_in "Search a band's concerts now", with: "Bastille"
  #   click_button "Search"
  # end
end

feature "Browse concerts" do
  before do
    visit root_path

    expect(page).to have_content("Relive your favorite concerts")

    fill_in "Search a band's concerts now", with: "Killswitch Engage"
    click_button "Search"

    expect(page).to have_content("Concerts for Killswitch Engage")
  end

  scenario "it loads a maximum of 10 concerts" do
    expect(page).to have_css('.concert-listing', count: 10)
  end
end
#   context "Landing page should allow a user to submit a search" do

#     it "should render a flash error message if a user submits an empty search" do
#       visit root_path
#       click_on "Submit"
#       expect(page).to have_content("Please actually type something in the search field. We can't raise this baby alone.")
#     end

#     context "a User submits valid search terms" do
#       it "should render the search results page" do
#         visit root_path
#         fill_in "Band", with: "Killswitch Engage"
#         click_on "Submit"
#         expect(page).to have_content("Concerts for Killswitch Engage")
#       end

#       it "should render the most recent concert from the setlist api by that artist" do
#         visit root_path
#         fill_in "Band", with: "Killswitch Engage"
#         click_on "Submit"
#         expect(page).to have_content("May 25 2014, Disarm the Descent Tour, Lonestar Pavilion, Lubbock, Texas")
#       end
#     end

#   end

#   context ""

# end
