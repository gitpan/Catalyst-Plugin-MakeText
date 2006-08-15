use 5.008002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Catalyst::Plugin::MakeText',
    VERSION_FROM      => 'lib/Catalyst/Plugin/MakeText.pm', # finds $VERSION
    PREREQ_PM         => { Locale::Maketext::Simple => 0.17 },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Catalyst/Plugin/MakeText.pm', # retrieve abstract from module
       AUTHOR         => 'Jun Shimizu <bayside@cpan.org>') : ()),
);
