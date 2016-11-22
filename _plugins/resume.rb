module Resume
  class Resume
    def self.from_file()
      YAML.load_file(File.join(Dir.pwd, '_data', 'resume.yml'))
    end
  end

  class Generator < Jekyll::Generator
    def generate(site)
      resume = site.pages.detect {|page| page.name == 'resume.html'}
      resume.data['resume'] = Resume.from_file()
    end
  end

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

  module ResumeFilter
    def date_diff(start_date, end_date)
      end_date = end_date.nil? ? DateTime.now.to_date : end_date
      months = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
      years, months = months.divmod(12)
      duration = ''
      unless years == 0
        duration << StringUtils.pluralize(years, 'year') + ' '
      end
      unless months == 0
        duration << StringUtils.pluralize(months, 'month')
      end
      duration
    end
  end
end

Liquid::Template.register_filter(Resume::ResumeFilter)
