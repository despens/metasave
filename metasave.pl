#!/usr/bin/perl

use 5.10.0;
use strict;
use utf8;
use File::Find;
use String::ShellQuote;

sub handler {
    my $filename = shell_quote($_);
    my $metadata = qx/gvfs-info -a metadata::* $filename/ or die "$filename: $!\n";
    my @lines = split(/\n  /s, $metadata);
    for my $line (@lines) {
        my ($attribute, $value) = $line =~ m/^\s*(\S+): (.+)$/s;
        if($attribute and $value) {
            # is there an array in the value?
            if($value =~ m/^\[.+\]$/s) {
                $value =~ s/^\[(.+)\]$/$1/gs;
                my @values = split(/[\[\],\s]+/s, $value);
                map shell_quote, @values;
                my $stringv = join(' ', @values);

                say "gvfs-set-attribute $filename -t stringv $attribute $stringv ;";
            }
            else {
                if($value ne '[]') {
                    $value = shell_quote($value);
                    say "gvfs-set-attribute $filename $attribute $value ;";
                }
            }
        }
    }
}

say "#!/bin/sh";

find({wanted => \&handler, follow => 0, no_chdir => 1}, '.');