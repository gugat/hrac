module V1
  module Reports
    class JourneysController < ApplicationController

      before_action :set_employee, only: %i[show]
      before_action :convert_dates, only: %i[show]

      def show
        authorize @employee, :show_journeys_report?
        args = { employee: @employee, start_date: @start_date, end_date: @end_date }
        journeys = GenerateJourneysReport.for(args)
        render json: serialize(journeys), status: 200
      end
      
      private
    
      def set_employee
        @employee = Employee.find(params[:employee_id])
      end

      def convert_dates
        @start_date = DateTime.parse params[:start_date]
        @end_date = DateTime.parse params[:end_date]
      end

      def serialize(journey)
        ::Reports::JourneySerializer.new(journey).serialized_json
      end
    end
  end
end