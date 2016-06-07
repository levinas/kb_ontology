#! /usr/bin/env perl

use strict;
use Data::Dumper;
use JSON;

my $usage = "Usage: $0 mapped.genome.json >ontology.solr.json\n\n";

my $file = shift @ARGV or die $usage;

my $obj = from_json(`cat $file`);

my $new_obj;
for my $fea (@{$obj->{features}}) {
    my $id = $fea->{id};
    my $md5 = $fea->{md5};
    my $anno = $fea->{function};
    my ($ec) = $anno =~ /\(EC (.*?)\)/;
    my $go = $fea->{ontology}->{GO} or next;
    my @terms = map { my ($term,$name) = @$_; $name ? "$term $name" : $term } @$go;
    my $ent;
    $ent = { feature_id => $id,
             feature_type => 'CDS',
             protein_md5 => $md5,
             annotation => $anno,
             ontology => \@terms,
             ontology_evidence => [('IEA') x scalar@terms]
           };
    push @$new_obj, $ent;
}

print to_json($new_obj);
