all ::
	-mkdir js
	-mkdir wkt
	./0-ttf2svg.pe > Kai.svg
	./1-svg2js.pl < Kai.svg
	ls js | xargs -P 32 -n 1 -- ./2-svg2wkt.pl
	./3-wkt2gis.pl > Kai.sql
