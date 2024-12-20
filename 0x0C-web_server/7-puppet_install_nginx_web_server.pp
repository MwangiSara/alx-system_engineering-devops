# install and configure an Nginx server using Puppet instead of Bash
# include resources in your manifest to perform a 301 redirect when querying `/redirect_me`

# Ensure if Nginx is present
package {'nginx':
  ensure => 'present',
}

# Update package index and install Nginx
exec {'install':
  command  => 'sudo apt-get update ; sudo apt-get install -y nginx',
  provider => shell,

}

# Start Nginx service
service { 'nginx':
  ensure => running,
  enable => true,
}

# Create the index file with "Hello World!"
file { '/var/www/html/index.nginx-debian.html':
  content => 'Hello World!',
}

# exec {'Hello':
  # command  => 'echo "Hello World!" > /var/www/html/index.nginx-debian.html',
  # provider => shell,
# }

# Create the custom HTML file for redirection
file { '/var/www/html/redirect_me.html':
  content => '<html><head><meta http-equiv="refresh" content="0; url=https://github.com/OluTshegz"></head><body></body></html>',
}

# Create the custom 404 page with the desired string
file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page",
}

# Configure Nginx for redirection and custom 404 page
file { '/etc/nginx/sites-available/default':
  content => 'server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    location /redirect_me {
      return 301 https://github.com/OluTshegz;
    }

    error_page 404 /404.html;
    location = /404.html {
      internal;
    }
  }',
  notify  => Service['nginx'],
}

# exec {'sudo sed -i "/listen 80 default_server/a return 301 https://github.com/OluTshegz;" /etc/nginx/sites-available/default':
  # provider => shell,
# }

exec {'run':
  command  => 'sudo service nginx restart',
  provider => shell,
}
