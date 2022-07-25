require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    @recipes[index].done!
  end

  def load_csv
    CSV.foreach(@csv_file_path) { |row| @recipes << Recipe.new(row[0], row[1], row[2], row[3]) }
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time] }
    end
  end
end
