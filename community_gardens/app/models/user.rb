class User < ActiveRecord::Base[5.2]
include Slugify
    has_many :plants

end