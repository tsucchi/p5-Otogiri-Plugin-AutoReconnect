requires 'Otogiri::Plugin';
requires 'perl', '5.008001';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
};

on test => sub {
    requires 'Otogiri';
    requires 'DBD::SQLite';
    requires 'Test::More', '0.98';
};
