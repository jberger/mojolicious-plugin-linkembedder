package Mojolicious::Plugin::LinkEmbedder::Link::Image::Imgur;

=head1 NAME

Mojolicious::Plugin::LinkEmbedder::Link::Image::Imgur - imgur.com image

=head1 DESCRIPTION

This class inherits from L<Mojolicious::Plugin::LinkEmbedder::Link::FromMetaTag>.

=cut

use Mojo::Base 'Mojolicious::Plugin::LinkEmbedder::Link::FromMetaTag';

use Mojo::URL;
use Mojo::IOLoop;

=head1 ATTRIBUTES

=head2 media_id

Extracts the media_id from the url directly

=cut

has media_id => sub { shift->url->path->[0] };

=head1 AUTHOR

Joel Berger - C<jberger@cpan.org>

=cut

1;
