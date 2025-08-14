-- 1. Companies
CREATE TABLE companies (
    company_id       SERIAL PRIMARY KEY,
    name             VARCHAR(100) NOT NULL,
    owner            VARCHAR(100),
    email            VARCHAR(150),
    phone            VARCHAR(20),
    address          TEXT,
);

-- 2. Warehouses
CREATE TABLE warehouses (
    warehouse_id     SERIAL PRIMARY KEY,
    company_id       INT NOT NULL REFERENCES companies(company_id),
    name             VARCHAR(100) NOT NULL,
    location         TEXT
);

-- 3. Products
CREATE TABLE products (
    product_id       SERIAL PRIMARY KEY,
    company_id       INT NOT NULL REFERENCES companies(company_id),
    name             VARCHAR(150) NOT NULL,
    sku              VARCHAR(50) UNIQUE NOT NULL,
    price            DECIMAL(10, 2) NOT NULL,
    is_bundle        BOOLEAN DEFAULT FALSE,
    low_stock_threshold INT DEFAULT 10, 
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Product Bundles (links bundle products to their components)
CREATE TABLE product_bundles (
    bundle_id        INT NOT NULL REFERENCES products(product_id),
    component_id     INT NOT NULL REFERENCES products(product_id),
    quantity         INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (bundle_id, component_id)
);

-- 5. Suppliers
CREATE TABLE suppliers (
    supplier_id      SERIAL PRIMARY KEY,
    name             VARCHAR(150) NOT NULL,
    contact_email    VARCHAR(150),
    phone            VARCHAR(20),
    address          TEXT
);

-- 6. Product Suppliers (many-to-many between products and suppliers)
CREATE TABLE product_suppliers (
    product_id       INT NOT NULL REFERENCES products(product_id),
    supplier_id      INT NOT NULL REFERENCES suppliers(supplier_id),
    PRIMARY KEY (product_id, supplier_id)
);

-- 7. Inventory (current stock per warehouse per product)
CREATE TABLE inventory (
    inventory_id     SERIAL PRIMARY KEY,
    product_id       INT NOT NULL REFERENCES products(product_id),
    warehouse_id     INT NOT NULL REFERENCES warehouses(warehouse_id),
    quantity         INT NOT NULL DEFAULT 0,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (product_id, warehouse_id)
);

-- 8. Inventory History (tracks every change in inventory)
CREATE TABLE inventory_history (
    history_id       SERIAL PRIMARY KEY,
    product_id       INT NOT NULL REFERENCES products(product_id),
    warehouse_id     INT NOT NULL REFERENCES warehouses(warehouse_id),
    change_quantity  INT NOT NULL,
    reason           VARCHAR(200),
    changed_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
