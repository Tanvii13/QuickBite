============================================================================================================================================================================================
										SECTION 1: USER & ROLE
============================================================================================================================================================================================


INSERT INTO USER (user_id, full_name, email, phone, password_hash, role, registered_at, last_login, status) VALUES

(1,  'Aarav Mehta',      'aarav.mehta@gmail.com',      '9876543210', 'hash_aarav',   'customer',          '2024-01-05 10:00:00', '2024-04-01 09:00:00', 'active'),


(2,  'Priya Sharma',     'priya.sharma@gmail.com',     '9876543211', 'hash_priya',   'customer',          '2024-01-10 11:00:00', '2024-04-02 10:00:00', 'active'),


(3,  'Rohan Patel',      'rohan.patel@gmail.com',      '9876543212', 'hash_rohan',   'customer',          '2024-01-15 12:00:00', '2024-04-03 11:00:00', 'active'),


(4,  'Sneha Joshi',      'sneha.joshi@gmail.com',      '9876543213', 'hash_sneha',   'customer',          '2024-01-20 09:30:00', '2024-04-04 08:00:00', 'active'),


(5,  'Kabir Nair',       'kabir.nair@gmail.com',       '9876543214', 'hash_kabir',   'customer',          '2024-02-01 08:00:00', '2024-04-05 07:30:00', 'active'),


(6,  'Deepa Iyer',       'deepa.iyer@gmail.com',       '9876543215', 'hash_deepa',   'business_owner',    '2023-06-01 10:00:00', '2024-04-01 10:00:00', 'active'),


(7,  'Vikram Rao',       'vikram.rao@gmail.com',       '9876543216', 'hash_vikram',  'business_owner',    '2023-07-01 11:00:00', '2024-04-02 11:00:00', 'active'),


(8,  'Meena Pillai',     'meena.pillai@gmail.com',     '9876543217', 'hash_meena',   'business_owner',    '2023-08-01 09:00:00', '2024-04-03 09:00:00', 'active'),


(9,  'Arjun Singh',      'arjun.singh@gmail.com',      '9876543218', 'hash_arjun',   'delivery_partner',  '2023-09-01 07:00:00', '2024-04-01 07:00:00', 'active'),


(10, 'Lakshmi Das',      'lakshmi.das@gmail.com',      '9876543219', 'hash_lakshmi', 'delivery_partner',  '2023-10-01 06:30:00', '2024-04-02 06:30:00', 'active'),


(11, 'Nikhil Gupta',     'nikhil.gupta@gmail.com',     '9876543220', 'hash_nikhil',  'delivery_partner',  '2023-11-01 07:30:00', '2024-04-03 07:30:00', 'active'),


(12, 'Ritu Verma',       'ritu.verma@gmail.com',       '9876543221', 'hash_ritu',    'customer',          '2024-02-10 10:00:00', '2024-04-06 09:00:00', 'active'),


(13, 'Sanjay Kulkarni',  'sanjay.k@gmail.com',         '9876543222', 'hash_sanjay',  'business_owner',    '2023-05-15 10:00:00', '2024-04-01 10:00:00', 'active'),


(14, 'Pooja Desai',      'pooja.desai@gmail.com',      '9876543223', 'hash_pooja',   'customer',          '2024-03-01 11:00:00', '2024-04-07 10:00:00', 'active'),


(15, 'Amit Tiwari',      'amit.tiwari@gmail.com',      '9876543224', 'hash_amit',    'delivery_partner',  '2023-12-01 06:00:00', '2024-04-04 06:00:00', 'active');


INSERT INTO CUSTOMER (customer_id, user_id) VALUES

(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 12),
(7, 14);


INSERT INTO CUSTOMER_ADDRESS (address_id, customer_id, label, address_line, city, pincode, lat, lng, is_default) VALUES

(1,  1, 'Home',   '12 Shastri Nagar, Near Park',         'Ahmedabad',  '380001', 23.0225,  72.5714,  TRUE),


(2,  1, 'Office', '45 CG Road, Corporate Block',          'Ahmedabad',  '380009', 23.0300,  72.5600,  FALSE),


