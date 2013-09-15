package Mojolicious::Plugin::LinkEmbedder::Link::Image::Break;

=head1 NAME

Mojolicious::Plugin::LinkEmbedder::Link::Image::Break - break.com link

=head1 DESCRIPTION

This class inherit from L<Mojolicious::Plugin::LinkEmbedder::Link>.

=cut

use Mojo::Base 'Mojolicious::Plugin::LinkEmbedder::Link';

=head1 ATTRIBUTES

=head2 media_id

Returns the "v" query param value from L</url>.

=cut

has media_id => sub {
    # I think this require async
};

=head1 METHODS

=head2 to_embed

Returns an img tag.

=cut

sub to_embed {
  my $self = shift;
  my $url = $self->url;
  my %args = @_;

  qq(<object width="425" height="350"><param name="movie" value="http://embed.break.com/[%item.media_id%]"></param><embed src="http://embed.break.com/[%item.media_id%]" type="application/x-shockwave-flash" width="425" height="350"></embed></object>);
}


=head1 AUTHOR

Jan Henning Thorsen - C<jhthorsen@cpan.org>

=cut

1;
