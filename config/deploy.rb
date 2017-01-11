# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'arogachev_com'
set :repo_url, 'https://github.com/arogachev/arogachev.com.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/arogachev/arogachev_com'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Dependencies

namespace :bundle do
  desc 'Install Bundler packages'
  task :install do
    on roles(:all) do
      within release_path do
        execute "cd #{release_path} && bundle install --without development test"
      end
    end
  end
end

before 'deploy:updated', 'bundle:install'
before 'deploy:reverted', 'bundle:install'

# Assets

namespace :bower do
  desc 'Install Bower packages'
  task :install do
    on roles(:all) do
      within release_path do
        execute "cd #{release_path} && /home/arogachev/.npm-global/bin/bower install"
      end
    end
  end
end

before 'deploy:updated', 'bower:install'

namespace :assets do
  def portfolio_main_images(dir)
    command = [
      "assets_dir=\"#{dir}/assets/images/portfolio/projects\";",
      'for f in `ls $assets_dir`;',
      'do',
      'cd "$assets_dir/$f";',
      'echo "Generating assets for $f project";',
      'convert home.png -crop 1280x1280+0+0 -resize 700x700 main.jpg;',
      'done',
    ]
    command.join(' ')
  end

  desc 'Generate images on production server'
  task :generate_images do
    on roles(:all) do
      within release_path do
        execute portfolio_main_images("#{release_path}")
      end
    end
  end

  desc 'Generate images locally'
  task :generate_images_locally do
    run_locally do
      execute portfolio_main_images('$PWD')
    end
  end

  desc 'Generate files locally'
  task :generate_files_locally do
    invoke 'jekyll:build_locally'
    run_locally do
      execute 'node _components/resume/docx_export.js --download-template'
      execute '[ -d assets/files ] || mkdir assets/files'
      execute 'cp _generated/resume.docx assets/files/'
    end
  end

  desc 'Sync files on production server'
  task :sync_files do
    run_locally do
      execute "mkdir #{release_path}/assets/files"
      rsync = [
          'rsync',
          '--ru',
          '--progress',
          '--delete',
          'assets/files/resume.docx',
          "arogachev@arogachev.com:#{release_path}/assets/files/",
      ]
      execute rsync.join(' ')
    end
  end
end

before 'deploy:updated', 'assets:generate_images'
before 'deploy:updated', 'assets:sync_files'

# Static site generation

namespace :jekyll do
  desc 'Build site using Jekyll on production server'
  task :build do
    on roles(:all) do
      within release_path do
        execute "cd #{release_path} && bundle exec jekyll build"
      end
    end
  end

  desc 'Build site using Jekyll locally'
  task :build_locally do
    run_locally do
      execute 'bundle exec jekyll build'
    end
  end
end

before 'deploy:updated', 'jekyll:build'

# Web servers

namespace :nginx do
  desc 'Reload Nginx'
  task :reload do
    on roles(:all) do
      within release_path do
        execute 'sudo systemctl reload nginx'
      end
    end
  end
end

after 'deploy:finished', 'nginx:reload'
