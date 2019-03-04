require 'rails_helper'

RSpec.describe WorkDay, type: :model do
  it { should belong_to(:employee) }
  it { should validate_presence_of(:total_hours) }
  it { should validate_presence_of(:day) }
  it { should validate_uniqueness_of(:day).scoped_to(:employee_id)
              .with_message('should happen once per employee')  }

  describe 'scopes' do
    let(:employee) { create(:employee) }
    let(:base_date) { DateTime.now }
    let(:final_date) { base_date + 1.day }
    it '.by_day returns all work days in the given date range' do
      generate_work_days_with_one_day_difference
      expect(employee.work_days.by_day(base_date, final_date).count).to eq(2)
    end
  end
end
