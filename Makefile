BAKE_CONF := bakeconf-sdn.xml

BAKE_HOME := $(shell pwd)/bake
BAKE_BIN := $(BAKE_HOME)/bake.py
export PATH := bin:$(PATH)
export PYTHONPATH := $(PYTHON_PATH):$(BAKE_HOME)
export BAKE_HOME


all: libfluid dce

dce:
	$(BAKE_BIN) configure -c $(BAKE_CONF) -e dce-sdn-1.7
	$(BAKE_BIN) download
	$(BAKE_BIN) build -vvv

libfluid:
	$(BAKE_BIN) configure -c $(BAKE_CONF) -e libfluid
	$(BAKE_BIN) download
	sudo -E $(BAKE_BIN) build -vvv
	rmdir build
	sudo rm bakefile.xml bakeSetEnv.sh
