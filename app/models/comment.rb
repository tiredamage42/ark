class Comment < ApplicationRecord
    
    belongs_to :commentable, polymorphic: true
    belongs_to :user

    has_many :comments, as: :commentable
    
    validates :body, presence: true
        
    def commentable_root
        commentable.commentable_root
    end

end
