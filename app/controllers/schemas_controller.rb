class SchemasController < ApplicationController

  def show
    path = "#{Rails.root}/spec/support/api/schemas/#{params[:name]}.json"
    file = File.read(path)
    render json: file
  end

end