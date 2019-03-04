require 'rails_helper'

describe GenerateJourneysReport do

  let(:employee) { create(:employee) }
  let(:start_date) { DateTime.now.beginning_of_day }
  let(:end_date) { start_date + 3.days }
  let(:base_date) { start_date }

  def perform(*_args)
    described_class.for(employee: employee, start_date: start_date, end_date: end_date )
  end

  before do
    generate_work_days_with_one_day_difference
    generate_assistances_with_one_day_difference
    generate_anomalies_with_one_day_difference
  end

  it "returns array of Journeys" do
    expect(perform).to all( be_a(Reports::Journey) )
  end
end