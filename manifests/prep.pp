
class sockpuppet::prep {
  package { 'deep_merge':
    ensure   => 'present',
    provider => 'gem',
  }
}
