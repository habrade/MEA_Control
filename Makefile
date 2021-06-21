.PHONY : default
.PHONY : setup build project vivado clean
.PHONY : artifacts artifacts_bitfile artifacts_logs

DESIGN = MEA_Control
ART_DIR = build/artifacts
VIV_DIR = build/$(DESIGN)_0/$(DESIGN)-vivado
VIV_RUNDIR = $(VIV_DIR)/$(DESIGN)_0.runs
FILE_NAME = $(DESIGN)_$(DATE_STAMP)_$(GIT_BRANCH)_$(GIT_COMMIT)

default :
	@echo "No default action defined, use one of"
	@echo "  setup       create all fusesoc generated files"
	@echo "  build       run Vivado to build bitfile (includes setup)"
	@echo "  project     create Vivado project (after setup)"
	@echo "  vivado      start Vivado GUI session (after setup or build)"
	@echo "  artifacts   collects artifacts for gitlab-ci (after build)"
	@echo "  clean       remove all generated files"
#
# setup: run fusesoc
#
setup :
	fusesoc --monochrome --cores-root . run --no-export --setup \
		--target $(DESIGN) ::$(DESIGN)
#
# build: run fusesoc and Vivado to generate bitfile
#
build : 
	fusesoc --monochrome --cores-root . run --no-export --setup --build \
		--target $(DESIGN) ::$(DESIGN)
#
# project: create Vivado project
#
project :
	make -C $(VIV_DIR) $(DESIGN)_0.xpr
#
# vivado: run fusesoc and start Vivado GUI session
#
vivado :
	make -C $(VIV_DIR) build-gui
#
# clean: remove all build dirs
#
clean :
	rm -rf build
#
# artifacts: collect all artifacts
#
DATE_STAMP = $(shell date "+%F")
ifneq ($(CI),)
  GIT_BRANCH = $(CI_COMMIT_REF_NAME)
  GIT_COMMIT = $(CI_COMMIT_SHORT_SHA)
else
  GIT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
  GIT_COMMIT = $(shell git describe --always --abbrev=8)
endif
#
artifacts : artifacts_bitfile artifacts_logs

artifacts_bitfile :
	@mkdir -p build/artifacts
	if [ -f $(VIV_DIR)/$(DESIGN)_0.bit ]; then \
	  cp -p $(VIV_DIR)/$(DESIGN)_0.bit $(ART_DIR)/$(FILE_NAME).bit; \
	  gzip -f $(ART_DIR)/$(FILE_NAME).bit; \
	fi

artifacts_logs :
	@mkdir -p build/artifacts
	(cd $(VIV_RUNDIR); find -name "*.log" -or -name "*.rpt" | \
	  grep -v "job.id.log" | \
	  tar -T - -czf $(FILE_NAME)_logs.tgz)
	mv $(VIV_RUNDIR)/$(FILE_NAME)_logs.tgz $(ART_DIR)