(3,  2, 'Home',   '78 Satellite Road, Opp Mall',          'Ahmedabad',  '380015', 23.0100,  72.5200,  TRUE),


(4,  3, 'Home',   '33 Navrangpura, Lane 5',               'Ahmedabad',  '380009', 23.0400,  72.5500,  TRUE),


(5,  4, 'Home',   '10 Maninagar, Behind Temple',          'Ahmedabad',  '380008', 22.9900,  72.6000,  TRUE),


(6,  5, 'Home',   '55 Bopal, Near Circle',                'Ahmedabad',  '380058', 23.0200,  72.4700,  TRUE),


(7,  6, 'Home',   '22 Vastrapur, Lake Road',              'Ahmedabad',  '380054', 23.0450,  72.5300,  TRUE),


(8,  7, 'Home',   '9 Paldi, Market Street',               'Ahmedabad',  '380007', 23.0000,  72.5700,  TRUE);


INSERT INTO BUSINESS_OWNER (owner_id, user_id, type) VALUES

(1, 6,  'grocery'),

(2, 7,  'restaurant'),

(3, 8,  'restaurant'),

(4, 13, 'grocery');


INSERT INTO DELIVERY_PARTNER (partner_id, user_id, vehicle_type, availability, last_lat, last_lng, bank_account) VALUES

(1, 9,  'bike',     TRUE,  23.0300, 72.5600, 'SBIN0001234-909090'),

(2, 10, 'scooter',  TRUE,  23.0100, 72.5300, 'HDFC0005678-101010'),

(3, 11, 'bicycle',  FALSE, 23.0200, 72.5500, 'ICIC0009012-111111'),

(4, 15, 'bike',     TRUE,  23.0400, 72.5700, 'AXIS0003456-121212');



============================================================================================================================================================================================
										SECTION 2: GROCERY STORE
============================================================================================================================================================================================


INSERT INTO GROCERY_STORE (store_id, owner_id, name, address, avg_rating, min_order_amount, delivery_radius_km, fssai_license, gstin, avg_delivery_mins, is_open, reg_status, store_type, commission_pct) VALUES

(1, 1, 'FreshMart',      '18 SG Highway, Ahmedabad',    4.5, 199.00, 5.0,  'FSSAI001', 'GST001', 30, TRUE,  'approved', 'supermarket',      12.00),


(2, 1, 'QuickBasket',    '7 Satellite Road, Ahmedabad', 4.2, 149.00, 4.0,  'FSSAI002', 'GST002', 25, TRUE,  'approved', 'minimart',         10.00),


(3, 4, 'OrganicNest',    '56 Bopal, Ahmedabad',         4.7, 299.00, 6.0,  'FSSAI003', 'GST003', 40, TRUE,  'approved', 'organic_store',    14.00),


(4, 4, 'DailyNeeds',     '3 Maninagar, Ahmedabad',      4.0, 99.00,  3.0,  'FSSAI004', 'GST004', 20, FALSE, 'approved', 'minimart',         8.00);


INSERT INTO PRODUCT_CATEGORY (category_id, store_id, name, unit_type, mrp, display_order, description) VALUES

(1, 1, 'Fruits & Vegetables', 'kg',    NULL, 1, 'Fresh farm produce'),

(2, 1, 'Dairy & Eggs',        'piece', NULL, 2, 'Milk, cheese, butter and eggs'),

(3, 1, 'Snacks',              'pack',  NULL, 3, 'Chips, biscuits and namkeen'),

(4, 2, 'Beverages',           'litre', NULL, 1, 'Cold drinks, juices and water'),

(5, 2, 'Grains & Pulses',     'kg',    NULL, 2, 'Rice, dal and flour'),

(6, 3, 'Organic Staples',     'kg',    NULL, 1, 'Organic grains and lentils'),

(7, 3, 'Herbal Products',     'pack',  NULL, 2, 'Herbal teas and supplements'),

(8, 4, 'Cleaning Supplies',   'piece', NULL, 1, 'Household cleaning items');



INSERT INTO PRODUCT (product_id, category_id, name, brand, avg_rating, net_weight, is_perishable, selling_price, veg_flag, photo_url, stock_qty) VALUES

