# 🛍️ E-commerce Database Design

This project presents the database design for a comprehensive e-commerce platform. It includes an Entity-Relationship Diagram (ERD) and an SQL script to create all the necessary tables and relationships.

## 🎯 Objective

To design and implement a relational database for an e-commerce platform with features such as product variations, attributes, categories, and brand management.

## 📊 Entity Relationship Diagram (ERD)

You can view the interactive ERD here:
[E-commerce Database ERD](https://dbdiagram.io/d/e-commerceDiagram-68193ba41ca52373f5913034)

## 🗃️ Tables Overview

### ✅ `brand`
Stores brand-related information.

### ✅ `product_category`
Classifies products into categories with hierarchical structure.

### ✅ `product`
Core product information table.

### ✅ `product_image`
Stores image references for products.

### ✅ `color`
Available color options with name and code.

### ✅ `size_category`
Groups sizes into categories (e.g., clothing sizes, shoe sizes).

### ✅ `size_option`
Specific size values, linked to a size category.

### ✅ `product_item`
Represents stockable and purchasable items.

### ✅ `product_variation`
Links product items to specific variations (size + color).

### ✅ `attribute_category`
Groups types of product attributes.
- `attribute_category_id` - Unique identifier for each attribute category
- `category_name` - Name of the attribute category
- `description` - Detailed description of the attribute category
- `created_at` - Timestamp for record creation

### ✅ `attribute_type`
Defines the attribute data types.

### ✅ `product_attribute`
Stores actual attribute values per product.

## 🚀 How to Use

1. Clone or download this repository
2. Open a SQL environment (MySQL or compatible)
3. Run the `ecommerce.sql` file to create the database and tables
4. The script includes sample data to help you get started
5. Extend or customize as needed for your specific e-commerce requirements

## 📁 Files Included

- `e-commerce.sql` – Full SQL script for database creation with sample data
- `README.md` – Project overview and table descriptions
- ERD diagram accessible via the link above

## 📝 Design Decisions

- **Hierarchical Categories**: Product categories support parent-child relationships for unlimited depth.
- **Flexible Attributes**: The attribute system allows for any type of product specification.
- **Inventory Management**: Each product item tracks its own stock quantity.
- **Image Management**: Support for multiple images per product with display order.
- **Variation System**: Comprehensive system for handling different product variants (size, color).

## 🔄 Data Flow

1. Products are created and assigned to a category and brand
2. Product items are created for each purchasable variation
3. Product variations link specific combinations of attributes (size, color) to product items
4. Product attributes store additional specifications
5. Product images are linked to products

---
Made with 💻 and ☕ by [Group 353]
