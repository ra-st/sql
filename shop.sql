-- tables
-- Table: carts
CREATE TABLE carts (
    cart_id int NOT NULL,
    wallet int NOT NULL,
    create_at datetime NOT NULL DEFAULT NOW(),
    CONSTRAINT `carts_pk` PRIMARY KEY (cart_id)
);

-- Table: categories
CREATE TABLE categories (
    category_id int NOT NULL,
    name varchar(255) NOT NULL,
    parent int NULL DEFAULT 0,
    created_at datetime NOT NULL DEFAULT NOW(),
    created_by varchar(50) NOT NULL,
    CONSTRAINT `categories_pk` PRIMARY KEY (category_id)
);

-- Table: customers
CREATE TABLE customers (
    customer_phone varchar(50) NOT NULL,
    discount int NULL,
    CONSTRAINT `customers_pk` PRIMARY KEY (customer_phone)
);

-- Table: discounts
CREATE TABLE discounts (
    discount_id int NOT NULL,
    amount int NOT NULL,
    mode enum('percently','non-percently') NOT NULL DEFAULT 'percently',
    from_max int NULL,
    from_min int NULL,
    consumed int NOT NULL DEFAULT 0,
    CONSTRAINT `discounts_pk` PRIMARY KEY (discount_id)
);

-- Table: employees
CREATE TABLE employees (
    employee_phone varchar(50) NOT NULL,
    salary int NOT NULL DEFAULT 0,
    join_at datetime NOT NULL DEFAULT NOW(),
    CONSTRAINT `employees_pk` PRIMARY KEY (employee_phone)
);

-- Table: factors
CREATE TABLE factors (
    factor_id int NOT NULL,
    wallet int NOT NULL,
    mode enum('pay_in','pay_out') NOT NULL DEFAULT 'pay_out',
    title text NOT NULL,
    details text NOT NULL,
    amount int NOT NULL,
    date_time datetime NOT NULL DEFAULT NOW(),
    shop int NOT NULL,
    CONSTRAINT `factors_pk` PRIMARY KEY (factor_id)
);

-- Table: jobs
CREATE TABLE jobs (
    job_id int NOT NULL,
    employee varchar(50) NULL,
    role text NOT NULL,
    salary int NOT NULL DEFAULT 0,
    rate enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
    CONSTRAINT `jobs_pk` PRIMARY KEY (job_id)
);

-- Table: persons
CREATE TABLE persons (
    phone varchar(50) NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    address text NULL,
    city varchar(50),
    email text NULL,
    birth_date date NULL,
    wallet int NULL,
    join_at datetime NULL DEFAULT NOW(),
    CONSTRAINT `persons_pk` PRIMARY KEY (phone)
);

-- Table: persons_wallets
CREATE TABLE persons_wallets (
    person varchar(50) NOT NULL,
    wallet int NOT NULL,
    balance int NOT NULL,
    CONSTRAINT persons_wallets_pk PRIMARY KEY (person,wallet)
);

-- Table: products
CREATE TABLE products (
    product_id int NOT NULL,
    name text NOT NULL,
    price bigint NOT NULL,
    total_count int NOT NULL DEFAULT 0,
    category int NOT NULL,
    added_at datetime NOT NULL DEFAULT NOW(),
    added_by varchar(50) NOT NULL,
    shop int NOT NULL,
    CONSTRAINT `products_pk` PRIMARY KEY (product_id)
);

-- Table: products_carts
CREATE TABLE products_carts (
    product int NOT NULL,
    cart int NOT NULL,
    CONSTRAINT products_carts_pk PRIMARY KEY (product,cart)
);

-- Table: shops
CREATE TABLE shops (
    shop_id int NOT NULL,
    rate enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
    address text NOT NULL,
    city varchar(50) NOT NULL,
    shop_phone varchar(50) NOT NULL,
    CONSTRAINT `shops_pk` PRIMARY KEY (shop_id)
);

-- Table: shops_employees
CREATE TABLE shops_employees (
    shop int NOT NULL,
    employee varchar(50) NOT NULL
);

-- Table: wallets
CREATE TABLE wallets (
    wallet_id int NOT NULL,
    balance int NOT NULL DEFAULT 0,
    CONSTRAINT `wallets_pk` PRIMARY KEY (wallet_id)
);

