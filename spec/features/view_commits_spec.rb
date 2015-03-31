require "rails_helper"

feature "Viewing commits" do
  scenario "Display all commits" do
    ImportGitLog.new.call("#{Rails.root}/db/data/git.log")
    visit "/"
    expect(page).to have_content('Hash')
    expect(page).to have_content('0662da725f942fdf0892fae5a44944e538bb3fe4')
    expect(page).to have_content('Author')
    expect(page).to have_content('John Doe')
    expect(page).to have_content('rollup interval converter testing')
  end
end