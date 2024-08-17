# Prep Exercise Week 3 



In Week 2, I designed a database for storing food recipes, which included tables for `Recipes`, `Ingredients`, `Categories`, and `Steps`, along with junction tables to manage many-to-many relationships. This week’s exercise focuses on normalizing that database to ensure it adheres to the principles of the Second and Third Normal Forms (2NF and 3NF). Additionally, I will discuss the potential challenges of scaling the database to include thousands of recipes and provide relevant queries to demonstrate the normalized design.

## Was the Database Already in 2NF / 3NF?

Yes, the initial database design was already in 2NF and 3NF:

- **Second Normal Form (2NF)**: In the initial design, all non-key attributes were fully functionally dependent on the primary key. For example, in the `Recipes` table, attributes like `recipe_name` depended solely on the `recipe_id`. Similarly, in junction tables like `Recipe_Categories`, both the `recipe_id` and `category_id` together formed the composite primary key, and there were no partial dependencies.

- **Third Normal Form (3NF)**: The design also adhered to 3NF, as all attributes were directly dependent on the primary key, with no transitive dependencies. For instance, there were no attributes in the `Recipes` table that depended on something other than the primary key, `recipe_id`.

## Changes Made to Normalize the Database

While the database was already well-structured, a few enhancements were made to ensure robustness and to further enforce data integrity:

1. **Unique Constraints**: Added unique constraints to ensure that certain fields, like `ingredient_name` and `step_description`, remain unique across the database. This helps to avoid redundant entries and ensures consistency.

    ```sql
    ALTER TABLE Ingredients ADD CONSTRAINT UNIQUE (ingredient_name);
    ```

2. **Cascade on Delete**: Added `ON DELETE CASCADE` to foreign key constraints to ensure that when a record in a parent table (like `Recipes`) is deleted, related records in junction tables (like `Recipe_Ingredients`) are also deleted automatically. This helps maintain referential integrity.

    ```sql
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id) ON DELETE CASCADE
    ```

3. **Normalization of Steps Table**: Ensured that the `Steps` table was uniquely identifying each step across all recipes, which prevents duplication of steps like “Preheat the oven.” This makes the database more efficient when handling common instructions.

    ```sql
    CREATE TABLE Steps (
        step_id INT AUTO_INCREMENT PRIMARY KEY,
        step_description TEXT NOT NULL UNIQUE
    );
    ```



The initial database design was already in 2NF and 3NF, but a few enhancements were made to ensure maximum efficiency and data integrity. As the database scales to accommodate thousands of recipes, challenges such as performance, storage management, and data integrity will need to be addressed. The provided queries demonstrate how the normalized design supports complex data retrieval while maintaining efficiency.
