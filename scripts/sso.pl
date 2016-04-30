#! /usr/bin/env perl

# Creates the initial SEED Subsystem Ontology OBO file from the list
# of functional roles in CoreSEED subsystems.

use strict;
use Data::Dumper;
use Time::Piece;

# Input file 1: new version of list of functional roles
# Input file 2: optional 2-column table of existing [SSO, role] assignments
# Output: updated [SSO, role] mapping

my $usage = "Usage: $0 new.roles [old.sso.role] > new.sso.role\n\n";

my $new_file = shift @ARGV or die $usage;
my $old_file = shift @ARGV;

my @lines = `cat $old_file` if $old_file;
my %ssoH  = map { chomp; my ($sso, $role) = split /\t/; $sso => $role } @lines;
my %roleH = map { chomp; my ($sso, $role) = split /\t/; $role => $sso } @lines;
my @new_roles = sort map { chomp; s/^\s+//; s/\s+$//; $_ } `cat $new_file`;

for my $role (@new_roles) {
    $role =~ s/ , /, /;
    next if black_listed($role);
    next if $roleH{$role};
    my $sso = new_sso();
    $roleH{$role} = $sso;
    $ssoH{$sso} = $role;
}

print_sso_role_table(\%ssoH);
make_obo_file(\%ssoH, 'sso.obo', '0.1');

sub make_obo_file {
    my ($ssoH, $fname, $version) = @_;
    my $date = localtime->strftime('%Y-%m-%d');
    open(F, ">$fname") or die "Could not open $fname";
    print F "format-version: $version\n";
    print F "data-version: releases/$date\n";
    print F "default-namespace: seed_subsystem_ontology\n";
    print F "ontology: sso\n";
    for my $sso (sort keys %$ssoH) {
        print F "\n[Term]\n";
        print F "id: $sso\n";
        print F "name: $ssoH->{$sso}\n";
    }
    close(F);
}

sub print_sso_role_table {
    my ($ssoH) = @_;
    for my $sso (sort keys %$ssoH) {
        print join("\t", $sso, $ssoH->{$sso}) . "\n";
    }
}

my $global_role_index;
sub new_sso {
    $global_role_index ||= max_role_index();
    my $sso = sprintf("SSO:%09d", ++$global_role_index);
    return $sso;
}

sub max_role_index {
    my @ssos = sort keys %ssoH;
    return 0 unless @ssos;
    my ($index) = $ssos[-1] =~ /(\d+)/;
    return $index;
}

sub black_listed {
    my ($role) = @_;
    return 1 if $role =~ /(FIG|FIGfam)\d+:/;
    return 1 if $role =~ /^None$/i;
    return 1 if $role =~ /^uncharacterized domain$/i;
    return 0;
}
