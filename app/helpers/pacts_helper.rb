module PactsHelper
  def count_total_day_occurrences(start_date, end_date, weekdays)
    total_count = 0
    passed_count = 0
    current_date = start_date

    while current_date <= end_date
      # Adjusting wday to match the system: 0 for Monday, 1 for Tuesday, ..., 6 for Sunday
      adjusted_wday = current_date.wday - 1
      adjusted_wday = 6 if adjusted_wday == -1 # Adjust for Sunday

      if weekdays.include?(adjusted_wday)
        total_count += 1
        passed_count += 1 if current_date <= Date.today
      end
      current_date += 1.day
    end

    [passed_count, total_count]
  end
end
