require 'sqlite3'

class StudentRepository

  def initialize()
    @db_file = 'student.db'
    @table_name = 'students'
    @db = self.db_init(self.db_file)
  end

  def insert(id, name)
    id = id.to_i
    raise ArgumentError, "idは1以上の数字を入力してください" if id <= 0
    raise ArgumentError, "idは重複しています。違うidを入力してください" if self.find_by_id(id).length() > 0
    name = name.to_s
    self.db.execute "INSERT INTO #{self.table_name} (id, name) VALUES (?, ?);", id, name
  end

  def select
    self.db.execute "SELECT * FROM #{self.table_name}"
  end

  def delete(id)
    id = id.to_i
    does_not_exist = self.find_by_id(id).length() == 0
    raise ArgumentError, "指定したidを持つレコードが存在しません" if does_not_exist
    self.db.execute "DELETE FROM #{self.table_name} WHERE id = ?", id
  end

  private
  attr_accessor :table_name, :db_file, :db

  def find_by_id(id)
    id = id.to_i
    self.db.execute "SELECT * FROM #{self.table_name} WHERE id = ?", id
  end

  def db_init(db_name)
    db = SQLite3::Database.open db_name
    db.results_as_hash = true
    db
  end
end