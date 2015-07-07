class sockpuppet (
  $packlist = [],
  $userlist = {},
  $grouplist = {},
  $srvlist = [],
  $mountlist = {},
  $sshkeylist = {},
)
{

  hiera_include('sockpuppet::classes')

  # Not as pretty as autolookup, but hey...
  $full_userlist = hiera_hash('sockpuppet::userlist', $userlist)
  $full_grouplist = hiera_hash('sockpuppet::grouplist', $grouplist)
  $full_packlist = hiera_array('sockpuppet::packlist', $packlist)
  $full_srvlist = hiera_array('sockpuppet::srvlist', $srvlist)
  $full_mountlist = hiera_hash('sockpuppet::mountlist', $mountlist)
  $full_sshkeylist = hiera_hash('sockpuppet::sshkeylist', $sshkeylist)

  package { $full_packlist: ensure => installed }

  service { $full_srvlist:
    ensure => running,
    enable => true,
  }

  create_resources(group, $full_grouplist, { ensure => present } )
  create_resources(user, $full_userlist, { managehome => true } )
  create_resources(mount, $full_mountlist, { ensure => 'mounted' } )
  create_resources(ssh_authorized_key, $full_sshkeylist, { ensure => present } )

  
}

