============================================================================================================================================================================================
										SECTION A: USER & ROLE QUERIES
============================================================================================================================================================================================


Q1. List all users with their roles.
Text: Retrieve the full name, email, phone, and role of every registered user.


SELECT user_id, full_name, email, phone, role
FROM USER
ORDER BY registered_at;




Q2. List all active users.
Text: Find all users whose account status is 'active'.


SELECT user_id, full_name, email, role
FROM USER
WHERE status = 'active'
ORDER BY full_name;




Q3. Find all customers along with their full user details.
Text: Join the CUSTOMER table with USER to show every customer's name, email, and phone.


SELECT C.customer_id, U.full_name, U.email, U.phone
FROM CUSTOMER C
JOIN USER U ON C.user_id = U.user_id
ORDER BY C.customer_id;




Q4. List all business owners and their ownership type.
Text: Show the owner name, email, and business type (grocery / restaurant) for every business owner.


SELECT BO.owner_id, U.full_name, U.email, BO.type
FROM BUSINESS_OWNER BO
JOIN USER U ON BO.user_id = U.user_id
ORDER BY BO.type;






Q5. List all delivery partners with vehicle type and current availability.
Text: Display each delivery partner's name, vehicle type, and whether they are currently available.


SELECT DP.partner_id, U.full_name, DP.vehicle_type, DP.availability, DP.last_lat, DP.last_lng
FROM DELIVERY_PARTNER DP
JOIN USER U ON DP.user_id = U.user_id
ORDER BY DP.availability DESC;




Q6. Find all customers with their default delivery address.
Text: Retrieve each customer's name along with their default delivery address.


SELECT U.full_name, CA.address_line, CA.city, CA.pincode
FROM CUSTOMER C
JOIN USER U ON C.user_id = U.user_id
JOIN CUSTOMER_ADDRESS CA ON C.customer_id = CA.customer_id
WHERE CA.is_default = TRUE;




Q7. Count the number of addresses per customer.
Text: For each customer, count how many saved addresses they have.


SELECT C.customer_id, U.full_name, COUNT(CA.address_id) AS total_addresses
FROM CUSTOMER C
JOIN USER U ON C.user_id = U.user_id
LEFT JOIN CUSTOMER_ADDRESS CA ON C.customer_id = CA.customer_id
GROUP BY C.customer_id, U.full_name
ORDER BY total_addresses DESC;




Q8. Find users who registered in the last 90 days.
Text: List users who registered within the last 90 days from today.


SELECT user_id, full_name, email, registered_at
FROM USER
WHERE registered_at >= CURDATE() - INTERVAL 90 DAY
ORDER BY registered_at DESC;



Q9. List all available (online) delivery partners.
Text: Show delivery partners who are currently online and available for delivery.


SELECT DP.partner_id, U.full_name, DP.vehicle_type, DP.last_lat, DP.last_lng
FROM DELIVERY_PARTNER DP
JOIN USER U ON DP.user_id = U.user_id
WHERE DP.availability = TRUE;




Q10. Find all users who have never logged in after registration.
Text: List users whose last_login timestamp equals their registered_at timestamp or is NULL.


SELECT user_id, full_name, email, registered_at, last_login
FROM USER
WHERE last_login IS NULL OR last_login = registered_at;




============================================================================================================================================================================================
										SECTION B: GROCERY STORE QUERIES
============================================================================================================================================================================================


Q11. List all grocery stores with their owner's name.
Text: Show each grocery store's name, address, and the name of its business owner.


SELECT GS.store_id, GS.name AS store_name, GS.address, U.full_name AS owner_name, GS.avg_rating
FROM GROCERY_STORE GS
JOIN BUSINESS_OWNER BO ON GS.owner_id = BO.owner_id
JOIN USER U ON BO.user_id = U.user_id
ORDER BY GS.avg_rating DESC;




Q12. List all currently open grocery stores.
Text: Display grocery stores that are currently marked as open.


SELECT store_id, name, address, avg_rating, avg_delivery_mins
FROM GROCERY_STORE
WHERE is_open = TRUE AND reg_status = 'approved';




Q13. List all products under a specific grocery store (e.g., FreshMart - store_id = 1).
Text: Retrieve all products sold in FreshMart along with their category and price.


SELECT PC.name AS category, P.name AS product, P.brand, P.selling_price, P.stock_qty
FROM PRODUCT P
JOIN PRODUCT_CATEGORY PC ON P.category_id = PC.category_id
WHERE PC.store_id = 1
ORDER BY PC.name, P.name;




Q14. Find all out-of-stock products.
Text: List products that have zero stock quantity.


SELECT P.product_id, P.name, P.brand, PC.name AS category
FROM PRODUCT P
JOIN PRODUCT_CATEGORY PC ON P.category_id = PC.category_id
WHERE P.stock_qty = 0;




Q15. List all product variants with their products.
Text: Show each product variant along with the parent product name, label, and pricing.


SELECT P.name AS product, PV.label, PV.mrp, PV.selling_price, PV.stock_qty
FROM PRODUCT_VARIANT PV
JOIN PRODUCT P ON PV.product_id = P.product_id
ORDER BY P.name, PV.label;




Q16. Find the top 5 highest-rated products in a grocery store.
Text: List the 5 products with the highest average rating across all grocery stores.


SELECT P.product_id, P.name, P.brand, P.avg_rating, PC.name AS category
FROM PRODUCT P
JOIN PRODUCT_CATEGORY PC ON P.category_id = PC.category_id
ORDER BY P.avg_rating DESC
LIMIT 5;




Q17. Find the cheapest product in each product category.
Text: For each product category, identify the product with the lowest selling price.


SELECT PC.name AS category, P.name AS product, P.selling_price
FROM PRODUCT P
JOIN PRODUCT_CATEGORY PC ON P.category_id = PC.category_id
WHERE P.selling_price = (
   SELECT MIN(P2.selling_price)
   FROM PRODUCT P2
   WHERE P2.category_id = P.category_id
)
ORDER BY PC.name;




Q18. Count the number of products in each store.
Text: For each grocery store, count the total number of products listed.


