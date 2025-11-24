-- join data
select 
  o.order_id, 
  o.order_date,
  o.customer_id,
  o.staff_id,
  o.order_status,
  o.required_date,
  c.customer_id,
  c.first_name as customer_first_name,
  c.last_name as customer_last_name,
  c.phone as customer_phone,
  c.email as customer_email,
  c.street as customer_street,
  c.city as customer_city,
  c.state as customer_state,
  c.zip_code as customer_zip_code,
  oi.product_id as product_id,
  oi.quantity,
  oi.list_price,
  oi.discount,
  p.product_name,
  p.brand_id,
  p.category_id,
  p.model_year,
  ca.category_name,
  b.brand_name,
  s.first_name as staff_first_name,
  s.last_name as staff_last_name,
  s.manager_id 
from staging.orders o
LEFT JOIN staging.customers c ON o.customer_id = c.customer_id
LEFT JOIN staging.order_items oi ON o.order_id = oi.order_id
LEFT JOIN staging.products p ON oi.product_id = p.product_id
LEFT JOIN staging.categories ca ON p.category_id = ca.category_id
LEFT JOIN staging.brands b ON p.brand_id = b.brand_id
LEFT JOIN staging.staffs s ON o.staff_id = s.staff_id