-- Step 1: Create the original table
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(255),
    Products VARCHAR(255)
);

-- Step 2: Insert the given data
INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 3: Create the transformed table for 1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Step 4: Transform the data into 1NF
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Verify the transformation
SELECT * FROM ProductDetail_1NF;


--QUESTION 2: Normalize the table to 2NF 

-- Step 1: Create the original table
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255),
    Quantity INT
);

-- Step 2: Insert the given data
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Step 3: Create the normalized tables
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 4: Populate the normalized tables
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- Verify the transformation
SELECT * FROM Orders;
SELECT * FROM OrderProducts;