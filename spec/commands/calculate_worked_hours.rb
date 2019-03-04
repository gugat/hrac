require 'rails_helper'

describe CalculateWorkedHours do

  let(:employee) { create(:employee) }
  let(:day) { DateTime.now.beginning_of_day }

  def perform(*_args)
    described_class.for(employee: employee, day: day)
  end

  context 'When an employee has assistances ' do
    let(:assistance_day) { day }
    before { generate_assistances_for_one_day }

    it 'returns the number of worked hours' do
      expect(perform).to eq(8.0)
    end
  end

  context 'When an employee does not have assistances ' do
    let(:assistance_day) { day }

    it 'returns the zero worked hours' do
      expect(perform).to eq(0.0)
    end
  end
end