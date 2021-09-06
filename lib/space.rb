require_relative 'db_connection'

class Space
  attr_reader :id, :name, :description, :price, :user_id

  def initialize(id, name, description, price, user_id)
    @id  = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
  end

  def self.current
    @space
  end

  def self.all
    result = DBConnection.query("SELECT * FROM spaces")
    result.map do |space| 
      Space.new(space['space_id'], space['name'], space['description'], space['price'], space['user_id'])
    end
  end

  def self.create(name, description, price, user_id)
    name = sanitise_string(name)
    description = sanitise_string(description)
    result = DBConnection.query("INSERT INTO spaces (name, description, price, user_id) 
    VALUES('#{name}', '#{description}', '#{price}', '#{user_id}') RETURNING space_id, name, description, price, user_id;")
    @space = Space.new(result[0]['space_id'], result[0]['name'], result[0]['description'], result[0]['price'], result[0]['user_id'])
  end

  def self.with_id(id)
    result = DBConnection.query("SELECT * FROM spaces WHERE space_id = #{id};")
    @space = Space.new(result[0]['space_id'], result[0]['name'], result[0]['description'], result[0]['price'], result[0]['user_id'])
  end

  def self.of_user(user_id)
    result = DBConnection.query("SELECT * FROM spaces WHERE user_id = #{user_id};")
    result.map do |space| 
      Space.new(space['space_id'], space['name'], space['description'], space['price'], space['user_id'])
    end
  end
  
  def self.sanitise_string(string)
    string.gsub("'", "''")
  end
end