echo %1 %2

nuget.exe setApiKey -Source %1 -ConfigFile nuget.config %2
nuget.exe list -Source %1 -ConfigFile nuget.config
nuget.exe push Antlr.3.4.1.9004.nupkg -Source %1 -ApiKey %2 -ConfigFile nuget.config
nuget.exe list -Source %1 -ConfigFile nuget.config
nuget.exe install -Source %1 Antlr 
