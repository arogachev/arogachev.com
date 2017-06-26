# arogachev.com

Personal site powered by Jekyll.

## System dependencies

Recommended OS - Ubuntu 16.04.

### Ruby

- [Installation instructions](Ruby installation)
- Recommended version - 2.4.0

#### Bundler

```
gem install bundler
```

### Node.js

- [Installation instructions](Node.js installation)
- Recommended version - 7.9.0

#### Bower

```
npm install -g bower
```

### Pandoc

Pandoc and Tex Live are needed for generating resume in `docx` and `pdf` formats. They can be skipped if you are not 
going to work with resume.

Recommended version - 1.19.2.1.

```
sudo wget https://github.com/jgm/pandoc/releases/download/1.19.2.1/pandoc-1.19.2.1-1-amd64.deb
sudo dpkg -i pandoc-1.19.2.1-1-amd64.deb
```

#### Tex Live

```
sudo apt-get install texlive-full
```

> This can take a long time.

### ImageMagick

ImageMagick is needed for generating main images for portfolio projects. This can be skipped if you are not going to 
work with portfolio.

```
sudo apt-get install imagemagick
```

## Project dependencies

### Gems

```
bundle install 
```

#### jemoji

zlib is necessary for Nokogiri dependency:

```
sudo apt-get install zlib1g-dev
```

### Client side packages

```
bower install
```

### Build files

```
bundle exec rake
```

If you are not going to work with resume or / and portfolio you can skip this step completely or run specific commands.

#### Generating downloadable resume files

```
bundle exec rake resume:generate_files
```

#### Generating portfolio main images

```
bundle exec rake portfolio:generate_main_images
```

## Running server

```
bundle exec jekyll serve
```

## Deploy

```
bundle exec cap production deploy
```

## Running tests

```
bundle exec rspec
```

## Resume

For specifying sensitive information create file `_data/resume/secrets.yml` with the following contents and fill it:

```yaml
zip_code: ZIP Code
address: Street address (where you currently live) 
phone: Mobile phone number
 ```
 
[Ruby installation]: https://gorails.com/setup/ubuntu/16.04
[Node.js installation]: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
