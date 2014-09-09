namespace :sessions do

  task :delete do
    ActiveRecord::Base.connection.execute("DELETE FROM sessions WHERE created_at < '#{12.hours.ago}'")
  end

end