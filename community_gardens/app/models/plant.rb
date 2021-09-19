class Plant < ActiveRecord::Base
    # include Slugify

    belongs_to :user
end