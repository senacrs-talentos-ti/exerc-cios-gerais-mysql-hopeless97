 CREATE TABLE CLIENTS (
 ID  INT(4) AUTO_INCREMENT PRIMARY KEY,
 NAME  VARCHAR(50) NOT NULL,
 EMAIL  VARCHAR(50) NOT NULL
 );
 
 CREATE TABLE PRODUCTS (
 ID INT(4) AUTO_INCREMENT PRIMARY KEY,
 NAME VARCHAR(50) NOT NULL,
 PRICE DECIMAL(5, 2) NOT NULL
 );
 
 CREATE TABLE ORDERS (
 ID INT(4) AUTO_INCREMENT PRIMARY KEY,
 CLIENT_ID INT, 
 ORDER_DATE DATE NOT NULL,
 TOTAL DECIMAL(5, 2) NOT NULL,
  FOREIGN KEY(CLIENT_ID) REFERENCES CLIENTS(ID)
 );
 
 
 CREATE TABLE ORDER_ITEMS (
 ORDER_ID INT, 
 PRODUCT_ID INT, 
 QUANTITY INT(4) NOT NULL,
 PRICE DECIMAL(5, 2) NOT NULL,
 PRIMARY KEY(ORDER_ID, PRODUCT_ID),
 FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ID),
 FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCTS(ID)
 );
 

 INSERT INTO CLIENTS (ID, NAME, EMAIL) VALUES 
 (DEFAULT, 'HARPER O.', 'HARPER.O@GMAOL.COM'),
 (DEFAULT, 'DYLAN C.', 'DYLAN.C@GMAIL.COM'),
 (DEFAULT, 'ACE O.', 'ACE.O@GMAIL.COM'),
 (DEFAULT, 'JOEY D.', 'JOEY.D@GMAIL.COM'),
 (DEFAULT, 'JANNY C.', 'JANNY.C@GMAIL.COM'),
 (DEFAULT, 'CARL B.', 'CARLB.@GMAIL.COM'),
 (DEFAULT, 'SHANE V.', 'SHANE.V@GMAIL.COM'),
 (DEFAULT, 'AMBER Y.', 'AMB.Y@GMAIL.COM'),
 (DEFAULT, 'LAUREN G.', 'LAURY.G@GMAIL.COM'),
 (DEFAULT, 'TYLER W.', 'TY.W@GMAIL.COM'),
 (DEFAULT, 'CHRIS K.', 'CH.K@GMAIL.COM'),
 (DEFAULT, 'OLIVER D.', 'OLIVER.D@GMAIL.COM');
 
INSERT INTO PRODUCTS (ID, NAME, PRICE) VALUES
(DEFAULT, 'CALCA JEANS', 15.00),
(DEFAULT, 'CAMISA MANGA LONGA', 10.00),
(DEFAULT, 'CAMISA MANGA CURTA', 5.00),
(DEFAULT, 'BERMUDAS', 5.00),
(DEFAULT, 'SAIAS', 5.00),
(DEFAULT, 'CASACOS', 20.00),
(DEFAULT, 'CASACOS DE INVERNO', 25.00),
(DEFAULT, 'ADERECOS', 4.00),
(DEFAULT, 'CALCADOS', 8.00);

INSERT INTO ORDERS (ID, CLIENT_ID, ORDER_DATE, TOTAL) VALUES
(DEFAULT, 1, '2024-09-17', 50.00),
(DEFAULT, 2, '2024-09-20', 200.00),
(DEFAULT, 3, '2024-09-27', 45.00),
(DEFAULT, 4, '2024-09-28', 80.00),
(DEFAULT, 5, '2024-10-01', 68.00),
(DEFAULT, 6, '2024-10-04', 108.00),
(DEFAULT, 7, '2024-10-10', 90.00),
(DEFAULT, 8, '2024-10-17', 75.00);

INSERT INTO ORDER_ITEMS (ORDER_ID, PRODUCT_ID, QUANTITY, PRICE) VALUES
(1, 7, 20, 15.00),
(2, 8, 40, 10.00),
(3, 5, 50, 5.00),
(4, 3, 10, 5.00),
(5, 2, 34, 5.00),
(6, 1, 10, 20.00);





 UPDATE PRODUCTS SET PRICE = 6.00 WHERE ID = 8;
 UPDATE ORDER_ITEMS SET PRICE = 6.00 WHERE PRODUCT_ID = 8;
 

