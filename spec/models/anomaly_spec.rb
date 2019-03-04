require 'rails_helper'

RSpec.describe Anomaly, type: :model do
  it { should validate_presence_of(:day) }
  it { should belong_to(:employee) }


  describe 'scopes' do
    let(:employee) { create(:employee) }
    let(:base_date) { DateTime.now }
    let(:final_date) { base_date + 1.day }
    it '.by_day returns all anomalies in the given date range' do
      generate_anomalies_with_one_day_difference
      expect(employee.anomalies.by_day(base_date, final_date).count).to eq(2)
    end
  end
end