(1,  1, 'Tomatoes',           'Farm Fresh',    4.3, '1 kg',   TRUE,  49.00,  TRUE,  'https://img/tomato.jpg',   150),


(2,  1, 'Spinach',            'Green Valley',  4.5, '500 g',  TRUE,  29.00,  TRUE,  'https://img/spinach.jpg',  100),


(3,  2, 'Amul Milk',          'Amul',          4.8, '500 ml', TRUE,  30.00,  TRUE,  'https://img/milk.jpg',     200),


(4,  2, 'Eggs (6 pack)',      'Nandini',       4.6, '6 pcs',  TRUE,  60.00,  FALSE, 'https://img/eggs.jpg',     120),


(5,  3, 'Kurkure Masala',     "Lay's",         4.1, '80 g',   FALSE, 20.00,  TRUE,  'https://img/kurkure.jpg',  300),


(6,  3, 'Parle-G Biscuits',   'Parle',         4.7, '200 g',  FALSE, 25.00,  TRUE,  'https://img/parleg.jpg',   400),


(7,  4, 'Coca-Cola 1L',       'Coca-Cola',     4.2, '1 L',    FALSE, 55.00,  TRUE,  'https://img/coke.jpg',     180),


(8,  4, 'Real Orange Juice',  'Real',          4.4, '1 L',    FALSE, 90.00,  TRUE,  'https://img/orange.jpg',   90),


(9,  5, 'Basmati Rice',       'India Gate',    4.6, '5 kg',   FALSE, 450.00, TRUE,  'https://img/rice.jpg',     60),


(10, 5, 'Toor Dal',           'Patanjali',     4.3, '1 kg',   FALSE, 130.00, TRUE,  'https://img/dal.jpg',      80),


(11, 6, 'Organic Wheat Flour','24 Mantra',     4.8, '5 kg',   FALSE, 550.00, TRUE,  'https://img/flour.jpg',    40),


(12, 7, 'Tulsi Green Tea',    'Organic India', 4.9, '25 bags',FALSE, 120.00, TRUE,  'https://img/tea.jpg',      70),


(13, 8, 'Vim Bar',            'Vim',           4.0, '150 g',  FALSE, 35.00,  TRUE,  'https://img/vim.jpg',      250);



INSERT INTO PRODUCT_VARIANT (variant_id, product_id, label, mrp, selling_price, stock_qty) VALUES

(1,  9,  '5 kg',   520.00, 450.00, 60),

(2,  9,  '10 kg',  980.00, 850.00, 25),

(3,  10, '500 g',  70.00,  65.00,  100),

(4,  10, '1 kg',   140.00, 130.00, 80),

(5,  11, '1 kg',   120.00, 110.00, 90),

(6,  11, '5 kg',   570.00, 550.00, 40),

(7,  7,  '500 ml', 30.00,  28.00,  200),

(8,  7,  '2 L',    100.00, 90.00,  70),

(9,  3,  '200 ml', 12.00,  10.00,  300),

(10, 3,  '1 L',    60.00,  58.00,  120);


============================================================================================================================================================================================
										SECTION 3: RESTAURANT
============================================================================================================================================================================================


INSERT INTO RESTAURANT (restaurant_id, owner_id, area_id, name, address, lat, lng, fssai_license, gstin, cuisines, open_time, close_time, is_open, reg_status, min_order_amount, avg_delivery_mins, delivery_radius_km, avg_rating, total_ratings, bank_account, commission_pct) VALUES

(1, 2, 101, 'Spice Garden',      '22 CG Road, Ahmedabad',       23.0350, 72.5550, 'FSSAI101', 'RGSTIN01', 'Indian,Mughlai',   '10:00:00', '23:00:00', TRUE,  'approved', 200.00, 35, 6.0, 4.5, 320, 'HDFC00011111', 15.00),


(2, 2, 102, 'Pizza Planet',      '5 Vastrapur, Ahmedabad',       23.0420, 72.5280, 'FSSAI102', 'RGSTIN02', 'Italian,Fast Food','11:00:00', '23:30:00', TRUE,  'approved', 150.00, 28, 5.0, 4.3, 210, 'ICIC00022222', 18.00),


