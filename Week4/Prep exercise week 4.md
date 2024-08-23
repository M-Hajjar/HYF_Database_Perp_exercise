# Converting a Normalized SQL Database to a Document-Based NoSQL Database

### Collections:
1. **Recipes**
2. **Categories**
3. **Ingredients**

## Embedding vs. Normalization in NoSQL

In NoSQL databases, some data can be embedded directly within a document, which reduces the need for joins and can simplify queries. However, it's important to balance embedding with normalization to avoid excessive data duplication and to maintain flexibility.

### Embedding Strategy

1. **Recipes Collection**:
    - **Embedded Data**:
        - **Ingredients**: The list of ingredients specific to the recipe will be embedded within the recipe document. Each ingredient will include details like quantity and measurement.
        - **Steps**: The steps required to prepare the recipe will also be embedded as an array of steps, maintaining the order in which they should be performed.
    - **Normalized Data**:
        - **Category References**: Categories will remain a separate collection, with the `Recipes` collection storing references (IDs) to the relevant categories. This allows for easy categorization and filtering without duplicating category data across multiple recipes.

    ```json
    {
        "_id": "recipe_id",
        "name": "Recipe Name",
        "ingredients": [
            { "ingredient_id": "ingredient_id", "name": "Ingredient Name", "quantity": "1", "measurement": "cup" },
            { "ingredient_id": "ingredient_id", "name": "Ingredient Name", "quantity": "2", "measurement": "tbsp" }
        ],
        "steps": [
            { "step_number": 1, "description": "Preheat the oven to 350°F" },
            { "step_number": 2, "description": "Mix flour and sugar" }
        ],
        "category_ids": ["category_id_1", "category_id_2"]
    }
    ```

 **Categories Collection**:
    - **Stored Separately**: Categories will be stored as separate documents within the `Categories` collection. Each category document will contain an array of recipe IDs that belong to that category. This ensures that category data remains consistent and easy to manage.

    ```json
    {
        "_id": "category_id",
        "name": "Dessert",
        "recipe_ids": ["recipe_id_1", "recipe_id_2"]
    }
    ```

 **Ingredients Collection**:
    - **Stored Separately**: While individual recipes will have embedded ingredients, the `Ingredients` collection will store ingredient details like nutritional information or common usage. This allows for easy updating and management of ingredients across recipes.

    ```json
    {
        "_id": "ingredient_id",
        "name": "Flour",
        "nutritional_info": {
            "calories": 100,
            "protein": "3g"
        }
    }
    ```

##  Considerations for Scaling

As the database grows to include thousands of recipes:
- **Performance**: Embedding ingredients and steps within the `Recipes` collection can enhance read performance since all related data is retrieved in a single query.
- **Storage**: Properly balancing embedding and references ensures efficient storage, preventing redundant data while maintaining data consistency.
- **Data Integrity**: By keeping categories and ingredients in separate collections with references, it becomes easier to update and manage data without causing inconsistencies.

