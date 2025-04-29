CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    api_key TEXT UNIQUE NOT NULL
);

-- ตารางเว็บไซต์ที่ Affiliator ลงทะเบียน
CREATE TABLE affiliator_websites (
    id SERIAL PRIMARY KEY,
    affiliator_id INT NOT NULL REFERENCES clients(id),
    website_url TEXT NOT NULL
);

-- ตารางโรงแรม
CREATE TABLE hotels (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    price_per_night INT NOT NULL,
    thumbnail_url TEXT,
    detail_url TEXT
);

-- ตาราง Log การ Request
CREATE TABLE request_logs (
    id SERIAL PRIMARY KEY,
    affiliator_id INT NOT NULL REFERENCES clients(id),
    endpoint TEXT NOT NULL,
    method TEXT NOT NULL,
    parameters TEXT,
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ตาราง Log การ Click
CREATE TABLE click_logs (
    id SERIAL PRIMARY KEY,
    affiliator_id INT NOT NULL REFERENCES clients(id),
    item_clicked TEXT NOT NULL,
    referrer_url TEXT NOT NULL,
    clicked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ตาราง data เอาไว้ดู cloudfare
CREATE TABLE data (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL
);

INSERT INTO data (content) VALUES ('Sample data 1');
INSERT INTO data (content) VALUES ('Sample data 2');

INSERT INTO hotels (name, location, price_per_night, thumbnail_url, detail_url) VALUES
('Centurion Hotel Ueno', 'Ueno, Tokyo', 4500, 'https://example.com/thumbnails/centurion.jpg', 'https://example.com/details/centurion-ueno'),
('APA Hotel Keisei Ueno-Ekimae', 'Ueno, Tokyo', 3800, 'https://example.com/thumbnails/apa-ueno.jpg', 'https://example.com/details/apa-ueno-ekimae'),
('Hotel Sardonyx Ueno', 'Ueno, Tokyo', 5200, 'https://example.com/thumbnails/sardonyx.jpg', 'https://example.com/details/sardonyx-ueno'),
('Mitsui Garden Hotel Ueno', 'Ueno, Tokyo', 6000, 'https://example.com/thumbnails/mitsui.jpg', 'https://example.com/details/mitsui-ueno'),
('Dormy Inn Akihabara', 'Akihabara, Tokyo', 4900, 'https://example.com/thumbnails/dormy.jpg', 'https://example.com/details/dormy-akihabara'),
('The B Akasaka', 'Akasaka, Tokyo', 5500, 'https://example.com/thumbnails/theb-akasaka.jpg', 'https://example.com/details/theb-akasaka'),
('Shinjuku Granbell Hotel', 'Shinjuku, Tokyo', 7100, 'https://example.com/thumbnails/granbell.jpg', 'https://example.com/details/granbell-shinjuku'),
('APA Hotel Shinjuku Kabukicho Tower', 'Shinjuku, Tokyo', 6800, 'https://example.com/thumbnails/apa-shinjuku.jpg', 'https://example.com/details/apa-shinjuku'),
('Hotel Sunroute Plaza Shinjuku', 'Shinjuku, Tokyo', 7500, 'https://example.com/thumbnails/sunroute.jpg', 'https://example.com/details/sunroute-plaza'),
('Tokyo Dome Hotel', 'Bunkyo, Tokyo', 8000, 'https://example.com/thumbnails/tokyodome.jpg', 'https://example.com/details/tokyo-dome-hotel');