(3, 3, 103, 'Wok & Roll',        '88 Satellite Rd, Ahmedabad',   23.0150, 72.5180, 'FSSAI103', 'RGSTIN03', 'Chinese,Thai',     '12:00:00', '22:00:00', TRUE,  'approved', 180.00, 40, 7.0, 4.2, 175, 'AXIS00033333', 16.00),


(4, 3, 104, 'Burger Barn',       '15 Navrangpura, Ahmedabad',    23.0390, 72.5620, 'FSSAI104', 'RGSTIN04', 'American,Snacks',  '10:00:00', '22:30:00', TRUE,  'approved', 100.00, 25, 4.0, 4.1, 140, 'SBIN00044444', 14.00),


(5, 3, 105, 'South Spice',       '34 Paldi, Ahmedabad',          23.0010, 72.5710, 'FSSAI105', 'RGSTIN05', 'South Indian',     '07:00:00', '22:00:00', FALSE, 'approved', 120.00, 30, 5.5, 4.6, 400, 'HDFC00055555', 13.00);


INSERT INTO MENU_CATEGORY (category_id, restaurant_id, name, display_order) VALUES

(1, 1, 'Starters',       1),

(2, 1, 'Main Course',    2),

(3, 1, 'Breads',         3),

(4, 2, 'Pizzas',         1),

(5, 2, 'Pastas',         2),

(6, 3, 'Soups',          1),

(7, 3, 'Noodles',        2),

(8, 4, 'Burgers',        1),

(9, 4, 'Sides',          2),

(10,5, 'Breakfast',      1),

(11,5, 'Meals',          2);


INSERT INTO MENU_ITEM (item_id, category_id, restaurant_id, name, description, veg_flag, price, available, photo_url, avg_rating) VALUES

(1,  1, 1, 'Paneer Tikka',        'Grilled cottage cheese with spices',      TRUE,  180.00, TRUE,  'https://img/paneer_tikka.jpg',   4.6),


(2,  1, 1, 'Chicken Seekh',       'Minced chicken on skewers',               FALSE, 220.00, TRUE,  'https://img/seekh.jpg',          4.4),


(3,  2, 1, 'Dal Makhani',         'Slow-cooked black lentils',               TRUE,  250.00, TRUE,  'https://img/dal_makhani.jpg',    4.7),


(4,  2, 1, 'Butter Chicken',      'Creamy tomato-based chicken curry',       FALSE, 320.00, TRUE,  'https://img/butter_chicken.jpg', 4.8),


(5,  3, 1, 'Butter Naan',         'Soft leavened flatbread with butter',     TRUE,  50.00,  TRUE,  'https://img/naan.jpg',           4.5),


(6,  4, 2, 'Margherita Pizza',    'Classic tomato and cheese pizza',         TRUE,  299.00, TRUE,  'https://img/margherita.jpg',     4.4),


(7,  4, 2, 'BBQ Chicken Pizza',   'Smoky barbecue chicken on pizza',         FALSE, 399.00, TRUE,  'https://img/bbq_pizza.jpg',      4.3),


(8,  5, 2, 'Penne Arrabbiata',    'Spicy tomato pasta',                      TRUE,  249.00, TRUE,  'https://img/penne.jpg',          4.2),


(9,  6, 3, 'Hot & Sour Soup',     'Tangy spicy Chinese soup',                TRUE,  149.00, TRUE,  'https://img/soup.jpg',           4.1),


(10, 7, 3, 'Hakka Noodles',       'Stir-fried noodles with vegetables',      TRUE,  199.00, TRUE,  'https://img/noodles.jpg',        4.3),


(11, 7, 3, 'Chicken Chow Mein',   'Stir-fried noodles with chicken',         FALSE, 229.00, TRUE,  'https://img/chowmein.jpg',       4.5),


(12, 8, 4, 'Classic Veg Burger',  'Crispy patty with lettuce and cheese',    TRUE,  149.00, TRUE,  'https://img/veg_burger.jpg',     4.2),


(13, 8, 4, 'Chicken Zinger',      'Spicy crispy chicken burger',             FALSE, 199.00, TRUE,  'https://img/zinger.jpg',         4.4),


