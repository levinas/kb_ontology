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
        printf "%-23s => ", $ref;
        eval "print \"$hash{$1}\n\"";
    }
}

sub test {
    my @refs = qw( EC:2.4.1.-
                   PMID:10873824
                   GOC:mcc
                   Wikipedia:Reproduction
                   Reactome:REACT_22383
                   KEGG:R05612
                   RHEA:20839
                   MetaCyc:LACTASE-RXN
                   UM-BBD_reactionID:r1027
                   UM-BBD_enzymeID:e0078
                   UM-BBD_pathwayID:met
                   RESID:AA0210
                   PO_GIT:538
                   TO_GIT:58
                   GC_ID:1
                 );

    get_url($_) for @refs;
    exit;
}

sub get_ref2url_hash {
    my %hash = (
                EC                  => 'http://enzyme.expasy.org/EC/$2',
                GC_ID               => 'http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi#SG$2',
                GOC                 => 'http://www.geneontology.org/doc/GO.curator_dbxrefs',
                KEGG                => 'http://www.genome.jp/dbget-bin/www_bget?rn:$2',
                MetaCyc             => 'http://biocyc.org/META/NEW-IMAGE?type=NIL&object=$2',
                PMID                => 'http://www.ncbi.nlm.nih.gov/pubmed/$2',
                PO_GIT              => 'https://github.com/Planteome/plant-ontology/issues/$2',
                Reactome            => 'http://www.reactome.org/content/query?q=$2',
                RESID               => 'http://pir.georgetown.edu/cgi-bin/resid?id=$2',
                RHEA                => 'http://www.rhea-db.org/reaction?id=$2',
                TO_GIT              => 'https://github.com/Planteome/plant-trait-ontology/issues/$2',
                'UM-BBD_reactionID' => 'http://eawag-bbd.ethz.ch/servlets/pageservlet?ptype=r&reacID=$2',
                'UM-BBD_enzymeID'   => 'http://eawag-bbd.ethz.ch/servlets/pageservlet?ptype=ep&enzymeID=$2',
                'UM-BBD_pathwayID'  => 'http://eawag-bbd.ethz.ch/$2/$2\_map.html',
                Wikipedia           => 'https://en.wikipedia.org/wiki/$2',
               );

    wantarray ? %hash : \%hash;
}
