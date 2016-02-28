class Movie < ActiveRecord::Base
    @@all_ratings = ["G", "PG", "PG-13", "NC-17", "R"]
    def self.all_ratings
        @@all_ratings
    end
end