SELECT GS.name AS store_name, COUNT(P.product_id) AS total_products
FROM GROCERY_STORE GS
JOIN PRODUCT_CATEGORY PC ON GS.store_id = PC.store_id
JOIN PRODUCT P ON PC.category_id = P.category_id
GROUP BY GS.store_id, GS.name
ORDER BY total_products DESC;




Q19. List perishable products available in all stores.
Text: Find all products that are marked as perishable.


SELECT P.product_id, P.name, P.brand, P.net_weight, P.selling_price, GS.name AS store
FROM PRODUCT P
JOIN PRODUCT_CATEGORY PC ON P.category_id = PC.category_id
JOIN GROCERY_STORE GS ON PC.store_id = GS.store_id
WHERE P.is_perishable = TRUE
ORDER BY GS.name;




Q20. Find categories in each store along with the number of products.
Text: Show every product category along with its parent store name and the number of products it contains.


SELECT GS.name AS store, PC.name AS category, COUNT(P.product_id) AS product_count
FROM PRODUCT_CATEGORY PC
JOIN GROCERY_STORE GS ON PC.store_id = GS.store_id
LEFT JOIN PRODUCT P ON PC.category_id = P.category_id
GROUP BY GS.store_id, GS.name, PC.category_id, PC.name
ORDER BY GS.name, PC.display_order;




============================================================================================================================================================================================										SECTION C: RESTAURANT QUERIES
============================================================================================================================================================================================


Q21. List all restaurants with their owner names.
Text: Show each restaurant's name, cuisine, and its owner's full name.


SELECT R.restaurant_id, R.name AS restaurant, R.cuisines, U.full_name AS owner, R.avg_rating
FROM RESTAURANT R
JOIN BUSINESS_OWNER BO ON R.owner_id = BO.owner_id
JOIN USER U ON BO.user_id = U.user_id
ORDER BY R.avg_rating DESC;




Q22. List all currently open restaurants.
Text: Display restaurants that are currently open and registered/approved.


SELECT restaurant_id, name, cuisines, avg_delivery_mins, avg_rating
FROM RESTAURANT
WHERE is_open = TRUE AND reg_status = 'approved'
ORDER BY avg_rating DESC;




Q23. List all menu items in a specific restaurant (e.g., Spice Garden - restaurant_id = 1).
Text: Retrieve every menu item from Spice Garden, including category, name, price, and veg/non-veg flag.


SELECT MC.name AS category, MI.name AS item, MI.description, MI.price,
      IF(MI.veg_flag, 'Veg', 'Non-Veg') AS type, MI.available
FROM MENU_ITEM MI
JOIN MENU_CATEGORY MC ON MI.category_id = MC.category_id
WHERE MI.restaurant_id = 1
ORDER BY MC.display_order, MI.price;




Q24. Find all veg menu items available across all restaurants.
Text: List every vegetarian menu item along with the restaurant it belongs to.


SELECT R.name AS restaurant, MC.name AS category, MI.name AS item, MI.price
FROM MENU_ITEM MI
JOIN RESTAURANT R ON MI.restaurant_id = R.restaurant_id
JOIN MENU_CATEGORY MC ON MI.category_id = MC.category_id
WHERE MI.veg_flag = TRUE AND MI.available = TRUE
ORDER BY R.name, MI.price;




Q25. List all combo deals with the items included in each combo.
Text: Show every combo deal, which restaurant offers it, and what menu items are included.


SELECT CD.name AS combo_name, R.name AS restaurant, CD.price AS combo_price,
      MI.name AS item_name, MI.price AS item_price
FROM COMBO_DEAL CD
JOIN RESTAURANT R ON CD.restaurant_id = R.restaurant_id
JOIN COMBO_ITEM CI ON CD.combo_id = CI.combo_id
JOIN MENU_ITEM MI ON CI.item_id = MI.item_id
ORDER BY CD.combo_id;




Q26. Find the most expensive menu item in each restaurant.
Text: For each restaurant, identify the menu item with the highest price.


SELECT R.name AS restaurant, MI.name AS item, MI.price
FROM MENU_ITEM MI
JOIN RESTAURANT R ON MI.restaurant_id = R.restaurant_id
WHERE MI.price = (
   SELECT MAX(MI2.price)
   FROM MENU_ITEM MI2
   WHERE MI2.restaurant_id = MI.restaurant_id
)
ORDER BY MI.price DESC;




Q27. Count the number of menu items per category for each restaurant.
Text: For every restaurant, show how many menu items are listed under each menu category.


SELECT R.name AS restaurant, MC.name AS category, COUNT(MI.item_id) AS item_count
FROM MENU_CATEGORY MC
JOIN RESTAURANT R ON MC.restaurant_id = R.restaurant_id
LEFT JOIN MENU_ITEM MI ON MC.category_id = MI.category_id
GROUP BY R.restaurant_id, R.name, MC.category_id, MC.name
ORDER BY R.name, MC.display_order;




Q28. Find restaurants that offer both veg and non-veg items.
Text: List restaurants that have at least one veg item and at least one non-veg item on their menu.


SELECT R.restaurant_id, R.name
FROM RESTAURANT R
WHERE EXISTS (
   SELECT 1 FROM MENU_ITEM WHERE restaurant_id = R.restaurant_id AND veg_flag = TRUE
)
AND EXISTS (
   SELECT 1 FROM MENU_ITEM WHERE restaurant_id = R.restaurant_id AND veg_flag = FALSE
);




Q29. Find top 3 highest-rated restaurants.
Text: Display the 3 restaurants with the highest average customer rating.


SELECT restaurant_id, name, cuisines, avg_rating, total_ratings
FROM RESTAURANT
ORDER BY avg_rating DESC, total_ratings DESC
LIMIT 3;




Q30. List restaurants with average delivery time less than 30 minutes.
Text: Find restaurants that can deliver an order in under 30 minutes on average.


SELECT restaurant_id, name, cuisines, avg_delivery_mins, delivery_radius_km
FROM RESTAURANT
WHERE avg_delivery_mins < 30 AND is_open = TRUE
ORDER BY avg_delivery_mins;






