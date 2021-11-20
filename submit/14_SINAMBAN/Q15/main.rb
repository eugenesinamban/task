require_relative 'StudentRepository'

def error(e)
  "[ERROR] #{e}"
end

sr = StudentRepository.new
puts 'studentテーブルへの処理を入力してください(s:select,i:insert,d:delete,e:exit):'
while input = gets.chomp.downcase
  case input
  when 'e' then
    puts '終了'
    break
  when 's' then
    begin 
      data = sr.select
      if data.length() > 0
        data.each{|d|
          puts "[#{d['id'].to_s}]#{d['name']}"
        }
      else 
        puts 'Table empty'
      end
      puts '(s:select,i:insert,d:delete,e:exit):'
    rescue => e
      puts error(e)
      puts '終了'
      break
    end
  when 'i' then
    puts 'idを入力してください'
    id = gets.chomp
    puts 'nameを入力してください'
    name = gets.chomp
    begin
      sr.insert(id, name)
      puts '登録しました'
      puts '(s:select,i:insert,d:delete,e:exit):'
    rescue => e
      puts error(e)
      puts '終了'
      break
    end
  when 'd' then
    puts '削除するidを入力してください'
    id = gets.chomp
    begin
      sr.delete(id)
      puts "id#{id}を削除しました"
      puts '(s:select,i:insert,d:delete,e:exit):'
    rescue => e
      puts error(e)
      puts '終了'
      break
    end
  else
    puts '正しいコマンドを入力してください　(s:select,i:insert,d:delete,e:exit)：'
  end
end