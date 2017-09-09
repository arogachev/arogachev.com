module Resume
  class Generator < Jekyll::Generator
    def generate(site)
      site.data['resume'] = Decorator.new(site.data['resume'], site.data['geo']).decorate
    end
  end
end
