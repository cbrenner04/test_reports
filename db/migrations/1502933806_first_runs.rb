Sequel.migration do
  up do
    create_table(:first_runs) do
      primary_key :id
      Integer :build_number, null: false
      String :environment, null: false
      TrueClass :pass, null: false
      Integer :duration, null: false
      DateTime :created_at, null: false
    end
  end

  down do
    drop_table(:first_runs)
  end
end
