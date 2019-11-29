# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find_by_id(comment_params[:post_id])
    @comment = current_user.comments.build(comment_params)
    flash[:comment_errors] = [@comment.errors.full_messages, @comment.post_id] unless @comment.save
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
