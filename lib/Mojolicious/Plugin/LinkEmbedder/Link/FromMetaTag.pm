package Mojolicious::Plugin::LinkEmbedder::Link::FromMetaTag;

=head1 NAME

Mojolicious::Plugin::LinkEmbedder::Link::FromMetaTag - HTML links which may include meta information

=cut

use Mojo::Base 'Mojolicious::Plugin::LinkEmbedder::Link';

use Mojo::URL;
use Mojo::IOLoop;

=head1 ATTRIBUTES

=head2 dom

Mojo::DOM instance generated by retrieving the url

=cut

has 'dom';

=head2 og_image, og_title, og_type, og_url

Values extracted from the C<dom> via the L<Open Graph Protocol|http://ogp.me>.
C<og_url> is a L<Mojo::URL> instance if available.

=cut


has og_image => sub { shift->read_meta('og:image') };
has og_title => sub { shift->read_meta('og:title') };
has og_type  => sub { shift->read_meta('og:type')  };
has og_url   => sub { 
  my $url = shift->read_meta('og:url');
  $url ? Mojo::URL->new($url) : undef;
};

=head1 METHODS

=head2 image_link

Get a an image link from the data available.
Open Graph defines that all og data must have an image, therefore
even video links might be able to generate an image link.

=cut

sub image_link {
  my $self = shift;
  my $image = $self->og_image or return undef;
  my %args = @_;

  $args{alt} ||= $self->og_title;

  qq(<img src="$image" alt="$args{alt}">);
}

=head2 learn

  $self->learn($cb, @cb_args);

This method can be used to learn more information about the link. This class
has no idea what to learn, so it simply calls the callback (C<$cb>) with
C<@cb_args>.

=cut

sub learn {
  my ($self, $cb, @cb_args) = @_;
  my $ua = $self->{ua};
  my $delay = Mojo::IOLoop->delay(
    sub {
      my $delay = shift;
      $ua->get($self->url, $delay->begin);
    },
    sub {
      my ($delay, $tx) = @_;
      my $dom = $tx->res->dom;
      $self->dom( $dom ) if $dom;
      $cb->(@cb_args);
    },
  );
  $delay->wait unless $delay->ioloop->is_running;
}

=head2 pretty_url

Returns a pretty version of the L</url>. The default is to return a cloned
version of L</url>.

=cut

sub pretty_url { 
  my $self = shift;
  ($self->og_url || $self->url)->clone;
}

=head2 read_meta

  my $title = $link->read_meta('og:title');

Extract a meta property by name from the C<dom>.

=cut

sub read_meta { 
  my ($self, $prop) = @_;
  my $dom = $self->dom or return undef;
  ($dom->at("meta[property=$prop]") || {})->{content};
}

=head2 to_embed

Return a best available embedding link.

=cut

sub to_embed {
  my $self = shift;
  # handle video and music types
  $self->image_link || $self->SUPER::to_embed;
}

1;


