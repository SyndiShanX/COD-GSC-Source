CoD.ArenaRankedPlayUtility = {}
CoD.ArenaRankedPlayUtility.Init = function()
	CoD.ArenaRankedPlayUtility.Ranks = Engine.GetArenaInfo()
	local f1_local0 = 0
	for f1_local1 = 1, #CoD.ArenaRankedPlayUtility.Ranks, 1 do
		local f1_local4 = CoD.ArenaRankedPlayUtility.Ranks[f1_local1]
		if f1_local4.points then
			f1_local4.minPoints = f1_local0
			f1_local4.maxPoints = f1_local0 + f1_local4.points - 1
			f1_local0 = f1_local0 + f1_local4.points
		end
	end
end
CoD.ArenaRankedPlayUtility.GetRankInfo = function(f2_arg0)
	if f2_arg0 ~= nil then
		for f2_local0 = 1, #CoD.ArenaRankedPlayUtility.Ranks, 1 do
			local f2_local3 = CoD.ArenaRankedPlayUtility.Ranks[f2_local0]
			if f2_local3.points and f2_local3.minPoints <= f2_arg0 and f2_arg0 <= f2_local3.maxPoints then
				return f2_local3
			end
		end
	end
	return CoD.ArenaRankedPlayUtility.Ranks[1]
end
CoD.ArenaRankedPlayUtility.GetRank = function(f3_arg0)
	local f3_local0 = CoD.ArenaRankedPlayUtility.GetRankInfo(f3_arg0)
	return f3_local0.rank
end
CoD.ArenaRankedPlayUtility.GetDisplayRankString = function(f4_arg0)
	return tostring(CoD.ArenaRankedPlayUtility.GetDisplayRank(f4_arg0))
end
CoD.ArenaRankedPlayUtility.GetDisplayRank = function(f5_arg0)
	local f5_local0 = CoD.ArenaRankedPlayUtility.GetRankInfo(f5_arg0)
	return f5_local0.rank + 1
end
CoD.ArenaRankedPlayUtility.GetRankName = function(f6_arg0)
	local f6_local0 = CoD.ArenaRankedPlayUtility.GetRankInfo(f6_arg0)
	if f6_local0.mode == Engine[@"converttoxhash"]("stars_locked") then
		return Engine[@"hash_4F9F1239CFD921FE"](@"menu/rank_n", f6_local0.rank + 1)
	elseif f6_local0.mode == Engine[@"converttoxhash"]("master") then
		return Engine[@"hash_4F9F1239CFD921FE"]("menu/masters_caps")
	else
		return ""
	end
end
CoD.ArenaRankedPlayUtility.GetArenaRankIcon = function(f7_arg0)
	local f7_local0 = CoD.ArenaRankedPlayUtility.GetRankInfo(f7_arg0)
	return f7_local0.icon
end
CoD.ArenaRankedPlayUtility.GetArenaRankIconLarge = function(f8_arg0)
	local f8_local0 = CoD.ArenaRankedPlayUtility.GetRankInfo(f8_arg0)
	return f8_local0.iconLarge
end
CoD.ArenaRankedPlayUtility.GetStarCount = function(f9_arg0)
	local f9_local0 = CoD.ArenaRankedPlayUtility.GetRankInfo(f9_arg0)
	return f9_arg0 - f9_local0.minPoints
end
CoD.ArenaRankedPlayUtility.GetRankVisibleStars = function(f10_arg0)
	local f10_local0 = CoD.ArenaRankedPlayUtility.GetRankInfo(f10_arg0)
	return f10_local0.points - 1
end
CoD.ArenaRankedPlayUtility.GetArenaRankPoints = function(f11_arg0)
	local f11_local0 = CoD.ArenaRankedPlayUtility.GetRankInfo(f11_arg0)
	return f11_local0.points
