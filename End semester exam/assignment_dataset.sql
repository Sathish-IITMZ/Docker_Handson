-- ============================================
-- ASSIGNMENT DATASET FOR DATA VISUALIZATION
-- ============================================

USE workshop;

-- ============================================
-- SALES DATA TABLE
-- ============================================
DROP TABLE IF EXISTS sales_data;
CREATE TABLE sales_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE,
    product_name VARCHAR(100),
    category VARCHAR(50),
    region VARCHAR(50),
    customer_segment VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(12,2),
    discount_percent DECIMAL(5,2),
    profit DECIMAL(10,2),
    sales_rep VARCHAR(100),
    INDEX idx_date (sale_date),
    INDEX idx_category (category),
    INDEX idx_region (region)
);

-- ============================================
-- EMPLOYEE PERFORMANCE TABLE
-- ============================================
DROP TABLE IF EXISTS employee_performance;
CREATE TABLE employee_performance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    position VARCHAR(100),
    performance_date DATE,
    salary DECIMAL(10,2),
    performance_score DECIMAL(4,2),
    training_hours INT,
    projects_completed INT,
    attendance_rate DECIMAL(5,2),
    INDEX idx_department (department),
    INDEX idx_date (performance_date)
);

-- ============================================
-- FINANCIAL METRICS TABLE
-- ============================================
DROP TABLE IF EXISTS financial_metrics;
CREATE TABLE financial_metrics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    metric_date DATE,
    department VARCHAR(50),
    revenue DECIMAL(15,2),
    expenses DECIMAL(15,2),
    profit DECIMAL(15,2),
    budget_variance DECIMAL(6,2),
    INDEX idx_date (metric_date),
    INDEX idx_department (department)
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

-- Sales Data (50 records across different categories, regions, and dates)
INSERT INTO sales_data (sale_date, product_name, category, region, customer_segment, quantity, unit_price, total_amount, discount_percent, profit, sales_rep) VALUES
('2024-01-15', 'Laptop Pro X1', 'Technology', 'North America', 'Enterprise', 5, 1299.99, 6499.95, 5.0, 1949.99, 'John Smith'),
('2024-01-16', 'Smartphone Max', 'Technology', 'Europe', 'Consumer', 12, 899.99, 10799.88, 10.0, 2699.97, 'Sarah Wilson'),
('2024-01-17', 'Office Chair', 'Furniture', 'Asia', 'Enterprise', 8, 299.99, 2399.92, 8.0, 719.98, 'Mike Chen'),
('2024-01-18', 'Running Shoes', 'Clothing', 'North America', 'Consumer', 15, 129.99, 1949.85, 15.0, 584.96, 'Emma Davis'),
('2024-01-19', 'Coffee Machine', 'Appliances', 'Europe', 'Consumer', 6, 199.99, 1199.94, 12.0, 359.98, 'James Brown'),

('2024-01-22', 'Wireless Headphones', 'Technology', 'Asia', 'Consumer', 25, 79.99, 1999.75, 20.0, 599.93, 'Lisa Garcia'),
('2024-01-23', 'Standing Desk', 'Furniture', 'North America', 'Enterprise', 4, 599.99, 2399.96, 5.0, 719.99, 'David Miller'),
('2024-01-24', 'Winter Jacket', 'Clothing', 'Europe', 'Consumer', 18, 149.99, 2699.82, 18.0, 809.95, 'Anna Zhang'),
('2024-01-25', 'Blender Pro', 'Appliances', 'Asia', 'Consumer', 10, 89.99, 899.90, 10.0, 269.97, 'Tom Johnson'),
('2024-01-26', 'Tablet Ultra', 'Technology', 'North America', 'Education', 20, 399.99, 7999.80, 12.0, 2399.94, 'Maria Rodriguez'),

