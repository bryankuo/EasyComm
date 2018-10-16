# the definition of BASEDIR - Assume default logon directory
BASEDIR = /home/$(USER)
# while 131 has 2 development environment, DO NOT get confused.

# OS user
OSUSER = "\"$(USER)\""

# customers / clients
CUSTOMER = "\"TATUNG\""
#CUSTOMER = "\"TECHMATION\""

# products / systems / (hints for cluster config prefix)
#PRODUCT = "\"ippbx\""
#legacy compatible
#PRODUCT =
PRODUCT = "\"ha\""

# hardcoded name for Makefile
PROJDIR = ippbx

SYSNIC = "\"enp5s0\""
FSWITCH_MAC = "\"88:d7:f6:ae:ef:da\",\"88:d7:f6:ae:f3:b6\""
ESL_ADDR = "\"localhost\""
ESL_PORT = "8021"
ESL_CRED = "\"ClueCon\""
IPPBX_RA = "\"ippbxPBX\""
CLUSTERS = "tt-ha1" "tt-ha2" "tt-ippbx1" "tt-ippbx2"
HA_CLUSTERS = "tt-ha1" "tt-ha2"
POCKETS= "eins"
IPPBX_IPV4 = "\"10.10.13.202\""
HA_IPV4 = "\"10.10.13.205\""

# TOPOLOGY
# TOPOLOGY = "\"COMBO\""
# TOPOLOGY = "\"PAIR\""
# TOPOLOGY = "\"APCLUSTER\""
# //TODO: determine at runtime
ifeq ($(CUSTOMER), "\"TATUNG\"")
	TOPOLOGY = "\"APCLUSTER\""
else ifeq ($(CUSTOMER), "\"TECHMATION\"")
	TOPOLOGY := "\"COMBO\""
else
	TOPOLOGY = "\"COMBO\""
endif

#API versioning
MAJOR = 1
MINOR = 0
BUILD = $(shell date +"%Y%m%d.%H%M%S")
PRODUCT_VERSION = "\"$(MAJOR).$(MINOR).$(BUILD)\""

MAJOR = $(shell date +"%Y")
MINOR = $(shell date +"%m%d")
BUILD = $(shell date +"%H%M%S")
RELEASE_VERSION = "\"$(MAJOR).$(MINOR).$(BUILD)\""
NWATCHMAND_VERSION = "\"$(MAJOR).$(MINOR).$(BUILD)\""

# prerequites
LIBAV = /usr/include/libavcodec /usr/include/libavformat
DEPS = dependencies
# MYSQL_INC := $(shell mysql_config --cflags)
# MYSQL_LIBS := $(shell mysql_config --libs)

# DIR: ( relative path ) is used in topmost Makefile, for archiving.
# PATH: ( absolute path ) is used in each Makefile, for dependency.
FS = freeswitch
FSCORE_SRCDIR = $(BASEDIR)/$(PROJDIR)/$(DEPS)/$(FS)/src
FSMOD = $(BASEDIR)/$(PROJDIR)/$(DEPS)/$(FS)/src/mod
FSDIR = ./$(DEPS)/$(FS)
FS_PATH = $(BASEDIR)/$(PROJDIR)/$(DEPS)/$(FS)
MODAV = $(BASEDIR)/$(PROJDIR)/$(DEPS)/freeswitch/src/mod/applications/mod_av

# ippbx src path
# ippbx runtime root path
PX = freeswitch
PXDIR = ippbx_run
PX_PATH = $(BASEDIR)/$(PXDIR)
PXRUN_PATH = $(PX_PATH)/bin
IPPBX_ROOTDIR = "\"/home/$(USER)/$(PXDIR)\""
IPPBXROOT_PATH = "\"$(PX_PATH)\""

# system modules
CGI = cgi
CGITEST_PATH = ./cgi/tests
CGI_MODULE = $(CGI)
CGISRC_PATH = $(BASEDIR)/$(PROJDIR)/$(CGI)/src
CGIDIR  = ./$(CGI)/src
CGI_SRCDIR = ./$(CGI_MODULE)/src

