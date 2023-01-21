CREATE TABLE users (
    phone_number VARCHAR(20) PRIMARY KEY, 
    name VARCHAR(255) NOT NULL, 
    profile_picture BLOB, 
    status VARCHAR(255),
    last_seen TIMESTAMP 
);

CREATE TABLE groups (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    picture BLOB,
    FOREIGN KEY (created_by) REFERENCES users(phone_number)
);

CREATE TABLE group_members (
    group_id INT NOT NULL, 
    user_phone_number VARCHAR(20) NOT NULL, 
    role ENUM("admin","member") NOT NULL, 
    PRIMARY KEY (group_id, user_phone_number),
    FOREIGN KEY (group_id) REFERENCES groups(id),
    FOREIGN KEY (user_phone_number) REFERENCES users(phone_number)
);

CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    group_id INT,
    sender_phone_number VARCHAR(20) NOT NULL, 
    receiver_phone_number VARCHAR(20), 
    message TEXT NOT NULL,
    type ENUM("text","image","audio","video","document"),
    media BLOB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES groups(id),
    FOREIGN KEY (sender_phone_number) REFERENCES users(phone_number),
    FOREIGN KEY (receiver_phone_number) REFERENCES users(phone_number)
);

CREATE TABLE group_message_status (
    message_id INT NOT NULL, 
    group_id INT NOT NULL, 
    user_phone_number VARCHAR(20) NOT NULL, 
    status ENUM("delivered","read"), 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY (message_id, group_id, user_phone_number),
    FOREIGN KEY (message_id) REFERENCES messages(id),
    FOREIGN KEY (group_id) REFERENCES groups(id),
    FOREIGN KEY (user_phone_number) REFERENCES users(phone_number)
);

CREATE TABLE individual_message_status (
message_id INT NOT NULL,
sender_phone_number VARCHAR(20) NOT NULL,
receiver_phone_number VARCHAR(20) NOT NULL,
status ENUM("delivered","read"),
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (message_id, sender_phone_number, receiver_phone_number),
FOREIGN KEY (message_id) REFERENCES messages(id),
FOREIGN KEY (sender_phone_number) REFERENCES users(phone_number),
FOREIGN KEY (receiver_phone_number) REFERENCES users(phone_number)
);