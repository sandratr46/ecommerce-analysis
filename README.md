# 🛍️ E-commerce Customer & Product Analytics Dashboard

## 📌 Project Overview

This project analyzes customer behavior, product performance, and return impact using transactional e-commerce data.
The objective is to identify key drivers of revenue, customer value, and financial loss caused by product returns and customer churn.

---

## 🎯 Objectives

* Understand customer segmentation and value distribution
* Analyze churn behavior and identify at-risk customers
* Evaluate product performance and return impact
* Quantify revenue loss due to returns

---

## 📂 Dataset Description

The dataset contains transactional-level data with the following key fields:

* Customer_ID
* Age, Gender
* Product_ID, Product_Category
* Purchase_Date
* Quantity
* Total_Purchase_Amount
* Returns (0/1)
* Churn (0/1)
  
**Source:** Kaggle – https://www.kaggle.com/datasets/shriyashjagtap/e-commerce-customer-for-behavior-analysis/data

---
## 🧠 Approach & Methodology

### Data Notes

* Dataset is **synthetic (Kaggle)** and may not fully reflect real-world behavior
* Customer names are duplicated and not suitable as unique identifiers
* Original dataset lacked `Order_ID` and `Product_ID`
* `Returns` column contained missing values

---

### Data Cleaning & Preparation

Data preprocessing was performed using SQL prior to visualization in Power BI.

1. **Handle Missing Values**
  * The Returns column contains missing (blank) values.
  * Since this field represents a binary indicator (1 = returned, 0 = not returned), all blank values were assumed to indicate that the order was not returned.
  * Missing values were therefore replaced with 0 to ensure consistency in analysis.


2. **Data Standardization**

   * Standardized categorical values (e.g., gender, product categories)
   * Validated numeric fields for consistency

3. **Generate Unique Identifiers**

   * Created synthetic `Order_ID`, and `Product_ID` using SQL
     
<img width="930" height="457" alt="Screenshot 2026-04-27 at 22 26 02" src="https://github.com/user-attachments/assets/35db597f-2c9a-4c6b-9299-093e26d2e820" />

4. **Data Modeling**

   * Designed a **star schema**:

     * Fact table: Order
     * Dimension tables: Customer, Product, Customer Segment
<img width="897" height="433" alt="Screenshot 2026-04-27 at 18 44 26" src="https://github.com/user-attachments/assets/d4f1395d-d403-4b99-9c1a-ebf3de15eef0" />

---

### Customer Segmentation

* Implemented using **PERCENT_RANK() in SQL**
* Segments:

  * Top 20% → High Value
  * Next 30% → Medium Value
  * Bottom 50% → Low Value
<img width="897" height="442" alt="Screenshot 2026-04-27 at 18 45 10" src="https://github.com/user-attachments/assets/b5460428-2129-4a43-9350-5390113ce23d" />

---

### Key Metrics (DAX)

* Total Revenue / Net Revenue
* Return Rate
* Revenue Lost from Returns
* Churn Rate
* Average Customer Value

---
## 🔍 Data Discovery & Key Findings

### 1. Customer Insights

* Customer distribution is skewed toward the **low-value segment (~50%)**, while high-value customers represent only ~20% of the base
* Despite their smaller size, **high-value customers contribute a disproportionate share of total revenue**
* Customer demographics (age and gender) are relatively balanced

👉 **Insight:** Revenue is highly concentrated among a small group of high-value customers, making retention and targeted engagement critical.

---

### 2. Churn Analysis

* Overall churn rate is approximately **~20%**
* Low-value customers contribute the **highest number of churned customers** due to their larger population
* **High-value customers exhibit a slightly higher churn rate**, indicating greater risk per individual

👉 **Insight:** Although churn volume is driven by low-value customers, high-value customers represent a higher relative risk. Losing even a small portion of this segment can significantly impact revenue.

---

### 3. Product Performance

* Revenue contribution is **evenly distributed across all product categories**
* Sales volume (quantity sold) remains consistent across categories

👉 **Insight:** The business operates on a diversified product base, reducing dependency on any single category but limiting standout performance drivers.

---

### 4. Return Analysis (Key Focus)

* Return rates are consistently high at approximately **~41% across all categories**
* Revenue lost due to returns is substantial (~277M), significantly reducing overall profitability
* Net revenue (~405M) is heavily impacted by return-related losses

👉 **Insight:** Returns represent a major operational inefficiency affecting the entire business, rather than a category-specific issue.

---

### 5. Return Impact vs Sales Performance

* Categories generating higher revenue also incur **proportionally higher return losses**
* High sales volume does not necessarily translate into better performance due to the **offsetting impact of returns**

👉 **Insight:** Strong sales performance is undermined by high return rates, indicating that improving return management could significantly enhance profitability.

---

### 6. Time-Based Performance Trends

* Order volume and revenue remain relatively stable in the first half of the year
* A noticeable **decline in revenue occurs toward the end of the year**, despite relatively stable order volume
* Return rates remain consistently high across all months (~40%)

👉 **Insight:** The late-year revenue decline is not driven solely by demand, suggesting potential external factors such as seasonality or shifts in customer behavior.

---

## 📊 Dashboard Features

### Customer Page

* Customer segmentation (High / Medium / Low)
* Churn risk analysis by segment
* Demographic distribution (Age, Gender)
* Top 3 Customer
* Revenue by Customer Segmentation
<img width="769" height="435" alt="Screenshot 2026-04-27 at 18 40 52" src="https://github.com/user-attachments/assets/119f5287-daee-4ea4-8812-b2d02c7d8a5b" />

### Product Page

* Revenue vs Revenue Lost comparison
* Return rate by category
* Return impact analysis (scatter & combo charts)
<img width="769" height="435" alt="Screenshot 2026-04-27 at 18 42 09" src="https://github.com/user-attachments/assets/aaac607a-3de3-4aa9-87bb-5944c0515d09" />

### Performance Page

* KPI overview (Net Revenue, Orders, Return Rate, Churn Rate)
* Monthly trends for revenue, orders, and returns
<img width="769" height="435" alt="Screenshot 2026-04-27 at 18 42 38" src="https://github.com/user-attachments/assets/069df31d-fd7e-43cb-92d6-74b430b1d13c" />

---


## 📈 Business Recommendations

* Investigate root causes of high return rates (e.g., product quality or expectation mismatch)
* Improve retention strategies for high-value customers.
* Develop engagement strategies to convert medium-value customers
* Optimize return policies to reduce financial loss

---

## 🚀 Future Improvements

* Implement RFM segmentation
* Add predictive churn modeling
* Conduct deeper product-level return analysis
* Incorporate time-series forecasting

---

## 📎 Author

Sandra Trinh



