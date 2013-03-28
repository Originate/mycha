all:
	coffee -b -o . -c src/
	echo "#!/usr/bin/env node" > tmp
	cat mycha.bin.js >> tmp
	mv tmp mycha.bin.js
