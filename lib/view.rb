class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      status = recipe.done? ? "[X]" : "[]"
      puts "#{index + 1}. #{status} #{recipe.name} - #{recipe.description} - #{recipe.prep_time} min - #{recipe.rating}"
    end
  end

  def ask_user_for(stuff)
    puts "What's the #{stuff} of your recipe?"
    print "> "
    gets.chomp
  end

  def ask_user_for_number(stuff)
    puts "What's the #{stuff} of your recipe?"
    print "> "
    gets.chomp.to_f
  end

  def ask_user_for_index
    puts "Please select a recipe"
    print "> "
    gets.chomp.to_i - 1
  end

  def ask_user_ingredient
    puts "What ingredient would you like a recipe for?"
    print "> "
    gets.chomp
  end

  def print_ingredient_message(ingredient)
    puts "Looking for #{ingredient} recipes on the Internet..."
  end

  def print_ingredient_recipe(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} #{recipe}"
    end
  end

  def choose_recipe
    puts "Which recipe would you like to import? (enter index)"
    gets.chomp.to_i - 1
  end

  def importing_message(recipe)
    puts "Importing #{recipe} ..."
  end
end
