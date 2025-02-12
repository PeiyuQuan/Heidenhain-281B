
< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/HeiIOC.dbd"
HeiIOC_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/HeiIOCApp/Db")
epicsEnvSet("PREFIX", "BL62:hei1:")
epicsEnvSet("PORT", "serial1")
epicsEnvSet("M","M1:")
drvAsynIPPortConfigure("serial1", "192.168.0.132:4001 COM", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r\n")
asynOctetSetOutputEos("serial1",0,"\r")
asynSetOption("serial1",0,"baud","9600")
asynSetOption("serial1",0,"bits","7")
asynSetOption("serial1",0,"stop","2")
asynSetOption("serial1",0,"parity","Even")


dbLoadRecords("${TOP}/HeiIOCApp/Db/ND281B.db","P=$(PREFIX),M=$(M),PORT=serial1")
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn1,PORT=serial1,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db","P=$(PREFIX),PORT=serial1")
cd "${TOP}/iocBoot/${IOC}"
iocInit

