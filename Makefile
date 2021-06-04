SRC = src
DEST = $(SRC)/public

ifdef COMP
	COMP = compress
endif

clean:
	rm --recursive --dir $(DEST)/* || true

compress:
	[ ! -d $(DEST) ] && mkdir --parents $(DEST) || true
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
	[ ! -d $(DEST) ] && mkdir --parents $(DEST) || true
	chmod --changes u+rwx,g+rx $(SRC)/themes >> log/chmod.log
	hugo --source="$(SRC)"

deploy:
	hugo server --disableFastRender --source="$(SRC)"

.PHONY: clean build deploy
