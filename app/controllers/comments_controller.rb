class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

      if @comment.update(comment_params)
        redirect_to request.referer, notice: "コメントを編集しました"
      else
        flash.now[:danger] = "編集に失敗しました"
      r ender 'edit'
      end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
