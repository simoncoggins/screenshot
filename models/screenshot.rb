class Screenshot
  include DataMapper::Resource

  STATUS_PENDING = 10
  STATUS_COMPLETE = 100

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :status, Integer
  property :casperscript, Text
end
