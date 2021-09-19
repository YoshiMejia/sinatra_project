class Plant < ActiveRecord::Base[5.2]
    include Slugify

    belongs_to :user
end