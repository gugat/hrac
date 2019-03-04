module Reports
  class JourneySerializer
    include FastJsonapi::ObjectSerializer

    attribute :day

    attribute :assistances do |record|
      record.assistances.map do |assistance|
        { 
          type: (assistance.kind == 'in' ? 'entry' : 'exit'), 
          time: assistance.happening_at.getlocal.strftime('%H:%M') 
        }
      end
    end

    attribute :anomalies do |record|
      anomaly = record.anomalies.first 
      {
        absence: anomaly.absence,
        arrived_late: anomaly.absence,
        worked_too_short: anomaly.absence,
        finished_too_early: anomaly.absence,
        incomplete_assistances: anomaly.absence
      }
    end

    attribute :worked_hours
  end
end