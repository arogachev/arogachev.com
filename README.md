# arogachev.com

Personal site powered by Jekyll.

## Development

Requirements (recommended):

- Ruby >= 2.2.2 with Bundler gem
- Node.js with NPM and Bower
- Pandoc >= 1.19.1
- TeX Live
- ImageMagick

Pandoc and Tex Live are needed for generating resume in `docx` and `pdf` format. They can be skipped if you are not 
going to work with resume.

Install Pandoc:

```
sudo wget https://github.com/jgm/pandoc/releases/download/1.19.1/pandoc-1.19.1-1-amd64.deb
sudo dpkg -i pandoc-1.19.1-1-amd64.deb
```

Install Tex Live. This can take a very long time.

```
sudo apt-get install texlive-full
```

If there will be errors at the very end of installation (I am using Ubuntu 14.04 with Vagrant locally), generating PDF 
with Pandoc can cause some errors related with pdflatex. To solve them you might need to explicitly install the 
following packages:

```
sudo apt-get install texlive-latex-base
sudo apt-get install texlive-fonts-recommended
sudo apt-get install texlive-latex-extra
```

ImageMagick is needed for generating main images for portfolio projects. This can be skipped if you are not going to 
work with portfolio. It can be installed using `apt` too:

```
sudo apt-get install imagemagick
```

Install gems:

```
bundle install 
```

Install Bower packages:

```
bower install
```

Generate assets:

```
bundle exec rake
```

If you are not going to work with resume or / and portfolio you can skip this step completely or run specific commands.

For resume:

```
bundle exec rake resume:generate_files
```

For portfolio:

```
bundle exec rake portfolio:generate_main_images
```

Serve the site (by default it will be available at `localhost:3000`):

```
bundle exec jekyll serve
```

Deploy:

```
bundle exec cap production deploy
```

### Running tests

```
rspec
```

### Resume

For specifying sensitive information create file `_data/resume/secrets.yml` with the following contents and fill it:

```yaml
zip_code: ZIP Code
address: Street address (where you currently live) 
phone: Mobile phone number
 ```
