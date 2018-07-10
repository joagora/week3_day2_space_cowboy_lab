require('pry-byebug')
require('pg')
class Bounty

  def initialize attributes
    @id = attributes['id'].to_i if attributes['id']
    @name = attributes['name']
    @bounty_value = attributes['bounty_value']
    @danger_level = attributes['danger_level']
    @favourite_weapon = attributes['favourite_weapon']
  end


end
