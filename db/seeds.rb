def insertDatafor(file,connection)
  fileName = "db/sql/#{file}.sql"
  sql = File.read(fileName)
  statements = sql.split(/;$/)
  statements.pop

  ActiveRecord::Base.transaction do
    statements.each do |statement|
      connection.execute(statement)
    end
  end
end

unless Rails.env.production?
  connection = ActiveRecord::Base.connection
  connection.tables.each do |table|
    connection.execute("TRUNCATE #{table}") unless table == "schema_migrations"
  end

  insertDatafor('providers',connection);
  insertDatafor('conditions',connection);
  insertDatafor('diagnosis',connection);
  insertDatafor('procedures',connection);
  insertDatafor('provider_charges',connection);
end
