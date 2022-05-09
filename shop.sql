-- Last modification date: 2022-05-08 10:19:33.892

-- tables
-- Table: carts
CREATE TABLE carts (
    cart_id int NOT NULL,
    wallet int NOT NULL,
    create_at datetime NOT NULL DEFAULT now(),
    CONSTRAINT `carts_pk` PRIMARY KEY (cart_id)
);

-- Table: categories
CREATE TABLE categories (
    category_id int NOT NULL,
    name varchar(255) NOT NULL,
    parent int NULL DEFAULT 0,
    created_at datetime NOT NULL DEFAULT now(),
    created_by int NOT NULL,
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
    join_at datetime NOT NULL DEFAULT now(),
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
    date_time datetime NOT NULL DEFAULT now(),
    shop int NOT NULL,
    CONSTRAINT `factors_pk` PRIMARY KEY (factor_id)
);

-- Table: jobs
CREATE TABLE jobs (
    job_id int NOT NULL,
    employee_phone varchar(50) NULL,
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
    email text NULL,
    birth_date date NULL,
    wallet int NULL,
    join_at datetime NULL DEFAULT now(),
    CONSTRAINT `persons_pk` PRIMARY KEY (phone)
);

-- Table: persons_wallets
CREATE TABLE persons_wallets (
    person_phone varchar(50) NOT NULL,
    wallet_id int NOT NULL,
    balance int NOT NULL,
    CONSTRAINT persons_wallets_pk PRIMARY KEY (person_phone,wallet_id)
);

-- Table: products
CREATE TABLE products (
    product_id int NOT NULL,
    name text NOT NULL,
    total_count int NOT NULL DEFAULT 0,
    category int NOT NULL,
    added_at datetime NOT NULL DEFAULT now(),
    added_by int NOT NULL,
    shop int NOT NULL,
    CONSTRAINT `products_pk` PRIMARY KEY (product_id)
);

-- Table: products_carts
CREATE TABLE products_carts (
    product_id int NOT NULL,
    cart_id int NOT NULL,
    CONSTRAINT products_carts_pk PRIMARY KEY (product_id,cart_id)
);

-- Table: shops
CREATE TABLE shops (
    shop_id int NOT NULL,
    rate enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
    address text NOT NULL,
    shop_phone varchar(50) NOT NULL,
    CONSTRAINT `shops_pk` PRIMARY KEY (shop_id)
);

-- Table: shops_employees
CREATE TABLE shops_employees (
    shop_id int NOT NULL,
    employee_id int NOT NULL,
    CONSTRAINT shops_employees_pk PRIMARY KEY (shop_id,employee_id)
);

-- Table: wallets
CREATE TABLE wallets (
    wallet_id int NOT NULL,
    balance int NOT NULL DEFAULT 0,
    CONSTRAINT `wallets_pk` PRIMARY KEY (wallet_id)
);

-- Table: wallets_discounts
CREATE TABLE wallets_discounts (
    wallet_id int NOT NULL,
    discount_id int NOT NULL,
    CONSTRAINT wallets_discounts_pk PRIMARY KEY (wallet_id,discount_id)
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
ALTER TABLE factors ADD CONSTRAINT factors_shops FOREIGN KEY factors_shops (<EMPTY>,shop)
    REFERENCES shops (shop_id,shop_id);

-- Reference: factors_wallets (table: factors)
ALTER TABLE factors ADD CONSTRAINT factors_wallets FOREIGN KEY factors_wallets (wallet)
    REFERENCES wallets (wallet_id);

-- Reference: jobs_employees (table: jobs)
ALTER TABLE jobs ADD CONSTRAINT jobs_employees FOREIGN KEY jobs_employees (rate)
    REFERENCES employees (join_at);

-- Reference: persons_employees (table: employees)
ALTER TABLE employees ADD CONSTRAINT persons_employees FOREIGN KEY persons_employees (employee_phone)
    REFERENCES persons (phone);

-- Reference: persons_wallets_persons (table: persons_wallets)
ALTER TABLE persons_wallets ADD CONSTRAINT persons_wallets_persons FOREIGN KEY persons_wallets_persons (person_phone)
    REFERENCES persons (phone);

-- Reference: persons_wallets_wallets (table: persons_wallets)
ALTER TABLE persons_wallets ADD CONSTRAINT persons_wallets_wallets FOREIGN KEY persons_wallets_wallets (wallet_id)
    REFERENCES wallets (wallet_id);

-- Reference: products_carts_carts (table: products_carts)
ALTER TABLE products_carts ADD CONSTRAINT products_carts_carts FOREIGN KEY products_carts_carts (cart_id)
    REFERENCES carts (cart_id);

-- Reference: products_carts_products (table: products_carts)
ALTER TABLE products_carts ADD CONSTRAINT products_carts_products FOREIGN KEY products_carts_products (product_id)
    REFERENCES products (product_id);

-- Reference: products_categories (table: products)
ALTER TABLE products ADD CONSTRAINT products_categories FOREIGN KEY products_categories (category)
    REFERENCES categories (category_id);

-- Reference: products_shops (table: products)
ALTER TABLE products ADD CONSTRAINT products_shops FOREIGN KEY products_shops (shop)
    REFERENCES shops (shop_phone);

-- Reference: shops_employees_employees (table: shops_employees)
ALTER TABLE shops_employees ADD CONSTRAINT shops_employees_employees FOREIGN KEY shops_employees_employees (<EMPTY>,employee_id)
    REFERENCES employees (employee_phone,employee_phone);

-- Reference: shops_employees_shops (table: shops_employees)
ALTER TABLE shops_employees ADD CONSTRAINT shops_employees_shops FOREIGN KEY shops_employees_shops (shop_id)
    REFERENCES shops (shop_id);

-- Reference: wallets_discounts_discounts (table: wallets_discounts)
ALTER TABLE wallets_discounts ADD CONSTRAINT wallets_discounts_discounts FOREIGN KEY wallets_discounts_discounts (discount_id)
    REFERENCES discounts (discount_id);

-- Reference: wallets_discounts_wallets (table: wallets_discounts)
ALTER TABLE wallets_discounts ADD CONSTRAINT wallets_discounts_wallets FOREIGN KEY wallets_discounts_wallets (wallet_id)
    REFERENCES wallets (wallet_id);

-- End of file.

INSERT INTO TABLE shops (shop_id,rate,address,shop_phone)
    VALUES ('1','4','قاسم اباد _ادیب','d36'),
           ('2','5','AHMAD ABAD','03313'),
           ('3','3','VAKIL ABAD','5454');
