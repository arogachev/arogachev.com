module Resume
  class Generator < Jekyll::Generator
    def generate(site)
      site.data['resume'] = decorate(site.data['resume'])
    end

    def decorate(data)
      decorated_data = Resume::Decorator.new(data).decorate
      file = File.join(Dir.pwd, '_generated', 'resume.yml')
      File.open(file, 'w') {|f| f.write decorated_data.to_yaml }
      decorated_data
    end
  end
end
