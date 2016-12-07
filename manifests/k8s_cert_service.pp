define vault_client::k8s_cert_service (
  String $k8s_component,
  String $frequency,
)
{

  include ::systemd

  file { "/usr/lib/systemd/system/k8s-${k8s_component}-cert.service":
    ensure  => file,
    content => template('vault_client/k8s-cert.service.erb'),
  } ~>
  Exec['systemctl-daemon-reload']

  file { "/usr/lib/systemd/system/k8s-${k8s_component}-cert.timer":
    ensure  => file,
    content => template('vault_client/k8s-cert.service.erb'),
  } ~>
  Exec['systemctl-daemon-reload']
}
