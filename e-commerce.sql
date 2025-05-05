-- E-commerce Database Schema
-- Created: May 6, 2025

-- Drop database if exists (be careful with this in production!)
DROP DATABASE IF EXISTS ecommerce;

-- Create database
CREATE DATABASE ecommerce;

-- Use the database
USE ecommerce;

-- Create brand table
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    description TEXT,
    logo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (brand_name)
);

-- Create product_category table
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (category_name),
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id) ON DELETE CASCADE
);

-- Create product table
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id) ON DELETE RESTRICT,
    FOREIGN KEY (category_id) REFERENCES product_category(category_id) ON DELETE RESTRICT
);

-- Create product_image table
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Create color table
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL,
    color_code VARCHAR(20) NOT NULL, -- HEX or RGB code
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY (color_name),
    UNIQUE KEY (color_code)
);

-- Create size_category table
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY (category_name)
);

-- Create size_option table
CREATE TABLE size_option (
    size_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT NOT NULL,
    size_name VARCHAR(20) NOT NULL,
    size_code VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY (size_category_id, size_code),
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id) ON DELETE CASCADE
);

-- Create product_item table
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    SKU VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (SKU),
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Create product_variation table
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT NOT NULL,
    size_id INT,
    color_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY (product_item_id, size_id, color_id),
    FOREIGN KEY (product_item_id) REFERENCES product_item(item_id) ON DELETE CASCADE,
    FOREIGN KEY (size_id) REFERENCES size_option(size_id) ON DELETE RESTRICT,
    FOREIGN KEY (color_id) REFERENCES color(color_id) ON DELETE RESTRICT
);

-- Create attribute_category table
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY (category_name)
);

-- Create attribute_type table
CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY (type_name)
);

-- Create product_attribute table
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    attribute_category_id INT NOT NULL,
    attribute_type_id INT NOT NULL,
    attribute_name VARCHAR(100) NOT NULL,
    attribute_value TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id) ON DELETE RESTRICT,
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id) ON DELETE RESTRICT
);

-- Insert sample data for testing

-- Brands
INSERT INTO brand (brand_name, description, logo_url) VALUES
('Nike', 'Sports apparel and footwear', 'https://example.com/logos/nike.png'),
('Samsung', 'Electronics manufacturer', 'https://example.com/logos/samsung.png'),
('IKEA', 'Furniture retailer', 'https://example.com/logos/ikea.png');

-- Product Categories
INSERT INTO product_category (category_name, description, parent_category_id) VALUES
('Electronics', 'Electronic devices and accessories', NULL),
('Clothing', 'Apparel items', NULL),
('Furniture', 'Home and office furniture', NULL);

INSERT INTO product_category (category_name, description, parent_category_id) VALUES
('Smartphones', 'Mobile phones and accessories', 1),
('Laptops', 'Portable computers', 1),
('T-Shirts', 'Casual tops', 2),
('Shoes', 'Footwear', 2),
('Sofas', 'Living room seating', 3);

-- Colors
INSERT INTO color (color_name, color_code) VALUES
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Black', '#000000'),
('White', '#FFFFFF'),
('Green', '#00FF00');

-- Size Categories
INSERT INTO size_category (category_name, description) VALUES
('Clothing Sizes', 'Standard clothing size measurements'),
('Shoe Sizes', 'Standard shoe size measurements'),
('Electronic Sizes', 'Dimensions for electronic products');

-- Size Options
INSERT INTO size_option (size_category_id, size_name, size_code) VALUES
(1, 'Small', 'S'),
(1, 'Medium', 'M'),
(1, 'Large', 'L'),
(1, 'X-Large', 'XL'),
(2, 'US 8', '8'),
(2, 'US 9', '9'),
(2, 'US 10', '10'),
(3, '13 inch', '13IN'),
(3, '15 inch', '15IN');

-- Attribute Categories
INSERT INTO attribute_category (category_name, description) VALUES
('Physical', 'Physical characteristics'),
('Technical', 'Technical specifications'),
('Material', 'Product materials');

-- Attribute Types
INSERT INTO attribute_type (type_name, description) VALUES
('Text', 'Text value'),
('Number', 'Numeric value'),
('Boolean', 'True/False value');

-- Sample Products
INSERT INTO product (product_name, brand_id, category_id, base_price, description, is_active) VALUES
('Galaxy S25', 2, 4, 999.99, 'Latest Samsung smartphone with advanced features', TRUE),
('Air Max 270', 1, 7, 150.00, 'Athletic shoes with air cushioning', TRUE),
('KIVIK Sofa', 3, 8, 499.99, 'Comfortable 3-seat sofa', TRUE);

-- Product Images
INSERT INTO product_image (product_id, image_url, is_primary, display_order) VALUES
(1, 'https://example.com/images/galaxy-s25-front.jpg', TRUE, 1),
(1, 'https://example.com/images/galaxy-s25-back.jpg', FALSE, 2),
(2, 'https://example.com/images/airmax-270-side.jpg', TRUE, 1),
(3, 'https://example.com/images/kivik-sofa.jpg', TRUE, 1);

-- Product Items (specific variants)
INSERT INTO product_item (product_id, SKU, price, quantity_in_stock, is_active) VALUES
(1, 'SM-G25-BLK-128', 999.99, 50, TRUE),  -- Galaxy S25 Black 128GB
(1, 'SM-G25-WHT-128', 999.99, 30, TRUE),  -- Galaxy S25 White 128GB
(2, 'NK-AM270-RED-9', 150.00, 25, TRUE),  -- Nike Air Max Red Size 9
(2, 'NK-AM270-BLU-9', 150.00, 20, TRUE),  -- Nike Air Max Blue Size 9
(3, 'IK-KVK-BLK', 499.99, 10, TRUE);      -- KIVIK Sofa Black

-- Product Variations
INSERT INTO product_variation (product_item_id, size_id, color_id) VALUES
(1, NULL, 3),  -- Galaxy S25, Black
(2, NULL, 4),  -- Galaxy S25, White
(3, 6, 1),     -- Air Max, Size 9, Red
(4, 6, 2),     -- Air Max, Size 9, Blue
(5, NULL, 3);  -- KIVIK Sofa, Black

-- Product Attributes
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, attribute_name, attribute_value) VALUES
(1, 2, 2, 'Storage', '128GB'),
(1, 2, 2, 'RAM', '8GB'),
(1, 2, 1, 'Processor', 'Snapdragon 8 Gen 3'),
(2, 1, 1, 'Material', 'Mesh and synthetic leather'),
(2, 3, 2, 'Weight', '300g'),
(3, 3, 1, 'Material', 'Cotton and polyester'),
(3, 1, 2, 'Width', '228cm');
