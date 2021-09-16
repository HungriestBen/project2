require 'pg'

def run_sql(sql)
db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'custom_cards'})
result = db.exec(sql)
db.close
return result
end

def create_comment(timestamp, comment, user_id, card_id)
    sql = "INSERT INTO comments (time, comment, user_id, card_id) VALUES ('#{timestamp}', '#{comment}', '#{user_id}', '#{card_id}');"
    return run_sql(sql)
end

def find_comments_by_card_id(card_id)
    sql = "SELECT * FROM comments WHERE card_id = '#{card_id}' ORDER BY time desc;"
    return run_sql(sql)
end