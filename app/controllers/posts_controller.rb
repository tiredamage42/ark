class PostsController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_new_post, only: [:create]

  # GET /posts
  # GET /posts.json
  def index

    @posts = Post.search(params[:search])
  
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    #@comment = @post.comments.build
    #@comment.user_id = current_user.id
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_new_post
      #@post = current_user.posts.new(post_params)
      @post = current_user.posts.build(post_params)
    
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body, :user_id)
    end
end
