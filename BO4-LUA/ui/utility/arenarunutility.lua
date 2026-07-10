CoD.ArenaRunUtility = {}
CoD.ArenaRunUtility.GetCurrentBestRun = function(f1_arg0)
	local f1_local0 = Engine[0x8BF970606552F4C](f1_arg0, Enum[0xBBD4F9E70101BA8][0xD5A7695E03A7A90])
	if f1_local0 then
		return f1_local0.arenaStats[Enum[0xC0EA92D04BC003B][0x3603CAC0849A965]].arenaRunStats.bestRun
	else
		return 0
	end
end
CoD.ArenaRunUtility.GetCurrentBestPerfectRun = function(f2_arg0)
	local f2_local0 = Engine[0x8BF970606552F4C](f2_arg0, Enum[0xBBD4F9E70101BA8][0xD5A7695E03A7A90])
	if f2_local0 then
		return f2_local0.arenaStats[Enum[0xC0EA92D04BC003B][0x3603CAC0849A965]].arenaRunStats.bestPerfectRun
	else
		return 0
	end
end
CoD.ArenaRunUtility.GetCurrentWins = function(f3_arg0)
	return Engine[0x6F8EB1011B6A7A0](f3_arg0, Enum[0xC0EA92D04BC003B][0x3603CAC0849A965])
end
CoD.ArenaRunUtility.GetCurrentStrikes = function(f4_arg0)
	return Engine[0xFD5CF5F1B5934BE](f4_arg0, Enum[0xC0EA92D04BC003B][0x3603CAC0849A965])
end
CoD.ArenaRunUtility.PopulateArenaStats = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	if f5_arg3 == nil then
		return
	elseif type(f5_arg2) == "string" then
		f5_arg2 = CoD.ArenaUtility.GetArenaSlot(Engine[0x7B3B2B73B53EB34]())
		f5_arg2 = 1
	end
end
DataSources.ArenaRunStats = {
	getModel = function(f6_arg0)
		local f6_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "Arena")
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