============================================================================================================================================================================================
										SECTION D: ORDER QUERIES
============================================================================================================================================================================================


Q31. List all orders with customer names and order status.
Text: Show each order's ID, customer name, order type, grand total, and current status.


SELECT O.order_id, U.full_name AS customer, O.order_type, O.grand_total, O.status, O.placed_at
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
ORDER BY O.placed_at DESC;




Q32. List all restaurant orders with the restaurant name.
Text: Show all orders placed at restaurants, including the restaurant name and the customer name.


SELECT O.order_id, U.full_name AS customer, R.name AS restaurant,
      O.grand_total, O.status, O.placed_at
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
JOIN RESTAURANT R ON O.restaurant_id = R.restaurant_id
WHERE O.order_type = 'restaurant'
ORDER BY O.placed_at DESC;




Q33. List all grocery orders with the store name.
Text: Show all orders placed at grocery stores, including the store name and customer name.


SELECT O.order_id, U.full_name AS customer, GS.name AS store,
      O.grand_total, O.status, O.placed_at
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
JOIN GROCERY_STORE GS ON O.store_id = GS.store_id
WHERE O.order_type = 'grocery'
ORDER BY O.placed_at DESC;




Q34. Find all orders with their items and item prices.
Text: For each order, list every item ordered along with quantity and unit price.


SELECT O.order_id, O.status,
      COALESCE(P.name, MI.name) AS item_name,
      OI.quantity, OI.unit_price,
      (OI.quantity * OI.unit_price) AS line_total
FROM `ORDER` O
JOIN ORDER_ITEM OI ON O.order_id = OI.order_id
LEFT JOIN PRODUCT P ON OI.product_id = P.product_id
LEFT JOIN MENU_ITEM MI ON OI.item_id = MI.item_id
ORDER BY O.order_id;




Q35. Find the total number of orders placed by each customer.
Text: Count how many orders each customer has placed.


SELECT U.full_name, COUNT(O.order_id) AS total_orders,
      SUM(O.grand_total) AS total_spent
FROM CUSTOMER C
JOIN USER U ON C.user_id = U.user_id
LEFT JOIN `ORDER` O ON C.customer_id = O.customer_id
GROUP BY C.customer_id, U.full_name
ORDER BY total_orders DESC;




Q36. Find total revenue generated per day.
Text: Calculate the total revenue (grand_total) grouped by order date.


SELECT DATE(placed_at) AS order_date, COUNT(order_id) AS num_orders,
      SUM(grand_total) AS daily_revenue
FROM `ORDER`
WHERE status NOT IN ('cancelled')
GROUP BY DATE(placed_at)
ORDER BY order_date;




Q37. Find the most ordered menu item across all restaurants.
Text: Identify which menu item has been ordered the most number of times.


SELECT MI.item_id, MI.name AS item, R.name AS restaurant,
      SUM(OI.quantity) AS total_ordered
FROM ORDER_ITEM OI
JOIN MENU_ITEM MI ON OI.item_id = MI.item_id
JOIN RESTAURANT R ON MI.restaurant_id = R.restaurant_id
GROUP BY MI.item_id, MI.name, R.name
ORDER BY total_ordered DESC
LIMIT 5;




Q38. Find the most ordered grocery product across all stores.
Text: Identify which grocery product has been ordered the most.


SELECT P.product_id, P.name AS product, P.brand,
      SUM(OI.quantity) AS total_ordered
FROM ORDER_ITEM OI
JOIN PRODUCT P ON OI.product_id = P.product_id
GROUP BY P.product_id, P.name, P.brand
ORDER BY total_ordered DESC
LIMIT 5;




Q39. List all cancelled orders with the reason.
Text: Show all orders that were cancelled, along with who cancelled them, the reason, and refund information.


SELECT O.order_id, U.full_name AS customer, CN.cancelled_by, CN.reason,
      CN.refund_status, CN.refund_amount, CN.cancelled_at
FROM CANCELLATION CN
JOIN `ORDER` O ON CN.order_id = O.order_id
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id;




Q40. Find orders where a discount was applied.
Text: List all orders that had a discount greater than zero.


SELECT O.order_id, U.full_name AS customer, O.grand_total, O.discount, O.placed_at
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
WHERE O.discount > 0
ORDER BY O.discount DESC;




Q41. Find orders with substituted items and whether the customer approved.
Text: Show all orders that had at least one item substitution and the approval status.


SELECT O.order_id, U.full_name AS customer,
      OI_ref.order_item_id AS original_item,
      OI_sub.order_item_id AS substitute_item,
      OS.customer_approved
FROM ORDER_SUBSTITUTION OS
JOIN ORDER_ITEM OI_ref ON OS.reference_id = OI_ref.order_item_id
JOIN ORDER_ITEM OI_sub ON OS.substitute_item_id = OI_sub.order_item_id
JOIN `ORDER` O ON OI_ref.order_id = O.order_id
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id;




Q42. Calculate average order value per order type.
Text: Find the average order grand total for restaurant orders vs grocery orders.


SELECT order_type,
      COUNT(order_id) AS total_orders,
      ROUND(AVG(grand_total), 2) AS avg_order_value,
      SUM(grand_total) AS total_revenue
FROM `ORDER`
WHERE status = 'delivered'
GROUP BY order_type;




Q43. Find the top 3 customers by total spending.
Text: Identify the 3 customers who have spent the most money across all delivered orders.


SELECT U.full_name, SUM(O.grand_total) AS total_spent
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
WHERE O.status = 'delivered'
GROUP BY C.customer_id, U.full_name
ORDER BY total_spent DESC
LIMIT 3;




Q44. Find orders that have more than 2 items.
Text: Identify orders that contain more than 2 distinct order items.


SELECT O.order_id, U.full_name AS customer, COUNT(OI.order_item_id) AS item_count, O.grand_total
FROM `ORDER` O
JOIN ORDER_ITEM OI ON O.order_id = OI.order_id
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
GROUP BY O.order_id, U.full_name, O.grand_total
HAVING COUNT(OI.order_item_id) > 2
ORDER BY item_count DESC;




