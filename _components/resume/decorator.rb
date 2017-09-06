module Resume
  class Decorator
    def initialize(data)
      @data = data
    end

    def decorate
      @data['work'] = @data['work'].values.sort_by {|j| j['start_date']}

      @data['basics']['age'] = DateHelper.age(@data['basics']['birthdate'])
      add_work_duration

      @data['education']['start_date_text'] = @data['education']['start_date'].strftime('%B %Y')
      @data['education']['end_date_text'] = @data['education']['end_date'].strftime('%B %Y')

      @data['work'].each do |job|
        job['slug'] = Inflector.slugify(job['name'], true)
        job['start_date_year'] = job['start_date'].strftime('%Y')
        job['end_date_year'] = job['end_date'] ? job['end_date'].strftime('%Y') : 'Present'
        job['start_date_text'] = job['start_date'].strftime('%B %Y')
        job['end_date_text'] = job['end_date'] ? job['end_date'].strftime('%B %Y') : 'Present'
        job['work_duration'] = {}
        job['work_duration']['label'] = DateHelper.work_duration_label(job['start_date'], job['end_date'])
      end
      @data['work_reversed'] = @data['work'].reverse

      all_skills = @data['skills']
      main_skills, hidden_skills = all_skills.partition.with_index {|skill, index| index < 3}
      @data['skills'] = {}
      @data['skills']['main'] = main_skills
      @data['skills']['hidden'] = hidden_skills
      @data['skills']['all'] = all_skills

      @data['references'].each do |r|
        author_text = r['author'] + ', '
        author_text << r['position'] if r['position']
        author_text << ' ' + r['preposition'] + ' ' + r['company'] if r['company']
        r['author_text'] = author_text
      end

      @data
    end

    private

    def add_work_duration
      start_date = @data['work'].first['start_date']
      work_duration = DateHelper.work_duration(start_date, years_only: true)
      @data['basics']['work_duration'] = {}
      @data['basics']['work_duration']['years'] = work_duration[:years]
      @data['basics']['work_duration']['label'] = DateHelper.work_duration_label(start_date, years_only: true)
    end
  end
end
