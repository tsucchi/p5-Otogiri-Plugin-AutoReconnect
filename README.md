[![Build Status](https://travis-ci.org/tsucchi/p5-Otogiri-Plugin-AutoReconnect.svg?branch=master)](https://travis-ci.org/tsucchi/p5-Otogiri-Plugin-AutoReconnect) [![Coverage Status](https://img.shields.io/coveralls/tsucchi/p5-Otogiri-Plugin-AutoReconnect/master.svg)](https://coveralls.io/r/tsucchi/p5-Otogiri-Plugin-AutoReconnect?branch=master)
# NAME

Otogiri::Plugin::AutoReconnect - (DEPRECATED) Otogiri plugin automatically reconnect when connection is lost

# SYNOPSIS

    use Otogiri
    my $db = Otogiri->new(...);
    $db->load_plugin('AutoReconnect');
    ... # do something and connection is lost
    my $row = $db->single('person', { id => $person_id }); # automatically reconnect and connection is fine

# DESCRIPTION

Auto reconnect feature is integrated into [Otogiri](https://metacpan.org/pod/Otogiri) core from version 0.15. Please DO NOT USE this plugin.

Otogiri::Plugin::AutoReconnect is connection manager for Otogiri. When this plugin is loaded and database connection is 
lost, automatically reconnect to database.

# SEE ALSO

[Teng](https://metacpan.org/pod/Teng), [DBIx::TransactionManager](https://metacpan.org/pod/DBIx::TransactionManager), [DBIx::Connector](https://metacpan.org/pod/DBIx::Connector)

# LICENSE

Copyright (C) Takuya Tsuchida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Takuya Tsuchida <tsucchi@cpan.org>