Q45. List all pending orders.
Text: Show all orders that are currently in 'pending' status.


SELECT O.order_id, U.full_name AS customer, O.order_type,
      O.grand_total, O.placed_at
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
WHERE O.status = 'pending'
ORDER BY O.placed_at;




============================================================================================================================================================================================
	 									SECTION E: TRANSACTION QUERIES
============================================================================================================================================================================================


Q46. List all payments with their order and method.
Text: Show each payment along with the associated order, payment method, and payment status.


SELECT P.payment_id, O.order_id, U.full_name AS customer,
      P.method, P.status, P.paid_at, O.grand_total
FROM PAYMENT P
JOIN `ORDER` O ON P.order_id = O.order_id
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
ORDER BY P.paid_at DESC;




Q47. Find total revenue collected via each payment method.
Text: Calculate how much revenue was collected through each payment method (UPI, card, cash, etc.).


SELECT P.method, COUNT(P.payment_id) AS num_transactions,
      SUM(O.grand_total) AS total_collected
FROM PAYMENT P
JOIN `ORDER` O ON P.order_id = O.order_id
WHERE P.status = 'paid'
GROUP BY P.method
ORDER BY total_collected DESC;




Q48. List all refunded payments.
Text: Show all payments that have been refunded, along with refund amount and order details.


SELECT P.payment_id, O.order_id, U.full_name AS customer,
      CN.refund_amount, CN.refunded_at, P.method
FROM PAYMENT P
JOIN `ORDER` O ON P.order_id = O.order_id
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
JOIN CANCELLATION CN ON O.order_id = CN.order_id
WHERE P.status = 'refunded';




Q49. List all deliveries with partner and order details.
Text: Show each delivery along with the assigned partner's name, order status, and timestamps.


SELECT D.delivery_id, O.order_id, U.full_name AS partner,
      D.assigned_at, D.picked_up_at, D.delivered_at, D.status
FROM DELIVERY D
JOIN `ORDER` O ON D.order_id = O.order_id
JOIN DELIVERY_PARTNER DP ON D.partner_id = DP.partner_id
JOIN USER U ON DP.user_id = U.user_id
ORDER BY D.assigned_at DESC;




Q50. Calculate average delivery time (in minutes) per delivery partner.
Text: Find how long on average each delivery partner takes from pickup to delivery.


SELECT U.full_name AS partner, DP.vehicle_type,
      COUNT(D.delivery_id) AS total_deliveries,
      ROUND(AVG(TIMESTAMPDIFF(MINUTE, D.picked_up_at, D.delivered_at)), 1) AS avg_delivery_mins
FROM DELIVERY D
JOIN DELIVERY_PARTNER DP ON D.partner_id = DP.partner_id
JOIN USER U ON DP.user_id = U.user_id
WHERE D.status = 'delivered'
GROUP BY DP.partner_id, U.full_name, DP.vehicle_type
ORDER BY avg_delivery_mins;




Q51. Find the fastest delivery ever made.
Text: Identify the delivery with the shortest time between pickup and delivered timestamps.


SELECT D.delivery_id, O.order_id, U.full_name AS partner,
      TIMESTAMPDIFF(MINUTE, D.picked_up_at, D.delivered_at) AS delivery_mins
FROM DELIVERY D
JOIN `ORDER` O ON D.order_id = O.order_id
JOIN DELIVERY_PARTNER DP ON D.partner_id = DP.partner_id
JOIN USER U ON DP.user_id = U.user_id
WHERE D.status = 'delivered'
ORDER BY delivery_mins ASC
LIMIT 1;




Q52. Count deliveries per partner.
Text: Find how many completed deliveries each delivery partner has made.


SELECT U.full_name AS partner, DP.vehicle_type,
      COUNT(D.delivery_id) AS completed_deliveries
FROM DELIVERY D
JOIN DELIVERY_PARTNER DP ON D.partner_id = DP.partner_id
JOIN USER U ON DP.user_id = U.user_id
WHERE D.status = 'delivered'
GROUP BY DP.partner_id, U.full_name, DP.vehicle_type
ORDER BY completed_deliveries DESC;




Q53. Find orders that were cancelled and also have a delivery record assigned.
Text: List orders that got cancelled after a delivery partner was already assigned.


SELECT O.order_id, U.full_name AS customer,
      UD.full_name AS partner, D.assigned_at
FROM `ORDER` O
JOIN CANCELLATION CN ON O.order_id = CN.order_id
JOIN DELIVERY D ON O.order_id = D.order_id
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
JOIN DELIVERY_PARTNER DP ON D.partner_id = DP.partner_id
JOIN USER UD ON DP.user_id = UD.user_id;




============================================================================================================================================================================================
										SECTION F: RATING QUERIES
============================================================================================================================================================================================


Q54. List all ratings with customer names.
Text: Display all ratings along with the customer who gave them and the rating type.


SELECT R.rating_id, U.full_name AS customer, R.rating_type,
      R.rating, R.comment, R.created_at
FROM RATING R
JOIN CUSTOMER C ON R.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
ORDER BY R.created_at DESC;




Q55. Find the average rating given to each restaurant.
Text: Calculate the average rating for each restaurant based on 'restaurant' type ratings.


SELECT R2.restaurant_id, R2.name AS restaurant,
      ROUND(AVG(R.rating), 2) AS avg_rating, COUNT(R.rating_id) AS num_ratings
FROM RATING R
JOIN RESTAURANT R2 ON R.restaurant_id = R2.restaurant_id
WHERE R.rating_type = 'restaurant'
GROUP BY R2.restaurant_id, R2.name
ORDER BY avg_rating DESC;




Q56. Find the average rating for each grocery store.
Text: Calculate the average store rating from customer ratings for grocery stores.


SELECT GS.store_id, GS.name AS store,
      ROUND(AVG(R.rating), 2) AS avg_rating, COUNT(R.rating_id) AS num_ratings
FROM RATING R
JOIN GROCERY_STORE GS ON R.store_id = GS.store_id
GROUP BY GS.store_id, GS.name
ORDER BY avg_rating DESC;




