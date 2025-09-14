-- Question 1: Achieving 1NF by splitting Products into individual rows
-- Assuming ProductDetail(OrderID, CustomerName, Products) table exists

SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
) numbers ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY OrderID;

-- This query uses a number table pattern to split comma-separated Products into multiple rows


-- Question 2: Achieving 2NF by removing partial dependency (CustomerName depends only on OrderID)
-- Separate OrderDetails table without CustomerName

-- Create Orders table with OrderID and CustomerName
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create normalized OrderDetails table with OrderID, Product, Quantity only
SELECT OrderID, Product, Quantity
FROM OrderDetails;
