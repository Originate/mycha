all:
	coffee -b -o lib -c src/
	echo "#!/usr/bin/env node" > tmp
	cat lib/mycha.bin.js >> tmp
	mv tmp lib/mycha.bin.js
