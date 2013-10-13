class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    authorize! :create, @comment, message: "You need to be an admin to do that."
    if @comment.save
      redirect_to @comment, notice: "Comment was saved successfully."
    else
      flash[:error] = "Error creating comment. Please try again."
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

end
