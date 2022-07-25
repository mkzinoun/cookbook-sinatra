require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "lib/cookbook.rb"
require_relative "lib/recipe.rb"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get "/" do
  cookbook = Cookbook.new(File.join(__dir__, "lib/recipes.csv"))
  @recipes = cookbook.all
  erb :index
end

get "/new" do
  erb :new
end

post "/recipes" do
  cookbook = Cookbook.new(File.join(__dir__, "lib/recipes.csv"))
  recipe = Recipe.new(params[:recipe_name], params[:recipe_description], params[:recipe_rating], params[:recipe_preptime])
  cookbook.add_recipe(recipe)
  redirect to "/"
end
