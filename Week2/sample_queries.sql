-- Query to find all Vegetarian recipes with Potatoes
SELECT r.recipe_name
FROM Recipes r
JOIN Recipe_Ingredients ri ON r.recipe_id = ri.recipe_id
JOIN Ingredients i ON ri.ingredient_id = i.ingredient_id
JOIN Recipe_Categories rc ON r.recipe_id = rc.recipe_id
JOIN Categories c ON rc.category_id = c.category_id
WHERE c.category_name = 'Vegetarian' AND i.ingredient_name = 'Potatoes';

-- Query to find all Cakes that do not need baking
SELECT r.recipe_name
FROM Recipes r
JOIN Recipe_Categories rc ON r.recipe_id = rc.recipe_id
JOIN Categories c ON rc.category_id = c.category_id
WHERE c.category_name = 'Cake'
AND r.recipe_id NOT IN (
    SELECT r.recipe_id
    FROM Recipes r
    JOIN Recipe_Categories rc ON r.recipe_id = rc.recipe_id
    JOIN Categories c ON rc.category_id = c.category_id
    WHERE c.category_name = 'Baked'
);

-- Query to find all Vegan and Japanese recipes
SELECT r.recipe_name
FROM Recipes r
JOIN Recipe_Categories rc ON r.recipe_id = rc.recipe_id
JOIN Categories c ON rc.category_id = c.category_id
WHERE c.category_name IN ('Vegan', 'Japanese');
