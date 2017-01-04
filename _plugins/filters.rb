module Jekyll
  module StringFilter
    def humanize(input)
      StringHelper.humanize(input)
    end
  end

  module DateFilter
    def work_duration(start_date, end_date=nil)
      DateHelper.work_duration(start_date, end_date)
    end

    def age(birthdate)
      DateHelper.age(birthdate)
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
Liquid::Template.register_filter(Jekyll::DateFilter)
