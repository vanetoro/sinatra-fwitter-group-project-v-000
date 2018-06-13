class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  # validates_presence_of :username

  def slug
    self.username.split(' ').join('-')
  end

  def User.find_by_slug(username) #why doesn't this work with Self?
    User.all.detect{|u|u.slug.downcase == username.downcase }
  end



end
