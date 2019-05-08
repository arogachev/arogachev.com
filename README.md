# arogachev.com

[arogachev.com][arogachev.com] is my personal site powered by Jekyll.

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

[arogachev.com]: http://arogachev.com/
