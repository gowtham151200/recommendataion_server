-- MCP Recommendation Server - Database Schema and Seed Data
-- PostgreSQL 14+

-- ============================================
-- DROP EXISTING TABLES (for clean setup)
-- ============================================
DROP TABLE IF EXISTS user_interactions CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ============================================
-- CREATE TABLES
-- ============================================

CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    preferences JSONB DEFAULT '{}'
);

CREATE TABLE products (
    product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100) NOT NULL,
    brand VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    tags TEXT[] DEFAULT '{}',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT true
);

CREATE TABLE user_interactions (
    interaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(product_id) ON DELETE CASCADE,
    interaction_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- CREATE INDEXES
-- ============================================
CREATE INDEX idx_interactions_user ON user_interactions(user_id);
CREATE INDEX idx_interactions_product ON user_interactions(product_id);
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_brand ON products(brand);
CREATE INDEX idx_users_email ON users(email);

-- ============================================
-- SEED DATA: USERS (100 users)
-- ============================================
INSERT INTO users (user_id, email, first_name, last_name, preferences) VALUES
('a0000001-0000-0000-0000-000000000001', 'john.doe@email.com', 'John', 'Doe', '{"favorite_categories": ["Electronics", "Books"]}'),
('a0000001-0000-0000-0000-000000000002', 'jane.smith@email.com', 'Jane', 'Smith', '{"favorite_categories": ["Fashion", "Home"]}'),
('a0000001-0000-0000-0000-000000000003', 'bob.wilson@email.com', 'Bob', 'Wilson', '{"favorite_categories": ["Electronics", "Sports"]}'),
('a0000001-0000-0000-0000-000000000004', 'alice.jones@email.com', 'Alice', 'Jones', '{"favorite_categories": ["Books", "Home"]}'),
('a0000001-0000-0000-0000-000000000005', 'charlie.brown@email.com', 'Charlie', 'Brown', '{"favorite_categories": ["Sports", "Electronics"]}'),
('a0000001-0000-0000-0000-000000000006', 'diana.ross@email.com', 'Diana', 'Ross', '{"favorite_categories": ["Fashion", "Beauty"]}'),
('a0000001-0000-0000-0000-000000000007', 'edward.kim@email.com', 'Edward', 'Kim', '{"favorite_categories": ["Electronics", "Gaming"]}'),
('a0000001-0000-0000-0000-000000000008', 'fiona.garcia@email.com', 'Fiona', 'Garcia', '{"favorite_categories": ["Home", "Kitchen"]}'),
('a0000001-0000-0000-0000-000000000009', 'george.taylor@email.com', 'George', 'Taylor', '{"favorite_categories": ["Books", "Electronics"]}'),
('a0000001-0000-0000-0000-000000000010', 'helen.white@email.com', 'Helen', 'White', '{"favorite_categories": ["Fashion", "Sports"]}'),
('a0000001-0000-0000-0000-000000000011', 'ivan.martinez@email.com', 'Ivan', 'Martinez', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000012', 'julia.anderson@email.com', 'Julia', 'Anderson', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000013', 'kevin.thomas@email.com', 'Kevin', 'Thomas', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000014', 'lisa.jackson@email.com', 'Lisa', 'Jackson', '{"favorite_categories": ["Home"]}'),
('a0000001-0000-0000-0000-000000000015', 'michael.lee@email.com', 'Michael', 'Lee', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000016', 'nancy.harris@email.com', 'Nancy', 'Harris', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000017', 'oliver.clark@email.com', 'Oliver', 'Clark', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000018', 'patricia.lewis@email.com', 'Patricia', 'Lewis', '{"favorite_categories": ["Kitchen"]}'),
('a0000001-0000-0000-0000-000000000019', 'quinn.walker@email.com', 'Quinn', 'Walker', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000020', 'rachel.hall@email.com', 'Rachel', 'Hall', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000021', 'steve.allen@email.com', 'Steve', 'Allen', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000022', 'tina.young@email.com', 'Tina', 'Young', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000023', 'ulysses.king@email.com', 'Ulysses', 'King', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000024', 'victoria.wright@email.com', 'Victoria', 'Wright', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000025', 'walter.scott@email.com', 'Walter', 'Scott', '{"favorite_categories": ["Home"]}'),
('a0000001-0000-0000-0000-000000000026', 'xena.green@email.com', 'Xena', 'Green', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000027', 'yusuf.adams@email.com', 'Yusuf', 'Adams', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000028', 'zoe.baker@email.com', 'Zoe', 'Baker', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000029', 'adam.nelson@email.com', 'Adam', 'Nelson', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000030', 'bella.carter@email.com', 'Bella', 'Carter', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000031', 'carl.mitchell@email.com', 'Carl', 'Mitchell', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000032', 'daisy.perez@email.com', 'Daisy', 'Perez', '{"favorite_categories": ["Home"]}'),
('a0000001-0000-0000-0000-000000000033', 'ethan.roberts@email.com', 'Ethan', 'Roberts', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000034', 'faith.turner@email.com', 'Faith', 'Turner', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000035', 'gary.phillips@email.com', 'Gary', 'Phillips', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000036', 'hazel.campbell@email.com', 'Hazel', 'Campbell', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000037', 'ian.parker@email.com', 'Ian', 'Parker', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000038', 'jade.evans@email.com', 'Jade', 'Evans', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000039', 'kyle.edwards@email.com', 'Kyle', 'Edwards', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000040', 'luna.collins@email.com', 'Luna', 'Collins', '{"favorite_categories": ["Kitchen"]}'),
('a0000001-0000-0000-0000-000000000041', 'mason.stewart@email.com', 'Mason', 'Stewart', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000042', 'nora.sanchez@email.com', 'Nora', 'Sanchez', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000043', 'oscar.morris@email.com', 'Oscar', 'Morris', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000044', 'penny.rogers@email.com', 'Penny', 'Rogers', '{"favorite_categories": ["Home"]}'),
('a0000001-0000-0000-0000-000000000045', 'quentin.reed@email.com', 'Quentin', 'Reed', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000046', 'ruby.cook@email.com', 'Ruby', 'Cook', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000047', 'sam.morgan@email.com', 'Sam', 'Morgan', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000048', 'tara.bell@email.com', 'Tara', 'Bell', '{"favorite_categories": ["Kitchen"]}'),
('a0000001-0000-0000-0000-000000000049', 'uma.murphy@email.com', 'Uma', 'Murphy', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000050', 'victor.bailey@email.com', 'Victor', 'Bailey', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000051', 'wendy.rivera@email.com', 'Wendy', 'Rivera', '{"favorite_categories": ["Home"]}'),
('a0000001-0000-0000-0000-000000000052', 'xavier.cooper@email.com', 'Xavier', 'Cooper', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000053', 'yasmine.richardson@email.com', 'Yasmine', 'Richardson', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000054', 'zach.cox@email.com', 'Zach', 'Cox', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000055', 'amy.howard@email.com', 'Amy', 'Howard', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000056', 'brian.ward@email.com', 'Brian', 'Ward', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000057', 'chloe.torres@email.com', 'Chloe', 'Torres', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000058', 'derek.peterson@email.com', 'Derek', 'Peterson', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000059', 'emma.gray@email.com', 'Emma', 'Gray', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000060', 'felix.ramirez@email.com', 'Felix', 'Ramirez', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000061', 'grace.james@email.com', 'Grace', 'James', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000062', 'henry.watson@email.com', 'Henry', 'Watson', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000063', 'iris.brooks@email.com', 'Iris', 'Brooks', '{"favorite_categories": ["Home"]}'),
('a0000001-0000-0000-0000-000000000064', 'jack.kelly@email.com', 'Jack', 'Kelly', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000065', 'kate.sanders@email.com', 'Kate', 'Sanders', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000066', 'leo.price@email.com', 'Leo', 'Price', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000067', 'mia.bennett@email.com', 'Mia', 'Bennett', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000068', 'noah.wood@email.com', 'Noah', 'Wood', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000069', 'olivia.barnes@email.com', 'Olivia', 'Barnes', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000070', 'peter.ross@email.com', 'Peter', 'Ross', '{"favorite_categories": ["Kitchen"]}'),
('a0000001-0000-0000-0000-000000000071', 'quinn.henderson@email.com', 'Quinn', 'Henderson', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000072', 'rose.coleman@email.com', 'Rose', 'Coleman', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000073', 'sean.jenkins@email.com', 'Sean', 'Jenkins', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000074', 'tessa.perry@email.com', 'Tessa', 'Perry', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000075', 'uriel.powell@email.com', 'Uriel', 'Powell', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000076', 'violet.long@email.com', 'Violet', 'Long', '{"favorite_categories": ["Kitchen"]}'),
('a0000001-0000-0000-0000-000000000077', 'william.patterson@email.com', 'William', 'Patterson', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000078', 'ximena.hughes@email.com', 'Ximena', 'Hughes', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000079', 'yale.flores@email.com', 'Yale', 'Flores', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000080', 'zara.washington@email.com', 'Zara', 'Washington', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000081', 'aaron.butler@email.com', 'Aaron', 'Butler', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000082', 'beatrice.simmons@email.com', 'Beatrice', 'Simmons', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000083', 'caleb.foster@email.com', 'Caleb', 'Foster', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000084', 'daphne.gonzales@email.com', 'Daphne', 'Gonzales', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000085', 'evan.bryant@email.com', 'Evan', 'Bryant', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000086', 'faye.alexander@email.com', 'Faye', 'Alexander', '{"favorite_categories": ["Home"]}'),
('a0000001-0000-0000-0000-000000000087', 'grant.russell@email.com', 'Grant', 'Russell', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000088', 'hope.griffin@email.com', 'Hope', 'Griffin', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000089', 'isaac.diaz@email.com', 'Isaac', 'Diaz', '{"favorite_categories": ["Kitchen"]}'),
('a0000001-0000-0000-0000-000000000090', 'jenna.hayes@email.com', 'Jenna', 'Hayes', '{"favorite_categories": ["Fashion"]}'),
('a0000001-0000-0000-0000-000000000091', 'kurt.myers@email.com', 'Kurt', 'Myers', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000092', 'lily.ford@email.com', 'Lily', 'Ford', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000093', 'max.hamilton@email.com', 'Max', 'Hamilton', '{"favorite_categories": ["Home"]}'),
('a0000001-0000-0000-0000-000000000094', 'nina.graham@email.com', 'Nina', 'Graham', '{"favorite_categories": ["Beauty"]}'),
('a0000001-0000-0000-0000-000000000095', 'otto.sullivan@email.com', 'Otto', 'Sullivan', '{"favorite_categories": ["Gaming"]}'),
('a0000001-0000-0000-0000-000000000096', 'paula.wallace@email.com', 'Paula', 'Wallace', '{"favorite_categories": ["Kitchen"]}'),
('a0000001-0000-0000-0000-000000000097', 'reid.woods@email.com', 'Reid', 'Woods', '{"favorite_categories": ["Sports"]}'),
('a0000001-0000-0000-0000-000000000098', 'sara.cole@email.com', 'Sara', 'Cole', '{"favorite_categories": ["Books"]}'),
('a0000001-0000-0000-0000-000000000099', 'troy.west@email.com', 'Troy', 'West', '{"favorite_categories": ["Electronics"]}'),
('a0000001-0000-0000-0000-000000000100', 'unity.jordan@email.com', 'Unity', 'Jordan', '{"favorite_categories": ["Beauty"]}');

-- ============================================
-- SEED DATA: PRODUCTS (50 products)
-- ============================================
INSERT INTO products (product_id, name, description, category, brand, price, tags) VALUES
-- Electronics
('b0000001-0000-0000-0000-000000000001', 'Wireless Bluetooth Headphones', 'High-quality wireless headphones with noise cancellation', 'Electronics', 'SoundMax', 79.99, ARRAY['wireless', 'bluetooth', 'audio']),
('b0000001-0000-0000-0000-000000000002', 'Smart Watch Pro', 'Advanced smartwatch with health monitoring', 'Electronics', 'TechTime', 299.99, ARRAY['smartwatch', 'fitness', 'health']),
('b0000001-0000-0000-0000-000000000003', 'Mechanical Gaming Keyboard', 'RGB backlit mechanical keyboard', 'Electronics', 'GamePro', 129.99, ARRAY['gaming', 'keyboard', 'rgb']),
('b0000001-0000-0000-0000-000000000004', 'Portable Bluetooth Speaker', 'Waterproof portable speaker', 'Electronics', 'SoundMax', 59.99, ARRAY['speaker', 'portable', 'bluetooth']),
('b0000001-0000-0000-0000-000000000005', 'Noise Cancelling Earbuds', 'True wireless earbuds with ANC', 'Electronics', 'SoundMax', 149.99, ARRAY['earbuds', 'wireless', 'anc']),
('b0000001-0000-0000-0000-000000000006', 'Wireless Mouse', 'Ergonomic wireless mouse', 'Electronics', 'GamePro', 39.99, ARRAY['mouse', 'wireless', 'ergonomic']),
('b0000001-0000-0000-0000-000000000007', 'USB-C Hub', 'Multi-port USB-C hub', 'Electronics', 'TechGear', 54.99, ARRAY['usb', 'hub', 'adapter']),
('b0000001-0000-0000-0000-000000000008', 'Laptop Stand', 'Adjustable aluminum laptop stand', 'Electronics', 'TechGear', 49.99, ARRAY['laptop', 'stand', 'ergonomic']),
('b0000001-0000-0000-0000-000000000009', 'Wireless Charging Pad', 'Fast wireless charger', 'Electronics', 'TechGear', 29.99, ARRAY['charger', 'wireless', 'fast']),
('b0000001-0000-0000-0000-000000000010', 'Gaming Mouse Pad XL', 'Extra-large gaming mouse pad', 'Electronics', 'GamePro', 24.99, ARRAY['mousepad', 'gaming', 'xl']),
-- Fashion
('b0000001-0000-0000-0000-000000000011', 'Cotton T-Shirt Pack', 'Premium cotton t-shirts (3 pack)', 'Fashion', 'BasicWear', 29.99, ARRAY['cotton', 'tshirt', 'basic']),
('b0000001-0000-0000-0000-000000000012', 'Slim Fit Jeans', 'Classic slim fit denim jeans', 'Fashion', 'DenimCo', 59.99, ARRAY['jeans', 'denim', 'slim']),
('b0000001-0000-0000-0000-000000000013', 'Leather Belt', 'Genuine leather belt', 'Fashion', 'LeatherCraft', 34.99, ARRAY['belt', 'leather', 'classic']),
('b0000001-0000-0000-0000-000000000014', 'Running Sneakers', 'Lightweight running shoes', 'Fashion', 'SpeedRun', 119.99, ARRAY['shoes', 'running', 'sneakers']),
('b0000001-0000-0000-0000-000000000015', 'Wool Sweater', 'Soft wool blend sweater', 'Fashion', 'CozyKnit', 79.99, ARRAY['sweater', 'wool', 'warm']),
-- Home
('b0000001-0000-0000-0000-000000000016', 'Ergonomic Office Chair', 'Adjustable office chair with lumbar support', 'Home', 'ComfortPlus', 249.99, ARRAY['chair', 'office', 'ergonomic']),
('b0000001-0000-0000-0000-000000000017', 'Standing Desk Converter', 'Height-adjustable desk converter', 'Home', 'ComfortPlus', 199.99, ARRAY['desk', 'standing', 'ergonomic']),
('b0000001-0000-0000-0000-000000000018', 'LED Desk Lamp', 'Adjustable LED desk lamp', 'Home', 'BrightLife', 44.99, ARRAY['lamp', 'led', 'desk']),
('b0000001-0000-0000-0000-000000000019', 'Fleece Throw Blanket', 'Ultra-soft fleece blanket', 'Home', 'CozyNest', 34.99, ARRAY['blanket', 'fleece', 'soft']),
('b0000001-0000-0000-0000-000000000020', 'Scented Candle Set', 'Aromatherapy candles (3 pack)', 'Home', 'AromaBliss', 24.99, ARRAY['candle', 'scented', 'relaxation']),
-- Kitchen
('b0000001-0000-0000-0000-000000000021', 'Stainless Steel Water Bottle', 'Insulated water bottle 750ml', 'Kitchen', 'HydroLife', 24.99, ARRAY['bottle', 'water', 'insulated']),
('b0000001-0000-0000-0000-000000000022', 'Ceramic Coffee Mug Set', 'Set of 4 ceramic mugs', 'Kitchen', 'HomeStyle', 34.99, ARRAY['mug', 'coffee', 'ceramic']),
('b0000001-0000-0000-0000-000000000023', 'Electric Kettle', 'Fast-boiling electric kettle 1.7L', 'Kitchen', 'HomeStyle', 39.99, ARRAY['kettle', 'electric', 'boil']),
('b0000001-0000-0000-0000-000000000024', 'Insulated Lunch Bag', 'Leak-proof lunch bag', 'Kitchen', 'HydroLife', 19.99, ARRAY['lunch', 'bag', 'insulated']),
('b0000001-0000-0000-0000-000000000025', 'Non-Stick Pan Set', 'Set of 3 non-stick pans', 'Kitchen', 'ChefPro', 69.99, ARRAY['pan', 'cooking', 'nonstick']),
-- Sports
('b0000001-0000-0000-0000-000000000026', 'Yoga Mat', 'Non-slip yoga mat 6mm', 'Sports', 'FlexFit', 34.99, ARRAY['yoga', 'mat', 'fitness']),
('b0000001-0000-0000-0000-000000000027', 'Resistance Bands Set', 'Set of 5 resistance bands', 'Sports', 'FlexFit', 19.99, ARRAY['resistance', 'bands', 'workout']),
('b0000001-0000-0000-0000-000000000028', 'Dumbbell Set', 'Adjustable dumbbell set 20kg', 'Sports', 'IronStrong', 89.99, ARRAY['dumbbell', 'weights', 'strength']),
('b0000001-0000-0000-0000-000000000029', 'Running Shoes Elite', 'Professional running shoes', 'Sports', 'SpeedRun', 119.99, ARRAY['running', 'shoes', 'professional']),
('b0000001-0000-0000-0000-000000000030', 'Travel Backpack', 'Water-resistant 40L backpack', 'Sports', 'TrekMaster', 79.99, ARRAY['backpack', 'travel', 'hiking']),
-- Books
('b0000001-0000-0000-0000-000000000031', 'The Art of Programming', 'Software development guide', 'Books', 'TechPress', 49.99, ARRAY['programming', 'software', 'tech']),
('b0000001-0000-0000-0000-000000000032', 'Data Science Fundamentals', 'Introduction to data science', 'Books', 'TechPress', 39.99, ARRAY['data', 'science', 'beginner']),
('b0000001-0000-0000-0000-000000000033', 'Mindful Leadership', 'Leadership through mindfulness', 'Books', 'MindBooks', 24.99, ARRAY['leadership', 'mindfulness', 'business']),
('b0000001-0000-0000-0000-000000000034', 'Financial Freedom Guide', 'Personal finance strategies', 'Books', 'WealthWise', 29.99, ARRAY['finance', 'investing', 'money']),
('b0000001-0000-0000-0000-000000000035', 'Creative Writing Workshop', 'Techniques for writers', 'Books', 'WriterPress', 19.99, ARRAY['writing', 'creative', 'fiction']),
-- Beauty
('b0000001-0000-0000-0000-000000000036', 'Vitamin C Serum', 'Brightening vitamin C serum', 'Beauty', 'GlowUp', 34.99, ARRAY['serum', 'skincare', 'vitamin']),
('b0000001-0000-0000-0000-000000000037', 'Face Moisturizer', 'Hydrating moisturizer with SPF', 'Beauty', 'GlowUp', 29.99, ARRAY['moisturizer', 'skincare', 'spf']),
('b0000001-0000-0000-0000-000000000038', 'Hair Repair Mask', 'Deep conditioning hair mask', 'Beauty', 'SilkStrands', 24.99, ARRAY['hair', 'mask', 'conditioning']),
('b0000001-0000-0000-0000-000000000039', 'Perfume Eau de Toilette', 'Fresh elegant fragrance', 'Beauty', 'ScentLux', 59.99, ARRAY['perfume', 'fragrance', 'fresh']),
('b0000001-0000-0000-0000-000000000040', 'Makeup Brush Set', '12-piece brush set', 'Beauty', 'BeautyPro', 39.99, ARRAY['makeup', 'brushes', 'set']),
-- Gaming
('b0000001-0000-0000-0000-000000000041', 'Gaming Headset', 'Surround sound gaming headset', 'Gaming', 'GamePro', 89.99, ARRAY['headset', 'gaming', 'audio']),
('b0000001-0000-0000-0000-000000000042', 'Wireless Controller', 'Premium wireless controller', 'Gaming', 'GamePro', 69.99, ARRAY['controller', 'wireless', 'gaming']),
('b0000001-0000-0000-0000-000000000043', 'Gaming Chair', 'Ergonomic gaming chair', 'Gaming', 'GamePro', 299.99, ARRAY['chair', 'gaming', 'ergonomic']),
('b0000001-0000-0000-0000-000000000044', 'Capture Card', '4K capture card for streaming', 'Gaming', 'StreamPro', 149.99, ARRAY['capture', 'streaming', '4k']),
('b0000001-0000-0000-0000-000000000045', 'Monitor Stand', 'Gaming monitor stand with USB hub', 'Gaming', 'GamePro', 59.99, ARRAY['monitor', 'stand', 'usb']),
-- Food & Supplements
('b0000001-0000-0000-0000-000000000046', 'Organic Coffee Beans', 'Premium single-origin coffee 1kg', 'Food', 'BeanMaster', 19.99, ARRAY['coffee', 'organic', 'beans']),
('b0000001-0000-0000-0000-000000000047', 'Protein Powder', 'Whey protein vanilla 2lb', 'Food', 'FitFuel', 44.99, ARRAY['protein', 'fitness', 'supplement']),
('b0000001-0000-0000-0000-000000000048', 'Vitamin D3', 'High-potency vitamin D3', 'Food', 'FitFuel', 14.99, ARRAY['vitamin', 'supplement', 'health']),
('b0000001-0000-0000-0000-000000000049', 'Green Tea Collection', 'Assorted green tea bags', 'Food', 'TeaTime', 12.99, ARRAY['tea', 'green', 'organic']),
('b0000001-0000-0000-0000-000000000050', 'Trail Mix Variety Pack', 'Healthy snack mix (6 pack)', 'Food', 'NutriSnack', 16.99, ARRAY['snack', 'healthy', 'nuts']);

-- ============================================
-- SEED DATA: USER INTERACTIONS (1000+ interactions)
-- ============================================
DO $$
DECLARE
    user_ids UUID[] := ARRAY(SELECT user_id FROM users);
    product_ids UUID[] := ARRAY(SELECT product_id FROM products);
    interaction_types TEXT[] := ARRAY['view', 'purchase', 'wishlist'];
    i INT;
    rand_user UUID;
    rand_product UUID;
    rand_type TEXT;
    rand_date TIMESTAMP;
BEGIN
    FOR i IN 1..1500 LOOP
        rand_user := user_ids[1 + floor(random() * array_length(user_ids, 1))::int];
        rand_product := product_ids[1 + floor(random() * array_length(product_ids, 1))::int];

        -- Weight interaction types (more views than purchases)
        IF random() < 0.6 THEN
            rand_type := 'view';
        ELSIF random() < 0.85 THEN
            rand_type := 'wishlist';
        ELSE
            rand_type := 'purchase';
        END IF;

        rand_date := NOW() - (random() * INTERVAL '180 days');

        INSERT INTO user_interactions (user_id, product_id, interaction_type, created_at)
        VALUES (rand_user, rand_product, rand_type, rand_date);
    END LOOP;
END $$;

-- ============================================
-- VERIFICATION
-- ============================================
-- Run these to verify:
-- SELECT 'users' as table_name, COUNT(*) FROM users
-- UNION ALL SELECT 'products', COUNT(*) FROM products
-- UNION ALL SELECT 'user_interactions', COUNT(*) FROM user_interactions;
-- Expected: users=100, products=50, interactions=1500
