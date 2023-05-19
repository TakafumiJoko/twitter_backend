namespace :hash_tags do
  desc 'Create trends'
  task :create => :environment do
    User.first.tweets.create(message:'#WBC #大谷翔平 優勝')
    User.first.tweets.create(message:'#WBC #大谷翔平 優勝')
    User.first.tweets.create(message:'#TBS #オールスター感謝祭 面白いwwwww')
    p User.first.tweets

    if Tweet.find_by('created_at >= ?', Time.now - 60 * 60 * 24 - 60 * 5).checked
      tweets = Tweet.where('message LIKE ? and checked = false and created_at >= ?', '%#%', Time.now - 60 * 60 * 24).select(:id, :username, :message).distinct
      p "作業漏れが見つかりました。再発防止に努めてください。"
    else
      tweets = Tweet.where('message LIKE ? and checked = false and created_at >= ?', '%#%', Time.now - 60 * 60).select(:id, :username, :message).distinct
    end

    tweets.each do |tweet|
      create_hash_tags tweet
    end
    
    t_f = Tweet.where('created_at >= ?', Time.now - 60 * 5).first
    p 193, t_f.message
    t_f.hash_tags.each do |h|
      p 195, h.category.name, h.tweet_id, h.value
    end
  end

  private

    def create_hash_tags tweet
      hash_tags = validate tweet
      unless hash_tags.empty?
        p "202:#{hash_tags}"
        hash_tags.map! do |hash_tag|
          category_id = create_category hash_tag
          { tweet_id: hash_tag[:tweet_id], category_id: category_id, value: hash_tag[:value] }
        end
      end
      p "207:#{hash_tags}"
      HashTag.insert_all hash_tags 
      check_tweet tweet
    end
    
    def validate tweet
      have_blanks = tweet.message.scan(/\s*#[\wぁ-んァ-ヴ一-龠]+\s*/)
      validateds = []
      unless have_blanks.empty?
        have_blanks.each do |have_blank|
          validateds.push have_blank.strip if have_blank.match /[A-zぁ-んァ-ヴ一-龠]{1}/
        end
      end
      unless validateds.empty?
        hash_tags = validateds.map do |validated|
          { tweet_id: tweet.id, value: validated }
        end
      end
      hash_tags
    end
    
    def create_category arg_hash_tag
      if hash_tag = HashTag.find_by(value: arg_hash_tag[:value])
        hash_tag.category_id
      else
        p "#{arg_hash_tag[:value]}のカテゴリー名は何にしますか？"
        name = gets.split("\n")[0]
        if category = Category.find_by(name: name) 
          category.id
        else
          Category.create(name: name).id
        end
      end
    end

    def check_tweet tweet
      tweet.update(checked: true)      
    end  
end

# # TODO @before_creates

# namespace :trends do
#   desc 'Create hash tags'
#   task :create => :environment do
#     ActiveRecord::Base.transaction do
#       User.first.tweets.create(message:'#WBC #大谷翔平 優勝')
#       User.first.tweets.create(message:'#WBC #大谷翔平 優勝')
#       User.first.tweets.create(message:'#TBS #オールスター感謝祭 面白いwwwww')
#       p User.first.tweets
      
#       if Tweet.find_by('created_at >= ?', Time.now - 60 * 60 * 24 - 60 * 5).checked
#         @tweets = Tweet.where('message LIKE ? and checked = false and created_at >= ?', '%#%', Time.now - 60 * 60 * 24).select(:id, :username, :message).distinct
#         p "作業漏れが見つかりました。再発防止に努めてください。"
#       else
#         @tweets = Tweet.where('message LIKE ? and checked = false and created_at >= ?', '%#%', Time.now - 60 * 60).select(:id, :username, :message).distinct
#       end
      
#       p @tweets

#       p create_hash_tags(@tweets)
            
#       p check_tweets(@tweets)
#     end
#   end

#   desc 'Create trends'
#   task :create => :environment do
#     before_categorizeds = HashTag.where('created_at >= ?', Time.now - 60 * 5).group(:value).select(:value, :count_value).count(:value)
#     @before_creates = []
#     before_categorizeds.each do |trend_name, trend_count|
#       create_category trend_name, trend_count
#     end
#     @before_creates.each do |b|
#       trend = Trend.create b
#     end
#   end
    
#   private

#     def create_hash_tags tweets
#       if validate tweets
#         HashTag.insert_all @before_creates
#       end
#       p @before_creates
#     end
    
#     def validate tweets
#       @before_creates = []
#       tweets.each do |tweet|
#         have_blanks = tweet.message.scan(/\s*#[\wぁ-んァ-ヴ一-龠]+\s*/)
#         validateds = []
#         unless have_blanks.empty?
#           have_blanks.each do |have_blank|
#             validateds.push have_blank.strip if have_blank.match /[A-zぁ-んァ-ヴ一-龠]{1}/
#           end
#         end
#         unless validateds.empty?
#           validateds.each do |validated|
#             @before_creates.push tweet_id: tweet.id, value: validated
#           end
#         end
#       end
#       !@before_creates.empty?
#     end

#     def check_tweets tweets
#       Tweet.update_all(checked: true)
#       p Tweet.all
#     end
   
#     def create_category trend_name, trend_count
#       if trend = Trend.find_by(name: trend_name)
#         category_id = trend.category_id
#       else
#         p "#{trend_name}のカテゴリー名は何にしますか？"
#         name = gets.split("\n")[0]
#         if category = Category.find_by(name: name)
#           category_id = category.id
#         else
#           category_id = Category.create(name: name).id
#         end
#       end
#       @before_creates.push category_id: category_id, name: trend_name, count: trend_count
#     end

#     def update_tweets

#     end

# end


# namespace :trends do
#   desc 'Create trends'
#   task :create => :environment do
#     User.first.tweets.create(message:'#WBC #大谷翔平 優勝')
#     User.first.tweets.create(message:'#WBC #大谷翔平 優勝')
#     User.first.tweets.create(message:'#TBS #オールスター感謝祭 面白いwwwww')
#     p User.first.tweets

#     if Tweet.find_by('created_at >= ?', Time.now - 60 * 60 * 24 - 60 * 5).checked
#       tweets = Tweet.where('message LIKE ? and checked = false and created_at >= ?', '%#%', Time.now - 60 * 60 * 24).select(:id, :username, :message).distinct
#       p "作業漏れが見つかりました。再発防止に努めてください。"
#     else
#       tweets = Tweet.where('message LIKE ? and checked = false and created_at >= ?', '%#%', Time.now - 60 * 60).select(:id, :username, :message).distinct
#     end

#     tweets.each do |tweet|
#       create_trend tweet
#     end
    
#     p Tweet.where('created_at >= ?', Time.now - 60 * 5)
#     p HashTag.where('created_at >= ?', Time.now - 60 * 5)
#     p Trend.where('created_at >= ?', Time.now - 60 * 5)
#   end

#   private

#     def create_hash_tags tweet
#       hash_tags = validate tweet
#       ret = HashTag.insert_all hash_tags unless hash_tags.empty?
#       p ret.rows
#       hash_tags
#     end
    
#     def validate tweet
#       have_blanks = tweet.message.scan(/\s*#[\wぁ-んァ-ヴ一-龠]+\s*/)
#       validateds = []
#       unless have_blanks.empty?
#         have_blanks.each do |have_blank|
#           validateds.push have_blank.strip if have_blank.match /[A-zぁ-んァ-ヴ一-龠]{1}/
#         end
#       end
#       unless validateds.empty?
#         hash_tags = validateds.map do |validated|
#           { tweet_id: tweet.id, value: validated }
#         end
#       end
#       hash_tags
#     end
    
#     def create_trend tweet
#       hash_tags = create_hash_tags tweet
#       hash_tags.each do |hash_tag|
#         trend = create_category hash_tag
#         p trend = Trend.create(trend)
#       end
#       update_tweet tweet, trend
#     end
    
#     def create_category hash_tag
#       if trend = Trend.find_by(name: hash_tag[:value])
#         category_id = trend.category_id
#       else
#         p "#{hash_tag.value}のカテゴリー名は何にしますか？"
#         name = gets.split("\n")[0]
#         if category = Category.find_by(name: name)
#           category_id = category.id
#         else
#           category_id = Category.create(name: name).id
#         end
#       end
#       { category_id: category_id, name: hash_tag[:value] }
#     end

#     def update_tweet tweet, trend
#       tweet.update(trend_id: trend.id, checked: true)      
#     end  
# end