(14, 9, 4, 'French Fries',        'Crispy golden fries',                     TRUE,  89.00,  TRUE,  'https://img/fries.jpg',          4.3),


(15,10, 5, 'Masala Dosa',         'Crispy rice crepe with spiced filling',   TRUE,  120.00, TRUE,  'https://img/dosa.jpg',           4.7),


(16,10, 5, 'Idli Sambar',         '3 soft rice cakes with sambar',           TRUE,  80.00,  TRUE,  'https://img/idli.jpg',           4.5),


(17,11, 5, 'Meals Veg',           'Full south Indian thali',                 TRUE,  180.00, TRUE,  'https://img/meals.jpg',          4.6),


(18, 9, 4, 'Onion Rings',         'Crispy battered onion rings',             TRUE,  79.00,  TRUE,  'https://img/onion_rings.jpg',    4.1);


INSERT INTO COMBO_DEAL (combo_id, restaurant_id, name, price) VALUES

(1, 1, 'Family Feast',      899.00),

(2, 2, 'Pizza Duo',         549.00),

(3, 4, 'Burger Meal',       279.00),

(4, 5, 'Breakfast Combo',   179.00);


INSERT INTO COMBO_ITEM (combo_id, item_id) VALUES

(1, 1), (1, 3), (1, 5),

(2, 6), (2, 8),

(3, 12), (3, 14),

(4, 15), (4, 16);


============================================================================================================================================================================================
										SECTION 4: ORDERS
============================================================================================================================================================================================


INSERT INTO `ORDER` (order_id, customer_id, store_id, restaurant_id, order_type, tax, delivery_fee, status, subtotal, items_total, grand_total, placed_at, discount, est_delivery_mins) VALUES

(1,  1, NULL, 1,    'restaurant', 30.00, 40.00, 'delivered',   500.00, 500.00, 570.00, '2024-03-01 12:30:00', 0.00,   35),


(2,  2, 1,    NULL, 'grocery',    15.00, 30.00, 'delivered',   200.00, 200.00, 245.00, '2024-03-02 14:00:00', 0.00,   25),


(3,  3, NULL, 2,    'restaurant', 25.00, 35.00, 'delivered',   400.00, 400.00, 460.00, '2024-03-03 19:30:00', 0.00,   30),


(4,  4, NULL, 3,    'restaurant', 20.00, 40.00, 'delivered',   350.00, 350.00, 410.00, '2024-03-04 20:00:00', 50.00,  40),


(5,  5, 2,    NULL, 'grocery',    18.00, 25.00, 'delivered',   300.00, 300.00, 343.00, '2024-03-05 10:00:00', 0.00,   20),


(6,  1, NULL, 4,    'restaurant', 15.00, 30.00, 'delivered',   250.00, 250.00, 295.00, '2024-03-06 13:00:00', 0.00,   25),


(7,  2, NULL, 5,    'restaurant', 12.00, 20.00, 'delivered',   200.00, 200.00, 232.00, '2024-03-07 08:30:00', 0.00,   30),


(8,  3, 3,    NULL, 'grocery',    40.00, 50.00, 'delivered',   650.00, 650.00, 740.00, '2024-03-08 11:00:00', 0.00,   40),


(9,  6, NULL, 1,    'restaurant', 35.00, 40.00, 'cancelled',   450.00, 450.00, 525.00, '2024-03-09 15:00:00', 0.00,   35),


(10, 7, NULL, 2,    'restaurant', 20.00, 35.00, 'delivered',   350.00, 350.00, 405.00, '2024-03-10 20:30:00', 0.00,   28),


(11, 1, 1,    NULL, 'grocery',    10.00, 20.00, 'delivered',   109.00, 109.00, 139.00, '2024-03-11 09:00:00', 0.00,   25),


(12, 4, NULL, 5,    'restaurant', 14.00, 20.00, 'delivered',   240.00, 240.00, 274.00, '2024-03-12 08:00:00', 0.00,   30),


(13, 5, NULL, 1,    'restaurant', 28.00, 40.00, 'delivered',   480.00, 480.00, 548.00, '2024-03-13 19:00:00', 0.00,   35),


