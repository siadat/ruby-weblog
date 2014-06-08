db.create_table :posts do
    primary_key :id
    String :title
    String :body, :text=>true
end
