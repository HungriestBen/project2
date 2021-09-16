require 'pg'
require 'bcrypt'

def run_sql(sql)
    db = PG.connect(dbname: 'custom_cards')
    result = db.exec(sql)
    db.close
    return result
end

def create_user(email, password_digest)

    db = PG.connect(dbname: 'custom_cards')

    password = password_digest
    email = email
    digested_password = BCrypt::Password.create(password)

    sql = "INSERT INTO users (email, password_digest) VALUES ('#{email}', '#{digested_password}')returning *;"
    new_user = db.exec(sql)

    # results = db.exec(sql)
    db.close
    return new_user[0]
end

def find_user_by_email(email)
    db = PG.connect(dbname: 'custom_cards')
    sql = "SELECT * FROM users WHERE email = '#{email}';"
    result = db.exec(sql) #Return an array of hashes
    db.close

    if result.count > 0
        return result[0]
    else
        return false
    end
end

def find_user_by_id(id)
    db = PG.connect(dbname: 'custom_cards')
    sql = "SELECT * FROM users WHERE id = '#{id}';"
    result = db.exec(sql)
    db.close

    if result.count > 0
        return result[0]
    else
        return false
    end
end

def find_email_taken(email)
    sql = "SELECT FROM users WHERE email = '#{email}';"
    return run_sql(sql)
end

def find_user_by_comment_user_id(id)
    sql = "SELECT * FROM users WHERE id = '#{id}';"
    return run_sql(sql)
end