end
CoD.ArenaRankedPlayUtility.UpdateArenaBest = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = f12_arg1.arenaBest
	if f12_local0 then
		local f12_local1 = f12_local0.points:get()
		local f12_local2 = f12_arg2.points:get()
		if f12_local1 <= f12_local2 then
			f12_local0.points:set(f12_local2)
			local f12_local3 = f12_local0.skill:get()
			local f12_local4 = f12_arg2.skill:get()
			if f12_local3 <= f12_local4 then
				f12_local0.skill:set(f12_local4)
				local f12_local5 = f12_local0.variance:get()
				local f12_local6 = f12_arg2.variance:get()
				if f12_local6 < f12_local5 then
					f12_local0.variance:set(f12_local6)
				end
			end
			f12_arg1.arenaBestPlaylist:set(f12_arg0.name)
			return true
		end
	end
	return false
end
CoD.ArenaRankedPlayUtility.ClearSlot = function(f13_arg0, f13_arg1, f13_arg2)
	if f13_arg0 ~= nil then
		f13_arg0.season:set(f13_arg1)
		f13_arg0.rankedPlayStats.points:set(f13_arg2)
		CoD.ArenaUtility.ClearMatchesStats(eventStats.rankedPlayStats.matchesStats)
	end
end
CoD.ArenaRankedPlayUtility.CheckSeason = function(f14_arg0)
	return false
end
CoD.ArenaRankedPlayUtility.ArenaPregameStart = function(f15_arg0)
	if not LuaUtils.IsArenaPublicGame() then
		return
	end
	local f15_local0 = Engine.StorageGetBuffer(f15_arg0, Enum.StorageFileType[@"hash_5D5A7695E03A7A90"])
	if f15_local0 ~= nil then
		local f15_local1 = f15_local0.arenaStats
		if f15_local1 ~= nil then
			local f15_local2 = Engine.GetCurrentArenaSlot()
			local f15_local3 = f15_local1[f15_local2]
			if f15_local2 ~= -1 and f15_local3 ~= nil then
				local f15_local4 = f15_local3.points:get()
				local f15_local5 = CoD.ArenaRankedPlayUtility.GetRank(f15_local4)
				local f15_local6 = math.max(f15_local4 - 1, 0)
				if f15_local5 == CoD.ArenaRankedPlayUtility.GetRank(f15_local6) then
					f15_local3.points:set(f15_local6)
				end
				f15_local3.matchStartPoints:set(f15_local4)
				Engine.exec(f15_arg0, "uploadstats")
			end
		end
	end
end
CoD.ArenaRankedPlayUtility.ArenaPregameError = function(f16_arg0)
	if not LuaUtils.IsArenaPublicGame() then
		return
	end
	local f16_local0 = Engine.StorageGetBuffer(f16_arg0, Enum.StorageFileType[@"hash_5D5A7695E03A7A90"])
	if f16_local0 ~= nil then
		local f16_local1 = f16_local0.arenaStats
		if f16_local1 ~= nil then
			local f16_local2 = Engine.GetCurrentArenaSlot()
			local f16_local3 = f16_local1[f16_local2]
			if f16_local2 ~= -1 and f16_local3 ~= nil then
				local f16_local4 = f16_local3.points:get()
				local f16_local5 = f16_local3.matchStartPoints:get()
				if f16_local4 ~= f16_local5 then
					f16_local3.points:set(f16_local5)
					Engine.exec(f16_arg0, "uploadstats")
				end
			end
		end
	end
end
CoD.ArenaRankedPlayUtility.Init()
DataSources.RankedPlay = {
	Initialize = function()
		if not DataSources.Arena.subscriptionElement then
			DataSources.Arena.subscriptionElement = LUI.UIElement.new()
			DataSources.Arena.subscriptionElement.updateDataSource = CoD.ArenaUtility.UpdateArenaOnLobbyNav
			CoD.DirectorUtility.AddLobbyNavSubscriptionOnce(DataSources.Arena.subscriptionElement)
		end
	end,
	getModel = function(f18_arg0)
		DataSources.Arena.Initialize()
		local f18_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "Arena")
		f18_local0:create("arenaRank")
		f18_local0:create("arenaStars")
		f18_local0:create("arenaRankedPlayStarList")
		f18_local0:create("arenaRankIcon")
		f18_local0:create("arenaRankIconLarge")
		return f18_local0
	end,
}
CoD.ArenaRankedPlayUtility.GetStarRowFirstCoordinates = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	local f19_local0 = 25
	local f19_local1 = 225
	local f19_local2 = f19_local0 + f19_arg0 * f19_arg1 / 2 - f19_arg2 * f19_arg0 / 2
	local f19_local3 = f19_local2 + f19_arg0
	local f19_local4 = f19_local1 + f19_arg3 * f19_arg0
	return f19_local2, f19_local3, f19_local4, f19_local4 + f19_arg0
