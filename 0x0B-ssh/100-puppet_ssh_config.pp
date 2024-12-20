# using Puppet to make changes to our configuration file by setting up your client
# SSH configuration file so that you can connect to a server without typing a password

include stdlib

# Define a resource to manage the "IdentityFile" line
    file_line { 'Declare identity file':
      ensure             => present,
      path               => '/etc/ssh/ssh_config',
      line               => '    IdentityFile ~/.ssh/school',
      match              => '^[#]+[\s]*(?i)IdentityFile[\s]+~/.ssh/id_rsa$',
      replace            => true,
      append_on_no_match => true,
    }

# Regex match explanation
#
# ^       beginning of the line
# [#]*  atleast one hash character
# [\s]*  zero or more white space characters
# (?i)IdentityFile case insensitive "IdentityFile"
# [\s]+ at least one whitespace character
# ~/.ssh/id_rsa The ssh private key file path we want to replace
# $      end of the line

# Define a resource to manage the "PasswordAuthentication" line
    file_line { 'Turn off passwd auth':
      ensure             => present,
      path               => '/etc/ssh/ssh_config',
      line               => '    PasswordAuthentication no',
      match              => '^[#]+[\s]*(?i)PasswordAuthentication[\s]+(yes|no)$',
      replace            => true,
      append_on_no_match => true,
    }

# Regex match explanation
#
# ^       beginning of the line
# [#]*  atleast one hash character
# [\s]*  zero or more white space characters
# (?i)PasswordAuthentication case insensitive "PasswordAuthentication"
# [\s]+ at least one whitespace character
# (yes|no) with the value "yes" or the value "no"
# $      end of the line
