class Post < ApplicationRecord
    belongs_to :user


    def self.search (search)
        
        if search
            searched = where(['body LIKE ?', "%#{search}%"])
        else    
            searched = all
        end
        # cached_votes_total, 
        # cached_votes_score, 
        # cached_votes_up, 
        # cached_votes_down, 
        # cached_weighted_score, 
        # cached_weighted_total, 
        # cached_weighted_average,
        searched.order(:created_at => :desc)
    end
end