(14, 2, 3,    NULL, 'grocery',    55.00, 50.00, 'delivered',   750.00, 750.00, 855.00, '2024-03-14 16:00:00', 0.00,   40),


(15, 3, NULL, 4,    'restaurant', 18.00, 30.00, 'pending',     300.00, 300.00, 348.00, '2024-03-15 12:00:00', 0.00,   25);


INSERT INTO ORDER_ITEM (order_item_id, order_id, product_id, item_id, variant_id, quantity, unit_price) VALUES

(1,  1,  NULL, 4,    NULL, 1,  320.00),

(2,  1,  NULL, 5,    NULL, 2,  50.00),

(3,  1,  NULL, 3,    NULL, 1,  250.00),

(4,  2,  3,    NULL, 9,   2,  10.00),

(5,  2,  1,    NULL, NULL,3,  49.00),

(6,  3,  NULL, 6,    NULL,1,  299.00),

(7,  3,  NULL, 8,    NULL,1,  249.00),

(8,  4,  NULL, 10,   NULL,2,  199.00),

(9,  4,  NULL, 9,    NULL,1,  149.00),

(10, 5,  9,    NULL, 1,   1,  450.00),

(11, 6,  NULL, 12,   NULL,1,  149.00),

(12, 6,  NULL, 14,   NULL,2,  89.00),

(13, 7,  NULL, 15,   NULL,2,  120.00),

(14, 7,  NULL, 16,   NULL,1,  80.00),

(15, 8,  11,   NULL, 6,   1,  550.00),

(16, 8,  12,   NULL, NULL,1,  120.00),

(17, 9,  NULL, 4,    NULL,1,  320.00),

(18, 9,  NULL, 2,    NULL,1,  220.00),

(19,10,  NULL, 7,    NULL,1,  399.00),

(20,11,  5,    NULL, NULL,2,  20.00),

(21,11,  6,    NULL, NULL,3,  25.00),

(22,12,  NULL, 16,   NULL,2,  80.00),

(23,12,  NULL, 15,   NULL,1,  120.00),

(24,13,  NULL, 4,    NULL,1,  320.00),

(25,13,  NULL, 3,    NULL,1,  250.00),

(26,14,  9,    NULL, 2,   1,  850.00),

(27,15,  NULL, 13,   NULL,1,  199.00),

(28,15,  NULL, 14,   NULL,1,  89.00);



INSERT INTO ORDER_SUBSTITUTION (sub_id, reference_id, substitute_item_id, customer_approved) VALUES

(1, 5,  4,  TRUE),

(2, 10, 11, FALSE);


============================================================================================================================================================================================
										SECTION 5: TRANSACTION
============================================================================================================================================================================================


INSERT INTO PAYMENT (payment_id, order_id, status, paid_at, method) VALUES

(1,  1,  'paid',    '2024-03-01 12:35:00', 'UPI'),

(2,  2,  'paid',    '2024-03-02 14:05:00', 'credit_card'),

(3,  3,  'paid',    '2024-03-03 19:32:00', 'UPI'),

(4,  4,  'paid',    '2024-03-04 20:02:00', 'debit_card'),

(5,  5,  'paid',    '2024-03-05 10:02:00', 'UPI'),

(6,  6,  'paid',    '2024-03-06 13:05:00', 'cash'),

(7,  7,  'paid',    '2024-03-07 08:32:00', 'UPI'),

(8,  8,  'paid',    '2024-03-08 11:02:00', 'credit_card'),

(9,  9,  'refunded','2024-03-09 16:00:00', 'UPI'),

(10,10,  'paid',    '2024-03-10 20:32:00', 'UPI'),

(11,11,  'paid',    '2024-03-11 09:05:00', 'debit_card'),

(12,12,  'paid',    '2024-03-12 08:05:00', 'UPI'),

(13,13,  'paid',    '2024-03-13 19:05:00', 'UPI'),

(14,14,  'paid',    '2024-03-14 16:05:00', 'credit_card'),

(15,15,  'pending', NULL,                  'UPI');



INSERT INTO CANCELLATION (cancel_id, order_id, cancelled_by, cancelled_at, reason, refund_status, refunded_at, refund_amount) VALUES

