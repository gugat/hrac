require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should have_many(:assistances) }
  it { should have_many(:work_days) }


  describe 'calculate worked hours' do
    context 'when ' do
      let!(:selected_date) { Time.now.beginning_of_day }
      let!(:employee) { create(:employee) }
      before do
        # Generate assistances in the same day as a normal working day with
        # a break.
        [8, 12, 13, 20].each_with_index do |plus_hour, index|
          create(:assistance,
                 kind: (index % 2).zero? ? 'in' : 'out',
                 happening_at: selected_date + plus_hour.hours,
                 employee: employee)
        end
      end

      it 'returns the number of worked hours' do
        expect(employee.calculate_worked_hours(selected_date)).to eq(11)
      end
    end
  end


end
