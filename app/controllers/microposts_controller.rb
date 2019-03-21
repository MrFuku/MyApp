class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,   only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @q = Micropost.none.ransack
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @micropost = Micropost.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @micropost.comments
    @user = @micropost.user
    respond_to do |format|
      format.js
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end
end
