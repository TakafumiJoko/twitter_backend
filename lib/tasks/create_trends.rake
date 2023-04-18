namespace :trends do
  desc 'Create trends'
  task :create => :environment do
    before_categorizeds = HashTag.where('created_at >= ?', Time.now - 60 * 5).group(:value).select(:value, :count_value).count(:value)
    @before_creates = []
    before_categorizeds.each do |trend_name, trend_count|
      create_category trend_name, trend_count
    end
    ret = Trend.insert_all @before_creates
    p ret.rows
  end
    
  private

    def create_category trend_name, trend_count
      if trend = Trend.find_by(name: trend_name)
        category_id = trend.category_id
      else
        p "#{trend_name}のカテゴリー名は何にしますか？"
        name = gets.split("\n")[0]
        if category = Category.find_by(name: name)
          category_id = category.id
        else
          category_id = Category.create(name: name).id
        end
      end
      @before_creates.push category_id: category_id, name: trend_name, count: trend_count
    end
end