class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  #before_action :correct_user,   only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @user = @comment.user
      @micropost = @comment.micropost
      @comment = Comment.new
      @comments = @micropost.comments
    else

    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    @user = comment.user
    @micropost = comment.micropost
    @comment = Comment.new
    if comment.destroy
      @comments = @micropost.comments
    else
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:micropost_id, :user_id, :content)
  end
end
