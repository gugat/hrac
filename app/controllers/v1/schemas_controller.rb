module V1
  class SchemasController < ApplicationController

    before_action :set_schemas_path, only: %i[show]

    def show
      path = "#{@schemas_path}/#{params[:name]}.json"
      file = File.read(path)
      render json: file
    end

    private

    def set_schemas_path
      config = Rails.application.config_for(:api)
      @schemas_path = config['schemas_path']
    end

  end
end