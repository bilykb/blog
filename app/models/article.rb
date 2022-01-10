class Article < ActiveRecord::Base # ActiveRecord is the parent class that immediately gives Article a bunch of funcationality, like CRUD operations, validation for data sent to Models, search support and build model relations
  has_many :comments, dependent: :destroy # in postgresql, this defines the relationship between Comment and Article.  Comment will also need a line "belongs_to :article".  This is a one to many relationship. Adding "dependent: :destroy also ensures that any associated comments are deleted as well"
  validates :title, presence: true,
    length: {minimum: 5} # ensures all articles have a title with at least 5 characters.  Google Rails validations for expanded features. Now, if we use .save on @article, it will return false if short.  This error handling needs to be handled in the articles_controller.rb file
end
