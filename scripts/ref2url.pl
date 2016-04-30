#! /usr/bin/env perl

use strict;

my $usage = "Usage: $0 xref (e.g., PMID:10873824)\n\n";

test();

my $ref = shift @ARGV or die $usage;
get_url($ref);

sub get_url {
    my ($ref) = @_;
    my %hash = get_ref2url_hash();
    if ($ref =~ /(\S+?):(\S+)/) {
        eval "print \"$hash{$1}\n\"";
    }
}

sub test {
    my @refs = qw( EC:2.4.1.-
                   PMID:10873824
                   GOC:mcc
                   Wikipedia:Reproduction
                   Reactome:REACT_22383
                 );

    get_url($_) for @refs;
}

sub get_ref2url_hash {
    my %hash = (

                EC        => 'http://enzyme.expasy.org/EC/$2',
                GOC       => 'http://www.geneontology.org/doc/GO.curator_dbxrefs',
                PMID      => 'http://www.ncbi.nlm.nih.gov/pubmed/$2',
                Reactome  => 'http://www.reactome.org/content/query?q=$2',
                Wikipedia => 'https://en.wikipedia.org/wiki/$2',

               );

    wantarray ? %hash : \%hash;
}
