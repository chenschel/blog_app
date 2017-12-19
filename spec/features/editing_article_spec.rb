require 'rails_helper'

RSpec.feature 'Editing Article' do
  before do
    @article = Article.create(title: 'Title of first Article', body: 'Body of first article')
  end

  scenario 'A user updates an atircle' do
    visit '/'

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: 'Article update'
    fill_in 'Body', with: 'Body of article updated'
    click_button 'Update Article'

    expect(page).to have_content('Article has been updated')
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario 'A user fails to update an article' do
    visit '/'

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: ''
    fill_in 'Body', with: 'Body of article updated'
    click_button 'Update Article'

    expect(page).to have_content('Article has not been updated')
    expect(page.current_path).to eq(article_path(@article))
  end
end
