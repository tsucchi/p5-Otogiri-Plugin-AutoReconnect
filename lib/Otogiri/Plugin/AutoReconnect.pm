package Otogiri::Plugin::AutoReconnect;
use 5.008001;
use strict;
use warnings;

use Otogiri::Plugin;

our $VERSION = "0.01";

our @EXPORT = qw(reconnect);

BEGIN {
    no warnings 'redefine';
    *DBIx::Otogiri::dbh = \&dbh;
}

sub reconnect {
    my ($self) = @_;
    $self->{dbh} = DBIx::Sunny->connect(@{$self->{connect_info}});
}

sub dbh {
    my ($self) = @_;
    my $dbh = $self->{dbh};
    if ( !$dbh->FETCH('Active') || !$dbh->ping ) {
        $self->reconnect;
    }
    return $self->{dbh};
}

1;
__END__

=encoding utf-8

=head1 NAME

Otogiri::Plugin::AutoReconnect - Otogiri plugin automatically reconnect when connection is lost

=head1 SYNOPSIS

    use Otogiri
    my $db = Otogiri->new(...);
    $db->load_plugin('AutoReconnect');
    ... # do something and connection is lost
    my $row = $db->single('person', { id => $person_id }); # automatically reconnect and connection is fine

=head1 DESCRIPTION

Otogiri::Plugin::AutoReconnect is connection manager for Otogiri. When this plugin is loaded and database connection is 
lost, automatically reconnect to database.

=head1 LICENSE

Copyright (C) Takuya Tsuchida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Takuya Tsuchida E<lt>tsucchi@cpan.orgE<gt>

=cut