(1, 9, 'customer', '2024-03-09 15:30:00', 'Wrong address entered', 'refunded', '2024-03-10 10:00:00', 525.00);



INSERT INTO DELIVERY (delivery_id, order_id, partner_id, assigned_at, picked_up_at, status, delivered_at) VALUES

(1,  1,  1, '2024-03-01 12:40:00', '2024-03-01 13:00:00', 'delivered', '2024-03-01 13:15:00'),


(2,  2,  2, '2024-03-02 14:10:00', '2024-03-02 14:25:00', 'delivered', '2024-03-02 14:50:00'),


(3,  3,  1, '2024-03-03 19:38:00', '2024-03-03 20:00:00', 'delivered', '2024-03-03 20:28:00'),


(4,  4,  3, '2024-03-04 20:05:00', '2024-03-04 20:20:00', 'delivered', '2024-03-04 21:00:00'),


(5,  5,  4, '2024-03-05 10:05:00', '2024-03-05 10:15:00', 'delivered', '2024-03-05 10:35:00'),


(6,  6,  2, '2024-03-06 13:08:00', '2024-03-06 13:20:00', 'delivered', '2024-03-06 13:45:00'),


(7,  7,  1, '2024-03-07 08:35:00', '2024-03-07 08:50:00', 'delivered', '2024-03-07 09:20:00'),


(8,  8,  4, '2024-03-08 11:05:00', '2024-03-08 11:20:00', 'delivered', '2024-03-08 12:00:00'),


(9,  10, 2, '2024-03-10 20:35:00', '2024-03-10 20:50:00', 'delivered', '2024-03-10 21:18:00'),


(10, 11, 1, '2024-03-11 09:08:00', '2024-03-11 09:20:00', 'delivered', '2024-03-11 09:45:00'),


(11, 12, 3, '2024-03-12 08:08:00', '2024-03-12 08:25:00', 'delivered', '2024-03-12 08:55:00'),


(12, 13, 4, '2024-03-13 19:08:00', '2024-03-13 19:25:00', 'delivered', '2024-03-13 20:00:00'),


(13, 14, 2, '2024-03-14 16:08:00', '2024-03-14 16:25:00', 'delivered', '2024-03-14 17:05:00');


============================================================================================================================================================================================
										SECTION 6: RATING
============================================================================================================================================================================================


INSERT INTO RATING (rating_id, order_id, store_id, product_id, partner_id, customer_id, restaurant_id, item_id, rating, comment, created_at, rating_type) VALUES

(1,  1,  NULL,1, 1, 1, 1,    NULL, 5, 'Butter Chicken was amazing!',          '2024-03-01 14:00:00', 'food'),


(2,  1,  NULL,NULL,1,1, 1,   NULL, 5, 'Super fast delivery!',                 '2024-03-01 14:01:00', 'delivery'),


(3,  1,  NULL,NULL,NULL,1,1, NULL, 4, 'Good restaurant overall',              '2024-03-01 14:02:00', 'restaurant'),


(4,  2,  1,   3, 2, 2, NULL, NULL, 4, 'Milk was fresh',                       '2024-03-02 16:00:00', 'product'),


(5,  2,  1,   NULL,2,2,NULL, NULL, 5, 'Quick delivery, well packed',          '2024-03-02 16:01:00', 'delivery'),


(6,  3,  NULL,NULL,1,3,2,    6,    4, 'Margherita was decent',                '2024-03-03 21:00:00', 'food'),


(7,  4,  NULL,NULL,3,4,3,   10,    3, 'Noodles were a bit oily',              '2024-03-04 22:00:00', 'food'),


(8,  5,  2, 9, 4, 5, NULL, NULL, 5, 'Great quality basmati rice',            '2024-03-05 12:00:00', 'product'),


(9,  6,  NULL,NULL,2,1,4,   12,    4, 'Veg Burger was nice',                  '2024-03-06 15:00:00', 'food'),


(10, 7,  NULL,NULL,1,2,5,   15,    5, 'Best Masala Dosa in Ahmedabad!',       '2024-03-07 10:00:00', 'food'),


