use strict;
use warnings;
use Test::More;
use Otogiri;
use Otogiri::Plugin;
#use DBIx::QueryLog;
use File::Temp qw(tempfile);

my ($fh, $dbfile)  = tempfile('db_XXXXX', UNLINK => 1, EXLOCK => 0);

my $db = Otogiri->new( connect_info => ["dbi:SQLite:dbname=$dbfile", '', '', { RaiseError => 1, PrintError => 0 }] );
$db->load_plugin('AutoReconnect');


my $sql = "
CREATE TABLE person (
  id   INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT    NOT NULL,
  age  INTEGER NOT NULL DEFAULT 20
);";

$db->do($sql);

$db->fast_insert('person', {
    name => 'Sherlock Shellingford',
    age  => 15,
});
my $person_id = $db->last_insert_id();


subtest 'reconnect', sub {
    $db->dbh->disconnect();
    $db->reconnect();
    my $row = $db->single('person', { id => $person_id });
    ok( defined $row );
};

subtest 'auto reconnect', sub {
    $db->dbh->disconnect();
    #$db->reconnect();
    my $row = $db->single('person', { id => $person_id });
    ok( defined $row );
};


done_testing;
