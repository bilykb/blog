class CommentsController < ApplicationController # generated with bin/rails generate controller comments.  A controller is a class that is defined to inherit from ApplicationController
  # standard practice is to put CRUD actions in this order: index, show, new, edit, create, update, delete

  http_basic_authenticate_with name: "dhh", password: "secret", # prevents non authenticated users from deleting comments
only: :destroy # authenticated users are only allowed to delete comments

  def create # since there is an association between Articles and Comments established in modles/article.rb and models/comment.rb Rails will automatically link the comment to that article
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params) # comments are nested in articles.  To retrieve a comment, we will need to retrieve the article it is attached to
    redirect_to article_path(@article) # redirects to the same article, which calls the show action in articles_controller.rb, which renders show.html.erb. show.html.erb will need to have code that displays the commens
  end

  def destroy
    @article = Article.find(params[:article_id]) # finds the specific article
    @comment = @article.comments.find(params[:id]) # finds the specific comment in all comments linked to article
    @comment.destroy # destroys specific comment

    redirect_to article_path(@article) # redirect to show action in articles_controller.rb
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body) # white lists :commenter and :body
    end
end
