# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)

    flash[:comment_errors] = [@comment.errors.full_messages, @comment.post_id] unless @comment.save
    redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
