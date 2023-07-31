SELECT DISTINCT
	CONCAT(recipes.id, '-', cupboards.id) AS id,
	cupboards.id AS cupboard_id,
	recipes.id AS recipe_id,
	recipes.recipe_type_id,
	recipes.is_perfect,
	recipes.num_of_ingredients,
	recipes.num_of_potions,
	recipes.rarity,
	recipes.stars,
	recipes.total_magimins,
	recipes. "value",
	recipes. "cost",
	round(recipes.cost_per_potion, 2) AS cost_per_potion,
	recipes.profit,
	recipes.profit - recipes.cost AS profit_margin,
	round((recipes.profit - recipes.cost) / recipes.num_of_potions, 2) AS profit_margin_per_potion,
	SUM(
		CASE WHEN (COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0 THEN
		(recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price
	ELSE
		0
		END) * 1.0 AS calculated_cost,
	round((SUM(
			CASE WHEN (COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0 THEN
			(recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price
		ELSE
			0
			END)) / (recipes.num_of_potions * 1.0), 2) AS calculated_cost_per_potion,
	recipes.value - (SUM(
			CASE WHEN (COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0 THEN
			(recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price
		ELSE
			0
			END)) AS calculated_profit,
	round(recipes.value - (SUM(
				CASE WHEN (COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0 THEN
				(recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price
			ELSE
				0
				END)) - SUM(
			CASE WHEN (COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0 THEN
			(recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price
		ELSE
			0
			END) * 1.0, 2) AS calculated_profit_margin,
	round((recipes.value - (SUM(
				CASE WHEN (COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0 THEN
				(recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price
			ELSE
				0
				END)) - SUM(
			CASE WHEN (COALESCE(cupboard_ingredients.quantity, 0) - recipe_ingredients.quantity) < 0 THEN
			(recipe_ingredients.quantity - COALESCE(cupboard_ingredients.quantity, 0)) * ingredients.base_price
		ELSE
			0
			END) * 1.0) / recipes.num_of_potions, 2) AS calculated_profit_margin_per_potion,
	array_agg(recipe_ingredients.id) AS recipe_ingredient_ids,
	array_agg(cupboard_ingredients.id) AS cupboard_ingredient_ids,
	0=ANY(array_agg(COALESCE(cupboard_ingredients.quinn_location_tab,0))) AS undiscovered_cupboard_ingredients
FROM
	recipes
	INNER JOIN recipe_ingredients ON recipe_ingredients.recipe_id = recipes.id
	INNER JOIN ingredients ON ingredients.id = recipe_ingredients.ingredient_id
	INNER JOIN cupboard_ingredients ON cupboard_ingredients.ingredient_id = ingredients.id
	INNER JOIN cupboards ON cupboard_ingredients.cupboard_id = cupboards.id
	INNER JOIN recipe_types ON recipes.recipe_type_id = recipe_types.id
WHERE
	cupboards.highest_license_tier >= recipes.license_tier
GROUP BY
	recipes.id,
	recipe_types.name,
	cupboards.id
ORDER BY
	recipes.id,
	cupboards.id
