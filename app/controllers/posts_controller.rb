class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :downvote, :upvote]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user, only: [:destroy, :edit]

  # GET /posts
  # GET /posts.json
  def index
    if params[:category].blank?
      @posts = Post.paginate(:page => params[:page], :per_page => 10).order("created_at desc")
    else
      @category_id = params[:category]
      @posts = Post.where(category_id: @category_id).paginate(:page => params[:page], :per_page => 10).order("created_at desc")
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Đăng bài thành công.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Cập nhật thành công.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Xóa bài thành công.' }
      format.json { head :no_content }
    end
  end

  def downvote
    @post.downvote_by current_user
    redirect_to :back
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :picture, :category_id)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to :back if @post.nil?
    end
end
