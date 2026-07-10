CoD.ArenaRunUtility = {}
CoD.ArenaRunUtility.GetCurrentBestRun = function(f1_arg0)
	local f1_local0 = Engine[@"storagegetbuffer"](f1_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	if f1_local0 then
		return f1_local0.arenaStats[Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"]].arenaRunStats.bestRun
	else
		return 0
	end
end
CoD.ArenaRunUtility.GetCurrentBestPerfectRun = function(f2_arg0)
	local f2_local0 = Engine[@"storagegetbuffer"](f2_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	if f2_local0 then
		return f2_local0.arenaStats[Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"]].arenaRunStats.bestPerfectRun
	else
		return 0
	end
end
CoD.ArenaRunUtility.GetCurrentWins = function(f3_arg0)
	return Engine[@"hash_26F8EB1011B6A7A0"](f3_arg0, Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"])
end
CoD.ArenaRunUtility.GetCurrentStrikes = function(f4_arg0)
	return Engine[@"hash_5FD5CF5F1B5934BE"](f4_arg0, Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"])
end
CoD.ArenaRunUtility.PopulateArenaStats = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	if f5_arg3 == nil then
		return
	elseif type(f5_arg2) == "string" then
		f5_arg2 = CoD.ArenaUtility.GetArenaSlot(Engine[@"getplaylistid"]())
		f5_arg2 = 1
	end
end
DataSources.ArenaRunStats = {
	getModel = function(f6_arg0)
		local f6_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "Arena")
		local f6_local1 = f6_local0:create("arenaRunStats")
		local f6_local2 = f6_local1:create("wins")
		f6_local2:set(CoD.ArenaRunUtility.GetCurrentWins(f6_arg0))
		f6_local2 = f6_local1:create("strikes")
		f6_local2:set(CoD.ArenaRunUtility.GetCurrentStrikes(f6_arg0))
		f6_local2 = f6_local1:create("bestRun")
		f6_local2:set(CoD.ArenaRunUtility.GetCurrentBestRun(f6_arg0))
		f6_local2 = f6_local1:create("bestPerfectRun")
		f6_local2:set(CoD.ArenaRunUtility.GetCurrentBestPerfectRun(f6_arg0))
		return f6_local1
	end,
}
