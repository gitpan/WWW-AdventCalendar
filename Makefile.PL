
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share dist => "share";


my %WriteMakefileArgs = (
  "ABSTRACT" => "a calendar for a month of articles (on the web)",
  "AUTHOR" => "Ricardo SIGNES <rjbs\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Test::More" => "0.96"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.03"
  },
  "DISTNAME" => "WWW-AdventCalendar",
  "EXE_FILES" => [
    "bin/advcal"
  ],
  "LICENSE" => "perl",
  "NAME" => "WWW::AdventCalendar",
  "PREREQ_PM" => {
    "Calendar::Simple" => 0,
    "Color::Palette" => "0.100002",
    "Color::Palette::Schema" => 0,
    "Config::MVP" => 2,
    "Config::MVP::Assembler" => 0,
    "Config::MVP::Reader::INI" => 0,
    "DateTime" => 0,
    "DateTime::Format::W3CDTF" => 0,
    "Digest::MD5" => 0,
    "Email::Address" => 0,
    "Email::Simple" => 0,
    "File::Basename" => 0,
    "File::Copy" => 0,
    "File::Path" => "2.07",
    "File::ShareDir" => 0,
    "Getopt::Long::Descriptive" => "0.083",
    "Gravatar::URL" => 0,
    "HTML::Mason::Interp" => 0,
    "Moose" => "0.70",
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::StrictConstructor" => 0,
    "Path::Class" => 0,
    "Pod::Elemental" => 0,
    "Pod::Elemental::Transformer::Codebox" => 0,
    "Pod::Elemental::Transformer::List" => 0,
    "Pod::Elemental::Transformer::PPIHTML" => 0,
    "Pod::Elemental::Transformer::Pod5" => 0,
    "Pod::Elemental::Transformer::SynMux" => 0,
    "Pod::Elemental::Transformer::VimHTML" => "0.093581",
    "Pod::Simple::XHTML" => "3.13",
    "XML::Atom::SimpleFeed" => 0,
    "autodie" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "1.107",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

package
MY;
use File::ShareDir::Install qw(postamble);


