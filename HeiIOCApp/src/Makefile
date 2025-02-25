TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += HeiIOCSupport

# Compile and add code to the support library
HeiIOCSupport_SRCS += xxxRecord.c
HeiIOCSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
HeiIOCSupport_SRCS += dbSubExample.c
HeiIOCSupport_SRCS += devHeiIOCVersion.c
HeiIOCSupport_SRCS += HeiIOCHello.c
HeiIOCSupport_SRCS += initTrace.c

HeiIOCSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = HeiIOCVersion.h
# Macro name
GENVERSIONMACRO = HeiIOCVERSION

# Build the IOC application
PROD_IOC = HeiIOC

# HeiIOC.dbd will be created and installed
DBD += HeiIOC.dbd

# HeiIOC.dbd will include these files:
HeiIOC_DBD += base.dbd
HeiIOC_DBD += xxxSupport.dbd
HeiIOC_DBD += dbSubExample.dbd
HeiIOC_DBD += devHeiIOCVersion.dbd
HeiIOC_DBD += HeiIOCHello.dbd
HeiIOC_DBD += initTrace.dbd
HeiIOC_DBD += asyn.dbd
HeiIOC_DBD += drvAsynIPPort.dbd
HeiIOC_DBD += drvAsynSerialPort.dbd
HeiIOC_DBD += calc.dbd
HeiIOC_DBD += stream-scalcout.dbd
HeiIOC_DBD += stream.dbd
#HeiIOC_DBD += as.dbd
HeiIOC_DBD += asSupport.dbd
# HeiIOC_registerRecordDeviceDriver.cpp derives from HeiIOC.dbd
HeiIOC_SRCS += HeiIOC_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
HeiIOC_SRCS_DEFAULT += HeiIOCMain.cpp
HeiIOC_SRCS_vxWorks += -nil-

# Link in the code from our support library
HeiIOC_LIBS += HeiIOCSupport
HeiIOC_LIBS += asyn
HeiIOC_LIBS += calc
HeiIOC_LIBS += autosave
HeiIOC_LIBS += stream

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into HeiIOCSupport
    sncExample_SNCFLAGS += +r
    HeiIOC_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    HeiIOCSupport_SRCS += sncExample.stt
    HeiIOCSupport_LIBS += seq pv
    HeiIOC_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    HeiIOC_LIBS += qsrv
    HeiIOC_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    HeiIOC_DBD += PVAServerRegister.dbd
    HeiIOC_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
HeiIOC_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devHeiIOCVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
