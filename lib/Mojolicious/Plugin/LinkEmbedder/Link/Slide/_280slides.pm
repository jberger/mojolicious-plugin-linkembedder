package Mojolicious::Plugin::LinkEmbedder::Link::Slide::_280slides;

=head1 NAME

Mojolicious::Plugin::LinkEmbedder::Link::Slide::_280slides - 280slides.com link

=head1 DESCRIPTION

This class inherit from L<Mojolicious::Plugin::LinkEmbedder::Link::Slide>.

=cut

use Mojo::Base 'Mojolicious::Plugin::LinkEmbedder::Link::Slide';

=head1 ATTRIBUTES

=head2 media_id

Returns the "name" query param value from L</url>.

=cut

has media_id => sub { shift->url->query->param('name') || '' };

=head2 uid

Returns the "user" query param value from L</url>.

=cut

has uid => sub { shift->url->query->param('user') || '' };

=head1 METHODS

=head2 to_embed

Returns the HTML code for an iframe embedding this movie.

=cut

sub to_embed {
  my $self = shift;
  my $url = Mojo::URL->new('http://280slides.com/Viewer/');
  my %args = @_;

  $url->query({ name => $self->media_id, user => $self->uid });

  $args{width} ||= $self->DEFAULT_VIDEO_WIDTH;
  $args{height} ||= $self->DEFAULT_VIDEO_HEIGHT;

  qq(<iframe width="$args{width}" height="$args{height}" src="$url" style="border: 1px solid black; margin: 0; padding: 0;"></iframe>);
}

=head1 AUTHOR

Marcus Ramberg

=cut

1;
