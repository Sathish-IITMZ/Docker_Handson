# Data Visualization Assignment Guide
**Duration: 50 minutes | Total Marks: 50**

## Pre-Assignment Setup
1. Ensure Docker Desktop is installed and running
2. Download the assignment files:
   - `docker-compose.yml`
   - `assignment_dataset.sql`
   - This guide (`assignment_guide.md`)

---

## Task 1: Environment Setup (10 marks) - 10 minutes

### Step 1.1: Deploy Docker Environment (4 marks)
```bash
# Navigate to your assignment folder
cd /path/to/assignment/folder

# Deploy the containers
docker-compose up -d
```

### Step 1.2: Verify Services (3 marks)
```bash
# Check all containers are running
docker ps

# Expected output should show 4 containers:
# - assignment_mysql
# - assignment_grafana  
# - assignment_influxdb
# - assignment_node_red
```

### Step 1.3: Access Grafana (3 marks)
1. Open browser and go to: `http://localhost:3000`
2. Login credentials:
   - Username: `admin`
   - Password: `admin123`
3. Take a screenshot of the Grafana welcome page

**Deliverable for Task 1:**
- Screenshot of `docker ps` output
- Screenshot of Grafana login/welcome page

---

## Task 2: Database Access and Exploration (15 marks) - 15 minutes

### Step 2.1: Connect to MySQL (3 marks)
```bash
# Connect to MySQL container
docker exec -it assignment_mysql mysql -u root -p

# Password: assignment123
# Then switch to workshop database
USE workshop;
```

### Step 2.2: Explore Database Structure (4 marks)
```sql
-- List all tables
SHOW TABLES;

-- Check structure of sales_data table
DESCRIBE sales_data;

-- Count records in main tables
SELECT 'sales_data' as table_name, COUNT(*) as records FROM sales_data
UNION ALL
SELECT 'employee_performance', COUNT(*) FROM employee_performance
UNION ALL
SELECT 'financial_metrics', COUNT(*) FROM financial_metrics;
```

### Step 2.3: Execute Sample Query (4 marks)
```sql
-- Execute the provided sample query
SELECT category, COUNT(*) as product_count, 
       AVG(total_amount) as avg_sales
FROM sales_data 
WHERE sale_date >= '2024-01-01'
GROUP BY category
ORDER BY avg_sales DESC;
```

### Step 2.4: Create Custom Query (4 marks)
```sql
-- Find top 5 products by total sales amount
SELECT product_name, 
       SUM(total_amount) as total_sales,
       COUNT(*) as orders_count
FROM sales_data 
GROUP BY product_name 
ORDER BY total_sales DESC 
LIMIT 5;
```

**Deliverable for Task 2:**
- Screenshot of database connection
- Screenshot of sample query results
- Screenshot of your top 5 products query results

---

## Task 3: Data Curation (10 marks) - 10 minutes

### Step 3.1: Monthly Sales Trends (4 marks)
```sql
-- Monthly sales aggregation for 2024
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') as month,
    SUM(total_amount) as monthly_revenue,
    COUNT(*) as orders_count,
    AVG(total_amount) as avg_order_value
FROM sales_data 
WHERE YEAR(sale_date) = 2024
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY month;
```

### Step 3.2: Regional Revenue Analysis (3 marks)
```sql
-- Total revenue by region
SELECT 
    region,
    SUM(total_amount) as total_revenue,
    COUNT(DISTINCT customer_segment) as customer_segments,
    AVG(total_amount) as avg_sale
FROM sales_data 
GROUP BY region 
ORDER BY total_revenue DESC;
```

### Step 3.3: Employee Performance by Department (3 marks)
```sql
-- Average performance score by department
SELECT 
    department,
    COUNT(*) as employee_count,
    AVG(performance_score) as avg_performance,
    AVG(salary) as avg_salary
FROM employee_performance 
GROUP BY department 
ORDER BY avg_performance DESC;
```

**Deliverable for Task 3:**
- Screenshots of all three query results
- Save these queries in a text file for submission

---

## Task 4: Visualization Creation (15 marks) - 15 minutes

