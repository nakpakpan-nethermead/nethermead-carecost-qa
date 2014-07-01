def insertDatafor(file)
  fileName = "db/sql/#{file}.sql"
  sql = File.read(fileName)
  statements = sql.split(/;$/)
  statements.pop
  connection = ActiveRecord::Base.connection
  ActiveRecord::Base.transaction do
    statements.each do |statement|
      connection.execute(statement)
    end
  end
end

unless Rails.env.production?
  
  # connection.tables.each do |table|
  #   connection.execute("TRUNCATE #{table}") unless table == "schema_migrations"
  # end

  # insertDatafor('conditions',connection)
  # insertDatafor('providers',connection)
  # insertDatafor('diagnosis')
  # insertDatafor('procedures',connection)
  # insertDatafor('provider_charges',connection)
end
