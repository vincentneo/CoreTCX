import CoreTCX

var tcx = TCXRoot()
var tcxfolder = TCXSubfolders<TCXHistoryFolder>()

tcxfolder.running = TCXHistoryFolder(name: "HAS_RAN")
   

print(tcxfolder.tcxFormatted())

print(tcxfolder.tcxFormatted())
