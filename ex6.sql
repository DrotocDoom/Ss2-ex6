CREATE DATABASE EcommerceDB;
CREATE SCHEMA shop;

CREATE TABLE shop.users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('customer', 'admin'))
);

CREATE TABLE shop.categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE shop.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK ( price > 0),
    stock_quantity INT NOT NULL CHECK ( stock_quantity >= 0),
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES shop.categories(category_id)
);

CREATE TABLE shop.orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'shipped', 'delivered', 'cancelled')),
    FOREIGN KEY (user_id) REFERENCES shop.users(user_id)
);

CREATE TABLE shop.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price NUMERIC(10, 2) NOT NULL CHECK ( price > 0),
    FOREIGN KEY (order_id) REFERENCES shop.orders(order_id),
    FOREIGN KEY (product_id) REFERENCES shop.products(product_id)
);

CREATE TABLE shop.payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    amount NUMERIC(10, 2) NOT NULL CHECK ( amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'momo', 'bank_transfer', 'cash')),
    FOREIGN KEY (order_id) REFERENCES shop.orders(order_id)
);