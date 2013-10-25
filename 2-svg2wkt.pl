#!/usr/bin/perl
use strict;
$_ = $ARGV[0];
exec("casperjs js/$_ > wkt/$_.wkt");
