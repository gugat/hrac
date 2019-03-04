module ExpectedResponseHelper
  module Reports
    module Journey
      def employee_journey_response(start_date)
        {
          data: [
            {
              type: "journey",
              attributes: {
                day: start_date,
                assistances: [
                  { type: "entry", time: "08:00" },
                  { type: "exit", time: "13:00" },
                  { type: "entry", time: "15:00" },
                  { type: "exit", time: "18:00" }
                ],
                anomalies: {
                  absence: false,
                  arrived_late: false,
                  worked_too_short: false,
                  finished_too_early: false,
                  incomplete_assistances: false
                },
                worked_hours: 8.0
              }
            }
          ]
        }
      end
    end
  end
end