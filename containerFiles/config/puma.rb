workers 2
threads_count = 5
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 80
environment ENV['RACK_ENV'] || 'production'

on_worker_boot do
end