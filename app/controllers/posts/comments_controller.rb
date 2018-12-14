#controller for comments on posts
class Posts::CommentsController < CommentsController
    private
    def set_commentable
        @commentable = Post.find(params[:post_id])
    end  
end