end
CoD.ArenaRankedPlayUtility.PopulateRankedPlayWidget = function(f20_arg0, f20_arg1)
	if f20_arg1.starList ~= nil then
		for f20_local3, f20_local4 in ipairs(f20_arg1.starList) do
			f20_arg1:removeElement(f20_local4)
		end
	end
	local f20_local0 = 4
	local f20_local1 = 45
	local f20_local2 = Engine.GetArenaPoints(Engine.GetPrimaryController(), f20_arg0)
	local f20_local3 = CoD.ArenaRankedPlayUtility.GetRankInfo(f20_local2)
	local f20_local4 = f20_local3.maxPoints - f20_local3.minPoints
	local f20_local5 = math.min(f20_local4, f20_local0)
	local f20_local6 = 0
	local f20_local7, f20_local8, f20_local9, f20_local10 = CoD.ArenaRankedPlayUtility.GetStarRowFirstCoordinates(f20_local1, f20_local0, f20_local5, f20_local6)
	local f20_local11 = f20_local4
	local f20_local12 = CoD.ArenaRankedPlayUtility.GetStarCount(f20_local2)
	f20_arg1.starList = {}
	for f20_local13 = 1, f20_local4, 1 do
		local self = LUI.UIImage.new(0, 0, f20_local7, f20_local8, 0, 0, f20_local9, f20_local10)
		if f20_local13 <= f20_local12 then
			self:setImage(RegisterImage("arena_star_icon"))
		else
			self:setImage(RegisterImage("arena_star_icon_empty"))
		end
		f20_arg1:addElement(self)
		if f20_local13 % f20_local0 == 0 then
			f20_local7, f20_local8, f20_local9, f20_local10 = CoD.ArenaRankedPlayUtility.GetStarRowFirstCoordinates(f20_local1, f20_local0, math.min(f20_local11 - f20_local0, f20_local0), f20_local6 + 1)
		else
			f20_local7 = f20_local7 + f20_local1
			f20_local8 = f20_local8 + f20_local1
		end
		table.insert(f20_arg1.starList, self)
	end
	local f20_local13 = Engine.CreateModel(Engine.GetGlobalModel(), "Arena")
	local f20_local14 = CoD.ArenaRankedPlayUtility.GetArenaRankIconLarge(f20_local2)
	local f20_local15 = f20_local13:create("arenaRankIconLarge")
	f20_local15:set(f20_local14)
	f20_local15 = CoD.ArenaRankedPlayUtility.GetDisplayRankString(f20_local2)
	local f20_local17 = f20_local13:create("arenaRank")
	f20_local17:set(f20_local15)
	f20_local17 = f20_local13:create("arenaStars")
	f20_local17:set(f20_local12)
end
CoD.ArenaRankedPlayUtility.PopulateRankedPlayAARWidget = function(f21_arg0, f21_arg1)
	local f21_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "Arena")
	DataSources.RankedPlayStar = ListHelper_SetupDataSource("RankedPlayStar", function(f22_arg0)
		local f22_local0 = {}
		local f22_local1 = 45
		local f22_local2 = 36
		for f22_local3 = 1, f22_local1, 1 do
			if f22_local3 <= f22_local2 then
				table.insert(f22_local0, {
					models = {
						image = "arena_star_icon",
					},
					properties = {},
				})
			else
				table.insert(f22_local0, {
					models = {
						image = "arena_star_icon_empty",
					},
					properties = {},
				})
			end
		end
		return f22_local0
	end, true)
	DataSources.RankedPlayStar.prepare(f21_arg0, f21_arg1)
	local f21_local1 = f21_local0:create("arenaRankedPlayStarList")
	f21_local1:set("RankedPlayStar")
end
