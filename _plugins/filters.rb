class StringUtils
  def self.pluralize(n, singular, plural=nil)
    plural = plural.nil? ? "#{singular}s" : plural
    if n == 1
      "1 #{singular}"
    elsif plural
      "#{n} #{plural}"
    else
      "#{n} #{singular}s"
    end
  end
end

class DateUtils
  def self.diff(start_date, end_date=nil, show_months=true)
    end_date = end_date.nil? ? DateTime.now.to_date : end_date
    months = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
    years, months = months.divmod(12)
    diff = ''
    unless years == 0
      diff << StringUtils.pluralize(years, 'year') + ' '
    end
    unless show_months == false || months == 0
      diff << StringUtils.pluralize(months, 'month')
    end
    diff
  end
end

module Jekyll
  module InflectionsFilter
    def humanize(input)
      input.gsub('_', ' ').capitalize
    end
  end

  module DateFilter
    def date_diff(start_date, end_date=nil)
      DateUtils.diff(start_date, end_date)
    end

    def date_diff_years(start_date, end_date=nil)
      DateUtils.diff(start_date, end_date, false)
    end
  end
end

Liquid::Template.register_filter(Jekyll::InflectionsFilter)
Liquid::Template.register_filter(Jekyll::DateFilter)
