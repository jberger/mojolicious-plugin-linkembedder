package Mojolicious::Plugin::LinkEmbedder::Link::Meta;

=head1 NAME

Mojolicious::Plugin::LinkEmbedder::Link::Meta - Base class for meta property readers

=cut

use Mojo::Base -base;

=head1 ATTRIBUTES

=head2 dom

An instance of L<Mojo::DOM> from which properties can be extracted.

=cut

has 'dom';

=head2 image, title, type, url

These are the properties that are expected to be available from most meta protocols.
It is actually the set of required properties for the Open Graph Protocol.
For this minimal base class, they all return C<undef>.

=cut

has [qw/image title type url/];

=head2 handled

Since this base class is also the fallback, handled returns a true value.

=cut

sub handled { 1 }

=head2 read_meta

  my $title = $link->read_meta('og:title');

Extract a meta property by name from the C<dom>.

=cut

sub read_meta { 
  my ($self, $prop) = @_;
  my $dom = $self->dom or return undef;
  ($dom->at("meta[property=$prop]") || {})->{content};
}

=head2 pretty_url

Subclasses should return a canonical url extracted via their meta protocol.
It should also be a L<Mojo::URL> instance if it exists.
This base class returns C<undef>.

=cut

sub pretty_url { undef }

=head2 to_embed

Subclasses should return an embedding representation of the target resource.
This base class returns C<undef>.

=cut

sub to_embed { undef }

1;

