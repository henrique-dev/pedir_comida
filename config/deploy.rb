# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "pedir_comida"
set :repo_url, "git@github.com:henrique-dev/pedir_comida.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, "master"

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/var/www/pedir_comida"

# Default value for :format is :airbrussh.
# set :format, :airbrussh
set :format, :airbrussh

set :log_level, :debug

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_files, "config/database.yml", "config/master.key"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
append :linked_dirs, "storage", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "pub"

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

after 'deploy:finished', 'deploy:restart'

namespace :deploy do
    task :restart do
        invoke 'unicorn:stop'
        invoke 'unicorn:start'
    end
end