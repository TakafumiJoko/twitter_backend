class CategoriesController < ApplicationController
  def main
    categories = Category.where(name: ['おすすめ', 'トレンド', 'ニュース', 'スポーツ', 'エンターテイメント'])
    render json: {
      categories: categories
    }
  end
  
  def index
    categories = Category.all
    render json: {
      categories: categories,
    }
  end
end