ALTER TABLE CLIENTS ADD COLUMN BIRTHDATE DATE;
USE BRECHO;

SELECT CLIENTS.NAME AS CLIENTS, ORDERS.ID AS ORDERS_ITEMS, ORDER_ITEMS.PRODUCT_ID, PRODUCTS.NAME AS PRODUCTS
FROM CLIENTS
INNER JOIN ORDERS ON CLIENTS.ID = ORDERS.CLIENT_ID
INNER JOIN ORDER_ITEMS ON ORDERS.ID = ORDER_ITEMS.ORDER_ID
INNER JOIN PRODUCTS ON ORDER_ITEMS.PRODUCT_ID = PRODUCTS.ID;

SELECT CLIENTS.NAME AS CLIENTS, ORDERS.ID AS ORDERS_ITEMS, ORDER_ITEMS.PRODUCT_ID, PRODUCTS.NAME AS PRODUCTS
FROM CLIENTS
LEFT JOIN ORDERS ON CLIENTS.ID = ORDERS.CLIENT_ID
LEFT JOIN ORDER_ITEMS ON ORDERS.ID = ORDER_ITEMS.ORDER_ID
LEFT JOIN PRODUCTS ON ORDER_ITEMS.PRODUCT_ID = PRODUCTS.ID;

SELECT  ORDERS.ID AS ORDERS_ID, ORDER_ITEMS.PRODUCT_ID, PRODUCTS.NAME AS PRODUCTS
FROM ORDERS 
RIGHT JOIN ORDER_ITEMS ON ORDERS.ID = ORDER_ITEMS.ORDER_ID
RIGHT JOIN PRODUCTS ON ORDER_ITEMS.PRODUCT_ID = PRODUCTS.ID;


SELECT TOTAL, SUM(TOTAL) as totalVendas, SUM(QUANTITY) AS totalDeItemsVendidos
FROM ORDERS, order_items
GROUP BY TOTAL, quantity;


select clients.name as clients, clients.ID, COUNT(TOTAL) as totalPedidos
from clients
LEFT JOIN orders
 on clients.ID = orders.client_ID
group by clients.id, orders.total 
order by totalPedidos desc;

select products.name as products, products.id, count(quantity)as quantity
from products
right join order_items
on products.id = order_items.product_id
group by products.id, order_items.quantity
order by quantity desc;


select clients.name as clients, clients.ID, COUNT(TOTAL) as totalPedidos
from clients
LEFT JOIN orders
 on clients.ID = orders.client_ID
group by clients.id, orders.total 
order by total desc;

select products.name as products, products.id, count(quantity)as quantity
from products
right join order_items
on products.id = order_items.product_id
group by products.id, order_items.quantity
order by quantity asc
limit 3;

select clients.name as clients, clients.ID, sum(TOTAL) as totalPedidos
from clients
LEFT JOIN orders
 on clients.ID = orders.client_id
group by clients.id, orders.total 
order by total desc
limit 3;

select clients.name as cliente, clients.id, avg(quantity) as mediaDeProdutos, order_items.order_id, products.id as products_id, products.name as products
from clients
inner join orders on clients.id = orders.client_id
inner join order_items on orders.id = order_items.order_id
inner join products on order_items.product_id = products.id
group by clients.id, orders.id, order_items.order_id, products.id
order by mediaDeProdutos asc;


select order_DATE as MONTHs, count(ORDERS.ID) as totalPedidos, count(ORDERS.CLIENT_ID) AS totalCliente
from ORDERS
inner join orders on order_date = orders.client_id
GROUP BY ORDERS.ORDER_DATE, orders.client_id
ORDER BY MONTHs;


select products.id, products.name as products,products.price, order_items.product_id
from products
left join order_items on products.id = order_items.product_id
where order_items.product_id is null;


select order_items.order_id, orders.id, order_items.product_id
from orders
inner join order_items on orders.id = order_items.order_id
group by order_items.order_id, order_items.product_id
having count(order_items.product_id) > 2;

select clients.id, clients.name, avg(total) as values_order
from clients
inner join orders on clients.id = orders.CLIENT_ID
group by clients.id, clients.name, orders.id
order by values_order desc;
 
select products.id, products.name, sum(quantity) as quantityTotal
 from products
 right join order_items on products.id = order_items.PRODUCT_ID
 group by products.id, order_items.PRODUCT_ID
 order by quantityTotal desc;
 
