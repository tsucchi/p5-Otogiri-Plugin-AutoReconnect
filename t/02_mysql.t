use strict;
use warnings;
use Test::More;
use Mock::Quick;
use Otogiri;
use Otogiri::Plugin;
#use DBIx::QueryLog;

use Test::Requires 'Test::mysqld';

my $mysqld = Test::mysqld->new(
    my_cnf => {
        'skip-networking' => '',
    }
) or plan skip_all => $Test::mysqld::errstr;

my $db = Otogiri->new( connect_info => [$mysqld->dsn(dbname => 'test'), '', ''] );
$db->load_plugin('AutoReconnect');


my $sql = "
CREATE TABLE person (
  id   INTEGER PRIMARY KEY AUTO_INCREMENT,
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

subtest 'in transaction', sub {

    my $txn = $db->txn_scope();
    my $row = $db->single('person', { id => $person_id });

    my $guard = qclass(
        -takeover => 'DBIx::Sunny::db',
        ping => sub { 0 },
    );

    eval {
        $db->insert('person', {
            name => 'Nero Yuzurizaki',
            age  => 15,
        });
    };
    like( $@, qr/^Detected transaction/ );

    $txn->rollback();
};



done_testing;
