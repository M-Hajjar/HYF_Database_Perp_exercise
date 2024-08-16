-- Create the database
CREATE DATABASE IF NOT EXISTS food;

-- Use the database
USE food;

-- Create the Categories table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create the Recipes table
CREATE TABLE Recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_name VARCHAR(255) NOT NULL,
    description TEXT,
    prep_time INT,  -- time in minutes
    cook_time INT,  -- time in minutes
    servings INT    -- number of servings
);

-- Create the Ingredients table
CREATE TABLE Ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_name VARCHAR(255) NOT NULL UNIQUE
);

-- Create the Steps table
CREATE TABLE Steps (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    step_description TEXT NOT NULL UNIQUE
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

-- Optional: Insert sample data
INSERT INTO Categories (category_name) VALUES ('Vegetarian'), ('Vegan'), ('Gluten-Free'), ('Japanese'), ('Cake'), ('No-Bake');

INSERT INTO Ingredients (ingredient_name) VALUES ('Condensed Milk'), ('Cream Cheese'), ('Lemon Juice'), ('Pie Crust'), ('Cherry Jam'), ('Brussels Sprouts'), ('Sesame Seeds'), ('Pepper'), ('Salt'), ('Olive Oil'), ('Macaroni'), ('Butter'), ('Flour'), ('Milk'), ('Shredded Cheddar Cheese'), ('Eggs'), ('Soy Sauce'), ('Sugar');

INSERT INTO Steps (step_description) VALUES 
('Beat Cream Cheese'),
('Add condensed Milk and blend'),
('Add Lemon Juice and blend'),
('Add the mix to the pie crust'),
('Spread the Cherry Jam'),
('Place in refrigerator for 3h'),
('Preheat the oven'),
('Mix the ingredients in a bowl'),
('Spread the mix on baking sheet'),
('Bake for 30 minutes');

-- Add sample data for Recipes, Recipe_Categories, Recipe_Ingredients, and Recipe_Steps as needed
