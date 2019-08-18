class Dog 
  
  attr_accessor :name, :breed, :id
  
  def initialize(name:, breed:, id: nil)
    @id = id
    @name = name
    @breed = breed 
  end
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS dogs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end
  
  def save 
    if self.id
    self.update
   else
    sql = "INSERT INTO dogs (name, breed) VALUES (?, ?)"
    
    DB[:conn].execute(sql, self.name, self.breed)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
  end
  
  def update 
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = "
  end
  
  end
  
  def self.drop_table
    sql = "DROP TABLE dogs"
    
    DB[:conn].execute (sql)
  end
  
  def self.new_from_db(row)
    new_dog = Dog.new(name: @name, breed: @breed)
    new_dog.id = row[0]
    new_dog.name = row[1]
    new_dog.breed = row[2]
    new_dog
  end
  
  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE name = ?
      LIMIT 1 
    SQL
    
    DB[:conn].execute(sql, name).map {|row| self.new_from_db(row)}.first
  end
  
end