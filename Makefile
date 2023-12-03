DIST=PicPuzzle (2023) (Crunchworks)

.PHONY: dist

default:
	make dist

clean:
	rm -f "${DIST}.zip"

dist:
	rm -f "dist/${DIST}.zip"
	gunzip -c "assets/empty.dsk.gz" > "${DIST}.dsk"
	openmsx -machine msx2 -script install.tcl
	zip -m -9 "dist/${DIST}.zip" "${DIST}.dsk"

