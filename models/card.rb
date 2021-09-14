require 'pg'

def run_sql(sql)
    db = PG.connect(dbname: 'custom_cards')
    result = db.exec(sql)
    db.close
    return result
end


def create_card(title, attack, health, rarity, text_description, cost, image_url)
    sql = "INSERT INTO cards (title, attack, health, rarity, text_description, cost, image_url) VALUES ('#{title}', '#{attack}', '#{health}', '#{rarity}', '#{text_description}', '#{cost}', '#{image_url}');"
    return run_sql(sql)
end


def find_all_cards()
    sql = "SELECT * FROM cards ORDER by id;"
    return run_sql(sql)
end

def find_card_by_id(id)
    sql = "SELECT * FROM cards where id = #{id}"
    return run_sql(sql)[0]
end

def find_latest_card_id(id)
    sql = "SELECT * FROM cards ORDER BY id DESC limit 1;"
    return run_sql(sql)
end

#Updates dish
def update_card(id, title, attack, health, rarity, text_description, cost, image_url)
    sql = "UPDATE cards SET title = '#{title}', attack = '#{attack}', health = '#{health}', rarity = '#{rarity}', text_description = '#{text_description}', cost = '#{cost}', image_url = '#{image_url}' WHERE id = #{id};"
    return run_sql(sql)
end