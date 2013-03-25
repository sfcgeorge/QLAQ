class PostsController < ApplicationController
  def recent
    @posts = Forem::Post.order('created_at DESC').limit(10)
    render 'forem/posts/recent'
  end
end