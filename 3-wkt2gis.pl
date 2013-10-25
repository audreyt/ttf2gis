#!/usr/bin/env perl
use strict;
binmode STDOUT, ':utf8';
print << '.';
CREATE TABLE IF NOT EXISTS ttf (ch text, g geometry);
CREATE INDEX ttf_ch ON ttf (ch);
DELETE FROM ttf;
.

for (<wkt/*>) {
    next unless -s $_;
    open FH, '<', $_;
    s!wkt/!!; s!\..*!!;
    my $ch = chr hex $_;
print << ".";
INSERT INTO ttf VALUES ('$ch', ST_MakeValid(ST_Simplify(ST_Translate(st_scale(
ST_GeomFromText('MULTIPOLYGON((
.
while (<FH>) {
    s/^\S+ GEOMETRYCOLLECTION\(POLYGON\(//;
    s/\)\)$//;
    s/(\d+\.\d+)/int($1+0.5)/eg;
    s/\),\(/\)\),\n\(\(/g;
    print;
}
print << '.';
))')
, 2.048, 2.048), 0, 1700), 4))
);
.
}
