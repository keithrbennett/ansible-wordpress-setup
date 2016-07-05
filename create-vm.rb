#!/usr/bin/env ruby

require 'awesome_print'
require 'droplet_kit'

CLIENT = DropletKit::Client.new(access_token: ENV['DIGOCEAN_API_TOKEN'])

def create_wp_droplet

  wordpress_droplet_config = {
      name:     'bbs-wordpress',
      region:   'sgp1',
      image:    wordpress_image_id,
      size:     '1gb',
      ssh_keys: ['ed:1c:68:ee:fb:35:b8:60:c0:ee:24:e5:64:7c:b2:58']
  }

  new_droplet_template = DropletKit::Droplet.new(wordpress_droplet_config)
  CLIENT.droplets.create(new_droplet_template)
end


def wordpress_image_id
  CLIENT.images.all.select { |image| image.slug == 'wordpress' }.first.id
end


def list_droplets
  CLIENT.droplets.all.map(&:to_h).each { |d| ap d }
end


# puts wordpress_image_id
create_wp_droplet
list_droplets
