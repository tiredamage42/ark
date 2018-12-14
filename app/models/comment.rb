class Comment < ApplicationRecord
    
    belongs_to :commentable, polymorphic: true
    belongs_to :user

    has_many :comments, as: :commentable, dependent: :destroy
    
    validates :body, presence: true, allow_blank: false
        
    def commentable_root
        commentable.commentable_root
    end

      

end
