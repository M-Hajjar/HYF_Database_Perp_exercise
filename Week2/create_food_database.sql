-- Create the database
CREATE DATABASE IF NOT EXISTS food;

-- Use the database
USE food;

-- Create the Categories table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Recipes table with additional columns
CREATE TABLE Recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_name VARCHAR(255) NOT NULL,
    description TEXT,
    prep_time INT,  -- time in minutes
    cook_time INT,  -- time in minutes
    servings INT    -- number of servings
);

-- Create the Ingredients table with a unique constraint
CREATE TABLE Ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name VARCHAR(255) NOT NULL UNIQUE
);

-- Create the Steps table
CREATE TABLE Steps (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    step_description TEXT NOT NULL
);

-- Create the Recipe_Categories junction table with ON DELETE CASCADE
CREATE TABLE Recipe_Categories (
    recipe_id INT,
    category_id INT,
    PRIMARY KEY (recipe_id, category_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

-- Create the Recipe_Ingredients junction table with ON DELETE CASCADE
CREATE TABLE Recipe_Ingredients (
    recipe_id INT,
    ingredient_id INT,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id) ON DELETE CASCADE
);

-- Create the Recipe_Steps table with an additional composite key
CREATE TABLE Recipe_Steps (
    recipe_id INT,
    step_id INT,
    instruction_order INT,
    PRIMARY KEY (recipe_id, step_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (step_id) REFERENCES Steps(step_id) ON DELETE CASCADE,
    UNIQUE (recipe_id, instruction_order)
);

-- Insert categories
INSERT INTO Categories (category_name) VALUES ('Cake'), ('No-Bake'), ('Vegetarian'), ('Vegan'), ('Gluten-Free'), ('Japanese');

-- Insert recipes
INSERT INTO Recipes (recipe_name, description, prep_time, cook_time, servings) VALUES
('No-Bake Cheesecake', 'A delicious no-bake cheesecake.', 15, 0, 8),
('Roasted Brussels Sprouts', 'Healthy roasted brussels sprouts.', 10, 30, 4),
('Mac & Cheese', 'Classic comfort food.', 10, 20, 6),
('Tamagoyaki Japanese Omelette', 'Traditional Japanese omelette.', 5, 10, 2);

-- Insert ingredients
INSERT INTO Ingredients (ingredient_name) VALUES
('Condensed milk'), ('Cream Cheese'), ('Lemon Juice'), ('Pie Crust'), ('Cherry Jam'),
('Brussels Sprouts'), ('Lemon juice'), ('Sesame seeds'), ('Pepper'), ('Salt'), ('Olive oil'),
('Macaroni'), ('Butter'), ('Flour'), ('Milk'), ('Shredded Cheddar cheese'),
('Eggs'), ('Soy sauce'), ('Sugar');

-- Insert steps for No-Bake Cheesecake
INSERT INTO Steps (step_description) VALUES
('Beat Cream Cheese'),
('Add condensed Milk and blend'),
('Add Lemon Juice and blend'),
('Add the mix to the pie crust'),
('Spread the Cherry Jam'),
('Place in refrigerator for 3h');

-- Insert relationships into junction tables
-- Example for No-Bake Cheesecake:
INSERT INTO Recipe_Categories (recipe_id, category_id) VALUES (1, 1), (1, 2), (1, 3);
INSERT INTO Recipe_Ingredients (recipe_id, ingredient_id) VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5);
INSERT INTO Recipe_Steps (recipe_id, step_id, instruction_order) VALUES (1, 1, 1), (1, 2, 2), (1, 3, 3), (1, 4, 4), (1, 5, 5), (1, 6, 6);

-- Repeat the insertion process for the other recipes
