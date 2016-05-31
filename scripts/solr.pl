#! /usr/bin/env perl

use strict;
use Data::Dumper;
use JSON;

my $usage = "Usage: $0 genome.original.json genome.go.json\n\n";

my $file1 = shift @ARGV or die $usage;
my $file2 = shift @ARGV or die $usage;

my $obj1 = from_json(slurp($file1));
my $obj2 = from_json(slurp($file2));

my $features1 = $obj1->{features};
my $features2 = $obj2->{features};

my %id2func;
for my $fea (@$features1) {
    my $id = $fea->{id};
    my $func = $fea->{function};
    next unless $id && $func;
    $id2func{$id} = $func;
}

my $new_obj;
for my $fea (@$features2) {
    my $id = $fea->{id};
    my $md5 = $fea->{md5};
    my $func = $fea->{function};
    my $anno = $id2func{$id};
    my ($ec) = $anno =~ /\(EC (.*?)\)/;
    next unless $func =~ 'GO:';
    my @terms = split(/ \/ /, $func);
    my $ent;
    $ent = { feature_id => $id,
             feature_type => 'CDS',
             protein_md5 => $md5,
             annotation => $anno,
             go => \@terms,
             go_evidence => 'IEA',
             ec => "EC:$ec"
           };
    push @$new_obj, $ent;
}

print to_json($new_obj);


=head2 slurp

A fast file reader:

     $data = slurp( )               #  \*STDIN
     $data = slurp( \*FILEHANDLE )  #  an open file handle
     $data = slurp(  $filename )    #  a file name
     $data = slurp( "<$filename" )  #  file with explicit direction

=head3 Note

It is faster to read lines by reading the file and splitting
than by reading the lines sequentially.  If space is not an
issue, this is the way to go.  If space is an issue, then lines
or records should be processed one-by-one (rather than loading
the whole input into a string or array).

=cut

sub slurp {
    my ( $fh, $close );
    if ( $_[0] && ref $_[0] eq 'GLOB' ) {
        $fh = shift;
    } elsif ( $_[0] && ! ref $_[0] ) {
        my $file = shift;
        if ( -f $file                       ) {
        } elsif (    $file =~ /^<(.*)$/ && -f $1 ) {
            $file = $1;
        }                       # Explicit read
        else {
            return undef;
        }
        open( $fh, '<', $file ) or return undef;
        $close = 1;
    } else {
        $fh = \*STDIN;
        $close = 0;
    }
    my $out = '';
    my $inc = 1048576;
    my $end =       0;
    my $read;
    while ( $read = read( $fh, $out, $inc, $end ) ) {
        $end += $read;
    }
    close( $fh ) if $close;
    $out;
}
