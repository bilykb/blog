class Comment < ActiveRecord::Base
  belongs_to :article # in postgresql, this defines the relationship between Comment and Article.  Article will also need a line "has_many :comments".  This is a one to many relationship.
end

# Model generated by using "bin/rails generate model Comment commenter:string body:text article:references"
# line 2, "belongs_to :article" an association that was generated by the above CLI comment