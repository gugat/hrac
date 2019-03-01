require 'rails_helper'

describe AssistancePolicy do
  subject { described_class }

  let(:current_employee) { FactoryBot.build_stubbed :employee }
  let(:admin) { FactoryBot.build_stubbed :employee, :admin }

  permissions :create? do
    it 'prevents creation of assistances if not an admin' do
      expect(subject).not_to permit(current_employee)
    end

    it 'allows an admin to create an assistance' do
      expect(subject).to permit(admin)
    end
  end
end
