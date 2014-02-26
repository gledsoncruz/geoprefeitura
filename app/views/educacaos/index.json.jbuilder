json.array!(@educacaos) do |educacao|
  json.extract! educacao, :id, :nome, :email, :contato, :the_geom
  json.url educacao_url(educacao, format: :json)
end

