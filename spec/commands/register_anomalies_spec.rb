require 'rails_helper'

describe RegisterAnomalies do

  let(:employee) { create(:employee) }
  let(:day) { DateTime.now.beginning_of_day }

  def perform(*_args)
    described_class.for(employee: employee, day: day)
  end


  context 'Given and employee and a day' do
    
    it 'registers anomalies' do
      allow_any_instance_of(EmployeeAnomaliesService).to receive(:absence?) { true }
      allow_any_instance_of(EmployeeAnomaliesService).to receive(:worked_too_short?) { true }
      allow_any_instance_of(EmployeeAnomaliesService).to receive(:arrived_late?) { true }
      allow_any_instance_of(EmployeeAnomaliesService).to receive(:finished_too_early?) { true }
      allow_any_instance_of(EmployeeAnomaliesService).to receive(:incomplete_assistances?) { true }
      expect{ perform }.to change { Anomaly.count }.by(1)
    end
  end
end