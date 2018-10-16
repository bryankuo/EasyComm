# Makefile for Tatung upgrade to CentOS7 project
LANG=en

include ./dir.mk

export FSMAC=$(FSWITCH_MAC)

SUBDIRS = $(CGIDIR) \
	$(PROV_SRCDIR) \
	$(RFID_SRCDIR)

	 # $(WMDIR) \
	 # $(JANDIR) \
	 # $(TCLKTRDIR)

.PHONY: nwatchmand

# HIERARCHY?
# TOPOLOGY = STANDALONE
# TOPOLOGY = PAIR
TOPOLOGY = "\"STANDALONE\""
# to be obseleted

subdirs:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

rfid-base:
	$(MAKE)	-C $(RFID_SRCDIR) libapiRfidDatabase.a

cgi-base:
	$(MAKE)	-C $(CGIDIR) libapiAdmDatabase.a
	$(MAKE)	-C $(CGIDIR) libapiSystem.a

provision-base:
	$(MAKE)	-C $(PROV_SRCDIR) libapiProvisioningDatabase.a

# fs libesl rfid nwatchmand:release-depend provision-install
cgi: rfid-base provision-base nwatchmand cgi-base
	$(MAKE)	-C $(CGIDIR)

cgi-install: provision-install cgi
	$(MAKE)	-C $(CGIDIR) install
	@# be awared miss overwritten to i386 machine
	@#$(MAKE)	-C $(CGIDIR) remote-install

cgi-clean:
	$(MAKE)	-C $(CGIDIR) clean
	$(MAKE)	-C $(CGIDIR) depend-clean
	$(MAKE)	-C $(CGIDIR) depend

cgi-test:
	$(MAKE)	-C $(CGIDIR) test

phonechecker: cgi
	$(MAKE)	-C $(CGIDIR) cgiPhoneChecker

phonechecker-install:
	$(MAKE)	-C $(CGIDIR) cgiPhoneChecker-install

phonechecker-clean:
	$(MAKE)	-C $(CGIDIR) cgiPhoneChecker-clean

# cgi provision
rfid: rfid-base nwatchmand-install
	@#$(MAKE)	-C $(RFID_SRCDIR) depend
	$(MAKE)	-C $(RFID_SRCDIR)

rfid-install: rfid
	$(MAKE)	-C $(RFID_SRCDIR) install
	$(MAKE)	-C $(RFID_SRCDIR) remote-install

rfid-clean:
	$(MAKE)	-C $(RFID_SRCDIR) clean
	$(MAKE)	-C $(RFID_SRCDIR) depend-clean

provision: cgi-base provision-base
	@#$(MAKE)	-C $(PROV_SRCDIR) depend
	$(MAKE)	-C $(PROV_SRCDIR)

provision-clean:
	$(MAKE)	-C $(PROV_SRCDIR) clean
	$(MAKE)	-C $(PROV_SRCDIR) depend-clean

provision-install: provision
	$(MAKE)	-C $(PROV_SRCDIR) install
	$(MAKE)	-C $(PROV_SRCDIR) remote-install

# libmodbus
nwatchmand: cgi-base provision-base provision
	$(MAKE)	-C $(WMAN_SRCDIR) depend-clean
	$(MAKE)	-C $(WMAN_SRCDIR) depend
	$(MAKE)	-C $(WMAN_SRCDIR)

nwatchmand-clean:
	$(MAKE)	-C $(WMAN_SRCDIR) clean

nwatchmand-install: cgi-install nwatchmand
	$(MAKE)	-C $(WMAN_SRCDIR) install
	$(MAKE)	-C $(WMAN_SRCDIR) remote-install
	$(MAKE)	-C $(WMAN_SRCDIR) release-depend-clean
	@echo "build mbapi..."
	$(MAKE) -C $(WMAN_SRCDIR) mbapi
	$(MAKE)	-C $(WMAN_SRCDIR) release-depend
	@#//TODO: refine
	@echo "build release..."
	$(MAKE)	-C $(WMAN_SRCDIR) release

nwatchmand-test:
	$(MAKE)	-C $(WMAN_SRCDIR) test

modbus-tool:
	$(MAKE)	-C $(MODBUS_TOOL_SRCDIR)

modbus-tool-clean:
	$(MAKE)	-C $(MODBUS_TOOL_SRCDIR) clean

stagecoachd:
	$(MAKE)	-C $(SCOACH_SRCDIR)

