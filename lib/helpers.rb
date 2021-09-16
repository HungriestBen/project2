
def logged_in?()
    if session[:user_id]
      return true
    else
      return false
    end
  end
  
def current_user()
    user = find_user_by_id(session[:user_id])
    return user
end
  

def run_sql(sql)
    db = PG.connect(dbname: 'custom_cards')
    result = db.exec(sql)
    db.close
    return result
end