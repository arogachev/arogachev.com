# arogachev.com

Personal site powered by Jekyll.

## Development

Requirements (recommended):

- Ruby >= 2.2.2 with Bundler gem
- Node.js >= 7.1.0 with NPM and Bower
- Pandoc >= 1.19.1
- TeX Live

Install Pandoc:

```
sudo wget https://github.com/jgm/pandoc/releases/download/1.19.1/pandoc-1.19.1-1-amd64.deb
sudo dpkg -i pandoc-1.19.1-1-amd64.deb
```

Install Tex Live:

```
sudo apt-get install texlive-full
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

Serve the site (by default it will be available at `localhost:3000`):

```
bundle exec jekyll serve
```

Deploy:

```
bundle exec cap production deploy
```
