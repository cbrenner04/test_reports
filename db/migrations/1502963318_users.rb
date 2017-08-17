Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :user, null: false
      String :password_hash, null: false
    end
  end

  down do
    drop_table(:users)
  end
end
