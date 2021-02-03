
-- Database creation 
CREATE DATABASE recipes
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1


 -- Creating the Schema for the Tables
 CREATE SCHEMA cooking_recipes
    AUTHORIZATION postgres;


-- Creating the Table of Measurements
CREATE TABLE cooking_recipes.measurement
(
    measurement_unit character varying(20) NOT NULL,
    PRIMARY KEY (measurement_unit)
);

ALTER TABLE cooking_recipes.measurement
    OWNER to postgres;


-- Creating the Quantity table
CREATE TABLE cooking_recipes.quantity
(
    quantity character varying(25) NOT NULL,
    PRIMARY KEY (quantity)
);

ALTER TABLE cooking_recipes.quantity
    OWNER to postgres;


-- Creating the Ingredient table 
CREATE TABLE cooking_recipes.ingredient
(
    ingredient_name character varying(50) NOT NULL,
    PRIMARY KEY (ingredient_name)
);

ALTER TABLE cooking_recipes.ingredient
    OWNER to postgres;


-- Creating the ingredient description table where it will describe every ingredient separetely
CREATE TABLE cooking_recipes.ingredient_description
(
    ingrd_description character varying(100) NOT NULL,
    ingredient_guides character varying(200),
    PRIMARY KEY (ingrd_description)
);

ALTER TABLE cooking_recipes.ingredient_description
    OWNER to postgres;


-- Creating the Recipe Table
CREATE TABLE cooking_recipes.recipe
(
    recipe_id integer NOT NULL,
    recipe_name character varying(300) NOT NULL,
    diet_type character varying(50) NOT NULL,
    method text NOT NULL,
    serves integer NOT NULL,
    PRIMARY KEY (recipe_id)
);

ALTER TABLE cooking_recipes.recipe
    OWNER to postgres;


-- Creating the Description Table
CREATE TABLE cooking_recipes.description
(
    description_id integer NOT NULL,
    recipe_id integer NOT NULL,
    meal_type character varying(15) NOT NULL,
    preparation_time character varying(15) NOT NULL,
    cooking_time character varying(15) NOT NULL,
    meal_description text NOT NULL,
    PRIMARY KEY (description_id)
);

ALTER TABLE cooking_recipes.description
    OWNER to postgres;


-- Nutrition table
CREATE TABLE cooking_recipes.nutrition
(
    kcal numeric(6) NOT NULL,
    fat_in_grams numeric(6) NOT NULL,
    saturates_in_grams numeric(6) NOT NULL,
    carbs_in_grams numeric(6) NOT NULL,
    sugars_in_grams numeric(6) NOT NULL,
    fibre_in_grams numeric(6) NOT NULL,
    protein_in_grams numeric(6) NOT NULL,
    salt_in_grams double precision(6) NOT NULL,
    nutrition_id serial NOT NULL,
    PRIMARY KEY (nutrition_id)
);

ALTER TABLE cooking_recipes.nutrition
    OWNER to postgres;

-- Creating the intersection table for the recipe-nutrition connection
CREATE TABLE cooking_recipes.recipe_nutritions
(
    rn_id serial NOT NULL,
    recipe_id integer NOT NULL,
    nutrition_id serial NOT NULL,
    PRIMARY KEY (rn_id, recipe_id),
    FOREIGN KEY (recipe_id)
        REFERENCES cooking_recipes.recipe (recipe_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (nutrition_id)
        REFERENCES cooking_recipes.nutrition (nutrition_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

ALTER TABLE cooking_recipes.recipe_nutritions
    OWNER to postgres; 

-- Connection the Description Table with the recipe one
ALTER TABLE cooking_recipes.description
    ADD FOREIGN KEY (recipe_id)
    REFERENCES cooking_recipes.recipe (recipe_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION;


--  Creating Intersection table for the recipe table 
-- the Ingredient table, the Measurement, 
-- the Quantity and the ingredient description ones 
-- adding the PK from the previous tables as PK/FK in this one

 CREATE TABLE cooking_recipes.ingredients_for_recipe
(
    ri_id integer NOT NULL,
    ingrd_description character varying(100),
    recipe_id integer NOT NULL,
    ingredient_name character varying(50) NOT NULL,
    quantity character varying(15) NOT NULL,
    measurement_unit character varying(20),
    PRIMARY KEY (ri_id, recipe_id, ingredient_name),
    FOREIGN KEY (ingrd_description)
        REFERENCES cooking_recipes.ingredient_description (ingrd_description) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (recipe_id)
        REFERENCES cooking_recipes.recipe (recipe_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (ingredient_name)
        REFERENCES cooking_recipes.ingredient (ingredient_name) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (quantity)
        REFERENCES cooking_recipes.quantity (quantity) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (measurement_unit)
        REFERENCES cooking_recipes.measurement (measurement_unit) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

ALTER TABLE cooking_recipes.ingredients_for_recipe
    OWNER to postgres;
