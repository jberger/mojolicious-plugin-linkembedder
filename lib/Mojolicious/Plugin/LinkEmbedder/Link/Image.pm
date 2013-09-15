package Mojolicious::Plugin::LinkEmbedder::Link::Image;

=head1 NAME

Mojolicious::Plugin::LinkEmbedder::Link::Image - Image URL

=head1 DESCRIPTION

This class inherit from L<Mojolicious::Plugin::LinkEmbedder::Base>.

=cut

use Mojo::Base 'Mojolicious::Plugin::LinkEmbedder::Link';

=head1 METHODS

=head2 to_embed

Returns an img tag.

=cut

sub to_embed {
  my $self = shift;
  my $url = $self->url;
  my %args = @_;

  $args{alt} ||= $url->to_string;

  qq(<img src="$url" alt="$args{alt}">);
}

=head1 AUTHOR

Jan Henning Thorsen - C<jhthorsen@cpan.org>

=cut

1;
