class ArticlesController < ApplicationController # generated with bin/rails generate controller articles.  A controller is a class that is defined to inherit from ApplicationController
  # standard practice is to put CRUD actions in this order: index, show, new, edit, create, update, delete

  http_basic_authenticate_with name: "dhh", password: "secret", # rails has basic authentication features, which needs to be specified at the top of the controller.
except: [:index, :show] # this line ensures that a user will be authenticated on every action EXCEPT index and show

  def index
    # needed to list all articles.  The route associated with this action is "articles GET /articles(.:format) articles#index"
    @articles = Article.all
    # @article is passed by Rails to "views/articles/index.html.erb"
    # variable contains all submitted articles
    # implicitely renders @articles
    # all instance variables are automatically available to the ERB templates
  end

  def show # this action will point to the following route: "article GET /articles/:id(.:format) articles#show"
    @article = Article.find(params[:id])
    # .find searches all articles for the one with a specific id
    # it is assigned to an instance variable because Rails will pass all instance variables to view
    # we will need a "show" view which will be in views/articles/show.html.erb
  end # we will need a hyperlink pointing to the show view, which will be placed in views/articles/index.html.erb and views/articles/show.html.erb

  def new # this can be generated manually or by using bin/rails generate articles new.
    @article = Article.new
  end # this method needs to have a view associated with it in views/articles/new.  If one does not exist, Rails will look for a view in views/application/new since Application is the parent of Articles. If neither is found it will error.

  def edit # edit action will need a view in views/articles/edit.html.erb.  But we will also need a hyperlink pointing to the Edit page, which will be placed in views/articles/index.html.erb, and in views/articles/show.html
    @article = Article.find(params[:id])
  end

  def create 
    # in new.html.erb line 3, we ensured the submit would point to the create method.  This method is created to save data to that database, then proceeds to move to the associated view.  When a form is submitted to create, Rails sends the form fields as parameters, which can be referenced inside create.  If you want to see the parameters you can use this line of code: "render plain: params[:article].inspect"

    # render plain: params[:article].inspect # prints to console, a debug tool i think?
    # needed to be commented out because you cannot use render and redirect_to in the same method
    # the render method takes a hash with a key of plain and value of params[:article].inspect  (params method is an object which represents the fields coming from the form).  You can access any parameter easily by using the key I wrote on line 3 in new.html.erb.  Syntax => params[:key].  
    # The params are passed but nothing is being done with them at this point in parsing. To use them we need to make a Model (basically database schema) in terminal with "bin/rails generate model Article title:string text:text".  It makes a model file and migration file in models/articles and db/migrate.  Look at db/migrate for a file with a [timestamp].create_articles.rb

    @article = Article.new(article_params) # article_params was formerly params.require(:article).permit(:title, :text) which was moved down into the private section below
    # models are classes defined in the models file
    # Here a new model is made and passed "params[:article]", which contains all the attributes we are interested in.  You can see what they are with the code in line 6 of this file
 

    if @article.save
    # .save saves the model to the database.
    # Rails automatically maps these attributes to the appropriate columns in the database
    # .save returns a boolean to confirm if the action was successful

    redirect_to @article
    # redirects to the show action
    else # this "if else statement" is error handling for the validation we included in models/article.rb where we created a minimum title .length of 5.  The user now needs to be told an error has occured in views/articles/new.tml.erb
      render 'new' # render method is used here instead of redirect_to so that the @article object is passed back to the new template when it is rendered. Rendering is done within the same request as the form submission, but redirect_to will tell the browser to issue another request.  
    end
  end

  def update # the edit.html.erb view points to this update method
    @article = Article.find(params[:id])

    if @article.update(article_params) # accepts a hash containing the attributes you wish to update. Here, we're passing all attributes, but its not needed.  If we do "@article.update(title: "A New Title") Rails would only update the title, and not touch the other attributes
      redirect_to @article
    else
      render "edit" # rerenders the edit if the update fails in order to pas the @article object
    end
  end

  def destroy # bin/rake shows the route for deleting articles is "DELETE /articles/:id(.:format) articles#destroy"
    @article = Article.find(params[:id])
    @article.destroy # calls destroy on Active Record objects.  Remember that any associated comments need to be deleted as well. please refer to modles/article.rb
    
    redirect_to articles_path # a view is not needed for this action, as all we need to do is redirect to the index action
  end # to utilize this action, there needs to be a hyperlink associated with it.  One will be placed in views/articles/index.html.erb alongside the "show" and "update" links

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
    # params.require(:article).permit(:title, :text) is moved to its own method from line 34 to keep our code dry and reusable in the same controller by other actions (create, update)
    # private prevents article_params from being used outside of its intended context
    # Rails by default requires the params submitted to be whitelisted. By Default everything is blacklisted to prevent malicious attacks. It's type specific. To whitelist these paramaters, we need to use .require() and .permit() in order to bulk submit data
  end
