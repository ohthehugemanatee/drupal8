# The name for the application, should only be things that can be in a directory name
set :application, 'app'

# The repo URL
set :repo_url, 'repo'

# Use git for the SCM
set :scm, :git

# Use a remote cache for git
set :deploy_via, :remote_cache

# Which logging formatter to use
set :format, :pretty

# Which logging level to use
set :log_level, :debug

# Whether to use sudo for commands
set :user_sudo, false

# Whether to use a pseudo-TTY
set :pty, true

# Array of folders to share
set :linked_dirs, %w{public/sites/default/files}

# Number of release directories to keep
set :keep_releases, 3

# Add custom SSH config
set :ssh_options, {
  config: 'config/ssh_config'
}

after "deploy:check", "drush:initialize"
after "deploy:publishing", "deploy:restart"
after "deploy:symlink:release", "deploy:symlink:drupal"
after "deploy:symlink:drupal", "deploy:symlink:settings"
after "deploy:symlink:settings", "drush:dbbackup"
after "drush:dbbackup", "drush:run_updates"
after "deploy:revert_release", "deploy:revert_database"
