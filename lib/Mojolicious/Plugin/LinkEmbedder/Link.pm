package Mojolicious::Plugin::LinkEmbedder::Link;

=head1 NAME

Mojolicious::Plugin::LinkEmbedder::Link - Base class for links

=cut

use Mojo::Base -base;
use Mojo::ByteStream;
use Mojo::Util;
use Mojolicious::Types;
use overload (
  q("") => sub { Mojo::ByteStream->new(shift->to_embed) },
  fallback => 1,
);

# this may change in future version
use constant DEFAULT_VIDEO_HEIGHT => 390;
use constant DEFAULT_VIDEO_WIDTH => 640;

=head1 ATTRIBUTES

=head2 media_id

Returns the part of the URL identifying the media. Default is empty string.

=cut

sub media_id { '' }

=head2 url

Holds a L<Mojo::URL> object.

=cut

sub url { shift->{url} }

has _types => sub {
  my $types = Mojolicious::Types->new;
  $types->type(mpg => 'video/mpeg');
  $types->type(mpeg => 'video/mpeg');
  $types->type(mov => 'video/quicktime');
  $types;
};

=head1 METHODS

=head2 is

  $bool = $self->is($str);
  $bool = $self->is('video');
  $bool = $self->is('video-youtube');

Convertes C<$str> using L<Mojo::Util/camelize> and checks if C<$self>
is of that type:

  $self->isa('Mojolicious::Plugin::LinkEmbedder::Link::' .Mojo::Util::camelize($_[1]));

=cut

sub is {
  $_[0]->isa(__PACKAGE__ .'::' .Mojo::Util::camelize($_[1]));
}

=head2 pretty_url

Returns a pretty version of the L</url>. The default is to return a cloned
version of L</url>.

=cut

sub pretty_url { shift->url->clone }

=head2 to_embed

Returns a link to the L</url>, with target "_blank".

=cut

sub to_embed {
  my $self = shift;
  my $url = $self->url;

  qq(<a href="$url" target="_blank">$url</a>);
}

=head1 AUTHOR

Jan Henning Thorsen - C<jan.henning@thorsen.pm>

=cut

1;
