CREATE DATABASE Gourmet_Galore_Restaurant_Repository;
USE Gourmet_Galore_Restaurant_Repository;

CREATE TABLE Store_Branch( STORE_ID INT NOT NULL,
Store_Name VARCHAR (100) NOT NULL,
Street VARCHAR (100), 
City VARCHAR (30),
Postcode VARCHAR (10),
Phone_Number INT);

ALTER TABLE Store_Branch
Add PRIMARY KEY (Store_Name);

-- Store dish name, description, price and type (appetiser, dessert, breakfast, etc)
CREATE TABLE Menu_Management(
Store_Dish_ID INT PRIMARY KEY NOT NULL,
Store_Dish_Name VARCHAR (100),
Store_Dish_Description VARCHAR (200),
Price FLOAT(2),
Type VARCHAR (50));

-- Dietary Restrictions: Store each dish’s dietary restrictions i.e is it vegetarian, vegan, halal, pescetarian, gluten-free, nut-free, etc
CREATE TABLE Dietry_Restrictions(
Store_Dish_ID INT NOT NULL,
Vegetarian VARCHAR (3),
Vegan VARCHAR (3), 
Halal VARCHAR (3), 
Pescetarian VARCHAR (3), 
Glutenfree VARCHAR (3), 
Nutfree VARCHAR (3),
FOREIGN KEY (Store_Dish_ID) 
REFERENCES Menu_Management (Store_Dish_ID));

ALTER TABLE Store_Branch
MODIFY COLUMN Phone_Number VARCHAR(15);


-- Insert into Store_Branch
INSERT INTO Store_Branch (STORE_ID, Store_Name, Street, City, Postcode, Phone_Number)
VALUES 
(1, 'Gourmet Central', '100 Park Avenue', 'New York', '10022', 2125550199),
(2, 'Gourmet Eastside', '55 E Houston St', 'New York', '10012', 6465550111),
(3, 'Gourmet Westside', '123 West 50th St', 'New York', '10020', 2125550155),
(4, 'Gourmet Uptown', '789 Madison Ave', 'New York', '10065', 2125550189),
(5, 'Gourmet Downtown', '234 Canal St', 'New York', '10013', 6465550144),
(6, 'Gourmet Midtown', '456 7th Ave', 'New York', '10018', 2125550177),
(7, 'Gourmet North', '123 Harlem St', 'New York', '10030', 6465550133),
(8, 'Gourmet South', '789 Battery Pl', 'New York', '10280', 2125550166),
(9, 'Gourmet East', '456 Water St', 'New York', '10038', 6465550122),
(10, 'Gourmet West', '123 Greenwich St', 'New York', '10006', 2125550155);

SELECT * FROM Store_Branch;

-- Insert into Menu_Management
INSERT INTO Menu_Management (Store_Dish_ID, Store_Dish_Name, Store_Dish_Description, Price, Type)
VALUES 
(1, 'Basil Symphony', 'Fresh basil leaves with cream cheese spread', 7.50, 'Appetiser'),
(2, 'Sunrise Wrap', 'Scrambled eggs, ham, and cheese in a wrap', 9.99, 'Breakfast'),
(3, 'Berries Delight', 'Seasonal berries with honey drizzle', 5.99, 'Dessert'),
(4, 'Seafood Paella', 'Mixed seafood cooked with rice and saffron', 15.99, 'Main Course'),
(5, 'Tofu Stir-fry', 'Tofu stir-fried with mixed vegetables', 11.99, 'Main Course'),
(6, 'Caramel Cheesecake', 'Rich caramel cheesecake with biscuit base', 6.50, 'Dessert'),
(7, 'Chicken Caesar Salad', 'Grilled chicken, romaine lettuce and Caesar dressing', 9.50, 'Appetiser'),
(8, 'Shrimp Scampi', 'Shrimp cooked in white wine and garlic sauce', 13.99, 'Main Course'),
(9, 'Green Goddess Smoothie', 'Spinach, pineapple and coconut milk smoothie', 4.99, 'Breakfast'),
(10, 'Veggie Pasta', 'Penne pasta tossed with mixed vegetables', 11.50, 'Main Course');

