class ConversationsController < ApplicationController
  #before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  #def index
  #  @conversations = Conversation.all
  #end

  # GET /conversations/1
  # GET /conversations/1.json
  #def show
  #end

  # GET /conversations/new
  #def new
  #  @conversation = Conversation.new
  #end

  # GET /conversations/1/edit
  #def edit
  #end

  # POST /conversations
  # POST /conversations.json
  def create

    # get a conversation between a current user and requested user. 
    # If in the session there is no added conversation_id yet, we’ll add it, 
    # if not, we’ll just respond with a js file.
    @conversation = Conversation.get(current_user.id, params[:user_id])
    
    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end


    #@conversation = Conversation.new(conversation_params)

    #respond_to do |format|
    #  if @conversation.save
    #    format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
    #    format.json { render :show, status: :created, location: @conversation }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @conversation.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  #def update
  #  respond_to do |format|
  #    if @conversation.update(conversation_params)
  #      format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @conversation }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @conversation.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end

    # Use callbacks to share common setup or constraints between actions.
    #def set_conversation
    #  @conversation = Conversation.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:recipient_id, :sender_id)
    end
end