-- Table: wallets_discounts
CREATE TABLE wallets_discounts (
    wallet int NOT NULL,
    discount int NOT NULL,
    CONSTRAINT wallets_discounts_pk PRIMARY KEY (wallet,discount)
);

-- foreign keys
-- Reference: carts_wallets (table: carts)
ALTER TABLE carts ADD CONSTRAINT carts_wallets FOREIGN KEY carts_wallets (wallet)
    REFERENCES wallets (wallet_id);

-- Reference: categories_categories (table: categories)
ALTER TABLE categories ADD CONSTRAINT categories_categories FOREIGN KEY categories_categories (parent)
    REFERENCES categories (category_id);

-- Reference: customers_persons (table: customers)
ALTER TABLE customers ADD CONSTRAINT customers_persons FOREIGN KEY customers_persons (customer_phone)
    REFERENCES persons (phone);

-- Reference: factors_shops (table: factors)
ALTER TABLE factors ADD CONSTRAINT factors_shops FOREIGN KEY factors_shops (shop)
    REFERENCES shops (shop_id);

-- Reference: factors_wallets (table: factors)
ALTER TABLE factors ADD CONSTRAINT factors_wallets FOREIGN KEY factors_wallets (wallet)
    REFERENCES wallets (wallet_id);

-- Reference: jobs_employees (table: jobs)
ALTER TABLE jobs ADD CONSTRAINT jobs_employees FOREIGN KEY jobs_employees (employee)
    REFERENCES employees (employee_phone);

-- Reference: persons_employees (table: employees)
ALTER TABLE employees ADD CONSTRAINT persons_employees FOREIGN KEY persons_employees (employee_phone)
    REFERENCES persons (phone);

-- Reference: persons_wallets_persons (table: persons_wallets)
ALTER TABLE persons_wallets ADD CONSTRAINT persons_wallets_persons FOREIGN KEY persons_wallets_persons (person)
    REFERENCES persons (phone);

-- Reference: persons_wallets_wallets (table: persons_wallets)
ALTER TABLE persons_wallets ADD CONSTRAINT persons_wallets_wallets FOREIGN KEY persons_wallets_wallets (wallet)
    REFERENCES wallets (wallet_id);

-- Reference: products_carts_carts (table: products_carts)
ALTER TABLE products_carts ADD CONSTRAINT products_carts_carts FOREIGN KEY products_carts_carts (cart)
    REFERENCES carts (cart_id);

-- Reference: products_carts_products (table: products_carts)
ALTER TABLE products_carts ADD CONSTRAINT products_carts_products FOREIGN KEY products_carts_products (product)
    REFERENCES products (product_id);

-- Reference: products_categories (table: products)
ALTER TABLE products ADD CONSTRAINT products_categories FOREIGN KEY products_categories (category)
    REFERENCES categories (category_id);

-- Reference: categories_employees (table: categories)
ALTER TABLE categories ADD CONSTRAINT categories_employees FOREIGN KEY categories (created_by)
    REFERENCES employees (employee_phone);

-- Reference: products_employees (table: products)
ALTER TABLE products ADD CONSTRAINT products_employees FOREIGN KEY products (added_by)
    REFERENCES employees (employee_phone);


-- Reference: products_shops (table: products)
ALTER TABLE products ADD CONSTRAINT products_shops FOREIGN KEY products_shops (shop)
    REFERENCES shops (shop_id);

-- Reference: shops_employees_employees (table: shops_employees)
ALTER TABLE shops_employees ADD CONSTRAINT shops_employees_employees FOREIGN KEY shops_employees_employees (employee)
    REFERENCES employees (employee_phone);

-- Reference: shops_employees_shops (table: shops_employees)
ALTER TABLE shops_employees ADD CONSTRAINT shops_employees_shops FOREIGN KEY shops_employees_shops (shop)
    REFERENCES shops (shop_id);

-- Reference: wallets_discounts_discounts (table: wallets_discounts)
ALTER TABLE wallets_discounts ADD CONSTRAINT wallets_discounts_discounts FOREIGN KEY wallets_discounts_discounts (discount)
    REFERENCES discounts (discount_id);

