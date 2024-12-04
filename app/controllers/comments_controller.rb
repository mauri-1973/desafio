class CommentsController < ApplicationController
    load_and_authorize_resource
  def create
    @comment = Comment.new(comment_params)
    @comment.user = User.first # Aquí puedes cambiar el usuario en función de tu autenticación
    @comment.post = Post.find(params[:post_id])

    if @comment.save
      redirect_to posts_path, notice: "Comentario agregado."
    else
      redirect_to posts_path, alert: "Error al agregar comentario."
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to posts_path, notice: 'Comentario eliminado exitosamente.'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end