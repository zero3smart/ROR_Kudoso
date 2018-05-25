json.array!(@families) do |family|
  json.extract! family, :id, :name, :primary_contact_id
  json.url family_url(family, format: :json)
end