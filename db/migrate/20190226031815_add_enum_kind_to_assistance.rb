class AddEnumKindToAssistance < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE TYPE assistance_kind AS ENUM ('in', 'out');
    SQL

    add_column :assistances, :kind, :assistance_kind
  end


  def down
    delete_column :assistances, :kind

    execute <<-SQL
      ALTER TABLE assistances ALTER COLUMN kind TYPE varchar;
      DROP TYPE assistance_kind;
    SQL

  end
end
