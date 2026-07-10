require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
Lobby.Analytics = {}
Lobby.Analytics.OnMatchEnd = function(f1_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](Engine[@"getprimarycontroller"]()), "lobbyRoot.showPostMatchSurvey"), true)
end
