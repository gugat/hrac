require 'rails_helper'

describe EmployeePolicy do
  subject { described_class }

  let(:current_employee) { FactoryBot.build_stubbed :employee }
  let(:other_employee) { FactoryBot.build_stubbed :employee }
  let(:admin) { FactoryBot.build_stubbed :employee, :admin }

  permissions :index? do
    it 'prevents listing of employees if not admin' do
      expect(subject).not_to permit(current_employee)
    end

    it 'allows admin to list employees' do
      expect(subject).to permit(admin)
    end
  end

  permissions :show? do
    it 'prevents other employees from seeing your profile' do
      expect(subject).not_to permit(current_employee, other_employee)
    end

    it 'allows you to see your own profile' do
      expect(subject).to permit(current_employee, current_employee)
    end

    it 'allows and admin to see any employee profile' do
      expect(subject).to permit(admin)
    end
  end

  permissions :create? do
    it 'prevents creation of employees if not an admin' do
      expect(subject).not_to permit(current_employee)
    end

    it 'allows an admin to create an employee' do
      expect(subject).to permit(admin)
    end
  end
end