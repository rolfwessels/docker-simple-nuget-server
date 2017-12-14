
nuget.exe setApiKey -Source http://192.168.1.250:8083/ e46c582041db4cbe86a84b76a374383a
nuget.exe list -Source http://192.168.1.250:8083/
nuget.exe push Antlr.3.4.1.9004.nupkg -Source http://192.168.1.250:8083/
nuget.exe list -Source http://192.168.1.250:8083/
