#!/usr/bin/env ruby

require 'awesome_print'
require 'droplet_kit'
require 'shellwords'

CLIENT = DropletKit::Client.new(access_token: ENV['DIGOCEAN_API_TOKEN'])
SGP1_FLOATING_IP = '188.166.206.130'
HOST_ALIASES = %w(blog do)


def wait_for_droplet_status(droplet, target_value = 'active', interval = 1)
  start_time = Time.now
  loop do
    droplet = CLIENT.droplets.find(id: droplet.id)
    return if droplet.status == target_value
    puts "%4d  %s" % [Time.now - start_time, droplet.status]
    sleep interval
  end
  puts "Sleeping another 5 seconds..."; sleep 5
end



def create_wp_droplet

  wordpress_droplet_config = {
      name:     'bbs-wordpress',
      region:   'sgp1',
      image:    wordpress_image_id,
      size:     '1gb',
      ssh_keys: ['ed:1c:68:ee:fb:35:b8:60:c0:ee:24:e5:64:7c:b2:58']
  }

  new_droplet_template = DropletKit::Droplet.new(wordpress_droplet_config)
  new_droplet = CLIENT.droplets.create(new_droplet_template)
  puts "Created new droplet #{new_droplet.id}. Waiting for active state..."
  wait_for_droplet_status(new_droplet)
  puts "Droplet now active:"
  sleep 5
  new_droplet
end


def wordpress_image_id
  word_press_images = CLIENT.images.all.select { |image| image.slug == 'wordpress-16-04' }
  word_press_images.last.id
end


def list_droplets
  CLIENT.droplets.all.map(&:to_h).each { |d| ap d }
end


# Run command, outputting both stdout and stderr when it is done
def run_command(command)
  puts command
  output = `#{command} 2>&1`
  puts output
  output
end


def reset_floating_ip(ip, new_droplet)

  wait_for_floating_ip_assignment = -> do
    loop do
      fip = CLIENT.floating_ips.find(ip: ip)
      return fip if fip.droplet
      sleep 1
    end
  end


  # CLIENT.floating_ip_actions.unassign(ip: ip)
  CLIENT.floating_ip_actions.assign(ip: ip, droplet_id: new_droplet.id)
  puts "Assigned floating ip #{ip} to droplet #{new_droplet.id}. Waiting for completion..."
  wait_for_floating_ip_assignment.()
end


def remove_vm(floating_ip_addr)
  floating_ip = CLIENT.floating_ips.find(ip: floating_ip_addr)
  if floating_ip.droplet
    droplet_id = floating_ip.droplet.id
    puts "Removing droplet with id #{droplet_id}"
    CLIENT.droplets.delete(id: droplet_id)
    puts "Removed droplet at #{floating_ip_addr}"
  else
    puts "No droplet associated with floating IP #{floating_ip_addr}. Not deleting any VM."
  end
end


def update_known_hosts
  aliases = HOST_ALIASES + Array(SGP1_FLOATING_IP)
  known_hosts_filespec = File.join(ENV['HOME'], '.ssh', 'known_hosts')
  puts

  aliases.each do |host_spec|

    puts "Attempting to remove #{host_spec} from known_hosts file..."
    run_command("ssh-keygen -R #{host_spec}")

    puts "Attempting to register new key for #{host_spec} in known_hosts file..."
    lines = run_command("ssh-keyscan -t rsa -H #{host_spec} 2>&1").split("\n")
    good_lines = lines.reject { |line| /^#/.match(line) }
    File.open(known_hosts_filespec, 'a') { |f| f << good_lines.join("\n") << "\n" }
  end
end


def main
  remove_vm(SGP1_FLOATING_IP)
  new_droplet = create_wp_droplet
  reset_floating_ip(SGP1_FLOATING_IP, new_droplet)
  update_known_hosts
  puts "Done with recreate-vm."
end

main