-- Reference: wallets_discounts_wallets (table: wallets_discounts)
ALTER TABLE wallets_discounts ADD CONSTRAINT wallets_discounts_wallets FOREIGN KEY wallets_discounts_wallets (wallet)
    REFERENCES wallets (wallet_id);

-- End of file.

INSERT INTO persons (phone, first_name, last_name, address, city, email, birth_date, join_at) 
    VALUES ('+989363716021','Ali','Ahmady','Asia/Iran/Tehran','Tehran','Ali@gmail.com','2022-01-24','2020-10-20 20:59:59'),
           ('+989363236021','Abbas','Abbasy','Asia/Iran/Mashahd','Mashhad','Abbas@gmail.com','2010-02-24','2020-10-21 20:59:59'),
           ('+989393936021','Shaba','Shabaii','Asia/Iran/Mashahd','Mashhad','Shaba@gmail.com','2010-02-24','2020-10-21 20:59:59'),
           ('+989368536021','Sola','Soly','Asia/Iran/Mashahd','Mashhad','Sola@gmail.com','2010-02-25','2020-10-21 20:59:59'),
           ('+986845536021','Sina','Sinoii','Asia/Iran/Mashahd','Mashhad','Sina@gmail.com','2010-02-26','2020-10-21 20:59:59'),
           ('+989984652021','Sagha','Asaby','Asia/Iran/Mashahd','Mashhad','Sagha@gmail.com','2010-03-28','2020-10-21 20:59:59'),
           ('+989398785021','Sana','Yasi','Asia/Iran/Mashahd','Mashhad','Sana@gmail.com','2010-02-20','2020-10-21 20:59:59'),
           ('+989986541021','hgfs','oiuy','Asia/Iran/Isfahan','Isfahan','jhgfjh@gmail.com','2010-10-03','2020-10-22 20:59:59'),
           ('+989389854621','hs','kjhgkjh','Asia/Iran/Isfahan','Isfahan','jhgfgh@gmail.com','2003-10-01','2020-10-22 20:59:59'),
           ('+986845886021','hgdf','oiuh','Asia/Iran/Isfahan','Isfahan','kufb@gmail.com','2003-10-02','2020-10-22 20:59:59'),
           ('+989984654021','utrdt','oiuhui','Asia/Iran/Isfahan','Isfahan','kuygb@gmail.com','2003-10-14','2020-10-22 20:59:59'),
           ('+989464655621','hgfd','iuho','Asia/Iran/Isfahan','Isfahan','jhgfb@gmail.com','2003-10-24','2020-10-22 20:59:59'),
           ('+989368465481','utyd','uyd','Asia/Iran/Isfahan','Isfahan','bcgfmk@gmail.com','2003-10-04','2020-10-22 20:59:59'),
           ('+989362356021','Abolfazl','Aboly','Asia/Iran/Zahedan','Zahedan','Abolfazl@gmail.com','2003-12-04','2020-10-23 20:59:59'),
           ('+989363356021','Sajjad','Sajjadi','Asia/Iran/Birjand','Birjand','Sajjad@gmail.com','2002-02-25','2020-10-22 22:59:59'),
           ('+989363235251','Kumar','Khalil','Asia/India/Mumbaii','Mumbaii','Kumar@gmail.com','2002-03-21','2020-10-22 20:59:59'),
           ('+989363713252','Saber','Sabery','Asia/Iran/Rasht','Rasht','Saber@gmail.com','2002-04-01','2020-10-23 20:59:59'),
           ('+989363235235','Saba','Sabaii','Asia/Iran/Sari','Sari','Saba@gmail.com','2000-12-24','2020-10-22 20:59:59'),
           ('+989363745346','Sara','Saboory','Asia/Iran/Urumia','Urumia','Sara@gmail.com','2004-10-24','2020-10-20 21:09:59');

INSERT INTO wallets (wallet_id,balance)
    VALUES (1,12424),
           (2,124544),
           (3,124543324),
           (4,1245443634),
           (5,124534524);

INSERT INTO persons_wallets (person, wallet, balance)
    VALUES ('+989389854621',1,10424),
           ('+986845886021',1,2000),
           ('+989984654021',2,124544),
           ('+989464655621',3,124543324),
           ('+989368465481',4,1245443634),
           ('+986845536021',2,1444),
	       ('+989368536021',3,14),
	       ('+989398785021',3,0),
	       ('+989984652021',1,141424),
	       ('+989984652021',4,0),
           ('+989362356021',5,124534524);

