class BaseApp
  Dir.glob('./lib/*.rb').each do |file|
    require file
  end
end
