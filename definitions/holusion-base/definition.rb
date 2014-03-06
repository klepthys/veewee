#Thanks to Fletcher Nichol - https://github.com/fnichol

Veewee::Definition.declare({
  :cpu_count => '1',
  :memory_size=> '512',
  :disk_size => '2048', :disk_format => 'VDI', :hostiocache => 'off',
  :os_type_id => 'Debian_64',
  :iso_file => "holusion_installer.iso",
  :iso_src => "http://holusion.net/holusion_installer.iso",
  :iso_md5 => "e550735d39996f8776fc4d8d0ae5eb78",
  :iso_download_timeout => "1000",
  :boot_wait => "10", :boot_cmd_sequence => [
     '<Enter>'
  ],
  :kickstart_port => "7122",
  :kickstart_timeout => "10000",
  :kickstart_file => "preseed.cfg",
  :ssh_login_timeout => "10000",
  :ssh_user => "root",
  :ssh_password => "holobox",
  :ssh_key => "",
  :ssh_host_port => "7222",
  :ssh_guest_port => "22",
  :sudo_cmd => "echo '%p'|sudo -S bash '%f'",
  :shutdown_cmd => "halt -p",
  :postinstall_files => [
    "base.sh",
    "vagrant.sh",
    "virtualbox.sh",
    #"vmfusion.sh",
    "ruby.sh",
    "puppet.sh",
    "chef.sh",
    "cleanup-virtualbox.sh",
    "cleanup.sh",
    "zerodisk.sh"
  ],
  :postinstall_timeout => "10000"
})
