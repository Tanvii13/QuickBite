/*
==========================================================
QuickBite Food Delivery Platform
Database Schema
==========================================================
*/
DROP SCHEMA IF EXISTS delivery_platform CASCADE;
CREATE SCHEMA delivery_platform;
SET search_path TO delivery_platform;
-- ────────────────────────────────────────────────────────────────
-- 1. USER (quoted: USER is a reserved keyword in PostgreSQL)
-- ────────────────────────────────────────────────────────────────
CREATE TABLE "USER" (
 user_id SERIAL PRIMARY KEY,
 full_name VARCHAR(100) NOT NULL,
 email VARCHAR(150) NOT NULL UNIQUE,
 phone VARCHAR(15) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 role VARCHAR(20) NOT NULL
 CHECK (role IN ('customer','business_owner','delivery_partner','admin')),
 registered_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 last_login TIMESTAMP,
 status VARCHAR(20) NOT NULL DEFAULT 'active'
 CHECK (status IN ('active','suspended','deleted'))
);
-- ────────────────────────────────────────────────────────────────
-- 2. CUSTOMER (specialisation of USER)
-- ────────────────────────────────────────────────────────────────
CREATE TABLE CUSTOMER (
 customer_id SERIAL PRIMARY KEY,
 user_id INT NOT NULL UNIQUE
 REFERENCES "USER"(user_id) ON DELETE CASCADE
);
-- ────────────────────────────────────────────────────────────────
-- 3. BUSINESS_OWNER (specialisation of USER)
-- ────────────────────────────────────────────────────────────────
CREATE TABLE BUSINESS_OWNER (
 owner_id SERIAL PRIMARY KEY,
 user_id INT NOT NULL UNIQUE
 REFERENCES "USER"(user_id) ON DELETE CASCADE
);
-- ────────────────────────────────────────────────────────────────
-- 4. DELIVERY_PARTNER (specialisation of USER)
-- ────────────────────────────────────────────────────────────────
CREATE TABLE DELIVERY_PARTNER (
 partner_id SERIAL PRIMARY KEY,
 user_id INT NOT NULL UNIQUE
 REFERENCES "USER"(user_id) ON DELETE CASCADE,
 vehicle_type VARCHAR(30) NOT NULL
 CHECK (vehicle_type IN ('bike','bicycle','scooter','car')),
 availability BOOLEAN NOT NULL DEFAULT FALSE,
 last_lat NUMERIC(9,6),
 last_lng NUMERIC(9,6),
 bank_account VARCHAR(30)
);
-- ────────────────────────────────────────────────────────────────
-- 5. GROCERY_STORE
-- ────────────────────────────────────────────────────────────────
CREATE TABLE GROCERY_STORE (
 store_id SERIAL PRIMARY KEY,
 owner_id INT NOT NULL
 REFERENCES BUSINESS_OWNER(owner_id),
 name VARCHAR(150) NOT NULL,
 address TEXT NOT NULL,
 avg_rating NUMERIC(3,2) NOT NULL DEFAULT 0.00
 CHECK (avg_rating BETWEEN 0 AND 5),
 min_order_amount NUMERIC(10,2) NOT NULL DEFAULT 0,
 delivery_radius_km NUMERIC(5,2) NOT NULL,
 fssai_license VARCHAR(30) UNIQUE,
 gstin VARCHAR(20) UNIQUE,
 avg_delivery_mins INT DEFAULT 45,
 is_open BOOLEAN NOT NULL DEFAULT FALSE,
 reg_status VARCHAR(20) NOT NULL DEFAULT 'pending'
 CHECK (reg_status IN
('pending','approved','rejected','suspended')),
 store_type VARCHAR(30),
 commission_pct NUMERIC(5,2) NOT NULL DEFAULT 10.00
);
-- ────────────────────────────────────────────────────────────────
-- 6. RESTAURANT
-- ────────────────────────────────────────────────────────────────
CREATE TABLE RESTAURANT (
 restaurant_id SERIAL PRIMARY KEY,
 owner_id INT NOT NULL
 REFERENCES BUSINESS_OWNER(owner_id),
 area_id INT,
 name VARCHAR(150) NOT NULL,
 address TEXT NOT NULL,
 lat NUMERIC(9,6),
 lng NUMERIC(9,6),
 fssai_license VARCHAR(30) UNIQUE,
 gstin VARCHAR(20) UNIQUE,
 cuisines TEXT,
 open_time TIME,
 close_time TIME,
 is_open BOOLEAN NOT NULL DEFAULT FALSE,
 reg_status VARCHAR(20) NOT NULL DEFAULT 'pending'
 CHECK (reg_status IN
('pending','approved','rejected','suspended')),
 min_order_amount NUMERIC(10,2) NOT NULL DEFAULT 0,
 avg_delivery_mins INT DEFAULT 30,
 delivery_radius_km NUMERIC(5,2),
 avg_rating NUMERIC(3,2) NOT NULL DEFAULT 0.00
 CHECK (avg_rating BETWEEN 0 AND 5),
 total_ratings INT NOT NULL DEFAULT 0,
 bank_account VARCHAR(30),
 commission_pct NUMERIC(5,2) NOT NULL DEFAULT 15.00
);
-- ────────────────────────────────────────────────────────────────
-- 7. CUSTOMER_ADDRESS
-- ────────────────────────────────────────────────────────────────
CREATE TABLE CUSTOMER_ADDRESS (
 address_id SERIAL PRIMARY KEY,
 customer_id INT NOT NULL
 REFERENCES CUSTOMER(customer_id) ON DELETE CASCADE,
 label VARCHAR(50) NOT NULL DEFAULT 'Home',
 address_line TEXT NOT NULL,
 city VARCHAR(100) NOT NULL,
 pincode VARCHAR(10) NOT NULL,
 lat NUMERIC(9,6),
 lng NUMERIC(9,6),
 is_default BOOLEAN NOT NULL DEFAULT FALSE
);
-- ────────────────────────────────────────────────────────────────
-- 8. PRODUCT_CATEGORY
-- ────────────────────────────────────────────────────────────────
CREATE TABLE PRODUCT_CATEGORY (
 category_id SERIAL PRIMARY KEY,
 store_id INT NOT NULL
 REFERENCES GROCERY_STORE(store_id) ON DELETE CASCADE,
 name VARCHAR(100) NOT NULL,
 unit_type VARCHAR(30),
 mrp NUMERIC(10,2),
 display_order INT NOT NULL DEFAULT 0,
 description TEXT,
 UNIQUE (store_id, name)
);
-- ────────────────────────────────────────────────────────────────
-- 9. PRODUCT
-- ────────────────────────────────────────────────────────────────
CREATE TABLE PRODUCT (
 product_id SERIAL PRIMARY KEY,
 category_id INT NOT NULL
 REFERENCES PRODUCT_CATEGORY(category_id),
 name VARCHAR(150) NOT NULL,
 brand VARCHAR(100),
 avg_rating NUMERIC(3,2) NOT NULL DEFAULT 0.00
 CHECK (avg_rating BETWEEN 0 AND 5),
 net_weight VARCHAR(30),
 is_perishable BOOLEAN NOT NULL DEFAULT FALSE,
 selling_price NUMERIC(10,2) NOT NULL CHECK (selling_price >= 0),
 veg_flag BOOLEAN NOT NULL DEFAULT TRUE,
 photo_url TEXT,
 stock_qty INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0)
);
-- ────────────────────────────────────────────────────────────────
-- 10. PRODUCT_VARIANT
-- ────────────────────────────────────────────────────────────────
CREATE TABLE PRODUCT_VARIANT (
 variant_id SERIAL PRIMARY KEY,
 product_id INT NOT NULL
 REFERENCES PRODUCT(product_id) ON DELETE CASCADE,
 label VARCHAR(50) NOT NULL,
 mrp NUMERIC(10,2) NOT NULL CHECK (mrp >= 0),
 selling_price NUMERIC(10,2) NOT NULL CHECK (selling_price >= 0),
 stock_qty INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
 UNIQUE (product_id, label)
);
-- ────────────────────────────────────────────────────────────────
-- 11. MENU_CATEGORY
-- ────────────────────────────────────────────────────────────────
CREATE TABLE MENU_CATEGORY (
 category_id SERIAL PRIMARY KEY,
 restaurant_id INT NOT NULL
 REFERENCES RESTAURANT(restaurant_id) ON DELETE CASCADE,
 name VARCHAR(100) NOT NULL,
 display_order INT NOT NULL DEFAULT 0,
 UNIQUE (restaurant_id, name)
);
-- ────────────────────────────────────────────────────────────────
-- 12. MENU_ITEM
-- ────────────────────────────────────────────────────────────────
CREATE TABLE MENU_ITEM (
 item_id SERIAL PRIMARY KEY,
 category_id INT NOT NULL
 REFERENCES MENU_CATEGORY(category_id),
 restaurant_id INT NOT NULL
 REFERENCES RESTAURANT(restaurant_id),
 name VARCHAR(150) NOT NULL,
 description TEXT,
 veg_flag BOOLEAN NOT NULL DEFAULT TRUE,
 price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
 available BOOLEAN NOT NULL DEFAULT TRUE,
 photo_url TEXT,
 avg_rating NUMERIC(3,2) NOT NULL DEFAULT 0.00
 CHECK (avg_rating BETWEEN 0 AND 5)
);
-- ────────────────────────────────────────────────────────────────
-- 13. COMBO_DEAL
-- ────────────────────────────────────────────────────────────────
CREATE TABLE COMBO_DEAL (
 combo_id SERIAL PRIMARY KEY,
 restaurant_id INT NOT NULL
 REFERENCES RESTAURANT(restaurant_id) ON DELETE CASCADE,
 name VARCHAR(150) NOT NULL,
 price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
 UNIQUE (restaurant_id, name)
);
-- ────────────────────────────────────────────────────────────────
-- 14. COMBO_ITEM (all-key relation, no non-trivial FDs)
-- ────────────────────────────────────────────────────────────────
CREATE TABLE COMBO_ITEM (
 combo_id INT NOT NULL REFERENCES COMBO_DEAL(combo_id) ON DELETE CASCADE,
 item_id INT NOT NULL REFERENCES MENU_ITEM(item_id) ON DELETE CASCADE,
 PRIMARY KEY (combo_id, item_id)
);
-- ────────────────────────────────────────────────────────────────
-- 15. COUPON
-- ────────────────────────────────────────────────────────────────
CREATE TABLE COUPON (
 coupon_id SERIAL PRIMARY KEY,
 code VARCHAR(30) NOT NULL UNIQUE,
 discount_value NUMERIC(10,2) NOT NULL CHECK (discount_value > 0),
 discount_type VARCHAR(20) NOT NULL
 CHECK (discount_type IN ('flat','percentage')),
 max_discount_cap NUMERIC(10,2),
 applicable_to VARCHAR(20) NOT NULL
 CHECK (applicable_to IN ('restaurant','grocery','both')),
 min_order_value NUMERIC(10,2) NOT NULL DEFAULT 0,
 times_used INT NOT NULL DEFAULT 0,
 max_uses INT,
 valid_from TIMESTAMP NOT NULL,
 valid_until TIMESTAMP NOT NULL,
 order_type VARCHAR(20),
 CHECK (valid_until > valid_from)
);
-- ────────────────────────────────────────────────────────────────
-- 16. ORDER (quoted: ORDER is a reserved keyword in PostgreSQL)
-- ────────────────────────────────────────────────────────────────
CREATE TABLE "ORDER" (
 order_id SERIAL PRIMARY KEY,
 customer_id INT NOT NULL
 REFERENCES CUSTOMER(customer_id),
 store_id INT REFERENCES GROCERY_STORE(store_id),
 restaurant_id INT REFERENCES RESTAURANT(restaurant_id),
 order_type VARCHAR(20) NOT NULL
 CHECK (order_type IN ('grocery','food')),
 tax NUMERIC(10,2) NOT NULL DEFAULT 0,
 delivery_fee NUMERIC(10,2) NOT NULL DEFAULT 0,
 status VARCHAR(20) NOT NULL DEFAULT 'placed'
 CHECK (status IN ('placed','confirmed','preparing',
 'out_for_delivery','delivered','cancelled')),
 subtotal NUMERIC(10,2) NOT NULL,
 grand_total NUMERIC(10,2) NOT NULL,
 placed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 discount NUMERIC(10,2) NOT NULL DEFAULT 0,
 est_delivery_time TIMESTAMP,
 CHECK (
 (order_type = 'grocery' AND store_id IS NOT NULL AND restaurant_id IS NULL) OR
 (order_type = 'food' AND restaurant_id IS NOT NULL AND store_id IS NULL)
 )
);
-- ────────────────────────────────────────────────────────────────
-- 17. ORDER_ITEM
-- ────────────────────────────────────────────────────────────────
CREATE TABLE ORDER_ITEM (
 order_item_id SERIAL PRIMARY KEY,
 order_id INT NOT NULL
 REFERENCES "ORDER"(order_id) ON DELETE CASCADE,
 product_id INT REFERENCES PRODUCT(product_id),
 item_id INT REFERENCES MENU_ITEM(item_id),
 variant_id INT REFERENCES PRODUCT_VARIANT(variant_id),
 quantity INT NOT NULL CHECK (quantity > 0),
 unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
 CHECK (product_id IS NOT NULL OR item_id IS NOT NULL)
);
-- ────────────────────────────────────────────────────────────────
-- 18. ORDER_SUBSTITUTION
-- ────────────────────────────────────────────────────────────────
CREATE TABLE ORDER_SUBSTITUTION (
 sub_id SERIAL PRIMARY KEY,
 reference_id INT NOT NULL
 REFERENCES ORDER_ITEM(order_item_id),
 substitute_product_id INT REFERENCES PRODUCT(product_id),
 substitute_item_id INT REFERENCES MENU_ITEM(item_id),
 customer_approved BOOLEAN NOT NULL DEFAULT FALSE,
 CHECK (
 (substitute_product_id IS NOT NULL AND substitute_item_id IS NULL) OR
 (substitute_item_id IS NOT NULL AND substitute_product_id IS NULL)
 )
);
-- ────────────────────────────────────────────────────────────────
-- 19. DELIVERY
-- ────────────────────────────────────────────────────────────────
CREATE TABLE DELIVERY (
 delivery_id SERIAL PRIMARY KEY,
 order_id INT NOT NULL UNIQUE
 REFERENCES "ORDER"(order_id),
 partner_id INT NOT NULL
 REFERENCES DELIVERY_PARTNER(partner_id),
 assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 picked_up_at TIMESTAMP,
 status VARCHAR(20) NOT NULL DEFAULT 'assigned'
 CHECK (status IN ('assigned','picked_up','delivered','failed')),
 delivered_at TIMESTAMP
);
-- ────────────────────────────────────────────────────────────────
-- 20. PAYMENT
-- ────────────────────────────────────────────────────────────────
CREATE TABLE PAYMENT (
 payment_id SERIAL PRIMARY KEY,
 order_id INT NOT NULL UNIQUE
 REFERENCES "ORDER"(order_id),
 status VARCHAR(20) NOT NULL DEFAULT 'pending'
 CHECK (status IN ('pending','success','failed','refunded')),
 paid_at TIMESTAMP,
 method VARCHAR(30) NOT NULL
 CHECK (method IN ('upi','card','netbanking','cod','wallet'))
);
-- ────────────────────────────────────────────────────────────────
-- 21. CANCELLATION
-- ────────────────────────────────────────────────────────────────
CREATE TABLE CANCELLATION (
 cancel_id SERIAL PRIMARY KEY,
 order_id INT NOT NULL UNIQUE
 REFERENCES "ORDER"(order_id),
 cancelled_by VARCHAR(20) NOT NULL
 CHECK (cancelled_by IN
('customer','store','restaurant','system')),
 cancelled_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 reason TEXT,
 refund_status VARCHAR(20) NOT NULL DEFAULT 'not_applicable'
 CHECK (refund_status IN ('not_applicable','pending','processed')),
 refunded_at TIMESTAMP,
 refund_amount NUMERIC(10,2) NOT NULL DEFAULT 0
);
-- ────────────────────────────────────────────────────────────────
-- 22. WISHLIST_ITEM
-- ────────────────────────────────────────────────────────────────
CREATE TABLE WISHLIST_ITEM (
 wishlist_id SERIAL PRIMARY KEY,
 customer_id INT NOT NULL
 REFERENCES CUSTOMER(customer_id) ON DELETE CASCADE,
 product_id INT REFERENCES PRODUCT(product_id),
 item_id INT REFERENCES MENU_ITEM(item_id),
 added_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE (customer_id, product_id),
 UNIQUE (customer_id, item_id),
 CHECK (product_id IS NOT NULL OR item_id IS NOT NULL)
);
-- ────────────────────────────────────────────────────────────────
-- 23. RATING
-- ────────────────────────────────────────────────────────────────
CREATE TABLE RATING (
 rating_id SERIAL PRIMARY KEY,
 order_id INT NOT NULL REFERENCES "ORDER"(order_id),
 customer_id INT NOT NULL REFERENCES CUSTOMER(customer_id),
 rating_type VARCHAR(20) NOT NULL
 CHECK (rating_type IN
('store','product','partner','restaurant','item')),
 rating NUMERIC(3,1) NOT NULL CHECK (rating BETWEEN 1.0 AND 5.0),
 comment TEXT,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 store_id INT REFERENCES GROCERY_STORE(store_id),
 product_id INT REFERENCES PRODUCT(product_id),
 partner_id INT REFERENCES DELIVERY_PARTNER(partner_id),
 restaurant_id INT REFERENCES RESTAURANT(restaurant_id),
 item_id INT REFERENCES MENU_ITEM(item_id)
);
-- ────────────────────────────────────────────────────────────────
-- 24. SETTLEMENT
-- ────────────────────────────────────────────────────────────────
CREATE TABLE SETTLEMENT (
 settlement_id SERIAL PRIMARY KEY,
 store_id INT REFERENCES GROCERY_STORE(store_id),
 restaurant_id INT REFERENCES RESTAURANT(restaurant_id),
 partner_type VARCHAR(20) NOT NULL
 CHECK (partner_type IN ('grocery_store','restaurant')),
 total_orders INT NOT NULL DEFAULT 0,
 gross_value NUMERIC(12,2) NOT NULL,
 commission NUMERIC(12,2) NOT NULL,
 net_payable NUMERIC(12,2) NOT NULL,
 period_from DATE NOT NULL,
 period_to DATE NOT NULL,
 status VARCHAR(20) NOT NULL DEFAULT 'pending'
 CHECK (status IN ('pending','processed','failed')),
 payment_ref VARCHAR(50),
 settled_on DATE,
 CHECK (period_to >= period_from),
 CHECK (
 (store_id IS NOT NULL AND restaurant_id IS NULL) OR
 (restaurant_id IS NOT NULL AND store_id IS NULL)
 )
);
-- ────────────────────────────────────────────────────────────────
-- INDEXES (on frequently queried foreign keys)
-- ────────────────────────────────────────────────────────────────
CREATE INDEX idx_customer_user ON CUSTOMER(user_id);
CREATE INDEX idx_partner_user ON DELIVERY_PARTNER(user_id);
CREATE INDEX idx_order_customer ON "ORDER"(customer_id);
CREATE INDEX idx_order_store ON "ORDER"(store_id);
CREATE INDEX idx_order_restaurant ON "ORDER"(restaurant_id);
CREATE INDEX idx_order_item_order ON ORDER_ITEM(order_id);
CREATE INDEX idx_delivery_partner ON DELIVERY(partner_id);
CREATE INDEX idx_rating_customer ON RATING(customer_id);
CREATE INDEX idx_rating_order ON RATING(order_id);
CREATE INDEX idx_wishlist_customer ON WISHLIST_ITEM(customer_id);
CREATE INDEX idx_product_category ON PRODUCT(category_id);
CREATE INDEX idx_menu_item_rest ON MENU_ITEM(restaurant_id);
CREATE INDEX idx_settlement_store ON SETTLEMENT(store_id);
CREATE INDEX idx_settlement_rest ON SETTLEMENT(restaurant_id);

-- Additional recommended indexes
CREATE INDEX idx_product_name ON PRODUCT(name);
CREATE INDEX idx_menu_name ON MENU_ITEM(name);
CREATE INDEX idx_restaurant_owner ON RESTAURANT(owner_id);
CREATE INDEX idx_store_owner ON GROCERY_STORE(owner_id);
CREATE INDEX idx_payment_status ON PAYMENT(status);
CREATE INDEX idx_order_status ON "ORDER"(status);
