class User < ActiveRecord::Base
# include Slugify
    has_many :plants

end