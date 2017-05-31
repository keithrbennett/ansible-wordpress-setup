#!/usr/bin/env ruby

require 'open3'

PLAYBOOKS = %w(
  01-root-operations.yml
  02-install-wp-cli.yml
  03-copy-bbs-content.yml
  04-themes-etc.yml
  11a-apt-get-upgrade.yml
  11b-apt-get-upgrade-reboot.yml
  12-set-up-ruby.yml
)

SEPARATOR_LINE = "#{'*' * 79}\n"

start_time = Time.now


def run_shell_command(command)
  Open3.popen2e(command) do |stdin, stdout_err, wait_thr|
    while line = stdout_err.gets
      puts line
    end

    exit_status = wait_thr.value
    unless exit_status.success?
      abort "!!! FAILED! Command: #{command}, Exit Code: #{exit_status}"
    end
  end
end


def run_playbook(playbook_spec)
  puts "\n\n#{SEPARATOR_LINE}Running playbook #{playbook_spec}\n#{SEPARATOR_LINE}\n"
  playbook_start_time = Time.now
  run_shell_command("ansible-playbook #{playbook_spec}")
  puts "\n\nFinished with playbook #{playbook_spec}. " <<
           "Duration was #{Time.now - playbook_start_time} seconds."
end


PLAYBOOKS.each do |playbook|
  run_playbook(playbook)
end

puts SEPARATOR_LINE
puts "Entire operation duration: #{Time.now - start_time}"

