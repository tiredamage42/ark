class Comments::CommentsController < CommentsController
    private
    def set_commentable
        @commentable = Comment.find(params[:comment_id])
    end
end
