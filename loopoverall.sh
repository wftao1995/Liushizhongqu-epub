#!/bin/bash
process() {
	if [ -d $1 ]
	then
		cd $1
		echo $1
		ebook-convert main.html main.epub --epub-version 2 --pretty-print --epub-inline-toc --extra-css ../layer.css
		mv main.epub "${1}.epub"
		scname=`echo $1 | opencc -c t2s.json`
		echo $scname
		opencc -i main.html -c t2s.json -o main_sc.html
		ebook-convert main_sc.html main.epub --epub-version 2 --pretty-print --epub-inline-toc --extra-css ../layersc.css
		mv main.epub "${scname}.epub"
		#rm main_sc.html
	fi
}
export -f process
ls . | parallel process
