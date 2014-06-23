
Veewee::Definition.declare({
  :cpu_count => '1',
  :memory_size=> '512',
  :disk_size => '2048', :disk_format => 'VDI', :hostiocache => 'off',
  :os_type_id => 'Debian_64',
  :iso_file => "holusion_installer.iso",
  :iso_src => "http://holusion.net/development/holusion_installer.iso",
#  :iso_md5 => "8600f5f5de36f8fe5599ca5d18901b7a",
  :iso_download_timeout => "1000",
    :boot_wait => "10", :boot_cmd_sequence => [
	'<Esc>',
	'/install.amd/vmlinuz ',
	'initrd=/install.amd/initrd.gz ',
	'file=/cdrom/preseed/./preseed.cfg ',
	'auto=true priority=critical ',
	'classes=base;virtual',
	'<Enter>'
  ],
  :ssh_login_timeout => "1500",
  :ssh_user => "root",
  :ssh_password => "holobox",
  :ssh_key => "",
  :ssh_host_port => "7222",
  :ssh_guest_port => "22",
  :sudo_cmd => "echo '%p'|sudo -S bash '%f'",
  :shutdown_cmd => "poweroff",
  :postinstall_files => [
    "base.sh",
    "virtualbox.sh",
    "cleanup.sh",
    "zerodisk.sh"
  ],
  :postinstall_timeout => "10000"
})
