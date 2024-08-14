# fixes mispell of php extension in `wp-settings.php`.

exec { 'fix_extension':
  command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
  path    => '/usr/local/bin/:/bin/'
}
