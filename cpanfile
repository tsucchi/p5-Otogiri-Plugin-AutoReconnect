requires 'perl', '5.008001';
requires 'Otogiri::Plugin', '0.03';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
};

on test => sub {
    requires 'Otogiri';
    requires 'File::Temp';
    requires 'DBD::SQLite';
    requires 'Test::More', '0.98';
};
