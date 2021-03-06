BAKE_CONF := bakeconf-sdn.xml

export BAKE_HOME := $(shell pwd)/bake
export PATH := bin:$(PATH)
export PYTHONPATH := $(PYTHON_PATH):$(BAKE_HOME)
BAKE_BIN := $(BAKE_HOME)/bake.py


all: libfluid dce
	echo "success!"

dce:
	$(BAKE_BIN) --debug configure -c $(BAKE_CONF) -e dce-sdn-1.7
	$(BAKE_BIN) download
	$(BAKE_BIN) build -vvv

libfluid:
	$(BAKE_BIN) configure -c $(BAKE_CONF) -e libfluid
	$(BAKE_BIN) download
	$(BAKE_BIN) build --sudo -vvv
	-sudo rmdir build
	-sudo rm bakefile.xml bakeSetEnv.sh

test:
	$(BAKE_BIN) check

clean:
	-rm -rf build
