# Sets user limits for user Holberton

# Increase hard file limit for Holberton user.
exec { 'increase-hard-file-limit-for-holberton-user':
  command => 'sed -i "/^# End of file/i holberton hard nofile 100000" /etc/security/limits.conf',
  path    => '/usr/local/bin:/bin',
}

# Increase soft file limit for Holberton user.
exec { 'increase-soft-file-limit-for-holberton-user':
  command => 'sed -i "/^# End of file/i holberton soft nofile 100000" /etc/security/limits.conf',
  path    => '/usr/local/bin:/bin',
}