require 'rails_helper'

RSpec.feature 'Showing an article' do
  before do
    @john = User.create(email: 'john@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    login_as(@john)
    @article = Article.create(title: 'Title of first article', body: 'Body of the first aritcle', user: @john)
    logout
  end

  scenario 'A non signed-in user does not see edit or delele links' do
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))

    expect(page).not_to have_content('Edit Article')
    expect(page).not_to have_content('Delete Article')
  end

  scenario 'A signed-in owner does see edit or delele links' do
    login_as(@john)
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))

    expect(page).to have_content('Edit Article')
    expect(page).to have_content('Delete Article')
  end

  scenario 'A non-owner signed in user does not see edit or delele links' do
    login_as(@fred)
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))

    expect(page).not_to have_content('Edit Article')
    expect(page).not_to have_content('Delete Article')
  end

  scenario 'Display individual article' do
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))
  end
end
