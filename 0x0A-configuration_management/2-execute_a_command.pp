# Using Puppet, create a manifest that kills a process named `killmenow` using requirements:
exec { 'kill':
  command => 'pkill -f killmenow',
  path    => '/usr/bin:/usr/sbin:/bin',  # ['/usr/bin', '/usr/sbin', '/bin']
}
