class mediawiki::web {

  
  file { '/var/www':
    ensure => directory
  }

  file { '/var/www/html':
    ensure => directory
  }

  $install_path        = '/var/www/html'
  $major_version       = '1.32'
  $minor_version       = '1'
  $archive_name        = "mediawiki-${major_version}.${minor_version}.tar.gz"
  $repository_url      = "https://releases.wikimedia.org/mediawiki/${major_version}"
  $package_source      = "${repository_url}/${archive_name}"
  
  include ::archive

  archive { $archive_name:
    path         => "/tmp/${archive_name}",
    source       => $package_source,
    extract      => true,
    extract_path => $install_path,
    creates      => "${install_path}/mediawiki-${major_version}.${minor_version}",
    cleanup      => true,
    require      => File['/var/www/html']
  }

  include ::apt

  class { '::php::globals':
    php_version => '7.3',
    config_root => '/etc/php/7.3',
  }->
  class { '::php':
    manage_repos => true,
    extensions => {
      'mysql'    => {},
      'xml'      => {},
      'mbstring' => {},
      'apcu'     => {},
      'intl'     => {},
      'gd'       => {},
      'curl'     => {}, 
    }
  }

  class { '::apache':
    mpm_module => 'prefork',
  }
  class { '::apache::mod::php':
    php_version => '7.3'
  }

  file { '/var/www/html/mediawiki':
    ensure => link,
    target => '/var/www/html/mediawiki-1.32.1',
    require => Archive[$archive_name],
  }

}
