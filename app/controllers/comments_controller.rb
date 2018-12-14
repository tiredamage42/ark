class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_commenting_available
  

  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  before_action :set_commentable,  only: [:create, :update, :destroy]
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # commentable /comments
  # commentable /comments.json
  def create

    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    
    respond_to do |format|
      if @comment.save
    
        @create_succeeded = true
      
        format.js { flash.now[:notice] = "Comment was successfully created" }
      
        #CommentMailer.comment_created(current_user, @post.user, @comment.body).deliver
      else
        @create_succeeded = false
        format.js { flash.now[:notice] = @comment.errors.first }
      
      
      end
    end
    

  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @commentable.commentable_root, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy

    @comment.destroy

    respond_to do |format|
    
      format.js { flash.now[:notice] = "Comment was successfully deleted" }
    end
    
  end


  private

    def set_commenting_available
      @commenting_available = true
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