INSERT INTO employees (employee_phone, salary)
    VALUES ('+989363236021','10000000'),
           ('+989363716021','5000000'),
           ('+989393936021','4500000'),
           ('+986845886021','25000000'),
           ('+989363356021','335000');

INSERT INTO categories (category_id, name, parent, created_at, created_by)
    VALUES (1,'sport',null,now(),'+989363236021'),
           (2,'digital',null,now(),'+989363236021'),
           (3,'wearing',null,now(),'+989363236021'),
           (4,'clothe',3,now(),'+989363236021'),
           (5,'short',3,now(),'+989363236021'),
           (6,'trouser',3,now(),'+989363236021'),
           (7,'food',null,now(),'+989363236021');

INSERT INTO shops (shop_id, rate, address, city, shop_phone)
    VALUES (1,'4','Ghasem abad','Mashhad','05138242450'),
           (2,'5','Hashemieh','Mashhad','0215456432'),
           (3,'0','Sajjad blv','Mashhad','0503432343'),
           (4,'1','Rzieh','Mashhad','0503432343'),
           (5,'5','Karagaran Shomali','Teharn','0213432343'),
           (6,'0','Urumia','Tehran','0213432343'),
           (7,'2','Hojjati','Tehran','0213432343'),
           (8,'2','Namaz street','Tehran','0213432343'),
           (9,'5','Laleha','Tehran','0213432343'),
           (10,'3','Sima','Quchan','0503432343'),
           (11,'1','soijeooij','Quchan','0503432343'),
           (12,'2','ihiiohu','Sabzevar','0503432343'),
           (13,'0','oiuh','Sabzevar','0503432343'),
           (14,'3','oiuh','Khozestan','0503432343'),
           (15,'1','oyoy','Hamedan','0503432343'),
           (16,'5','Aoih','Birjand','0503432343'),
           (17,'3','Aoiuh','Bojnurd','0503432343'),
           (18,'4','oig8iiu','Kerman','0503432343'),
           (19,'3','98u 8u oj','Kordestan','0503432343'),
           (20,'5','A8uo 9u ','Torbat Jam','0503432343'),
           (21,'5','98u oi ioD','Torbat Heidarieh','0503432343'),
           (22,'3',' 98o iD','Ahvaz','0503432343'),
           (23,'4','A 98u 9 ','Sari','0503432343'),
           (24,'3',' 098uo y8hih','Semnan','0503432343'),
           (25,'3','VAKIL ABAD','Sarv','0452423114');

INSERT INTO factors (factor_id, wallet, mode, title, details, amount, date_time, shop)
    VALUES (1,1,'pay_in','phone','fast post','1','2022-10-20',1),
           (2,3,'pay_in','bag','Breakable','10','2020-8-6',2),
           (3,5,'pay_out','lap tap','electrical thing','3','2019-5-8',3),
           (4,5,'pay_out','tv','sensitive','25','2018-8-7',3),
           (5,4,'pay_out','car','new car','15','2015-5-31',4),
           (6,1,'pay_in','glasses','sensitive','142','2012-11-15',5),
           (7,1,'pay_in','game go','iue','82','2012-11-15',5),
           (8,1,'pay_in','banana','spiuhe','142','2012-11-25',6),
           (9,1,'pay_in','cd','soiuhiouhve','5','2012-11-05',7),
           (10,1,'pay_in','sart','seniouhiuohive','82','2012-11-05',8),
           (11,1,'pay_in','sal','soiuhoiuhive','9','2012-11-05',9),
           (12,3,'pay_in','shoes','blaoiuhiuoe','5','2018-10-06',10),
           (13,2,'pay_out','wallet','Loiuhiouhbag','21','2016-4-08',11),
           (14,1,'pay_in','ball','eoiuhiuhve','54','2013-10-15',12),
           (15,2,'pay_out','song','in time recive','87','2011-12-15',13);

INSERT INTO customers (customer_phone)
    VALUES ('+989368536021'),
           ('+986845536021'),
           ('+989984652021'),
           ('+989398785021'),
           ('+989986541021');


