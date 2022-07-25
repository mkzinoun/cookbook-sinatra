require_relative "recipe"
require_relative "view"
require_relative "service_object"
require "open-uri"
require "nokogiri"

class Controller
  USER_AGENT = "Mozilla/5.0 (Windows NT x.y; rv:10.0) Gecko/20100101 Firefox/10.0"

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.display(@cookbook.all)
  end

  def create
    name = @view.ask_user_for("name")
    description = @view.ask_user_for("description")
    rating = @view.ask_user_for_number("rating")
    prep_time = @view.ask_user_for_number("preptime")
    recipe = Recipe.new(name, description, rating, prep_time)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    list
    index = @view.ask_user_for_index
    @cookbook.remove_recipe(index)
  end

  def import
    ingredient = @view.ask_user_ingredient
    @view.print_ingredient_message(ingredient)
    scrape_recipe = ScrapeAllrecipesService.new(ingredient)
    hash = scrape_recipe.call_recipe("https://www.allrecipes.com/search/results/?search=")
    @view.print_ingredient_recipe(hash[:titles].first(5))
    index = @view.choose_recipe
    @view.importing_message(hash[:titles][index])
    recipe_title_for_scraping = hash[:titles][index].downcase.split.join("-")
    scrape_preptime = ScrapeAllrecipesService.new(recipe_title_for_scraping)
    prep_time = scrape_preptime.call_preptime("https://www.allrecipes.com/recipe/")
    recipe = Recipe.new(hash[:titles][index], hash[:descriptions][index], hash[:ratings][index], prep_time[0].to_i)
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    list
    index = @view.ask_user_for_index
    @cookbook.mark_as_done(index)
  end
end
