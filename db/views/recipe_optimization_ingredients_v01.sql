SELECT DISTINCT
	cupboard_ingredients.cupboard_id AS "cupboard_id",
	recipe_ingredients.id AS "recipe_id",
	ingredients.name,
	recipe_ingredients.quantity AS "needed_quantity",
	cupboard_ingredients.quantity AS "actual_quantity"
FROM
	cupboard_ingredients
	INNER JOIN ingredients ON ingredients.id = cupboard_ingredients.ingredient_id
	INNER JOIN recipe_ingredients ON ingredients.id = recipe_ingredients.ingredient_id
