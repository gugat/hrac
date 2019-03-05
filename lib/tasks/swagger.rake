namespace :swagger do
  desc "Replace host in schemas url"
  task :host => :environment do
    schema_file = Rails.root.to_s + '/swagger/v1/swagger.json'
    schema_content = File.read(open(schema_file)) 
    api_config = Rails.application.config_for(:api)
    new_schema = schema_content.gsub(/http[s]?\:\/\/(.*?)\//, 
                                     api_config['schemas_host'] + '/')
    File.open(schema_file, "w") {|file| file.puts new_schema }
  end
end