Q57. Find the top-rated food items based on customer ratings.
Text: List the 5 menu items with the highest average rating from food-type ratings.


SELECT MI.item_id, MI.name AS item, R2.name AS restaurant,
      ROUND(AVG(R.rating), 2) AS avg_rating, COUNT(R.rating_id) AS num_ratings
FROM RATING R
JOIN MENU_ITEM MI ON R.item_id = MI.item_id
JOIN RESTAURANT R2 ON MI.restaurant_id = R2.restaurant_id
WHERE R.rating_type = 'food'
GROUP BY MI.item_id, MI.name, R2.name
ORDER BY avg_rating DESC
LIMIT 5;




Q58. Find the average rating received by each delivery partner.
Text: Calculate the average delivery rating given to each delivery partner.


SELECT DP.partner_id, U.full_name AS partner, DP.vehicle_type,
      ROUND(AVG(R.rating), 2) AS avg_rating, COUNT(R.rating_id) AS total_ratings
FROM RATING R
JOIN DELIVERY_PARTNER DP ON R.partner_id = DP.partner_id
JOIN USER U ON DP.user_id = U.user_id
WHERE R.rating_type = 'delivery'
GROUP BY DP.partner_id, U.full_name, DP.vehicle_type
ORDER BY avg_rating DESC;





Q59. Find customers who have given a rating of 5 to any item.
Text: List customers who have given a perfect 5 rating for any food item or product.


SELECT DISTINCT U.full_name AS customer, R.rating, R.comment, R.rating_type
FROM RATING R
JOIN CUSTOMER C ON R.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
WHERE R.rating = 5
ORDER BY U.full_name;




Q60. Find all orders that have not received any rating yet.
Text: List orders where no rating of any type has been submitted by the customer.


SELECT O.order_id, U.full_name AS customer, O.placed_at, O.status
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
WHERE O.order_id NOT IN (
   SELECT DISTINCT order_id FROM RATING WHERE order_id IS NOT NULL
)
AND O.status = 'delivered'
ORDER BY O.placed_at;




============================================================================================================================================================================================
										SECTION G: MISC (WISHLIST, COUPON, SETTLEMENT) QUERIES
============================================================================================================================================================================================


Q61. List all wishlist items for each customer.
Text: Show each customer's wishlist including whether the item is a grocery product or restaurant item.


SELECT U.full_name AS customer,
      COALESCE(P.name, MI.name) AS item_name,
      CASE WHEN WI.product_id IS NOT NULL THEN 'Grocery' ELSE 'Restaurant' END AS item_type,
      WI.added_at
FROM WISHLIST_ITEM WI
JOIN CUSTOMER C ON WI.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
LEFT JOIN PRODUCT P ON WI.product_id = P.product_id
LEFT JOIN MENU_ITEM MI ON WI.item_id = MI.item_id
ORDER BY U.full_name, WI.added_at;




Q62. Find the most wishlisted items (top 5).
Text: Identify the 5 items that appear most frequently in customer wishlists.


SELECT COALESCE(P.name, MI.name) AS item_name,
      CASE WHEN WI.product_id IS NOT NULL THEN 'Grocery' ELSE 'Restaurant' END AS type,
      COUNT(WI.wishlist_id) AS times_wishlisted
FROM WISHLIST_ITEM WI
LEFT JOIN PRODUCT P ON WI.product_id = P.product_id
LEFT JOIN MENU_ITEM MI ON WI.item_id = MI.item_id
GROUP BY WI.product_id, WI.item_id, item_name, type
ORDER BY times_wishlisted DESC
LIMIT 5;




Q63. Find customers who wishlisted an item and later ordered it.
Text: Identify customers who had an item in their wishlist and also placed an order for it.


SELECT DISTINCT U.full_name AS customer,
      COALESCE(P.name, MI.name) AS item_name,
      WI.added_at AS wishlisted_on,
      O.placed_at AS ordered_on
FROM WISHLIST_ITEM WI
JOIN CUSTOMER C ON WI.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
JOIN `ORDER` O ON C.customer_id = O.customer_id
JOIN ORDER_ITEM OI ON O.order_id = OI.order_id
LEFT JOIN PRODUCT P ON WI.product_id = P.product_id AND OI.product_id = WI.product_id
LEFT JOIN MENU_ITEM MI ON WI.item_id = MI.item_id AND OI.item_id = WI.item_id
WHERE (WI.product_id IS NOT NULL AND OI.product_id = WI.product_id)
  OR (WI.item_id   IS NOT NULL AND OI.item_id   = WI.item_id);




Q64. List all active coupons (valid today).
Text: Display coupons that are currently valid and still have uses remaining.


SELECT coupon_id, code, discount_value, discount_type, max_discount_cap,
      applicable_to, min_order_value, (max_uses - times_used) AS uses_remaining
FROM COUPON
WHERE valid_from <= CURDATE() AND valid_until >= CURDATE()
 AND times_used < max_uses
ORDER BY discount_value DESC;




Q65. Find the most used coupon.
Text: Identify the coupon that has been redeemed the most number of times.


SELECT coupon_id, code, discount_value, discount_type, times_used, max_uses
FROM COUPON
ORDER BY times_used DESC
LIMIT 1;




Q66. Find coupons that are nearly exhausted (over 80% used).
Text: List coupons where more than 80% of their maximum uses have been consumed.


SELECT coupon_id, code, times_used, max_uses,
      ROUND((times_used / max_uses) * 100, 1) AS usage_pct
FROM COUPON
WHERE (times_used / max_uses) >= 0.8
ORDER BY usage_pct DESC;




Q67. List all settlement records with the entity name (store or restaurant).
Text: Show each settlement record along with the name of the restaurant or store that was settled.


SELECT S.settlement_id,
      COALESCE(GS.name, R.name) AS entity_name,
      S.partner_type,
      S.total_orders, S.gross_value, S.commission, S.net_payable,
      S.period_from, S.period_to, S.status
FROM SETTLEMENT S
LEFT JOIN GROCERY_STORE GS ON S.store_id = GS.store_id
LEFT JOIN RESTAURANT R ON S.restaurant_id = R.restaurant_id
ORDER BY S.period_from, S.settlement_id;





