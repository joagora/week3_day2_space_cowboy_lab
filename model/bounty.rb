require('pry-byebug')
require('pg')
class Bounty

  def initialize attributes
    @id = attributes['id'].to_i if attributes['id']
    @name = attributes['name']
    @bounty_value = attributes['bounty_value'].to_i
    @danger_level = attributes['danger_level']
    @favourite_weapon = attributes['favourite_weapon']
  end

  def save
    #connect
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    #write with actual details
    sql = "INSERT INTO bounty (name, bounty_value, danger_level, favourite_weapon) VALUES ($1, $2, $3, $4) RETURNING *;"
    values = [@name, @bounty_value, @danger_level, @favourite_weapon]
    #prepare statements
    db.prepare("save", sql)
    #execute sql
    result = db.exec_prepared("save", values)
    @id = result.first['id'].to_i
    #close connect
    db.close
  end

end
