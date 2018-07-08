module MicropostsHelper
  def feed_items
    return unless logged_in?
    @feed_items = current_user.feed.paginate page: params[:page]
  end

  def micropost
    return unless logged_in?
    @micropost = current_user.microposts.build
  end
end
