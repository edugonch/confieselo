json.array!(@confesions) do |confesion|
  json.extract! confesion, :id, :tittle, :message, :anonymous
  json.url confesion_url(confesion, format: :json)
end
