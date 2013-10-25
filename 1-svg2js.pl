#!/usr/bin/env perl
use strict;
local $/ = '&#x';
<>;
while (<>) {
    s!/>\s*.*!!;
    s/;"\s+/";var /;
    s/\n/\\n/g;
    m/([^"]+)/ or die;
    open FH, '>', "js/$1.js";
    select FH;
print << '.';
var casper = require('casper').create();
casper.start('2-svg2wkt.html')
.
    print << ".";
.then(function() {console.log(this.evaluate(function(){
var c = "$_;
return c + ' ' + window.SVGtoWKT.convert('<svg><path d="' + d + '"></path></svg>');
}));})
.
print << '.';
;casper.run();
.
close FH;
}
