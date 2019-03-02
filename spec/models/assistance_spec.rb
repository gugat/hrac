require 'rails_helper'

RSpec.describe Assistance, type: :model do
  it { should validate_presence_of(:happening_at) }
  it { should validate_presence_of(:kind) }
  it { should belong_to(:employee) }

  describe 'set_worked_hours' do

    context 'when assistance is an entrance' do
      it 'does not set worked hours' do
        expect{ create(:assistance) }.not_to change{ WorkDay.count } 
      end
    end

    context 'when an assistance is created' do
      it 'sets worked hours' do
        expect{ create(:assistance, :out) }.to change { WorkDay.count }.by(1)
      end
    end

    context 'when an assistance is updated' do
      let(:assistance){ create(:assistance, :out) }
      let(:new_date){ Time.now }

      it 'updates worked hours' do
        assistance.update(happening_at: new_date)
        expect(assistance.happening_at).to eq new_date
      end
    end

  end
end
