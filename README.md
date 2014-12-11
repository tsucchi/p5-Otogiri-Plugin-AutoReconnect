# NAME

Otogiri::Plugin::AutoReconnect - Otogiri plugin automatically reconnect when connection is lost

# SYNOPSIS

    use Otogiri
    my $db = Otogiri->new(...);
    $db->load_plugin('AutoReconnect');
    ... # do something and connection is lost
    my $row = $db->single('person', { id => $person_id }); # automatically reconnect and connection is fine

# DESCRIPTION

Otogiri::Plugin::AutoReconnect is connection manager for Otogiri. When this plugin is loaded and database connection is 
lost, automatically reconnect to database.

# LICENSE

Copyright (C) Takuya Tsuchida.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Takuya Tsuchida <tsucchi@cpan.org>
