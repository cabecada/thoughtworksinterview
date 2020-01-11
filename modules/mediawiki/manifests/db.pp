class mediawiki::db {

  include apt
  
  apt::source { 'mariadb':
    location => 'http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu',
    release  => $::lsbdistcodename,
    repos    => 'main',
    key      => {
      id     => '199369E5404BD5FC7D2FE43BCBCB082A1BB943DB',
      server => 'hkp://keyserver.ubuntu.com:80',
    },
    include => {
      src   => false,
      deb   => true,
    },
  } 

  class {'::mysql::server':
    package_name     => 'mariadb-server',
    package_ensure   => '10.1.43+maria-1~xenial',
    service_name     => 'mysql',
    root_password    => 'AVeryStrongPasswordUShouldEncrypt!',
    override_options => {
      mysqld => {
        'log-error' => '/var/log/mysql/mariadb.log',
        'pid-file'  => '/var/run/mysqld/mysqld.pid',
        'bind-address' => "${::ipaddress_eth1}"
      },
      mysqld_safe => {
        'log-error' => '/var/log/mysql/mariadb.log',
      },
    }
  }

  class {'::mysql::client':
    package_name    => 'mariadb-client',
    package_ensure  => '10.1.43+maria-1~xenial',
    bindings_enable => true,
  }  
  
  mysql::db { 'mediawikidb':
    user     => 'mediawikiuser',
    password => 'mediawikipss',
    host     => '%',
    grant    => ['ALL'],
  }
  
  #Apt::Source['mariadb'] ~> Class['apt::update'] -> Class['::mysql::server'] -> Class['::mysql::client'] -> Mysql::Db['mediawikidb']

}
