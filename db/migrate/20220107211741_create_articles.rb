class CreateArticles < ActiveRecord::Migration
  def change # change is called when we run this migration
    create_table :articles do |t| #articles is the table name and always plural.  The model will always be singular.  Running this migration creates the articles table
      t.string :title # will be created as a column in the table
      t.text :text # will be created as a column in the table

      t.timestamps null: false
    end
  end
end

# this file was created in terminal using bin/rails generate model "Article title:string text:text"  It is needed to create the database schema, and allow ArticleController to send post requests to the database
# the timestamp created in the name of the file tells Rails the order of processing if there are multiple create files
# to execute a migration run "bin/rake db:migrate".  We work in the development environment by default, so this command will apply to the database defined in the development section of config/database.yml


# if you want to migrate to a different environment i needs to be stated using "bin/rake db:migrate RAILS_ENV=production"