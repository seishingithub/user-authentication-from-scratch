Sequel.migration do
  up do
    add_column(:users, :admin, FalseClass, :default => false)
  end

  down do
    drop_column(:users, :admin)
  end
end