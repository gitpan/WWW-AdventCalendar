
use strict;
use warnings;



use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'WWW-AdventCalendar',
  NAME      => 'WWW::AdventCalendar',
  AUTHOR    => "Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>",
  ABSTRACT  => "a\ calendar\ for\ a\ month\ of\ articles\ \(on\ the\ web\)",
  VERSION   => '0.093580',
  EXE_FILES => [ qw(bin/advcal) ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "DateTime" => '0',
    "HTML::Mason::Interp" => '0',
    "Pod::Simple::XHTML" => '3.12',
    "Pod::Elemental" => '0',
    "Calendar::Simple" => '0',
    "Pod::Elemental::Transformer::PPIHTML" => '0',
    "autodie" => '0',
    "Pod::Elemental::Transformer::VimHTML" => '0',
    "File::Path" => '0',
    "XML::Atom::SimpleFeed" => '0',
    "Email::Simple" => '0',
    "Moose" => '0.70',
    "File::Copy" => '0',
    "Pod::Elemental::Transformer::List" => '0',
    "DateTime::Format::W3CDTF" => '0',
    "Pod::Elemental::Transformer::Pod5" => '0',
    "Path::Class" => '0',
    "File::Basename" => '0',
  },
  test => {TESTS => 't/*.t'}
);

