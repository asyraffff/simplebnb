require_relative 'db_connection'

class Booking
  attr_reader :id,:check_in, :check_out, :space_id, :user_id

  def initialize(id, check_in, check_out, space_id, user_id)
    @id = id
    @check_in = check_in
    @check_out = check_out
    @space_id = space_id
    @user_id = user_id
  end

  def self.current
    @booking
  end

  def self.all
    result = DBConnection.query("SELECT * FROM bookings")
    result.map do |booking| 
      Booking.new(booking['booking_id'], booking['check_in'],
        booking['check_out'], booking['space_id'], booking['user_id'])
    end
  end

  def self.create(check_in, check_out, space_id, user_id)
    result = DBConnection.query("INSERT INTO bookings (check_in, check_out, space_id, user_id) 
    VALUES('#{check_in}', '#{check_out}', '#{space_id}', '#{user_id}') RETURNING booking_id, check_in, check_out, space_id, user_id;")
    
    @booking = Booking.new(result[0]['booking_id'],
      result[0]['check_in'], result[0]['check_out'],
      result[0]['space_id'], result[0]['user_id'])
  end

  def self.by_user(user_id)
    result = DBConnection.query("SELECT * FROM bookings WHERE user_id = #{user_id};")
    result.map do |booking| 
      Booking.new(booking['booking_id'], booking['check_in'],
        booking['check_out'], booking['space_id'], booking['user_id'])
    end
  end
end