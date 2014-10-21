package WWW::AdventCalendar::Article;
{
  $WWW::AdventCalendar::Article::VERSION = '1.106';
}
use Moose;
# ABSTRACT: one article in an advent calendar


use autodie;
use Digest::MD5 qw(md5_hex);
use Email::Address;
use Pod::Elemental;
use Pod::Elemental::Transformer::Pod5;
use Pod::Elemental::Transformer::SynMux;
use Pod::Elemental::Transformer::Codebox;
use Pod::Elemental::Transformer::PPIHTML;
use Pod::Elemental::Transformer::VimHTML;
use Pod::Elemental::Transformer::List;
use Pod::Simple::XHTML 3.13;

use namespace::autoclean;


has date => (is => 'ro', isa => 'DateTime', required => 1);
has [ qw(author title topic body) ] => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);


sub author_email {
  my ($self) = @_;
  my ($addr) = Email::Address->parse($self->author);
  return($addr
        ? $addr->address
        : md5_hex($self->author) . q{@advcal.example.com});
}


sub author_name {
  my ($self) = @_;
  my ($addr) = Email::Address->parse($self->author);
  return($addr ? $addr->name : $self->author);
}



has calendar => (
  is  => 'ro',
  isa => 'WWW::AdventCalendar',
  required => 1,
  weak_ref => 1,
);


has body_html => (
  is   => 'ro',
  lazy => 1,
  init_arg => undef,
  builder  => '_build_body_html',
);

sub _build_body_html {
  my ($self) = @_;

  my $body = $self->body;

  $body = "\n=encoding utf-8\n\n$body" unless $body =~ /^=encoding/s;

  my $document = Pod::Elemental->read_string($body);

  Pod::Elemental::Transformer::Pod5->new->transform_node($document);
  Pod::Elemental::Transformer::List->new->transform_node($document);

  my $mux = Pod::Elemental::Transformer::SynMux->new({
    transformers => [
      Pod::Elemental::Transformer::Codebox->new,
      Pod::Elemental::Transformer::PPIHTML->new,
      Pod::Elemental::Transformer::VimHTML->new,
    ],
  });

  $mux->transform_node($document);

  $body = $document->as_pod_string;

  my $parser = Pod::Simple::XHTML->new;
  $parser->perldoc_url_prefix('https://metacpan.org/module/');
  $parser->output_string(\my $html);
  $parser->html_h_level(2);
  $parser->html_header('');
  $parser->html_footer('');

  $parser->parse_string_document( Encode::encode('utf-8', $body) );

  $html = "<div class='pod'>$html</div>";

  $html =~ s{
    \s*(<pre>)\s*
    (<table\sclass='code-listing'>.+?
    \s*</table>)\s*(?:<!--\shack\s-->)?\s*(</pre>)\s*
  }{my $str = $2; $str =~ s/\G^\s\s[^\$]*$//gm; $str}gesmx;

  return $html;
}

sub atom_id {
  my ($self) = @_;

  return $self->calendar->uri . $self->date->ymd . '.html';
}

1;

__END__
=pod

=head1 NAME

WWW::AdventCalendar::Article - one article in an advent calendar

=head1 VERSION

version 1.106

=head1 DESCRIPTION

Objects of this class represent a single article in a L<WWW::AdventCalendar>.
They have a very limited set of attributes.  The primary task of this class is
the production of an HTML version of the article's body.

=head1 ATTRIBUTES

=head2 date

This is the date (a DateTime object) on which the article is to be published.

=head2 title

This is the title of the article.

=head2 topic

This is the topic of the article.  This attribute is required, for now, but may
become optional in the future.

=head2 author

This is the author of the article.  This attribute is required.  It should be
given in mailbox format:

  John Smith <jsmith@example.com>

=head2 body

This is the body of the document, as a string.  It is expected to be Pod.

=head2 calendar

This is the WWW::AdventCalendar object in which the article is found.

=head2 body_html

This is the body represented as HTML.  It is generated as required by a private
builder method.

=head1 METHODS

=head2 author_email

This returns the email portion of the author.  If none is present, it returns
an email-like string unique to the author's name.

=head2 author_name

This returns the name portion of the author.  If the author value doesn't
appear to be a mailbox string, the whole value is returned.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