('2024-02-05', 'Gaming Monitor', 'Technology', 'Europe', 'Consumer', 7, 449.99, 3149.93, 8.0, 944.98, 'Chris Lee'),
('2024-02-06', 'Bookshelf', 'Furniture', 'Asia', 'Consumer', 12, 199.99, 2399.88, 15.0, 719.96, 'Sophie Martin'),
('2024-02-07', 'Sports Shoes', 'Clothing', 'North America', 'Consumer', 22, 99.99, 2199.78, 22.0, 659.93, 'Kevin Park'),
('2024-02-08', 'Microwave', 'Appliances', 'Europe', 'Consumer', 8, 159.99, 1279.92, 10.0, 383.98, 'Carlos Ruiz'),
('2024-02-09', 'Smart Watch', 'Technology', 'Asia', 'Consumer', 16, 249.99, 3999.84, 16.0, 1199.95, 'Eva Van Der Berg'),

('2024-02-12', 'Keyboard Pro', 'Technology', 'North America', 'Enterprise', 30, 129.99, 3899.70, 25.0, 1169.91, 'Alex Thompson'),
('2024-02-13', 'Sofa Set', 'Furniture', 'Europe', 'Consumer', 2, 899.99, 1799.98, 5.0, 539.99, 'Rachel Green'),
('2024-02-14', 'Dress Shirt', 'Clothing', 'Asia', 'Consumer', 35, 39.99, 1399.65, 30.0, 419.90, 'Daniel Kim'),
('2024-02-15', 'Toaster', 'Appliances', 'North America', 'Consumer', 14, 49.99, 699.86, 20.0, 209.96, 'Jennifer Lopez'),
('2024-02-16', 'Webcam HD', 'Technology', 'Europe', 'Enterprise', 25, 89.99, 2249.75, 15.0, 674.93, 'Robert Taylor'),

('2024-03-01', 'Mouse Wireless', 'Technology', 'Asia', 'Consumer', 40, 29.99, 1199.60, 25.0, 359.88, 'Michelle Obama'),
('2024-03-02', 'Coffee Table', 'Furniture', 'North America', 'Consumer', 6, 249.99, 1499.94, 10.0, 449.98, 'William Gates'),
('2024-03-03', 'Jeans Premium', 'Clothing', 'Europe', 'Consumer', 28, 69.99, 1959.72, 28.0, 587.92, 'Steve Jobs'),
('2024-03-04', 'Rice Cooker', 'Appliances', 'Asia', 'Consumer', 12, 79.99, 959.88, 12.0, 287.96, 'Oprah Winfrey'),
('2024-03-05', 'USB Drive', 'Technology', 'North America', 'Enterprise', 50, 19.99, 999.50, 30.0, 299.85, 'Elon Musk'),

('2024-03-08', 'Monitor Stand', 'Furniture', 'Europe', 'Enterprise', 15, 79.99, 1199.85, 15.0, 359.96, 'Bill Clinton'),
('2024-03-09', 'T-Shirt Pack', 'Clothing', 'Asia', 'Consumer', 45, 24.99, 1124.55, 35.0, 337.37, 'Hillary Clinton'),
('2024-03-10', 'Air Fryer', 'Appliances', 'North America', 'Consumer', 9, 129.99, 1169.91, 9.0, 350.97, 'Barack Obama'),
('2024-03-11', 'Router WiFi', 'Technology', 'Europe', 'Consumer', 18, 99.99, 1799.82, 18.0, 539.95, 'Donald Trump'),
('2024-03-12', 'Desk Lamp', 'Furniture', 'Asia', 'Consumer', 24, 39.99, 959.76, 24.0, 287.93, 'Joe Biden'),

('2024-03-15', 'Sneakers', 'Clothing', 'North America', 'Consumer', 32, 89.99, 2879.68, 32.0, 863.90, 'Angela Merkel'),
('2024-03-16', 'Vacuum Cleaner', 'Appliances', 'Europe', 'Consumer', 5, 199.99, 999.95, 5.0, 299.99, 'Emmanuel Macron'),
('2024-03-17', 'External Drive', 'Technology', 'Asia', 'Enterprise', 20, 119.99, 2399.80, 20.0, 719.94, 'Vladimir Putin'),
('2024-03-18', 'Wardrobe', 'Furniture', 'North America', 'Consumer', 3, 499.99, 1499.97, 3.0, 449.99, 'Xi Jinping'),
('2024-03-19', 'Hoodie', 'Clothing', 'Europe', 'Consumer', 26, 49.99, 1299.74, 26.0, 389.92, 'Narendra Modi'),

