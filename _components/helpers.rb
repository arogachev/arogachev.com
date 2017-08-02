module Components
  module Helpers
    class StringHelper
      def self.pluralize(count, singular, plural=nil)
        plural = "#{singular}s" if plural.nil?
        noun = count == 1 ? singular : plural
        "#{count} #{noun}"
      end

      def self.string_between_markers(str, marker_start, marker_end=nil)
        marker_start = Regexp.escape(marker_start) if marker_start.is_a?(String)
        if marker_end.nil?
          marker_end = marker_start
        elsif marker_end.is_a?(String)
          marker_end = Regexp.escape(marker_end)
        end
        str[/#{marker_start}(.*?)#{marker_end}/m, 1]
      end
    end

    class DateHelper
      def self.work_duration(start_date, end_date=nil, years_only: false)
        end_date = DateTime.now.to_date if end_date.nil?
        days_total = (end_date - start_date).to_i
        months_total, extra_days = days_total.divmod(365.0 / 12)
        months_total +=1 if extra_days > 14
        years, months = months_total.divmod(12)
        if years_only
          years += 1 if months > 6
          months = 0
        end
        {years: years, months: months}
      end

      def self.work_duration_label(start_date, end_date=nil, years_only: false)
        duration = self.work_duration(start_date, end_date, years_only: years_only)
        years = duration[:years]
        months = duration[:months]
        return 'less than a month' if years == 0 && months == 0
        duration_parts = []
        unless years == 0
          duration_parts.push(StringHelper.pluralize(years, 'year'))
        end
        unless months == 0
          duration_parts.push(StringHelper.pluralize(months, 'month'))
        end
        duration_parts.join(' ')
      end

      def self.age(dob)
        now = Date.today
        now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
      end
    end
  end
end
