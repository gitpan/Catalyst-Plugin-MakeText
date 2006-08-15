package Catalyst::Plugin::MakeText;

use strict;
use warnings;
use FindBin;
use Locale::Maketext::Simple(
    Export => "_loc", 
    Path   => "$FindBin::Bin/../I18N"
);

our $VERSION = '0.04';

=head1 NAME

Catalyst::Plugin::MakeText - Internationalization Plugin for Catalyst

=head1 SYNOPSIS

  use Catalyst qw/MakeText/

  sub hoge {
      my ($self, $c) = @_;
      $c->languages( ['en'] );
      $c->stash->{'body_title'} = $c->localize( 'Register' );
  }

=head1 DESCRIPTION

It works Locale::Maketext::Simple wrapper.

At least, please prepare MyApp/I18N/some.po or MyApp/I18N/some.mo.

By the way, because the language resource file is loaded at the Catalyst 
is started, it is necessary to restart the server to reflect the 
change in the resource. 

MyApp/I18N/en.po example

    # Comment
    msgid "Register"
    msgstr "Register"

    msgid "Next"
    msgstr "Next"

making MyApp/I18N/en.mo

    msgfmt en.po -o en.mo

=head1 METHODS

=head2 languages($c, $locale_array_ref)

set language locale.

=cut

sub languages {
    my ( $c, $locale_array_ref ) = @_;
    if ( defined $locale_array_ref ) {
        my $locale = $locale_array_ref->[0];
        if ($c->can('session')) {
            $c->session->{'Catalyst::Plugin::MakeText'}->{'locale'} = $locale;
        } else {
            $c->stash->{'Catalyst::Plugin::MakeText'}->{'locale'} = $locale;
        }
    } else {
        if ( $c->can('session') ) {
            return $c->session->{'Catalyst::Plugin::MakeText'}->{'locale'};
        } else {
            return $c->stash->{'Catalyst::Plugin::MakeText'}->{'locale'};
        }
    }
}

=head2 loc($c, $message)

=head2 localize($c, $message)

get localized text.

=cut

sub loc {
    return &localize(@_);
}

sub localize {
    my ( $c, $message ) = @_;
    if ($c->can('session')) {
        &_loc_lang($c->session->{'Catalyst::Plugin::MakeText'}->{'locale'});
    } else {
        &_loc_lang($c->stash->{'Catalyst::Plugin::MakeText'}->{'locale'});
    }
    return &_loc($message);
}

=head1 SEE ALSO

Locale::Maketext::Simple

=head1 AUTHOR

Jun Shimizu, E<lt>bayside@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Jun Shimizu.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;
