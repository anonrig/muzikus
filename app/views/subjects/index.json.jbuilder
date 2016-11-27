json.array!(@subjects) do |subject|
  json.extract! subject, :id, :title
  json.url subject_url(subject, format: :json)
end
