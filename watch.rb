require 'listen'
require 'mail'

if RUBY_PLATFORM =~ /darwin/
  require 'terminal-notifier'

  def notify(body, subject, from)
    TerminalNotifier.notify(body, title: subject, subtitle: from)
  end
elsif RUBY_PLATFORM =~ /linux/
  require 'libnotify'

  def notify(body, subject, from)
    Libnotify.show(body: body, summary: "#{subject} – #{from}")
  end
end

def default
  dir = ENV['HOME'] + '/.maildir/INBOX/new'
  STDERR.puts "Using #{dir} as the default inbox directory"
  dir
end

directory = ARGV[0] || default

Listen.to(directory) do |modified, added, removed|
  added.each do |file|
    begin
      mail = Mail.read(file)
      STDERR.puts [mail.subject, mail.from].inspect
      body = (mail.multipart? ? mail.parts[0] : mail).body.decoded.slice(0, 40)
      notify(body, mail.subject, mail.from[0])
    rescue => e
      STDERR.puts [e, file].inspect
    end
  end
end.start

sleep
