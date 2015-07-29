class sockpuppet::selinux (
  $boollist = {},
  $restorecondlist = {},
  $fcontextlist = {},
)
{
  $full_boollist = hiera_hash('sockpuppet::boollist', $boollist)
  $full_restorecondlist = hiera_hash('sockpuppet::restorecondlist', $restorecondlist)
  $full_fcontextlist = hiera_hash('sockpuppet::fcontextlist', $fcontextlist)

  create_resources(selinux::boolean, $full_boollist)
  create_resources(selinux::restorecondlist, $full_restorecondlist)
  create_resources(selinux::fcontextlist, $full_fcontextlist)
}
