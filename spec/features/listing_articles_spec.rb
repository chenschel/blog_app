require 'rails_helper'

RSpec.feature 'Listing Articles' do
  before do
    @article1 = Article.create(title: 'Title of first article', body: 'Body of the first aritcle')
    @article2 = Article.create(title: 'Title of seconde article', body: 'Body of the second aritcle')
  end
end
