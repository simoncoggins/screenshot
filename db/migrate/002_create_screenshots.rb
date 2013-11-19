migration 2, :create_screenshots do
  up do
    create_table :screenshots do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :status, Integer
      column :casperscript, DataMapper::Property::Text
    end
  end

  down do
    drop_table :screenshots
  end
end
