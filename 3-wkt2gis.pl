#!/usr/bin/env perl
use strict;
print << '.';
DELETE FROM geom;
INSERT INTO geom VALUES (
ST_MakeValid(ST_Simplify(ST_Translate(st_scale(
ST_GeomFromText('MULTIPOLYGON((
.
while (<>) {
    s/GEOMETRYCOLLECTION\(POLYGON\(//;
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
