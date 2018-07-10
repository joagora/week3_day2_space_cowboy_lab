require('pry-byebug')
require('pg')
class Bounty
  attr_writer :bounty_value
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

  def Bounty.all
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "SELECT * FROM bounty;"
    db.prepare('all', sql)
    bounty = db.exec_prepared('all')
    db.close
    bounty_results = bounty.map {|db_result| Bounty.new(db_result)}
    return bounty_results
  end

  def delete
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "DELETE FROM bounty WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def update
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "UPDATE bounty SET (name, bounty_value, danger_level, favourite_weapon) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@name, @bounty_value, @danger_level, @favourite_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Bounty.find_by_name (name)
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "SELECT * FROM bounty WHERE name = $1;"
    values = [name]
    db.prepare("find", sql)
    bounties = db.exec_prepared("find", values)
    db.close
    return Bounty.new(bounties.first)
  end

  def Bounty.find_by_id (id)
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "SELECT * FROM bounty WHERE id = $1;"
    values = [id]
    db.prepare("find_by_id", sql)
    bounties = db.exec_prepared("find_by_id", values)
    db.close
    return Bounty.new(bounties.first)
  end
end
