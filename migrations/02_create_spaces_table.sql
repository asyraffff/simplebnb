CREATE TABLE spaces(
  space_id SERIAL PRIMARY KEY,
  name VARCHAR(140) NOT NULL,
  description VARCHAR(500) NOT NULL,
  price INTEGER NOT NULL,
  
  user_id INTEGER NOT NULL,
  CONSTRAINT fk_user
    FOREIGN KEY(user_id)
      REFERENCES users(user_id)
      ON DELETE CASCADE
      );