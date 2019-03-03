require 'rails_helper'

describe EmployeeAnomaliesService do
  def build(*_args)
    described_class.new(*_args)
  end

  let!(:employee) { create(:employee) }
  let!(:day) { DateTime.now.beginning_of_day }
  subject { build(employee, day) }

  context '#absence?' do 
    context 'when the employee has assistances' do
      let!(:assistances) { create_list(:assistance, 2, employee: employee) }
      it 'returns false' do
        expect(subject.absence?).to eq false
      end
    end
    
    context 'when the employee doesn\'t have assistances' do
      it 'returns true' do
        expect(subject.absence?).to eq true
      end
    end
  end

  context '#incomplete_assistances?' do
    context 'when the number of assistances is even' do 
      let!(:assistances) { create_list(:assistance, 4, employee: employee) }
      it 'returns false' do
        expect(subject.incomplete_assistances?).to eq false
      end
    end
    
    context 'when the number of assistances is odd' do 
      let!(:assistances) { create_list(:assistance, 3, employee: employee) }
      it 'returns true' do
        expect(subject.incomplete_assistances?).to eq true
      end
    end
  end

  context '#worked_too_short?' do
    context 'when the number of total worked hours is less than the imposed' do
      let!(:work_day) { create(:work_day, :few_hours, employee: employee) }
      # Check test environment for config file `schedule.yml`.
      it 'returns true' do
        expect(subject.worked_too_short?).to eq true
      end
    end
    
    context 'when the number of total worked hours is greater than the imposed' do
      let!(:work_day) { create(:work_day, :long_hours, employee: employee) }
      # Check test environment for config file `schedule.yml`.
      it 'returns false' do
        expect(subject.worked_too_short?).to eq false
      end
    end
  end

  context '#arrived_late?' do
    context 'when the employee is absent' do
      it 'returns false' do
        allow(subject).to receive(:absence?) { true }
        expect(subject.arrived_late?).to eq false
      end
    end
    
    context 'when the there is\'nt an entry assistance registered' do
      it 'returns false' do
        allow(subject).to receive(:first_entry) { nil }
        expect(subject.arrived_late?).to eq false
      end
    end

    context 'when arrived later than the permitted time' do
      let!(:first_assistance) { create(:bad_entry_assistance, employee: employee) }
      it 'returns true' do
        allow(subject).to receive(:first_entry) { first_assistance }
        expect(subject.arrived_late?).to eq true
      end
    end

    context 'when arrived before the permitted time' do
      let(:first_assistance) { create(:good_entry_assistance, employee: employee) }
      it 'returns false' do
        allow(subject).to receive(:first_entry) { first_assistance }
        expect(subject.arrived_late?).to eq false
      end
    end
  end

  context '#finished_too_early?' do
    context 'when the employee is absent' do
      it 'returns false' do
        allow(subject).to receive(:absence?) { true }
        expect(subject.finished_too_early?).to eq false
      end
    end
    
    context 'when the there is\'nt an exit assistance registered' do
      it 'returns false' do
        allow(subject).to receive(:last_exit) { nil }
        expect(subject.finished_too_early?).to eq false
      end
    end

    context 'when leaves before the minimun expected time to leave' do
      let!(:last_assistance) { create(:bad_exit_assistance, employee: employee) }
      it 'returns true' do
        allow(subject).to receive(:last_exit) { last_assistance }
        expect(subject.finished_too_early?).to eq true
      end
    end

    context 'when leaves after the minimun expected time to leave' do
      let(:last_assistance) { create(:good_exit_assistance, employee: employee) }
      it 'returns false' do
        allow(subject).to receive(:last_exit) { last_assistance }
        expect(subject.finished_too_early?).to eq false
      end
    end
  end

end