SELECT * FROM Menu_management;

-- Insert into Dietry_Restrictions
INSERT INTO Dietry_Restrictions (Store_Dish_ID, Vegetarian, Vegan, Halal, Pescetarian, Glutenfree, Nutfree)
VALUES 
(1, 'Yes', 'No', 'Yes', 'No', 'Yes', 'Yes'),
(2, 'No', 'No', 'Yes', 'No', 'No', 'Yes'),
(3, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 'No'),
(4, 'No', 'No', 'No', 'Yes', 'No', 'Yes'),
(5, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 'Yes'),
(6, 'Yes', 'No', 'Yes', 'No', 'No', 'No'),
(7, 'No', 'No', 'Yes', 'No', 'No', 'Yes'),
(8, 'No', 'No', 'No', 'Yes', 'No', 'Yes'),
(9, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 'Yes'),
(10, 'Yes', 'Yes', 'Yes', 'No', 'Yes', 'Yes');

SELECT * FROM Dietry_Restrictions;

ALTER TABLE Dietry_Restrictions
DROP COLUMN Pescetarian;

SET SQL_SAFE_UPDATES = 0;

UPDATE Store_Branch
SET store_branch.phone_number = 3123457882
WHERE store_branch.phone_number = 2125550199;

DELETE FROM Store_Branch
WHERE Store_ID = 10;

SET SQL_SAFE_UPDATES = 1;

SELECT store_dish_name, store_dish_description
FROM Menu_Management AS m
WHERE store_dish_ID = 1 OR store_dish_ID = 2
ORDER BY m.store_dish_ID;

-- how many dishes of each type (Appetiser, Dessert, Main Course, Breakfast) have a price greater than $10. 

SELECT Type, COUNT(*) 
FROM Menu_Management
WHERE Price > 10
GROUP BY Type
HAVING COUNT(*) > 1;

-- list all the dish types along with the average price of dishes in each type, 
-- but only include those types where the average price is greater than $15?

SELECT type, AVG(price)
FROM menu_management
Group BY type
HAVING AVG(price) > 15;

-- find out the types of dishes that have more than 5 dishes in the menu and the average price of these dishes is under $20?
SELECT type, ROUND(AVG(price),2)
FROM Menu_Management
GROUP BY type
HAVING ROUND(AVG(price),2) <20;

-- find types of dishes where each type has more than 5 dishes on the menu,
-- the average price is under $20, and the dish name contains the word "chicken"
SELECT Type, COUNT(*), AVG(price)
FROM Menu_management
WHERE store_dish_name like '%chicken%'
GROUP BY type
HAVING COUNT(*) >5 AND AVG(price) < 20;

SELECT * FROM menu_management;
SELECT Type, MAX(Price)
FROM Menu_Management
GROUP BY Type
ORDER BY MAX(price) DESC;

-- How many main courses are on the menu?
SELECT COUNT(*) FROM Menu_Management
Where type = 'main course';

-- Total prices of main courses
SELECT ROUND(SUM(price),2)
FROM Menu_management
WHERE type = 'main course';



SELECT Type, ROUND(AVG(Price),2)
FROM Menu_Management
GROUP BY Type
ORDER BY ROUND(AVG(Price),2);

-- Which dishes are vegan?
SELECT m.store_dish_name, d.vegan FROM Menu_management AS m
INNER JOIN dietry_restrictions AS d
ON d.store_dish_ID = m. store_dish_ID;

-- Stored Procedure

CREATE PROCEDURE vegan_dishes ()
BEGIN
SELECT m.store_dish_name, d.vegan FROM Menu_management AS m
INNER JOIN dietry_restrictions AS d
ON d.store_dish_ID = m.store_dish_ID
END //

DELIMITER //
CREATE PROCEDURE vegan_dishes(IN id INT)
BEGIN
SELECT m.store_dish_name, d.vegan FROM Menu_management AS m
INNER JOIN dietry_restrictions AS d
ON d.store_dish_ID = m.store_dish_ID;
END //
DELIMITER ;
CALL vegan_dishes(3);

SELECT store_dish_name FROM menu_management;
END //
DELIMITER ;
CALL get_dish_names();
