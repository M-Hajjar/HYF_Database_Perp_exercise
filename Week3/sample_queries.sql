-- Query to get all vegetarian recipes with potatoes
SELECT r.recipe_name
FROM Recipes r
JOIN Recipe_Categories rc ON r.recipe_id = rc.recipe_id
JOIN Categories c ON rc.category_id = c.category_id
JOIN Recipe_Ingredients ri ON r.recipe_id = ri.recipe_id
JOIN Ingredients i ON ri.ingredient_id = i.ingredient_id
WHERE c.category_name = 'Vegetarian' AND i.ingredient_name = 'Potatoes';

-- Query to get all cakes that do not need baking
SELECT r.recipe_name
FROM Recipes r
JOIN Recipe_Categories rc ON r.recipe_id = rc.recipe_id
JOIN Categories c ON rc.category_id = c.category_id
WHERE c.category_name = 'Cake' AND r.recipe_id NOT IN (
    SELECT rs.recipe_id
    FROM Recipe_Steps rs
    JOIN Steps s ON rs.step_id = s.step_id
    WHERE s.step_description LIKE '%Bake%'
);

-- Query to get all vegan and Japanese recipes
SELECT r.recipe_name
FROM Recipes r
JOIN Recipe_Categories rc ON r.recipe_id = rc.recipe_id
JOIN Categories c ON rc.category_id = c.category_id
WHERE c.category_name IN ('Vegan', 'Japanese')
GROUP BY r.recipe_id
HAVING COUNT(DISTINCT c.category_id) = 2;