# where cgi / httpd.conf binds
WEB = public_html
# local/server backup
WEBDIR = ./$(WEB)
# CGI output target
WEB_OUTDIR = $(WEB).x86_64
CGI_PATH = $(BASEDIR)/$(PROJDIR)/$(WEB_OUTDIR)/$(PROJDIR)/cgi-bin
# used within code by preprocessor definition
WEBROOT_PATH = "\"$(BASEDIR)/$(WEB)/$(PROJDIR)\""

# DIR: ( relative path ) is used in topmost Makefile, for archiving.
# PATH: ( absolute path ) is used in each Makefile, for dependency.
RFID = RfidDataServerd
RFIDDIR = ./$(RFID)
RFID_SRCDIR = ./$(RFID)/src
RFID_PATH = $(BASEDIR)/$(PROJDIR)/$(RFID)
RFIDSRC_PATH = $(RFID_PATH)/src
RFID_DCLIB_PATH = $(BASEDIR)/$(PROJDIR)/$(DEPS)/rfid_data_cloud_src/libRfidDataCloud

PROV = provision
PROVDIR = ./$(PROV)
PROV_SRCDIR = ./$(PROV)/src
PROV_PATH = $(BASEDIR)/$(PROJDIR)/$(PROV)
PROVSRC_PATH = $(BASEDIR)/$(PROJDIR)/$(PROV)/src

# whole subsystem
WMAN = nwatchmand
WMDIR = ./$(WMAN)
WMAN_SRCDIR = ./$(WMAN)/src
LIBMODBUS=libmodbus-3.1.4
LIBMODBUS_SRCDIR = $(BASEDIR)/$(PROJDIR)/$(DEPS)/$(LIBMODBUS)/src
LIBMBSRC_PATH = $(BASEDIR)/$(PROJDIR)/$(DEPS)/$(LIBMODBUS)/src
WMAN_PATH = $(BASEDIR)/$(PROJDIR)/$(WMAN)
WMANSRC_PATH = $(BASEDIR)/$(PROJDIR)/$(WMAN)/src
MODBUS_TOOL_SRCDIR = ./$(WMAN)/tests/libmodbus

SCOACH = stagecoachd
SCOACHDIR = ./$(SCOACH)
SCOACH_SRCDIR = ./$(SCOACH)/src
SCOACH_PATH = $(BASEDIR)/$(PROJDIR)/$(SCOACH)/src
SCOACH_RUNPATH = /usr/local/bin

JAN = janitord
JANDIR  = ./$(JAN)
JAN_SRCDIR  = $(JANDIR)/src
JAN_PATH  = $(BASEDIR)/$(PROJDIR)/$(JAN)/src
JANSRC_PATH  = $(BASEDIR)/$(PROJDIR)/$(JAN)/src

TIKT = TicketCollectord
TIKTS = TicketCollectord_src
TIKTDIR = ./$(TIKTS)
#TIKTS_PATH = $(BASEDIR)/$(TIKTS)
TIKTS_PATH = $(BASEDIR)/$(PROJDIR)/$(TIKTS)

TCLKTR=tktCollectord
TCLKTRDIR = ./$(TCLKTR)
TCLKTR_PATH = $(BASEDIR)/$(PROJDIR)/$(TCLKTR)
TCLKTR_SRCDIR  = $(TCLKTR_PATH)/src
TCLKTRSRC_PATH = $(TCLKTR_PATH)/src

JSMN_PATH = $(BASEDIR)/$(DEPS)/jsmn
JSMN_DIR = ./$(DEPS)/jsmn

# relative path is used for archiving
# absolute path is used when making module dependencies
TESTDIR = $(BASEDIR)/$(PROJDIR)/tests
TEST_PATH = $(BASEDIR)/$(PROJDIR)/tests

# *** to be continued
