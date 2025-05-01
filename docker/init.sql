CREATE TABLE IF NOT EXISTS hotels (
    hotel_id SERIAL PRIMARY KEY,
    hotel_name VARCHAR(255) NOT NULL,
    hotel_type VARCHAR(100) NOT NULL,
    hotel_location TEXT NOT NULL
);

-- ตารางข้อเสนอห้องพัก
CREATE TABLE IF NOT EXISTS hotel_offers (
    offer_id SERIAL PRIMARY KEY,
    offer_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    room_type VARCHAR(100) NOT NULL,
    stay_duration INT NOT NULL,
    available_date DATE NOT NULL,
    room_price DECIMAL(10, 2) NOT NULL,
    offer_level VARCHAR(50) NOT NULL,
    hotel_url TEXT NOT NULL,
    hotel_id INT NOT NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

-- ตาราง Affiliators (ลดเหลือแค่ name + api_key)
CREATE TABLE IF NOT EXISTS affiliators (
    affiliator_id SERIAL PRIMARY KEY,
    affiliator_name VARCHAR(255) NOT NULL,
    api_key TEXT UNIQUE NOT NULL
);

-- ตารางเว็บไซต์ที่ลงทะเบียนโดย affiliator
CREATE TABLE IF NOT EXISTS referrer_websites (
    referrer_id SERIAL PRIMARY KEY,
    affiliator_id INT NOT NULL,
    website_url TEXT,
    FOREIGN KEY (affiliator_id) REFERENCES affiliators(affiliator_id)
);

-- ตารางการคลิก (click log)
CREATE TABLE IF NOT EXISTS click_logs (
    click_id SERIAL PRIMARY KEY,
    offer_id INT NOT NULL,
    hotel_id INT NOT NULL,
    clicked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    referrer_url TEXT,
    FOREIGN KEY (offer_id) REFERENCES hotel_offers(offer_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

-- ตาราง request log จาก affiliator
CREATE TABLE IF NOT EXISTS request_logs (
    request_id SERIAL PRIMARY KEY,
    affiliator_id INT NOT NULL,
    request_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    endpoint TEXT NOT NULL,
    method TEXT NOT NULL,
    path_parameters TEXT,
    query_parameters TEXT,
    FOREIGN KEY (affiliator_id) REFERENCES affiliators(affiliator_id)
);

-- ตัวอย่างข้อมูลโรงแรม
INSERT INTO hotels (hotel_name, hotel_type, hotel_location) VALUES 
('The Berkeley Hotel Pratunam', 'โรงแรมหรู', '559 Ratchaprarop Rd, Makkasan, Bangkok'),
('Asia Hotel Bangkok', 'โรงแรมใจกลางเมือง', '296 Phayathai Road, Bangkok'),
('Baiyoke Sky Hotel', 'โรงแรมสูงที่สุดในไทย', '222 Ratchaprarop Rd, Bangkok');

-- ตัวอย่างข้อมูลข้อเสนอห้องพัก
INSERT INTO hotel_offers (offer_name, description, room_type, stay_duration, available_date, room_price, offer_level, hotel_url, hotel_id) VALUES 
('Superior Room - Berkeley', 
 'ห้องพักขนาดใหญ่พร้อมสิ่งอำนวยความสะดวกครบครัน ตั้งอยู่ใจกลางประตูน้ำ ใกล้แหล่งช้อปปิ้ง', 
 'Superior', 2, '2025-05-05', 2400.00, 'ปานกลาง', 
 'https://www.agoda.com/the-berkeley-hotel-pratunam/hotel/bangkok-th.html', 
 (SELECT hotel_id FROM hotels WHERE hotel_name = 'The Berkeley Hotel Pratunam' LIMIT 1)),

('Deluxe Room - Asia Hotel', 
 'ห้องพักในทำเลเยี่ยม ติดรถไฟฟ้าราชเทวี เหมาะสำหรับนักท่องเที่ยวและนักธุรกิจ', 
 'Deluxe', 2, '2025-05-07', 1900.00, 'ง่าย', 
 'https://www.agoda.com/asia-hotel-bangkok/hotel/bangkok-th.html', 
 (SELECT hotel_id FROM hotels WHERE hotel_name = 'Asia Hotel Bangkok' LIMIT 1)),

('Sky Zone Suite - Baiyoke Sky', 
 'ห้องพักบนชั้นสูงของโรงแรม ชมวิวเมืองแบบพาโนรามา พร้อมบุฟเฟต์อาหารเช้าชั้นยอด', 
 'Suite', 1, '2025-05-10', 3000.00, 'สูง', 
 'https://www.agoda.com/baiyoke-sky-hotel/hotel/bangkok-th.html', 
 (SELECT hotel_id FROM hotels WHERE hotel_name = 'Baiyoke Sky Hotel' LIMIT 1));