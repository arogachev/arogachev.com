module Resume
  class Generator < Jekyll::Generator
    def generate(site)
      site.data['resume'] = Decorator.new(site.data['resume']).decorate
    end
  end
end