Q68. Find total commissions earned from restaurants vs grocery stores.
Text: Compare the total platform commission earned from restaurants versus grocery stores.


SELECT
   CASE WHEN S.restaurant_id IS NOT NULL THEN 'Restaurant'
        ELSE 'Grocery' END AS partner_type,
   COUNT(S.settlement_id) AS settlements,
   SUM(S.gross_value) AS total_gross,
   SUM(S.commission) AS total_commission,
   SUM(S.net_payable) AS total_net_payable
FROM SETTLEMENT S
WHERE S.status = 'settled'
GROUP BY partner_type;




Q69. Find settlements that are still pending.
Text: List all settlement records that have not yet been paid out.


SELECT S.settlement_id,
      COALESCE(GS.name, R.name) AS entity_name,
      S.partner_type, S.net_payable, S.period_from, S.period_to
FROM SETTLEMENT S
LEFT JOIN GROCERY_STORE GS ON S.store_id = GS.store_id
LEFT JOIN RESTAURANT R ON S.restaurant_id = R.restaurant_id
WHERE S.status = 'pending';




============================================================================================================================================================================================
										SECTION H: ADVANCED / ANALYTICAL QUERIES
============================================================================================================================================================================================


Q70. Find the most popular restaurant by number of delivered orders.
Text: Rank restaurants by the total number of successfully delivered orders.


SELECT R.restaurant_id, R.name AS restaurant,
      COUNT(O.order_id) AS delivered_orders
FROM `ORDER` O
JOIN RESTAURANT R ON O.restaurant_id = R.restaurant_id
WHERE O.status = 'delivered'
GROUP BY R.restaurant_id, R.name
ORDER BY delivered_orders DESC;




Q71. Find the most popular grocery store by number of delivered orders.
Text: Rank grocery stores by the total number of successfully delivered grocery orders.


SELECT GS.store_id, GS.name AS store,
      COUNT(O.order_id) AS delivered_orders
FROM `ORDER` O
JOIN GROCERY_STORE GS ON O.store_id = GS.store_id
WHERE O.status = 'delivered'
GROUP BY GS.store_id, GS.name
ORDER BY delivered_orders DESC;




Q72. Rank delivery partners by revenue generated for the platform.
Text: Find which delivery partner brought in the most total revenue through their deliveries.


SELECT U.full_name AS partner, DP.vehicle_type,
      COUNT(D.delivery_id) AS deliveries,
      SUM(O.grand_total) AS revenue_generated
FROM DELIVERY D
JOIN DELIVERY_PARTNER DP ON D.partner_id = DP.partner_id
JOIN USER U ON DP.user_id = U.user_id
JOIN `ORDER` O ON D.order_id = O.order_id
WHERE D.status = 'delivered'
GROUP BY DP.partner_id, U.full_name, DP.vehicle_type
ORDER BY revenue_generated DESC;




Q73. Monthly revenue trend for the platform.
Text: Calculate total revenue for each month to observe growth trends.


SELECT DATE_FORMAT(placed_at, '%Y-%m') AS month,
      COUNT(order_id) AS total_orders,
      SUM(grand_total) AS monthly_revenue,
      ROUND(AVG(grand_total), 2) AS avg_order_value
FROM `ORDER`
WHERE status NOT IN ('cancelled', 'pending')
GROUP BY DATE_FORMAT(placed_at, '%Y-%m')
ORDER BY month;




Q74. Find customers who placed orders in consecutive months (repeat customers).
Text: Identify customers who have placed at least one order in two or more different months.


SELECT U.full_name AS customer, COUNT(DISTINCT DATE_FORMAT(O.placed_at, '%Y-%m')) AS active_months,
      COUNT(O.order_id) AS total_orders
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
GROUP BY C.customer_id, U.full_name
HAVING active_months >= 2
ORDER BY active_months DESC;




Q75. Find the day of the week with the highest number of orders.
Text: Determine which weekday receives the most orders from customers.


SELECT DAYNAME(placed_at) AS day_of_week,
      COUNT(order_id) AS total_orders,
      SUM(grand_total) AS total_revenue
FROM `ORDER`
GROUP BY DAYNAME(placed_at), DAYOFWEEK(placed_at)
ORDER BY DAYOFWEEK(placed_at);




Q76. Find customers who have only placed grocery orders.
Text: List customers who have exclusively ordered from grocery stores and never from restaurants.


SELECT U.full_name AS customer, COUNT(O.order_id) AS grocery_orders
FROM CUSTOMER C
JOIN USER U ON C.user_id = U.user_id
JOIN `ORDER` O ON C.customer_id = O.customer_id
WHERE O.order_type = 'grocery'
AND C.customer_id NOT IN (
   SELECT customer_id FROM `ORDER` WHERE order_type = 'restaurant'
)
GROUP BY C.customer_id, U.full_name;




Q77. Find customers who have only placed restaurant orders.
Text: List customers who have exclusively ordered from restaurants.


SELECT U.full_name AS customer, COUNT(O.order_id) AS restaurant_orders
FROM CUSTOMER C
JOIN USER U ON C.user_id = U.user_id
JOIN `ORDER` O ON C.customer_id = O.customer_id
WHERE O.order_type = 'restaurant'
AND C.customer_id NOT IN (
   SELECT customer_id FROM `ORDER` WHERE order_type = 'grocery'
)
GROUP BY C.customer_id, U.full_name;




Q78. Find the busiest hour of the day for orders.
Text: Determine which hour of the day has the most orders placed.


SELECT HOUR(placed_at) AS order_hour,
      COUNT(order_id) AS total_orders
FROM `ORDER`
GROUP BY HOUR(placed_at)
ORDER BY total_orders DESC;




Q79. Find revenue and commission for each restaurant.
Text: Show total revenue and total platform commission collected for each restaurant.


SELECT R.name AS restaurant,
      COUNT(O.order_id) AS total_orders,
      SUM(O.grand_total) AS total_revenue,
      ROUND(SUM(O.grand_total) * (R.commission_pct / 100), 2) AS platform_commission
