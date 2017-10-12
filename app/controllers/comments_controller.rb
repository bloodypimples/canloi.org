class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post) + "#comment-title", notice: 'Bình luận thành công.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to post_path(@post), notice: 'Đã có lỗi xảy ra, không thể đăng bình luận.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post) + "#comment-title", notice: 'Xóa bình luận thành công.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to :back if @comment.nil?
    end
end
