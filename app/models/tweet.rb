class Tweet < ActiveRecord::Base
  belongs_to :user

  def find_by_slug(tweet)
    Tweet.all.detect{|t|t.slug == tweet}
  end
end
