require 'rails_helper'

RSpec.feature 'Listing Articles' do
  before do
    john = User.create(email: 'john@example.com', password: 'password')
    login_as(john)
    @article1 = Article.create(title: 'Title of first article', body: 'Body of the first aritcle', user: john)
    @article2 = Article.create(title: 'Title of seconde article', body: 'Body of the second aritcle', user: john)
    logout
  end

  scenario 'List all Articles' do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)

    expect(page).not_to have_content('New Article')
  end
end
