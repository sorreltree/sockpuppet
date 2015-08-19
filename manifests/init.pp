class sockpuppet (
  $packlist = [],
  $userlist = {},
  $grouplist = {},
  $srvlist = [],
  $mountlist = {},
  $sshkeylist = {},
)
{

  class { 'sockpuppet::selinux': }
  hiera_include('sockpuppet::classes')

  # Not as pretty as autolookup, but hey...
  $full_userlist = hiera_hash('sockpuppet::userlist', $userlist)
  $full_grouplist = hiera_hash('sockpuppet::grouplist', $grouplist)
  $full_packlist = hiera_array('sockpuppet::packlist', $packlist)
  $full_srvlist = hiera_array('sockpuppet::srvlist', $srvlist)
  $full_mountlist = hiera_hash('sockpuppet::mountlist', $mountlist)
  $full_sshkeylist = hiera_hash('sockpuppet::sshkeylist', $sshkeylist)

  package { $full_packlist:
    ensure => installed,
    tag    => 'sockpuppet',
  }

  service { $full_srvlist:
    ensure => running,
    enable => true,
    tag    => 'sockpuppet',
  }

  create_resources(group, $full_grouplist, { ensure => present, tag => 'sockpuppet', } )
  create_resources(user, $full_userlist, { managehome => true, tag => 'sockpuppet', } )
  create_resources(mount, $full_mountlist, { ensure => 'mounted', tag => 'sockpuppet', } )
  create_resources(ssh_authorized_key, $full_sshkeylist, { ensure => present, tag => 'sockpuppet', } )

  
}
Yumrepo <|  |> ->
Package <| tag == 'sockpuppet' |> ->
Group   <| tag == 'sockpuppet' |> ->
User    <| tag == 'sockpuppet' |> ->
Ssh_authorized_key <| tag == 'sockpuppet' |> ->
Service <| tag == 'sockpuppet' |> ->
Mount   <| tag == 'sockpuppet' |>
