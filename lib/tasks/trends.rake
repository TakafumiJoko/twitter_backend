namespace :trend do
  desc "Insert records into tags"
  task :insert_tags => :environment do
    tweets = Tweet.where("message LIKE ?", "%#%").select(:message)
    hash_tags = tweets.map do |t|
      t[:message].match(/#.+[\s\n]*/).to_s.delete!("[#\s\n]")
    end
    tags = hash_tags.map do |h|
      Tag.create(name: h)
    end
  end

  desc "Insert records into trends"
  task :insert_trends => :environment do
    tags = Tag.where("checked = ? and created_at > ?", false, Date.today - 7).group(:name).order(count_name: :desc).select(:name, :count_name).count(:name)
    categories = Category.all
    puts "-----作成済みのカテゴリー一覧-----"
    categories.each { |n| puts n[:name] }
    puts "-----トレンドを新規作成してください-----"
    ranked_trends = ranked_trends(tags)
    categorized_trends = categorized_trends(ranked_trends, categories)
    Trend.create(categorized_trends)
  end

  private
  
    def ranked_trends(tags)
      now_rank = 0
      now_count = 0
      ary = tags.map do |t|
        now_rank+=1 if now_count != t[1] 
        now_count = t[1]
        {name: t[0], count: now_count, popularity: now_rank}
      end
    end

    def categorized_trends(trends, categories)
      trends.each do |t|
        p "#{t[:name]}のカテゴリーを入力してください"
        input_category = gets.split("\n")[0]
        categories.each do |c|
          if input_category == c[:name] 
            t[:category_id] = c.id
            break
          end
        end
      end
    end
end