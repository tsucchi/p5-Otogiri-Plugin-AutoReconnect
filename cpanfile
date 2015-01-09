requires 'perl', '5.008001';
requires 'Otogiri', '0.12';
requires 'Otogiri::Plugin', '0.03';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
};

on test => sub {
    requires 'File::Temp';
    requires 'DBD::SQLite';
    requires 'Test::More', '0.98';
    requires 'Test::Requires';
    requires 'Mock::Quick';
};

on develop => sub {
    requires 'Test::mysqld';
    requires 'Test::PostgreSQL';
};