stagecoachd-clean:
	$(MAKE)	-C $(SCOACH_SRCDIR) clean
	$(MAKE)	-C $(SCOACH_SRCDIR) depend-clean
	$(MAKE)	-C $(SCOACH_SRCDIR) depend

stagecoachd-install:
	$(MAKE)	-C $(SCOACH_SRCDIR) install
	$(MAKE)	-C $(SCOACH_SRCDIR) remote-install

janitord:
	$(MAKE)	-C $(JAN_SRCDIR) all

janitord-install: provision-base
	$(MAKE)	-C $(JAN_SRCDIR) all
	$(MAKE)	-C $(JAN_SRCDIR) install
	$(MAKE)	-C $(JAN_SRCDIR) remote-install

janitord-clean:
	$(MAKE)	-C $(JAN_SRCDIR) clean
	$(MAKE)	-C $(JAN_SRCDIR) depend-clean
	$(MAKE)	-C $(JAN_SRCDIR) depend

tktCollectord-clean:
	$(MAKE)	-C $(TCLKTR_SRCDIR) clean

tktCollectord: tktCollectord-clean
	$(MAKE)	-C $(TCLKTR_SRCDIR) depend
	$(MAKE)	-C $(TCLKTR_SRCDIR)

tktCollectord-install: cgi-install tktCollectord
	$(MAKE)	-C $(TCLKTR_SRCDIR) install
	$(MAKE)	-C $(TCLKTR_SRCDIR) remote-install

fs:
	$(MAKE)	-C $(FSDIR) all

fs-install: fs
	$(MAKE)	-C $(FSDIR) install mod_install
	#@sounds-install moh-install
	#@simply binary install using scp, including esl

# POC test
fs-remote-update:
	ssh -t tt-ippbx "sudo pcs resource disable ippbxPBX" && \
	sleep 5
	scp $(PXRUN_PATH)/$(FS) apexx@tt-ippbx:$(PXRUN_PATH)/$(FS)
	ssh -t tt-ippbx "sudo pcs resource enable ippbxPBX"

fs-clean:
	$(MAKE)	-C $(FSDIR) clean modwipe

esl-install: fs
	$(MAKE)	-C $(FSDIR)/libs/esl clean
	$(MAKE)	-C $(FSDIR)/libs/esl
	$(MAKE)	-C $(FSDIR)/libs/esl install

binary:
	@echo "make a snapshot for binary deployment"
	sudo tar -vcjf IPPBX_binary_`date +%Y%m%d%H%M%S`.tar.bz2 ./$(PXDIR)/ ./$(WEB)/
	# // TODO: test adding h option

#//TODO:  (nodes x directories)
scripts-install:
# ippbx
# @# scp ./ippbx_run/bin/delete_caller_csv.sh apexx@tt-ha:/home/apexx/ippbx_run/bin/delete_caller_csv.sh
#  0  6  *  *  * sudo /usr/sbin/ntpdate -s clock.stdtime.gov.tw
# 10  3  *  *  * sudo /usr/bin/tmpwatch -am 24 /tmp
#  0  1  *  *  * /home/apexx/ippbx_run/bin/janitord

# ha
# scp ippbx-[acd]u.sh root@tt-ha1:/usr/local/bin/
# sudo chmod 700 ippbx-[acd]u.sh

ticket:
	$(MAKE)	-C $(TIKTDIR)

ticket-install:
	$(MAKE)	-C $(TIKTDIR) install

ticket-clean:
	$(MAKE)	-C $(TIKTDIR) clean

TAGS:
	@echo "generating ctags..."
	ctags -R --fields=+Stima --extra=+q --recurse=yes --languages=java, \
		--tag-relative=yes --verbose=yes --totals=yes \
	./app/src/

TAGS-clean:
	@echo "clean ctags..."
	rm -f tags

# // TODO: ref. fs Makefile
dox:
	#cd docs && doxygen $(PWD)/docs/Doxygen.conf

#	for dir in $(SUBDIRS); do \
#		$(MAKE) -C $$dir clean; \
#	done
# #fs-clean

clean: TAGS-clean \
	janitord-clean \
	tktCollectord-clean \
	rfid-clean \
	nwatchmand-clean \
	provision-clean \
	phonechecker-clean \
	stagecoachd-clean \
	cgi-clean \
	modbus-tool-clean
	echo "clean"
	@# fs-clean
	@# SIPp-clean

install:

remote-install:

test-all:
	$(MAKE)	-C $(TESTDIR) all


# subdirs
all: cgi provision-install nwatchmand-install rfid
	@echo date "Done!"

all-install:
