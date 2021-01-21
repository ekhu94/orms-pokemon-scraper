class Pokemon
    attr_accessor :name, :type
    attr_reader :id, :db

    def self.new_from_db(db, row)
        id, name, type = row[0], row[1], row[2]
        self.new(id: id, name: name, type: type, db: db)
    end

    def self.save(name, type, db)
      sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES (?, ?);
        SQL
      db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
          SELECT * FROM pokemon WHERE id = ?;
          SQL
        pokemon = db.execute(sql, id)[0]
        self.new_from_db(db, pokemon)
    end

    def initialize(id: nil, name:, type:, db:)
      @id, @name, @type, @db = id, name, type, db
    end

    def update
      sql = <<-SQL
        UPDATE pokemon SET name = ?, type = ? WHERE id = ?;
        SQL
      DB[:conn].execute(sql, self.name, self.type, self.id)
    end
end
