source 'https://rubygems.org'

gem 'listen', '~> 3.0'
gem 'mail', '~> 2.6.0'
if RUBY_PLATFORM =~ /darwin/
  gem 'terminal-notifier', '~> 1.6.3'
elsif RUBY_PLATFORM =~ /linux/
  gem 'libnotify', '~> 0.9.0'
else
  throw 'No idea how to notify on this platform!'
end
