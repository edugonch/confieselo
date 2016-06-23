rails_env = ENV['RAILS_ENV'] || 'development'

workers 1                            
threads 8, 16

stdout_redirect(
    "/home/rails/current/log/puma.stdout.log",
    "/home/rails/current/log/puma.stderr.log")


bind  "unix:///home/rails/shared/tmp/sockets/puma.sock"
pidfile "/tmp/puma/pid"
state_path "/tmp/puma/state"

activate_control_app

daemonize true
preload_app!