INSERT INTO jobs (job_id, employee, role, salary, rate)
    VALUES (1,'+989363236021','shopping',5000000,4),
           (2,'+989363716021','statistics',10000000,4),
           (3,'+989393936021','advertising',5000000,5),
           (4,'+986845886021','ios developer',20000000,4),
           (5,'+989363356021','android developer',3000000,5);

INSERT INTO shops_employees (shop, employee)
    VALUES (1,'+989363236021'),
           (12,'+989363716021'),
           (15,'+989363716021'),
           (14,'+989363716021'),
           (13,'+989363716021'),
           (13,'+989363716021'),
           (10,'+989393936021'),
           (20,'+986845886021'),
           (18,'+986845886021'),
           (17,'+986845886021'),
           (17,'+986845886021'),
           (17,'+986845886021'),
           (7,'+986845886021'),
           (8,'+986845886021'),
           (9,'+986845886021'),
           (9,'+986845886021'),
           (10,'+986845886021'),
           (11,'+986845886021'),
           (12,'+986845886021'),
           (13,'+989363356021');

INSERT INTO products (product_id,name,price,total_count,category,added_at,added_by,shop)
    VALUES (1,'TEST 1',100000,10,1,now(),'+989363236021',1),
           (2,'TEST 2',100000,10,1,now(),'+989363716021',1),
           (3,'TEST 3',200000,10,1,now(),'+989393936021',1),
           (4,'TEST 4',246000,10,1,now(),'+986845886021',2),
           (5,'TEST 5',197000,10,1,now(),'+989363356021',2),
           (6,'TEST 6',658400,10,1,now(),'+989363356021',2),
           (7,'TEST 7',6546000,10,1,now(),'+989363356021',3),
           (8,'TEST 8',69868400,10,1,now(),'+989363356021',3),
           (9,'TEST 9',9846500000,10,1,now(),'+989363356021',3),
           (10,'TEST 9',999999999999,10,1,now(),'+989363356021',3),
           (11,'TEST 9',6546541,10,1,now(),'+989363356021',3),
           (12,'TEST 9',97658454,10,1,now(),'+989363356021',3),
           (13,'TEST 9',987654,10,1,now(),'+989363356021',3),
           (14,'TEST 9',4654,10,1,now(),'+989393936021',3),
           (15,'TEST 9',6879456,10,1,now(),'+989393936021',3),
           (16,'TEST 9',987654,10,1,now(),'+989393936021',3),
           (17,'TEST 9',868,10,1,now(),'+989393936021',3),
           (18,'TEST 9',6,10,1,now(),'+986845886021',3),
           (19,'TEST 9',9876984,10,1,now(),'+986845886021',3),
           (20,'TEST 9',68497,10,1,now(),'+986845886021',3),
           (21,'TEST 9',6546,10,1,now(),'+986845886021',3),
           (22,'TEST 9',6849/8,10,1,now(),'+986845886021',3),
           (23,'TEST 9',65489,10,1,now(),'+986845886021',3),
           (24,'TEST 9',9986798,10,1,now(),'+986845886021',3),
           (25,'TEST 10',548,10,1,now(),'+986845886021',3);

INSERT INTO carts (cart_id,wallet,create_at)
    VALUES (1,1,now()),
           (2,2,now()),
           (3,2,now()),
           (4,3,now()),
           (5,5,now()),
           (6,4,now()),
           (7,4,now()),
           (8,3,now()),
           (9,2,now()),
           (10,1,now());

INSERT INTO products_carts (product,cart)
    VALUES (5,1),
           (7,2),
           (8,3),
           (9,4),
           (3,5);

 
INSERT INTO discounts (discount_id, amount, mode, from_max, from_min, consumed)            
    VALUES (1,05,'percently',10000,100000,false),
           (2,10,'percently',5000,50000,true),
           (3,25,'percently',4000,45000,false),
           (4,52,'percently',7500,65000,false),
           (5,35,'percently',6000,35000,false),
           (6,65,'percently',8500,85000,true),
           (7,85,'percently',9000,90000,false),
           (8,32,'percently',8000,800000,false),
           (9,54,'percently',15000,150000,false),
           (10,74,'percently',2000,250000,false);

INSERT INTO wallets_discounts (wallet, discount)
    VALUES (1,1),
           (2,2),
           (3,3),
           (4,4),
           (5,5);
           
-- sorteds above
