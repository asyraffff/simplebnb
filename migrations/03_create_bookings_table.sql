CREATE TABLE bookings(
  booking_id SERIAL PRIMARY KEY,
  check_in DATE NOT NULL,
  check_out DATE NOT NULL CHECK (check_out > check_in),
  space_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  CONSTRAINT fk_space
    FOREIGN KEY(space_id)
      REFERENCES spaces(space_id)
      ON DELETE CASCADE,

  CONSTRAINT fk_user
    FOREIGN KEY(user_id)
      REFERENCES users(user_id)
      ON DELETE CASCADE
      );