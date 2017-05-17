class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_attributes)
    if @comment.save
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_attributes
    params.permit(:star_rating_user, :description, :hotel_id)
  end
end
