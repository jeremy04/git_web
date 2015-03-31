require "rails_helper"

feature "Search commits" do
  scenario "Search by commit hash" do
    author = Author.create!(name: "Joe")
    Commit.create!(committed_at: Time.now, commit_hash: "0662da725f942fdf0892fae5a44944e538bb3fe4", message: "Commit", author: author)
    visit "/"
    fill_in "commit_hash", :with => "0662"
    find_button("Search").click
    expect(page).to have_content("0662da725f942fdf0892fae5a44944e538bb3fe4")
  end

  scenario "Search by date" do
    author = Author.create!(name: "Joe")
    Commit.create!(committed_at: "2015-01-01", commit_hash: "hash", message: "Commit", author: author)
    visit "/"
    fill_in "committed_at", :with => "2015-01-01"
    find_button("Search").click
    expect(page).to have_content("hash")
  end

  scenario "Search by author" do
    author = Author.create!(name: "Jack")
    Commit.create!(committed_at: "2015-01-01", commit_hash: "hash", message: "Commit", author: author)
    visit "/"
    fill_in "committed_at", :with => "2015-01-01"
    select("Jack", from: "author")
    expect(page).to have_content("hash")
  end

  scenario "Search without terms should not find anything" do
    author = Author.create!(name: "Jack")
    Commit.create!(committed_at: "2015-01-01", commit_hash: "hash", message: "Commit", author: author)
    visit "/"
    find_button("Search").click
    expect(page).to_not have_content("hash")
    expect(page).to have_content("Found 0 results")
  end

end