('2024-03-22', 'Dishwasher', 'Appliances', 'Asia', 'Consumer', 4, 399.99, 1599.96, 4.0, 479.99, 'Justin Trudeau'),
('2024-03-23', 'Graphics Card', 'Technology', 'North America', 'Consumer', 8, 699.99, 5599.92, 8.0, 1679.98, 'Boris Johnson'),
('2024-03-24', 'Bean Bag', 'Furniture', 'Europe', 'Consumer', 16, 79.99, 1279.84, 16.0, 383.95, 'Scott Morrison'),
('2024-03-25', 'Polo Shirt', 'Clothing', 'Asia', 'Consumer', 38, 34.99, 1329.62, 38.0, 398.89, 'Jacinda Ardern'),
('2024-03-26', 'Food Processor', 'Appliances', 'North America', 'Consumer', 11, 149.99, 1649.89, 11.0, 494.97, 'Moon Jae-in'),

('2024-04-02', 'SSD Drive', 'Technology', 'Europe', 'Enterprise', 35, 159.99, 5599.65, 35.0, 1679.90, 'Yoshihide Suga'),
('2024-04-03', 'Filing Cabinet', 'Furniture', 'Asia', 'Enterprise', 8, 299.99, 2399.92, 8.0, 719.98, 'Joko Widodo'),
('2024-04-04', 'Formal Pants', 'Clothing', 'North America', 'Consumer', 29, 59.99, 1739.71, 29.0, 521.91, 'Rodrigo Duterte'),
('2024-04-05', 'Washing Machine', 'Appliances', 'Europe', 'Consumer', 3, 599.99, 1799.97, 3.0, 539.99, 'Sergio Mattarella'),
('2024-04-06', 'Power Bank', 'Technology', 'Asia', 'Consumer', 42, 39.99, 1679.58, 42.0, 503.87, 'Frank-Walter Steinmeier'),

('2024-04-09', 'Office Desk', 'Furniture', 'North America', 'Enterprise', 7, 399.99, 2799.93, 7.0, 839.98, 'Marcelo Rebelo'),
('2024-04-10', 'Blazer', 'Clothing', 'Europe', 'Consumer', 19, 129.99, 2469.81, 19.0, 740.94, 'Andrej Kiska'),
('2024-04-11', 'Refrigerator', 'Appliances', 'Asia', 'Consumer', 2, 899.99, 1799.98, 2.0, 539.99, 'Ram Nath Kovind'),
('2024-04-12', 'Printer', 'Technology', 'North America', 'Enterprise', 12, 249.99, 2999.88, 12.0, 899.96, 'Michael Higgins'),
('2024-04-13', 'Dining Table', 'Furniture', 'Europe', 'Consumer', 4, 699.99, 2799.96, 4.0, 839.99, 'Sergio Mattarella');

