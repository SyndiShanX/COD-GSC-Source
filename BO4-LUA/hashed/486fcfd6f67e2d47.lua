require("x64:53e8db3768fb02a")
Lobby.Paintjobs = {}
Lobby.Paintjobs.OnClientAdded = function(f1_arg0)
	if f1_arg0.lobbyModule == Enum[@"lobbymodule"][@"lobby_module_client"] then
		Engine[@"hash_3E41ECF8228967AD"](f1_arg0.xuid)
	end
end
Lobby.Paintjobs.OnClientRemoved = function(f2_arg0)
	if f2_arg0.lobbyModule == Enum[@"lobbymodule"][@"lobby_module_client"] then
		Engine[@"hash_2F3D516679F0B183"](f2_arg0.xuid)
	end
end
Lobby.Paintjobs.OnMatchEnd = function(f3_arg0)
	Engine[@"hash_351041C5B9B5DD93"]()
end