(11, 8,  3,   11,4,3,NULL,  NULL,  5, 'Love the organic flour',               '2024-03-08 13:00:00', 'product'),


(12,10,  NULL,NULL,2,7,2,    7,    4, 'BBQ Pizza was good',                   '2024-03-10 22:00:00', 'food'),


(13,12,  NULL,NULL,3,4,5,   16,    5, 'Idli Sambar was perfect',              '2024-03-12 10:00:00', 'food'),


(14, 13,  NULL,NULL,4,5,1,    4,    5, 'Butter Chicken again - never fails!',  '2024-03-13 21:00:00', 'food'),


(15, 14,  3,   9, 2,2,NULL,  NULL,  4, 'Good rice, fast delivery',             '2024-03-14 18:00:00', 'product');



============================================================================================================================================================================================
										SECTION 7: MISC
============================================================================================================================================================================================


INSERT INTO WISHLIST_ITEM (wishlist_id, customer_id, product_id, item_id, added_at) VALUES

(1, 1, NULL, 4,  '2024-02-01 10:00:00'),

(2, 1, 9,    NULL,'2024-02-02 11:00:00'),

(3, 2, NULL, 15, '2024-02-03 12:00:00'),

(4, 3, NULL, 6,  '2024-02-04 13:00:00'),

(5, 4, NULL, 10, '2024-02-05 14:00:00'),

(6, 5, 12,   NULL,'2024-02-06 15:00:00'),

(7, 6, NULL, 7,  '2024-02-07 16:00:00'),

(8, 7, NULL, 13, '2024-02-08 17:00:00');


INSERT INTO COUPON (coupon_id, code, discount_value, discount_type, max_discount_cap, applicable_to, min_order_value, times_used, max_uses, valid_from, valid_until, order_type) VALUES

(1, 'WELCOME50',  50.00,  'flat',       50.00, 'all',        100.00, 120, 500, '2024-01-01', '2024-12-31', 'both'),


(2, 'SAVE20PCT',  20.00,  'percentage', 150.00,'all',        200.00, 80,  300, '2024-02-01', '2024-11-30', 'both'),


(3, 'PIZZA100',   100.00, 'flat',       100.00,'restaurant', 399.00, 40,  200, '2024-03-01', '2024-06-30', 'restaurant'),


(4, 'GROCERY15',  15.00,  'percentage', 100.00,'grocery',    150.00, 55,  250, '2024-01-15', '2024-09-30', 'grocery'),


(5, 'NEWUSER100', 100.00, 'flat',       100.00,'all',        300.00, 10,  1000,'2024-01-01', '2024-12-31', 'both');


INSERT INTO SETTLEMENT (settlement_id, store_id, restaurant_id, partner_type, total_orders, gross_value, commission, net_payable, period_from, period_to, status, payment_ref, settled_on) VALUES

(1, 1,    NULL, 'store',      8,  3200.00, 384.00, 2816.00, '2024-03-01', '2024-03-07', 'settled', 'PAYREF001', '2024-03-10'),


(2, NULL, 1,    'restaurant', 5,  2400.00, 360.00, 2040.00, '2024-03-01', '2024-03-07', 'settled', 'PAYREF002', '2024-03-10'),


(3, NULL, 2,    'restaurant', 3,  1200.00, 216.00, 984.00,  '2024-03-01', '2024-03-07', 'settled', 'PAYREF003', '2024-03-10'),


(4, NULL, 4,    'restaurant', 2,  600.00,  84.00,  516.00,  '2024-03-01', '2024-03-07', 'settled', 'PAYREF004', '2024-03-10'),


(5, 2,    NULL, 'store',      3,  900.00,  90.00,  810.00,  '2024-03-01', '2024-03-07', 'pending',  NULL,        NULL),


(6, 3,    NULL, 'store',      2,  1500.00, 210.00, 1290.00, '2024-03-08', '2024-03-14', 'settled', 'PAYREF005', '2024-03-17'),


(7, NULL, 5,    'restaurant', 3,  700.00,  91.00,  609.00,  '2024-03-01', '2024-03-07', 'settled', 'PAYREF006', '2024-03-10');
