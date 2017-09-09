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

    class Inflector
      def self.slugify(str, normalize_spaces=false)
        str = str.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        normalize_spaces ? str.squeeze('-') : str
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

    class MarkdownHelper
      def self.headings_tree(content)
        items = content.encode(universal_newline: true).scan(/(\#{1,4}) (.+)\n/)
        if items.empty?
          return []
        end

        min_level = items[0][0].length
        tree = []
        prev_items = {}
        names_occurence = {}

        items.each do |item|
          name = item[1]
          current_level = item[0].length
          slug = Inflector.slugify(name)

          if names_occurence.key?(name)
            slug << "-#{names_occurence[name]}"
            names_occurence[name] += 1
          else
            names_occurence[name] = 1
          end

          data = {'name' => name, 'level' => current_level, 'slug' => slug}

          if current_level == min_level
            tree.push(data)
          else
            prev_level = current_level - 1

            if prev_items[prev_level]['children'].nil?
              prev_items[prev_level]['children'] = []
            end

            prev_items[prev_level]['children'].push(data)
          end

          prev_items[current_level] = data
        end

        tree
      end
    end
  end
end
