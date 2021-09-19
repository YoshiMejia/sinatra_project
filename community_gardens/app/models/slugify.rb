module Slugify
    def slug
        name.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        Self.class.all.find{|sg| sg.slug == slug}
    end
end