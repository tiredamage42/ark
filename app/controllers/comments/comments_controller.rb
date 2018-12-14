
# controller for comments on comments
class Comments::CommentsController < CommentsController
    
    private

    #can only comment on first level comments
    def set_commenting_available
        @commenting_available = false
    end
  
    def set_commentable
        @commentable = Comment.find(params[:comment_id])
    end

end
