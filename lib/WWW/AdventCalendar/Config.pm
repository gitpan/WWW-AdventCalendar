package WWW::AdventCalendar::Config;
{
  $WWW::AdventCalendar::Config::VERSION = '1.101';
}
use Moose;
extends 'Config::MVP::Reader::INI';
# ABSTRACT: Config::MVP-based configuration reader for WWW::AdventCalendar

use namespace::autoclean;


use Config::MVP::Assembler;

{
  package
    WWW::AdventCalendar::Config::Assembler;
  use Moose;
  extends 'Config::MVP::Assembler';
  use namespace::autoclean;
  sub expand_package { return undef }
}

{
  package
    WWW::AdventCalendar::Config::Palette;
  $INC{'WWW/AdventCalendar/Config/Palette.pm'} = 1;
}

sub build_assembler {
  my $assembler = WWW::AdventCalendar::Config::Assembler->new;

  my $section = $assembler->section_class->new({
    name => '_',
    aliases => { category => 'categories' },
    multivalue_args => [ qw( categories ) ],
  });
  $assembler->sequence->add_section($section);

  return $assembler;
}

1;

__END__
=pod

=head1 NAME

WWW::AdventCalendar::Config - Config::MVP-based configuration reader for WWW::AdventCalendar

=head1 VERSION

version 1.101

=head1 DESCRIPTION

You probably want to read about L<WWW::AdventCalendar> or L<Config::MVP>.

This is just a L<Config::MVP::Reader::INI> subclass that will begin its
assembler in a section named "C<_>" with a few multivalue args and aliases
pre-configured.

Apart from that, there is nothing to say.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

