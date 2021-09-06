require './lib/db_connection'

if ENV['RACK_ENV'] == 'test' 
  DBConnection.setup('makersbnb_test')
else
  DBConnection.setup('makersbnb')
end