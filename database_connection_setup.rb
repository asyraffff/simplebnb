require './lib/db_connection'

if ENV['RACK_ENV'] == 'test' 
  DBConnection.setup('simplebnb_test')
else
  DBConnection.setup('simplebnb')
end