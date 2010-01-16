
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;

use File::ShareDir::Install;
install_share "share";


my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'WWW::AdventCalendar',
                       'DISTNAME' => 'WWW-AdventCalendar',
                       'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
                       'ABSTRACT' => 'a calendar for a month of articles (on the web)',
                       'EXE_FILES' => [
                                        'bin/advcal'
                                      ],
                       'VERSION' => '0.100160',
                       'LICENSE' => 'perl',
                       'PREREQ_PM' => {
                                        'DateTime' => '0',
                                        'HTML::Mason::Interp' => '0',
                                        'Pod::Simple::XHTML' => '3.12',
                                        'Pod::Elemental' => '0',
                                        'Calendar::Simple' => '0',
                                        'Pod::Elemental::Transformer::PPIHTML' => '0',
                                        'autodie' => '0',
                                        'Pod::Elemental::Transformer::VimHTML' => '0',
                                        'File::Path' => '2.07',
                                        'XML::Atom::SimpleFeed' => '0',
                                        'Email::Simple' => '0',
                                        'Moose' => '0.70',
                                        'File::Copy' => '0',
                                        'Pod::Elemental::Transformer::List' => '0',
                                        'ExtUtils::MakeMaker' => '6.11',
                                        'DateTime::Format::W3CDTF' => '0',
                                        'Pod::Elemental::Transformer::Pod5' => '0',
                                        'Path::Class' => '0',
                                        'File::Basename' => '0'
                                      }
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);

package MY;
use File::ShareDir::Install qw(postamble);


