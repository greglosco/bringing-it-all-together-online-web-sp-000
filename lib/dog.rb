class Dog 
  
  attr_accessor :name, :breed, :id
  
  def initialize name:, breed:, id:
    @id = id
    @name = name
    @breed = breed 
  end
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS dogs (
      
      )
      SQL
  end
  
end