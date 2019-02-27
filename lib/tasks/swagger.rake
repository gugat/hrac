namespace :swagger do
  desc "Replace host in schemas url"
  task :host => :environment do
    schema_file = Rails.root.to_s + '/swagger/v1/swagger.json'
    schema_content = File.read(open(schema_file)) 
    swagger_config = Rails.application.config_for(:swagger)
    new_schema = schema_content.gsub(/http[s]?\:\/\/(.*?)\//, 
                                     swagger_config['schemas_host'] + '/')
    File.open(schema_file, "w") {|file| file.puts new_schema }
  end
end