FROM `ORDER` O
JOIN RESTAURANT R ON O.restaurant_id = R.restaurant_id
WHERE O.status = 'delivered'
GROUP BY R.restaurant_id, R.name, R.commission_pct
ORDER BY total_revenue DESC;




Q80. Find revenue and commission for each grocery store.
Text: Show total revenue and platform commission collected from each grocery store.


SELECT GS.name AS store,
      COUNT(O.order_id) AS total_orders,
      SUM(O.grand_total) AS total_revenue,
      ROUND(SUM(O.grand_total) * (GS.commission_pct / 100), 2) AS platform_commission
FROM `ORDER` O
JOIN GROCERY_STORE GS ON O.store_id = GS.store_id
WHERE O.status = 'delivered'
GROUP BY GS.store_id, GS.name, GS.commission_pct
ORDER BY total_revenue DESC;




Q81. List all orders along with their payment and delivery status.
Text: Join ORDER, PAYMENT, and DELIVERY to show a complete order fulfilment picture.


SELECT O.order_id, U.full_name AS customer, O.order_type,
      O.grand_total, O.status AS order_status,
      P.method AS payment_method, P.status AS payment_status,
      D.status AS delivery_status, D.delivered_at
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
LEFT JOIN PAYMENT P ON O.order_id = P.order_id
LEFT JOIN DELIVERY D ON O.order_id = D.order_id
ORDER BY O.placed_at DESC;




Q82. Find the cancellation rate per restaurant.
Text: Calculate what percentage of orders placed at each restaurant were cancelled.