### Step 4.1: Configure MySQL Data Source (3 marks)
1. In Grafana, go to **Configuration** → **Data Sources**
2. Click **Add data source**
3. Select **MySQL**
4. Configure:
   - **Host**: `assignment_mysql:3306`
   - **Database**: `workshop`
   - **User**: `grafana`
   - **Password**: `grafana123`
5. Click **Save & Test**

### Step 4.2: Create Bar Chart - Sales by Category (4 marks)
1. Create new dashboard
2. Add new panel
3. Select **Bar chart** visualization
4. Use this query:
```sql
SELECT 
    category as "Category",
    SUM(total_amount) as "Total Sales"
FROM sales_data 
GROUP BY category 
ORDER BY SUM(total_amount) DESC;
```
5. Panel settings:
   - **Title**: "Sales by Product Category"
   - **Y-axis label**: "Sales ($)"

### Step 4.3: Create Time Series - Sales Trends (4 marks)
1. Add new panel
2. Select **Time series** visualization  
3. Use this query:
```sql
SELECT 
    sale_date as time,
    SUM(total_amount) as value
FROM sales_data 
GROUP BY sale_date 
ORDER BY sale_date;
```
4. Panel settings:
   - **Title**: "Daily Sales Trend"
   - **Y-axis label**: "Sales ($)"

### Step 4.4: Create Stat Panel - Total Revenue (2 marks)
1. Add new panel
2. Select **Stat** visualization
3. Use this query:
```sql
SELECT SUM(total_amount) as "Total Revenue"
FROM sales_data;
```
4. Panel settings:
   - **Title**: "Total Revenue"
   - **Unit**: Currency ($)

### Step 4.5: Format and Polish (2 marks)
1. Arrange panels in a logical layout
2. Ensure all titles are descriptive
3. Check that currency formatting is applied
4. Save the dashboard as "Assignment Dashboard"

**Deliverable for Task 4:**
- Screenshot of data source configuration (Save & Test success)
- Screenshot of completed bar chart
- Screenshot of completed time series chart  
- Screenshot of completed stat panel
- Screenshot of final dashboard layout

---

## Submission Checklist

### Required Files:
1. **PDF Document** with all screenshots named: `[StudentID]_DataViz_Assignment.pdf`
2. **Text File** with all SQL queries named: `[StudentID]_Queries.txt`

### Screenshot Requirements:
- [ ] Docker ps output showing 4 running containers
- [ ] Grafana login/welcome page
- [ ] Database connection successful
- [ ] Sample query results (category analysis)
- [ ] Top 5 products query results
- [ ] Monthly sales trends query results
- [ ] Regional revenue query results
- [ ] Employee performance query results
- [ ] Grafana data source configuration
- [ ] Bar chart visualization
- [ ] Time series visualization
- [ ] Stat panel visualization
- [ ] Final dashboard layout

### SQL Queries to Include:
- [ ] Top 5 products by sales
- [ ] Monthly sales trends
- [ ] Regional revenue analysis
- [ ] Employee performance by department
- [ ] All Grafana visualization queries

---

## Troubleshooting

### Common Issues:

**Docker containers not starting:**
```bash
# Check Docker Desktop is running
# Try stopping and restarting
docker-compose down
docker-compose up -d
```

**Cannot connect to MySQL:**
```bash
# Wait 2-3 minutes for MySQL to fully initialize
# Check container logs
docker logs assignment_mysql
```

**Grafana data source connection fails:**
- Ensure you're using `assignment_mysql:3306` as host (not localhost)
- Verify credentials: grafana/grafana123
- Wait for MySQL container to be fully ready

**Time Remaining Alerts:**
- **40 minutes left**: Should have completed Task 1
- **30 minutes left**: Should have completed Task 2  
- **15 minutes left**: Should have completed Task 3
- **5 minutes left**: Focus on submission preparation

---

## Grading Rubric Quick Reference

| Task | Full Marks | Partial Credit |
|------|------------|----------------|
| Environment Setup (10) | All containers running + Grafana access | 5-7 marks for partial setup |
| Database Operations (15) | All queries working + custom query | 8-12 marks for some queries |
| Data Curation (10) | All 3 analytical queries working | 6-8 marks for 2 queries |
| Visualization (15) | All 3 charts + proper formatting | 8-12 marks for basic charts |

**Remember**: Partial marks are awarded for incomplete but correct attempts!