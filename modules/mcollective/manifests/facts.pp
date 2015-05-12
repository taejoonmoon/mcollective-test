# == Class: mcollective::facts
#
# This module sets a positive value read by facts::cronjob
#
# === Example
#
# include mcollective::facts
#
class mcollective::facts {
  $enable = 'present'

  # Ensure this class is parsed before the class which uses the value
  Class['mcollective::facts'] -> Class['mcollective::facts::cronjob']
}
