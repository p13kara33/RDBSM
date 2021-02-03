-- Starter for 4 people
 CREATE VIEW cooking_recipes.starter_for_4
 	AS	
	SELECT recipe.recipe_name, recipe.serves,
			description.meal_type,
			ingredients_for_recipe.quantity,
			ingredients_for_recipe.measurement_unit AS unit,
			ingredients_for_recipe.ingrd_description,
			ingredients_for_recipe.ingredient_name,
			ingredient_description.ingredient_guides
	FROM cooking_recipes.recipe
	INNER JOIN cooking_recipes.description
	ON description.recipe_id = recipe.recipe_id
	INNER JOIN cooking_recipes.ingredients_for_recipe
	ON recipe.recipe_id = ingredients_for_recipe.recipe_id
	LEFT JOIN cooking_recipes.ingredient_description
	ON ingredient_description.ingrd_description =ingredients_for_recipe.ingrd_description
	WHERE description.meal_type = 'starter' AND recipe.serves = 4;



-- Chicken as main ingredient
  CREATE VIEW cooking_recipes.feed_me_chicken
  	AS	
	SELECT recipe.recipe_name,
			ingredients_for_recipe.quantity,
			ingredients_for_recipe.measurement_unit AS unit,
			ingredients_for_recipe.ingrd_description,
			ingredients_for_recipe.ingredient_name,
			ingredient_description.ingredient_guides
	FROM cooking_recipes.recipe
	RIGHT JOIN cooking_recipes.ingredients_for_recipe
	ON recipe.recipe_id = ingredients_for_recipe.recipe_id
	LEFT JOIN cooking_recipes.ingredient
	ON ingredient.ingredient_name = ingredients_for_recipe.ingredient_name
	LEFT JOIN cooking_recipes.ingredient_description
	ON ingredient_description.ingrd_description = ingredients_for_recipe.ingrd_description
	WHERE ingredient.ingredient_name = 'chicken';
	

-- Vegan diet recipe with ingredients
CREATE VIEW cooking_recipes.food_for_vegan
	AS	
	SELECT recipe.recipe_name, recipe.diet_type,
			ingredients_for_recipe.quantity,
			ingredients_for_recipe.measurement_unit AS unit,
			ingredients_for_recipe.ingrd_description,
			ingredient.ingredient_name,
			ingredient_description.ingredient_guides
	FROM cooking_recipes.recipe
	INNER JOIN cooking_recipes.ingredients_for_recipe
	ON recipe.recipe_id = ingredients_for_recipe.recipe_id
	INNER JOIN cooking_recipes.ingredient
	ON ingredient.ingredient_name = ingredients_for_recipe.ingredient_name
	LEFT JOIN cooking_recipes.ingredient_description
	ON ingredient_description.ingrd_description =ingredients_for_recipe.ingrd_description
	WHERE recipe.diet_type = 'Vegan';