SELECT R.name AS restaurant,
      COUNT(O.order_id) AS total_orders,
      SUM(CASE WHEN O.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
      ROUND(SUM(CASE WHEN O.status = 'cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(O.order_id), 2) AS cancellation_rate_pct
FROM `ORDER` O
JOIN RESTAURANT R ON O.restaurant_id = R.restaurant_id
GROUP BY R.restaurant_id, R.name
ORDER BY cancellation_rate_pct DESC;




Q83. Identify high-value orders (above the average order value).
Text: List all orders whose grand total is above the overall average order value.


SELECT O.order_id, U.full_name AS customer, O.grand_total,
      O.order_type, O.placed_at
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
WHERE O.grand_total > (SELECT AVG(grand_total) FROM `ORDER` WHERE status = 'delivered')
AND O.status = 'delivered'
ORDER BY O.grand_total DESC;




Q84. Find delivery partners who have delivered orders for both grocery stores and restaurants.
Text: List delivery partners who have made deliveries for both grocery store orders and restaurant orders.


SELECT U.full_name AS partner, DP.vehicle_type
FROM DELIVERY_PARTNER DP
JOIN USER U ON DP.user_id = U.user_id
WHERE DP.partner_id IN (
   SELECT D.partner_id FROM DELIVERY D
   JOIN `ORDER` O ON D.order_id = O.order_id
   WHERE O.order_type = 'grocery'
)
AND DP.partner_id IN (
   SELECT D.partner_id FROM DELIVERY D
   JOIN `ORDER` O ON D.order_id = O.order_id
   WHERE O.order_type = 'restaurant'
);




Q85. Rank customers by total spending using window function.
Text: Use a window function to assign a spending rank to each customer.


SELECT U.full_name AS customer,
      SUM(O.grand_total) AS total_spent,
      RANK() OVER (ORDER BY SUM(O.grand_total) DESC) AS spending_rank
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
WHERE O.status = 'delivered'
GROUP BY C.customer_id, U.full_name;




Q86. Show running total of revenue over time.
Text: Display a cumulative (running) total of platform revenue ordered by date.


SELECT DATE(placed_at) AS order_date,
      SUM(grand_total) AS daily_revenue,
      SUM(SUM(grand_total)) OVER (ORDER BY DATE(placed_at)) AS running_total
FROM `ORDER`
WHERE status NOT IN ('cancelled', 'pending')
GROUP BY DATE(placed_at)
ORDER BY order_date;




Q87. Find all customers and their last order date.
Text: For each customer, display when their most recent order was placed.


SELECT U.full_name AS customer,
      MAX(O.placed_at) AS last_order_date,
      DATEDIFF(CURDATE(), MAX(O.placed_at)) AS days_since_last_order
FROM CUSTOMER C
JOIN USER U ON C.user_id = U.user_id
LEFT JOIN `ORDER` O ON C.customer_id = O.customer_id
GROUP BY C.customer_id, U.full_name
ORDER BY last_order_date DESC;




Q88. Find restaurants with no orders placed.
Text: List restaurants that have not received any orders.


SELECT R.restaurant_id, R.name, R.cuisines
FROM RESTAURANT R
WHERE R.restaurant_id NOT IN (
   SELECT DISTINCT restaurant_id FROM `ORDER` WHERE restaurant_id IS NOT NULL
);




Q89. Find grocery stores with no orders placed.
Text: List grocery stores that have not received any orders.


SELECT GS.store_id, GS.name
FROM GROCERY_STORE GS
WHERE GS.store_id NOT IN (
   SELECT DISTINCT store_id FROM `ORDER` WHERE store_id IS NOT NULL
);




Q90. Find products that have never been ordered.
Text: List grocery products that have not appeared in any order.


SELECT P.product_id, P.name, P.brand
FROM PRODUCT P
WHERE P.product_id NOT IN (
   SELECT DISTINCT product_id FROM ORDER_ITEM WHERE product_id IS NOT NULL
);




Q91. Find menu items that have never been ordered.
Text: List restaurant menu items that have never appeared in any order.


SELECT MI.item_id, MI.name, R.name AS restaurant
FROM MENU_ITEM MI
JOIN RESTAURANT R ON MI.restaurant_id = R.restaurant_id
WHERE MI.item_id NOT IN (
   SELECT DISTINCT item_id FROM ORDER_ITEM WHERE item_id IS NOT NULL
);




Q92. List all restaurants and their total number of menu items.
Text: Count how many menu items each restaurant has across all categories.


SELECT R.restaurant_id, R.name AS restaurant,
      COUNT(MI.item_id) AS total_menu_items
FROM RESTAURANT R
LEFT JOIN MENU_ITEM MI ON R.restaurant_id = MI.restaurant_id
GROUP BY R.restaurant_id, R.name
ORDER BY total_menu_items DESC;




Q93. Find the contribution percentage of each restaurant to total revenue.
Text: Calculate what percent of the platform's total delivered revenue comes from each restaurant.


SELECT R.name AS restaurant,
      SUM(O.grand_total) AS restaurant_revenue,
      ROUND(SUM(O.grand_total) * 100.0 / (SELECT SUM(grand_total) FROM `ORDER` WHERE status = 'delivered'), 2) AS revenue_pct
FROM `ORDER` O
JOIN RESTAURANT R ON O.restaurant_id = R.restaurant_id
WHERE O.status = 'delivered'
GROUP BY R.restaurant_id, R.name
ORDER BY revenue_pct DESC;




Q94. Full customer order history view.
Text: Generate a complete order history for each customer showing all orders, items, payment, and delivery.


SELECT U.full_name AS customer,
      O.order_id,
      O.placed_at,
      O.order_type,
      COALESCE(GS.name, R.name) AS entity_name,
      COALESCE(P2.name, MI.name) AS item_name,
      OI.quantity,
      OI.unit_price,
      O.grand_total,
      O.status AS order_status,
      PY.method AS payment_method,
      D.status AS delivery_status
FROM `ORDER` O
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
LEFT JOIN GROCERY_STORE GS ON O.store_id = GS.store_id
LEFT JOIN RESTAURANT R ON O.restaurant_id = R.restaurant_id
JOIN ORDER_ITEM OI ON O.order_id = OI.order_id
LEFT JOIN PRODUCT P2 ON OI.product_id = P2.product_id
LEFT JOIN MENU_ITEM MI ON OI.item_id = MI.item_id
LEFT JOIN PAYMENT PY ON O.order_id = PY.order_id
LEFT JOIN DELIVERY D ON O.order_id = D.order_id
ORDER BY U.full_name, O.placed_at, OI.order_item_id;




Q95. Find all products and their variants with discounted percentage.
Text: Show the discount percentage on each product variant compared to MRP.


SELECT P.name AS product, PV.label,
      PV.mrp, PV.selling_price,
      ROUND(((PV.mrp - PV.selling_price) / PV.mrp) * 100, 2) AS discount_pct
FROM PRODUCT_VARIANT PV
JOIN PRODUCT P ON PV.product_id = P.product_id
ORDER BY discount_pct DESC;




Q96. Find the product variant with the highest discount percentage.
Text: Identify which product variant offers the greatest percentage discount on MRP.


SELECT P.name AS product, PV.label, PV.mrp, PV.selling_price,
      ROUND(((PV.mrp - PV.selling_price) / PV.mrp) * 100, 2) AS discount_pct
FROM PRODUCT_VARIANT PV
JOIN PRODUCT P ON PV.product_id = P.product_id
ORDER BY discount_pct DESC
LIMIT 1;




Q97. Count how many distinct cuisines are served across all restaurants.
Text: Find all unique cuisines available across the entire restaurant catalogue.


SELECT DISTINCT TRIM(cuisine_name) AS cuisine
FROM RESTAURANT
JOIN JSON_TABLE(
   CONCAT('["', REPLACE(cuisines, ',', '","'), '"]'),
   '$[*]' COLUMNS (cuisine_name VARCHAR(100) PATH '$')
) AS jt
ORDER BY cuisine;




Q98. Find customers who have given an average rating of 4 or above.
Text: Identify customers who consistently give high ratings (average >= 4).


SELECT U.full_name AS customer,
      COUNT(R.rating_id) AS total_ratings_given,
      ROUND(AVG(R.rating), 2) AS avg_rating_given
FROM RATING R
JOIN CUSTOMER C ON R.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
GROUP BY C.customer_id, U.full_name
HAVING avg_rating_given >= 4
ORDER BY avg_rating_given DESC;




Q99. Identify orders where delivery took longer than estimated.
Text: Find all orders where actual delivery duration exceeded the estimated delivery time.


SELECT O.order_id, U.full_name AS customer,
      O.est_delivery_mins AS estimated_mins,
      TIMESTAMPDIFF(MINUTE, D.assigned_at, D.delivered_at) AS actual_mins,
      (TIMESTAMPDIFF(MINUTE, D.assigned_at, D.delivered_at) - O.est_delivery_mins) AS delay_mins
FROM `ORDER` O
JOIN DELIVERY D ON O.order_id = D.order_id
JOIN CUSTOMER C ON O.customer_id = C.customer_id
JOIN USER U ON C.user_id = U.user_id
WHERE D.status = 'delivered'
AND TIMESTAMPDIFF(MINUTE, D.assigned_at, D.delivered_at) > O.est_delivery_mins
ORDER BY delay_mins DESC;




Q100. Summary dashboard: platform-level KPIs.
Text: Display a one-shot summary of key platform metrics —
       total users, customers, partners, restaurants, stores, orders, and revenue.


SELECT
   (SELECT COUNT(*) FROM USER)                                      AS total_users,
   (SELECT COUNT(*) FROM CUSTOMER)                                  AS total_customers,
   (SELECT COUNT(*) FROM DELIVERY_PARTNER)                         AS total_partners,
   (SELECT COUNT(*) FROM RESTAURANT)                               AS total_restaurants,
   (SELECT COUNT(*) FROM GROCERY_STORE)                            AS total_stores,
   (SELECT COUNT(*) FROM `ORDER`)                                  AS total_orders,
   (SELECT COUNT(*) FROM `ORDER` WHERE status = 'delivered')       AS delivered_orders,
   (SELECT COUNT(*) FROM `ORDER` WHERE status = 'cancelled')       AS cancelled_orders,
   (SELECT ROUND(SUM(grand_total), 2) FROM `ORDER`
    WHERE status = 'delivered')                                     AS total_revenue,
   (SELECT ROUND(AVG(grand_total), 2) FROM `ORDER`
    WHERE status = 'delivered')                                     AS avg_order_value;
