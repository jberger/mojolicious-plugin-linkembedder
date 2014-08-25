package Mojolicious::Plugin::LinkEmbedder::Link::Meta::OpenGraphProtocol;

=head1 NAME

Mojolicious::Plugin::LinkEmbedder::Link::Meta::OpenGraphProtocol - A meta reader for the Open Graph Protocol

=head1 DESCRIPTION

Inherits from Mojolicious::Plugin::LinkEmbedder::Link::Meta

=cut

use Mojo::Base 'Mojolicious::Plugin::LinkEmbedder::Link::Meta';

=head1 ATTRIBUTES

=head2 image, title, type, url

Properties extracted from the C<dom> attribute via the Open Graph Protocol.
The C<url> attribute is an instance of L<Mojo::DOM> if it is available

=cut

has image => sub { shift->read_meta('og:image') };
has title => sub { shift->read_meta('og:title') };
has type  => sub { shift->read_meta('og:type')  };
has url   => sub { 
  my $url = shift->read_meta('og:url');
  $url ? Mojo::URL->new($url) : undef;
};

=head1 METHODS

=head2 handled

The Open Graph Protocol requires that the C<image>, C<title>, C<type> and C<url> properties are provided.
This method returns a true value of all of those can be retrieved from the C<dom> successfully.

=cut

sub handled {
  my $self = shift;
  return !! ($self->image && $self->title && $self->type && $self->url);
}

=head2 image_link

Get a an image link from the data available.
Open Graph defines that all og data must have an image, therefore
even video links should be able to generate an image link.

=cut

sub image_link {
  my $self = shift;
  my $image = $self->image or return undef;
  my %args = @_;

  $args{alt} ||= $self->title;

  qq(<img src="$image" alt="$args{alt}">);
}

=head2 pretty_url

Returns a clone of the C<url> attribute.

=cut

sub pretty_url { shift->url->clone }

=head2 to_embed

Returns a "best guess" at an embedding link.
Since all valid OG posting have an image link, this is the fallback.

=cut

sub to_embed { shift->image_link }

1;

