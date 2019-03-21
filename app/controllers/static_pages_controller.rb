class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      session[:page_owner_id] = current_user.id
      @micropost = current_user.microposts.build
      if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
        @q = current_user.feed.ransack(microposts_search_params)
        @feed_items = @q.result.paginate(page: params[:page])
      else
        @q = Micropost.none.ransack
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
      @url = root_path
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
