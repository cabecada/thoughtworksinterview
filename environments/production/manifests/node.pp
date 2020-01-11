node 'node-2.vagrant.local' {
  include mediawiki::web
}

node 'node-3.vagrant.local' {
  include mediawiki::db
}
