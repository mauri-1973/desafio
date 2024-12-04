class PostsController < ApplicationController
    load_and_authorize_resource
    before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all.includes(:comments)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.first # Aquí puedes cambiar el usuario en función de tu autenticación

    if @post.save
      redirect_to posts_path, notice: "Publicación creada con éxito."
    else
      render :index
    end
  end

  def like
    @post = Post.find(params[:id])
    like = @post.likes.find_by(user: current_user)

    if like
      like.destroy  # Si ya existe un "like", lo eliminamos
    else
      @post.likes.create(user: current_user)  # Si no existe, lo creamos
    end

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end