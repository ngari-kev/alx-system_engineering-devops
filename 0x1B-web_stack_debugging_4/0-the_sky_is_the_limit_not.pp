#Enhance Nginx server capacity by increasing the traffic limit

# Adjust the ULIMIT in the Nginx default configuration
exec { 'update-nginx-ulimit':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# Restart the Nginx service to apply changes
-> exec { 'reload-nginx-service':
  command => '/etc/init.d/nginx restart',
  path    => '/sbin/:/bin/:/usr/sbin/:/usr/bin/'
}
