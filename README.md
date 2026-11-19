# Database Normalization Assignment

**Topics:** First Normal Form (1NF) and Second Normal Form (2NF)  
**DBMS:** MySQL

## Project contents

- `answer.sql` — complete SQL solution for both questions.
- `README.md` — assignment explanation and execution instructions.
- `screenshots/` — add screenshots captured from your own MySQL Workbench session.

## How to run

1. Open MySQL Workbench and connect to your MySQL server.
2. Select **File → Open SQL Script** and open `answer.sql`.
3. Execute the script using the lightning-bolt button.
4. Review the result grids.

The script creates and selects a separate database named `normalization_assignment`. It drops and recreates only the three assignment tables so that the script can be run again. Do not run it in a database where you need to preserve existing tables with these names.

## Question 1: Achieving First Normal Form (1NF)

The original `ProductDetail` table contains multiple products in one `Products` cell, such as `Laptop, Mouse`. This violates 1NF because each cell must contain one atomic value.

The script creates `ProductDetail_1NF` with `OrderID`, `CustomerName`, and `Product`. Each product is inserted into its own row. The composite primary key is `(OrderID, Product)`.

**Expected result: 6 rows.**

| OrderID | CustomerName | Product |
|---:|---|---|
| 101 | John Doe | Laptop |
| 101 | John Doe | Mouse |
| 102 | Jane Smith | Tablet |
| 102 | Jane Smith | Keyboard |
| 102 | Jane Smith | Mouse |
| 103 | Emily Clark | Phone |

## Question 2: Achieving Second Normal Form (2NF)

The original composite primary key is `(OrderID, Product)`. The partial dependency is:

`OrderID → CustomerName`

`CustomerName` depends only on `OrderID`, which is part of the composite key, rather than on the entire key. This partial dependency violates 2NF.

The data is separated into two tables:

### Orders

- `OrderID` — primary key.
- `CustomerName`.
- Expected: 3 rows, one row per order.

### OrderItems

- `OrderID` — part of the composite primary key and a foreign key.
- `Product` — part of the composite primary key.
- `Quantity`.
- Composite primary key: `(OrderID, Product)`.
- Foreign key: `OrderID` references `Orders(OrderID)`.
- Expected: 6 rows.

The final INNER JOIN query in `answer.sql` combines both tables for verification and should return 6 rows.

## Screenshots to add

After executing the SQL successfully, capture your actual MySQL Workbench query and result grids using **Win + Shift + S**. Save the images in `screenshots/`:

1. `question1_1nf.png` — Question 1 result (6 rows).
2. `question2_orders.png` — Orders result (3 rows).
3. `question2_orderitems.png` — OrderItems result (6 rows).
4. `verification_join.png` — final JOIN result (6 rows).

Screenshots are not fabricated or pre-filled. Add genuine results from your own Workbench session.

## Conclusion

Question 1 achieves 1NF by storing one product per row. Question 2 achieves 2NF by moving customer information into `Orders` and storing products and quantities in `OrderItems`, with primary-key and foreign-key constraints.