-- Employee Performance Data
INSERT INTO employee_performance (employee_name, department, position, performance_date, salary, performance_score, training_hours, projects_completed, attendance_rate) VALUES
('Alice Johnson', 'Sales', 'Sales Manager', '2024-01-15', 75000.00, 88.5, 40, 12, 96.5),
('Bob Williams', 'Marketing', 'Marketing Specialist', '2024-01-15', 62000.00, 82.3, 35, 8, 94.2),
('Carol Brown', 'Technology', 'Software Developer', '2024-01-15', 85000.00, 91.2, 55, 15, 98.1),
('David Garcia', 'Operations', 'Operations Analyst', '2024-01-15', 58000.00, 78.9, 28, 6, 92.8),
('Emma Martinez', 'HR', 'HR Specialist', '2024-01-15', 55000.00, 85.7, 42, 9, 95.6),
('Frank Wilson', 'Sales', 'Sales Representative', '2024-01-15', 48000.00, 76.4, 25, 10, 89.3),
('Grace Lee', 'Technology', 'QA Engineer', '2024-01-15', 72000.00, 89.1, 48, 13, 97.2),
('Henry Davis', 'Marketing', 'Content Creator', '2024-01-15', 52000.00, 81.6, 32, 7, 93.8),
('Ivy Chen', 'Operations', 'Supply Chain Manager', '2024-01-15', 68000.00, 87.3, 38, 11, 96.1),
('Jack Thompson', 'HR', 'Recruiter', '2024-01-15', 51000.00, 79.8, 30, 8, 91.4),
('Kate Rodriguez', 'Sales', 'Account Manager', '2024-01-15', 65000.00, 84.2, 35, 9, 94.7),
('Liam O\'Connor', 'Technology', 'DevOps Engineer', '2024-01-15', 78000.00, 90.5, 52, 14, 98.9),
('Mia Patel', 'Marketing', 'Digital Marketing Manager', '2024-01-15', 67000.00, 86.8, 41, 10, 95.3),
('Noah Kim', 'Operations', 'Project Manager', '2024-01-15', 71000.00, 88.7, 45, 12, 97.5),
('Olivia Zhang', 'HR', 'Training Coordinator', '2024-01-15', 54000.00, 83.1, 39, 8, 93.2);

-- Financial Metrics Data
INSERT INTO financial_metrics (metric_date, department, revenue, expenses, profit, budget_variance) VALUES
('2024-01-15', 'Sales', 125000.00, 75000.00, 50000.00, 5.2),
('2024-01-15', 'Marketing', 45000.00, 35000.00, 10000.00, -2.1),
('2024-01-15', 'Technology', 95000.00, 82000.00, 13000.00, 3.7),
('2024-01-15', 'Operations', 85000.00, 70000.00, 15000.00, 1.8),
('2024-01-15', 'HR', 18000.00, 16500.00, 1500.00, -5.3),
('2024-02-15', 'Sales', 135000.00, 80000.00, 55000.00, 7.1),
('2024-02-15', 'Marketing', 48000.00, 37000.00, 11000.00, -1.5),
('2024-02-15', 'Technology', 102000.00, 85000.00, 17000.00, 4.2),
('2024-02-15', 'Operations', 88000.00, 72000.00, 16000.00, 2.3),
('2024-02-15', 'HR', 19000.00, 17000.00, 2000.00, -4.8),
('2024-03-15', 'Sales', 142000.00, 83000.00, 59000.00, 8.5),
('2024-03-15', 'Marketing', 52000.00, 39000.00, 13000.00, -0.8),
('2024-03-15', 'Technology', 108000.00, 88000.00, 20000.00, 5.1),
('2024-03-15', 'Operations', 91000.00, 74000.00, 17000.00, 2.9),
('2024-03-15', 'HR', 20000.00, 17500.00, 2500.00, -3.2),
('2024-04-15', 'Sales', 148000.00, 85000.00, 63000.00, 9.2),
('2024-04-15', 'Marketing', 55000.00, 41000.00, 14000.00, 0.3),
('2024-04-15', 'Technology', 115000.00, 91000.00, 24000.00, 6.1),
('2024-04-15', 'Operations', 94000.00, 76000.00, 18000.00, 3.5),
('2024-04-15', 'HR', 21000.00, 18000.00, 3000.00, -2.1);

-- Create a simple view for easier querying
CREATE VIEW sales_summary AS
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') as month,
    category,
    region,
    SUM(total_amount) as total_sales,
    SUM(profit) as total_profit,
    COUNT(*) as transaction_count,
    AVG(total_amount) as avg_transaction
FROM sales_data 
GROUP BY DATE_FORMAT(sale_date, '%Y-%m'), category, region;

-- Success message
SELECT 'Assignment dataset loaded successfully!' as status;