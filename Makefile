SRC = src
DEST = $(SRC)/public

ifdef COMP
	COMP = compress
endif

clean:
	rm --recursive --dir $(DEST)/* || true

compress:
	chmod --changes -rwx $(SRC)/themes >> log/chmod.log
	gzip --recursive --verbose --keep $(DEST)/*/*.css || true
	gzip --recursive --verbose --keep $(DEST)/*.css || true
	gzip --recursive --verbose --keep $(DEST)/*/*.html || true
	gzip --recursive --verbose --keep $(DEST)/*.html || true
	gzip --recursive --verbose --keep $(DEST)/*/*.js || true
	gzip --recursive --verbose --keep $(DEST)/*.js || true
	gzip --recursive --verbose --keep $(DEST)/*/*.json || true
	gzip --recursive --verbose --keep $(DEST)/*.json || true
	gzip --recursive --verbose --keep $(DEST)/*/*.svg || true
	gzip --recursive --verbose --keep $(DEST)/*.svg || true
	chmod --changes u+rwx,g+rx $(SRC)/themes >> log/chmod.log

build: clean $(COMP)
	chmod --changes u+rwx,g+rx $(SRC)/themes >> log/chmod.log
	hugo --buildDrafts --logFile=log/hugo_build.log --source="$(SRC)"

deploy:
	hugo server --minify --disableFastRender --source="$(SRC)"

.PHONY: clean build deploy
