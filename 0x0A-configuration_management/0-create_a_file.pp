# Using Puppet, this manifest creates a file in /tmp using requirements:
file {  '/tmp/school':
    ensure  => present,
    mode    => '0744',
    owner   => 'www-data',
    group   => 'www-data',
    content => 'I love Puppet',
}
