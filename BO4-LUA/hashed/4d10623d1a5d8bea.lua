require("x64:53e8db3768fb02a")
Lobby.Stats = {}
Lobby.Stats.WritePlayerStatToMissionStat = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	f1_arg1.PlayerStatsByMap[f1_arg2].currentStats[f1_arg3]:set(f1_arg1.PlayerStatsList[f1_arg3].statValue:get())
end
Lobby.Stats.WriteMissionStats = function(f2_arg0, f2_arg1, f2_arg2)
	if not f2_arg1.PlayerStatsByMap[f2_arg2] then
		return
	end
	statNames = {
		"SCORE",
		"KILLS",
		"INCAPS",
		"ASSISTS",
		"REVIVES",
	}
	for f2_local3, f2_local4 in pairs(statNames) do
		Lobby.Stats.WritePlayerStatToMissionStat(f2_arg0, f2_arg1, f2_arg2, f2_local4)
	end
	for f2_local0 = 0, 5, 1 do
		f2_arg1.PlayerStatsByMap[f2_arg2].previousCompletedDifficulties[f2_local0]:set(f2_arg1.PlayerStatsByMap[f2_arg2].completedDifficulties[f2_local0]:get())
		f2_arg1.PlayerStatsByMap[f2_arg2].previousReceivedXPForDifficulty[f2_local0]:set(f2_arg1.PlayerStatsByMap[f2_arg2].receivedXPForDifficulty[f2_local0]:get())
	end
end
Lobby.Stats.WriteCurrentDecorations = function(f3_arg0, f3_arg1)
	for f3_local0 = 0, 19, 1 do
		f3_arg1.currentPlayerCPDecorations[f3_local0]:set(f3_arg1.PlayerCPDecorations[f3_local0]:get())
	end
end
Lobby.Stats.WriteCurrentRankXP = function(f4_arg0, f4_arg1)
	f4_arg1.currentRankXP:set(f4_arg1.PlayerStatsList.RANKXP.statValue:get())
end
Lobby.Stats.WriteCurrentWeaponLevels = function(f5_arg0, f5_arg1)
	for f5_local0 = 1, 58, 1 do
		f5_arg1.currentWeaponLevels[f5_local0]:set(Engine[0x1EA89C73C920CC2](f5_arg0, f5_local0))
	end
end
Lobby.Stats.WriteCurrentCPStats = function(f6_arg0, f6_arg1)
	if f6_arg1 == nil then
		f6_arg1 = Engine[0xE67E7253CC272C9]()
	end
	local f6_local0 = LuaUtils.GetMapsTable()
	f6_local0 = f6_local0[f6_arg1]
	if f6_local0 ~= nil and f6_local0.rootMapName ~= nil then
		local f6_local1 = Engine[0xA6C26EBACD7322D](f6_arg0)
		Lobby.Stats.WriteCurrentWeaponLevels(f6_arg0, f6_local1)
		Lobby.Stats.WriteCurrentRankXP(f6_arg0, f6_local1)
		Lobby.Stats.WriteCurrentDecorations(f6_arg0, f6_local1)
		Lobby.Stats.WriteMissionStats(f6_arg0, f6_local1, f6_local0.rootMapName)
		Engine[0x7C75E608EA39B5C](f6_arg0, "uploadstats")
		Engine[0x7C75E608EA39B5C](f6_arg0, "savegamerprofilestats")
	end
end
Lobby.Stats.PreMatchValidateStats = function(f7_arg0, f7_arg1) end
Lobby.Stats.OnMatchStart = function(f8_arg0)
	Engine[0x7C75E608EA39B5C](nil, "sv_ae_init")
	local f8_local0 = Engine[0xA5B9C0111291A8B]()
	if f8_local0 ~= nil then
		Lobby.BlackMarket.ClearTierSkips(f8_local0)
		local f8_local1 = Engine[0x4DF5CFBC1771947](f8_local0)
		if f8_local1 ~= nil then
			local f8_local2 = f8_local1:create("AARPreMatch", true)
			if f8_local2 ~= nil then
				local f8_local3 = f8_local2:create("currentSeasonTiers", true)
				if f8_local3 ~= nil then
					local f8_local4 = CoDShared.Loot.GetCurrentSeason()
					if f8_local4 ~= nil then
						f8_local3:set(Engine[0x159D7050715A2C3](f8_local0, f8_local4))
					end
				end
			end
		end
	end
	if Engine[0x293941FE17453F1]() then
		local f8_local1 = Engine[0xA5B9C0111291A8B]()
		if Engine[0x19D51F845CA3D3C]() ~= Engine[0xE67E7253CC272C9]() then
			Lobby.Stats.WriteCurrentCPStats(f8_local1)
		end
		local f8_local3 = LuaUtils.GetMapsTable()
		f8_local3 = f8_local3[mapName]
		if f8_local3 ~= nil and f8_local3.rootMapName ~= nil then
			Engine[0x64660E478D906FB](f8_local3.rootMapName)
		end
	end
end
Lobby.Stats.OnWarzoneMatchStart = function(f9_arg0)
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		for f9_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
			local f9_local3 = Engine[0xA6C26EBACD7322D](f9_local0, Engine[0x8E494FC6037B54]())
			if f9_local3 then
				f9_local3[0x6BFF22CED3C153C][0x792C1F90C3A5C7F]:set(Engine[0x69811927938FCD7]())
				f9_local3[0x6BFF22CED3C153C][0xDF5E6BB54765F4C]:set(Engine[0x40145EEB2E913D2](f9_local0, Engine[0x761955642304848](f9_local0)))
			end
		end
	end
end
Lobby.Stats.OnUILoad = function(f10_arg0)
	if f10_arg0.init == true or f10_arg0.frontend == false then
		return
	elseif Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		for f10_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
			local f10_local3 = Engine[0xA6C26EBACD7322D](f10_local0, Engine[0xE038E13929C6347]())
			local f10_local4 = Engine[0xA6C26EBACD7322D](f10_local0, Engine[0x8E494FC6037B54]())
			if f10_local3 and f10_local4 then
				local f10_local5 = f10_local4[0x6BFF22CED3C153C]
				local f10_local6 = f10_local5[0x792C1F90C3A5C7F]:get()
				if f10_local6 ~= "" then
					local f10_local7 = Engine[0xD492E0385F6D3E4](Engine[0xC53F8D38DF9042B](f10_local6))
					local f10_local8 = f10_local4[0xEE246008306A24C][f10_local7]
					local f10_local9 = f10_local3[0xEE246008306A24C][f10_local7]
					local f10_local10 = (f10_local8[0x799A2983FA729D6]:get() + 1) % 10
					f10_local8[0x799A2983FA729D6]:set(f10_local10)
					local f10_local11 = f10_local8[0x2FF5EBA64F244E3][f10_local10]
					local f10_local12 = function(f11_arg0)
						return f10_local8[f11_arg0].statValue:get()
					end
					local f10_local13 = function(f12_arg0, f12_arg1)
						f10_local8[f12_arg0].statValue:set(f12_arg1)
					end
					local f10_local14 = function(f13_arg0)
						return f10_local8[f13_arg0].statValue:get() - f10_local9[f13_arg0].statValue:get()
					end
					local f10_local15 = f10_local14(0xD238EA28DDDB583)
					f10_local11[0xF6308BE8AB37FC0]:set(f10_local15)
					if f10_local12(0x5B27DF39A4715A3) < f10_local15 then
						f10_local13(0x5B27DF39A4715A3, f10_local15)
					end
					local f10_local16 = f10_local14(0xBFF3D8DB7BB109E)
					f10_local11[0xBFF3D8DB7BB109E]:set(f10_local16)
					if f10_local12(0xE4E1EB9512BA7B5) < f10_local16 then
						f10_local13(0xE4E1EB9512BA7B5, f10_local16)
					end
					f10_local11[0x10E63FBE7F624F5]:set(0)
					f10_local11[0x3F9FA1A7D1C1E8F]:set(f10_local14(0x3BF15114F02AF7B))
					f10_local11[0x80C2F604F99D74B]:set(f10_local14(0x80C2F604F99D74B))
					f10_local11[0x6ED920648D707FA]:set(f10_local14(0x6ED920648D707FA))
					f10_local11[0xEE08D8D2973448]:set(f10_local5[0xEE08D8D2973448]:get())
					f10_local11[0x95906BC03912AC4]:set(f10_local5[0x95906BC03912AC4]:get())
					f10_local11[0xD0CFE94310960B1]:set(1)
					Engine[0x28A466EF7723621](f10_local0, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC])
				end
			end
		end
	end
end
Lobby.Stats.OnMatchLaunchClient = function(f14_arg0)
	if Engine[0x293941FE17453F1]() then
		Lobby.Stats.WriteCurrentCPStats(Engine[0xA5B9C0111291A8B]())
	end
end
Lobby.Stats.OnMatchChangeMap = function(f15_arg0)
	if Engine[0x293941FE17453F1]() then
		local f15_local0 = Engine[0xA5B9C0111291A8B]()
		local f15_local1, f15_local2 = nil
		if f15_arg0.currentMap ~= nil and f15_arg0.currentMap ~= "" then
			local f15_local3 = LuaUtils.GetMapsTable()
			f15_local1 = f15_local3[f15_arg0.currentMap]
		end
		if f15_arg0.nextMap ~= nil and f15_arg0.nextMap ~= "" then
			local f15_local3 = LuaUtils.GetMapsTable()
			f15_local2 = f15_local3[f15_arg0.nextMap]
		end
		if f15_local2 == nil then
			return
		elseif f15_local1 ~= nil and f15_local1.isSafeHouse then
			Lobby.Stats.WriteCurrentCPStats(f15_local0, f15_arg0.nextMap)
			return
		end
	end
end
Lobby.Stats.ClearValidationEvent = function(f16_arg0)
	if f16_arg0 ~= nil and f16_arg0.validationEvent:get() ~= "" then
		f16_arg0.validationEvent:set("")
	end
end
Lobby.Stats.SpecialistErrorDetected = function(f17_arg0, f17_arg1, f17_arg2)
	f17_arg2.cacloadouts.charactercontext.characterindex:set(0)
	f17_arg2.cacloadouts.herogadget:set(0)
	f17_arg2.cacloadouts.heroweapon:set(113)
end
Lobby.Stats.IsWeaponValid = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	return true
end
Lobby.Stats.LoadoutErrorDetected = function(f19_arg0, f19_arg1)
	LuaUtils.ClearDDLKeysAndArrays(f19_arg1, {
		structArrays = {
			primary = {
				keys = {
					"itemIndex",
				},
				arrays = {
					"attachment",
				},
			},
			secondary = {
				keys = {
					"itemIndex",
				},
				arrays = {
					"attachment",
				},
			},
		},
	})
end
Lobby.Stats.KillstreakErrorDetected = function(f20_arg0, f20_arg1)
	f20_arg1:set(0)
end
Lobby.Stats.GetDefaultSprayGestures = function()
	if not Lobby.Stats.DefaultSprayGesturesTable then
		Lobby.Stats.DefaultSprayGesturesTable = {}
		for f21_local3, f21_local4 in ipairs(Engine[0xB2E4CCC119597B0]()) do
			if f21_local4[0x486837B8286880E] and f21_local4[0x486837B8286880E] == 1 then
				table.insert(Lobby.Stats.DefaultSprayGesturesTable, f21_local3)
			end
		end
	end
	return Lobby.Stats.DefaultSprayGesturesTable
end
Lobby.Stats.ValidateCharacterOutfits = function(f22_arg0, f22_arg1)
	if f22_arg0 then
		for f22_local16, f22_local17 in ipairs(Engine[0x1657A284F55F9CD](f22_arg1)) do
			local f22_local18 = f22_local17.bodyIndex
			local f22_local19 = f22_arg0[f22_local18]
			if f22_local19 then
				local f22_local3 = function(f23_arg0, f23_arg1)
					local f23_local0 = f23_arg1:get()
					if not f23_arg0 or not f23_arg0[f23_local0 + 1] or not f23_arg0[f23_local0 + 1].isValid then
						f23_arg1:set(0)
					end
				end
				local f22_local4 = Engine[0x5284767BCC0915E](f22_arg1, f22_local18)
				f22_local3(f22_local4.outfits, f22_local19[0xF7F78E9EBEFCE27])
				f22_local3(f22_local4.outfits, f22_local19[0xD9FCEAC8FF24CBD])
				for f22_local13, f22_local14 in ipairs(f22_local4.outfits) do
					local f22_local15 = f22_local19[0xE5C77948998E49][f22_local13 - 1]
					if f22_local15 then
						for f22_local11, f22_local12 in ipairs(CoDLoadoutsShared.characterCustomizationRegions) do
							f22_local3(f22_local14[f22_local12.name], f22_local15[0x12BCDFA518CC913][f22_local12.stat])
						end
					end
				end
			end
		end
	end
end
Lobby.Stats.FixupCAC = function(f24_arg0, f24_arg1)
	local f24_local0 = function(f25_arg0, f25_arg1)
		local f25_local0 = f25_arg0[0x3460F2DA135912A]:get()
		local f25_local1 = Engine[0xF8ECCDE64F061E1](f25_local0, f25_arg1)
		for f25_local2 = 0, #f25_arg0[0x73F89AC8D3F248] - 1, 1 do
			attachmentIndex = f25_arg0[0x73F89AC8D3F248][f25_local2]:get()
			attachmentRef = Engine[0x2E29FB421AD554B](f25_local0, attachmentIndex, f25_arg1)
			if f25_local1 <= attachmentIndex and attachmentRef ~= "clantag" and attachmentRef ~= "killcounter" and attachmentRef ~= "custom2" then
				f25_arg0[0x73F89AC8D3F248][f25_local2]:set(0)
			end
		end
		local f25_local2 = f25_arg0[0xEE983B435CE4912]:get()
		if f25_local2 > 0 then
			local f25_local3 = Engine[0xB98952F69D937F9](f25_local0)
			if f25_local3 ~= 0x0 then
				local f25_local4 = Engine[0x9F0BB7D52A7A978](f25_local3)
				local f25_local5 = false
				for f25_local9, f25_local10 in ipairs(f25_local4) do
					if f25_local10[0x3CF8E8F9081468B] == f25_local2 then
						f25_local5 = true
						break
					end
				end
				if not f25_local5 then
					f25_arg0[0xEE983B435CE4912]:set(0)
				end
			end
		end
	end
	if f24_arg0 then
		for f24_local1 = 0, #f24_arg0[0x596BA1A28B37AAE] - 1, 1 do
			local f24_local4 = f24_arg0[0x596BA1A28B37AAE][f24_local1]
			f24_local0(f24_local4[0xF31137FF783E939], f24_arg1)
			f24_local0(f24_local4[0x7FBC18FBDAA00D1], f24_arg1)
		end
	end
end
Lobby.Stats.OnMPLoadoutsDownloaded = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	local f26_local1 = Engine[0xA5B5E7CABA5C3AB](f26_local0)
	local f26_local2 = Engine[0x8BF970606552F4C](f26_arg0, f26_arg1)
	if f26_local2 ~= nil then
		local f26_local3 = f26_local2[f26_arg2]
		if f26_local3 then
			local f26_local4 = function(f27_arg0, f27_arg1)
				if f27_arg1 and f27_arg0[0x810366D1F05BBBD] and f27_arg0[0x810366D1F05BBBD] ~= 0x0 then
					return false
				elseif (f26_arg1 == Enum[0xBBD4F9E70101BA8][0x67DF1879D992E] or f26_arg1 == Enum[0xBBD4F9E70101BA8][0xCEBE62E27709AD0]) and CoDLoadoutsShared.ArenaHiddenPositionRoles[Engine[0x82C5756563934AE](f26_local0, f27_arg0.bodyIndex)] then
					return false
				else
					local f27_local0 = Engine[0x3B369D0D8A22BE2](f26_local0, f27_arg0.bodyIndex)
					return f27_local0 and f27_local0[0xD885806B56289E] ~= 0
				end
			end
			if f26_arg1 == Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA] then
				local f26_local5 = f26_local3.characterContext.characterIndex
				local f26_local6 = nil
				for f26_local10, f26_local11 in ipairs(f26_local1) do
					if f26_local11.bodyIndex == f26_local5:get() then
						f26_local6 = f26_local11
						break
					end
				end
				if not f26_local6 or not f26_local4(f26_local6, false) then
					f26_local7 = {}
					for f26_local11, f26_local12 in ipairs(f26_local1) do
						if f26_local4(f26_local12, true) then
							table.insert(f26_local7, f26_local12.bodyIndex)
						end
					end
					if #f26_local7 > 0 then
						f26_local5:set(math.random(#f26_local7))
					end
				end
				for f26_local10, f26_local11 in ipairs(Lobby.Stats.GetDefaultSprayGestures()) do
					f26_local3[0xF48E22CED35E56D][f26_local11]:set(1)
				end
				for f26_local10, f26_local11 in ipairs(f26_local1) do
					local f26_local12 = f26_local11.bodyIndex
					if f26_local3[0x147738D5CEE9199] and f26_local3[0x147738D5CEE9199][f26_local12] and f26_local3[0x147738D5CEE9199][f26_local12][0xCF85C301A206997] then
						f26_local3[0x147738D5CEE9199][f26_local12][0xCF85C301A206997][0][0x3930AAFA5D6AC7B][0]:set(1)
						for f26_local19, f26_local20 in DDLUtils.ipairs(f26_local3[0x147738D5CEE9199][f26_local12][0xCF85C301A206997]) do
							for f26_local16, f26_local17 in DDLUtils.pairs(f26_local20[0xC519DA7A1F958C5]) do
								f26_local17[0xD834AEE4BD18D13][0]:set(1)
							end
						end
					end
				end
				Lobby.Stats.ValidateCharacterOutfits(f26_local3[0x147738D5CEE9199], f26_local0)
			end
			Lobby.Stats.FixupCAC(f26_local3, f26_local0)
			Engine[0x28A466EF7723621](f26_arg0, f26_arg1)
		end
	end
end
Lobby.Stats.GetPrestigePermanentUnlocks = function(f28_arg0)
	local f28_local0 = 0
	for f28_local1 = 0, 19, 1 do
		if f28_arg0.prestigeTokens[f28_local1].tokenSpent:get() == 1 and 0 < f28_arg0.prestigeTokens[f28_local1].itemunlocked:get() then
			f28_local0 = f28_local0 + 1
		end
	end
	return f28_local0
end
Lobby.Stats.OnMPStatsDownloaded = function(f29_arg0)
	if not Engine[0x351C2A2F9B235FB](f29_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C]) then
		return
	else
		Lobby.Stats.ClearValidationEvent(Engine[0x8BF970606552F4C](f29_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C]))
	end
end
Lobby.Stats.OnMPStatsUploaded = function(f30_arg0)
	Lobby.Stats.ClearValidationEvent(Engine[0x8BF970606552F4C](f30_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C]))
end
Lobby.Stats.OnMPOnlineStatsDownloaded = function(f31_arg0)
	local f31_local0 = Engine[0x8BF970606552F4C](f31_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	local f31_local1 = 381
	for f31_local2 = 0, f31_local1, 1 do
		if f31_local0[0x873C248BAA41A06] then
			f31_local0[0x873C248BAA41A06][f31_local2]:set(CoDLootShared.ItemOwnedValue)
		end
		if f31_local0[0x2799A890D40252F][f31_local2] then
			f31_local0[0x2799A890D40252F][f31_local2]:set(CoDLootShared.ItemNewValue)
		end
	end
	for f31_local6, f31_local7 in ipairs({
		383,
		384,
		391,
		392,
	}) do
		if f31_local0[0x873C248BAA41A06] then
			f31_local0[0x873C248BAA41A06][f31_local7]:set(CoDLootShared.ItemOwnedValue)
		end
		if f31_local0[0x2799A890D40252F] then
			f31_local0[0x2799A890D40252F][f31_local7]:set(CoDLootShared.ItemNewValue)
		end
	end
	f31_local3 = 10
	for f31_local4 = 0, f31_local1, 1 do
		if f31_local0[0x8BB06B8B337E385] then
			f31_local0[0x8BB06B8B337E385][f31_local4]:set(CoDLootShared.ItemOwnedValue)
		end
		if f31_local0[0xD45B221DEE76EE4] then
			f31_local0[0xD45B221DEE76EE4][f31_local4]:set(CoDLootShared.ItemNewValue)
		end
	end
	for f31_local8, f31_local9 in ipairs({
		407,
		408,
		409,
		410,
		411,
	}) do
		if f31_local0[0x8BB06B8B337E385] then
			f31_local0[0x8BB06B8B337E385][f31_local9]:set(CoDLootShared.ItemOwnedValue)
		end
		if f31_local0[0xD45B221DEE76EE4] then
			f31_local0[0xD45B221DEE76EE4][f31_local9]:set(CoDLootShared.ItemNewValue)
		end
	end
	Engine[0x28A466EF7723621](f31_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
end
Lobby.Stats.OnZMOnlineStatsDownloaded = function(f32_arg0) end
Lobby.Stats.OnCPOnlineLoadoutsDownloaded = function(f33_arg0)
	local f33_local0 = Engine[0x8BF970606552F4C](f33_arg0, Enum[0xBBD4F9E70101BA8][0x807B0F98163FB00])
	if f33_local0 then
		local f33_local1 = f33_local0.cacLoadouts
		if f33_local1 then
			local f33_local2 = Engine[0xA5B5E7CABA5C3AB](Enum[0x9C0C2196D8313A0][0x60063C67132EB69])
			for f33_local3 = 0, #f33_local2 - 1, 1 do
				if f33_local1.characters[f33_local3].itemList then
					f33_local1.characters[f33_local3].itemList.body.items[0].markedOld:set(1)
					f33_local1.characters[f33_local3].itemList.helmet.items[0].markedOld:set(1)
					f33_local1.characters[f33_local3].itemList.helmet.items[1].markedOld:set(1)
				end
			end
			Engine[0x28A466EF7723621](f33_arg0, Enum[0xBBD4F9E70101BA8][0x807B0F98163FB00])
		end
	end
end
Lobby.Stats.UpdateWZStatsCheck = function(f34_arg0)
	if not Engine[0x351C2A2F9B235FB](f34_arg0.controller, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC]) then
		return
	elseif f34_arg0.fromVersion == nil or f34_arg0.toVersion == nil or f34_arg0.fromVersion >= 103 then
		return
	end
	local f34_local0 = Engine[0x8BF970606552F4C](f34_arg0.controller, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC])
	local f34_local1 = f34_local0[0x426CDF8D9F44EB8]
	if f34_local1 ~= nil and f34_local1:get() == 0 then
		local f34_local2 = {
			[0xC229A4571E9BFA] = Engine[0x93B19E01B1FD1C7](f34_arg0.controller),
			[0x8928A12A20A9D67] = f34_local0[0xD59E8BFAC78A33B][0x8928A12A20A9D67][0x3BF77799B56C06C]:get(),
			[0x39537506D3C46] = f34_local0[0xD59E8BFAC78A33B][0x39537506D3C46][0x3BF77799B56C06C]:get(),
			[0xDA76FCF32C2EE79] = f34_local0[0xD59E8BFAC78A33B][0xDA76FCF32C2EE79][0x3BF77799B56C06C]:get(),
			[0xC5941725865AE68] = f34_local0[0xD59E8BFAC78A33B][0xC5941725865AE68][0x3BF77799B56C06C]:get(),
			[0x8FEDB9313539419] = f34_local0[0xD59E8BFAC78A33B][0x8FEDB9313539419][0x3BF77799B56C06C]:get(),
		}
		local f34_local3 = function(f35_arg0)
			for f35_local3, f35_local4 in pairs({
				0x8928A12A20A9D67,
				0x39537506D3C46,
				0xDA76FCF32C2EE79,
				0xC5941725865AE68,
				0x8FEDB9313539419,
				0x7803B7AF4E9C3B9,
				0xA9FE1A4C26B89D9,
				0x182B762B7BAD117,
			}) do
				f35_arg0[f35_local4][0x3BF77799B56C06C]:set(f35_arg0[f35_local4][0x3BF77799B56C06C]:get() * 10)
			end
		end
		f34_local3(f34_local0[0xD59E8BFAC78A33B])
		for f34_local7, f34_local8 in DDLUtils.pairs(f34_local0[0xEE246008306A24C]) do
			f34_local3(f34_local0[0xEE246008306A24C][f34_local7])
		end
		f34_local1:set(1)
		Engine[0x28A466EF7723621](f34_arg0.controller, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC])
		Engine[0xDE279ECDDDD966](f34_arg0.controller, 0x3AA8F200F54CE0E, f34_local2)
	end
end
Lobby.Stats.ValidateWZCharacterSelection = function(f36_arg0)
	if not Engine[0x351C2A2F9B235FB](f36_arg0, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC]) or not Engine[0x351C2A2F9B235FB](f36_arg0, Enum[0xBBD4F9E70101BA8][0xDF87425733853AE]) or not Engine[0x351C2A2F9B235FB](f36_arg0, Enum[0xBBD4F9E70101BA8][0x7036247812689DA]) or not Engine[0x351C2A2F9B235FB](f36_arg0, Enum[0xBBD4F9E70101BA8][0x38AE20E1AEFD6F0]) or not Engine[0x351C2A2F9B235FB](f36_arg0, Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882]) then
		return
	end
	local f36_local0 = Lobby.CharacterSelection.GetValidWarzoneCharacterSelections(f36_arg0)
	local f36_local1 = Lobby.CharacterSelection.GetDefaultWarzoneCharacters(f36_arg0)
	local f36_local2 = f36_local1[math.random(1, #f36_local1)]
	local f36_local3 = function(f37_arg0)
		local f37_local0 = f37_arg0:get()
		for f37_local4, f37_local5 in ipairs(f36_local0) do
			if f37_local0 == f37_local5 then
				return true
			end
		end
		return false
	end
	local f36_local4 = function(f38_arg0)
		local f38_local0 = f38_arg0:get()
		for f38_local4, f38_local5 in ipairs(f36_local1) do
			if f38_local0 == f38_local5 then
				return true
			end
		end
		return false
	end
	local f36_local5 = CoDLoadoutsShared[0x1040083716E3993](f36_arg0)
	local f36_local6 = CoDLoadoutsShared[0xF3A3045A9BEB31](f36_arg0)
	local f36_local7 = function(f39_arg0)
		for f39_local3, f39_local4 in ipairs(f36_local5) do
			if f39_local4 == f39_arg0 then
				return true
			end
		end
		return false
	end
	local f36_local8 = function(f40_arg0)
		for f40_local3, f40_local4 in ipairs(f36_local6) do
			if f40_local4 == f40_arg0 then
				return true
			end
		end
		return false
	end
	local f36_local9 = Engine[0x8BF970606552F4C](f36_arg0, Enum[0xBBD4F9E70101BA8][0xDF87425733853AE])
	if f36_local9 then
		local f36_local10 = f36_local9[0x766CE60E25569A3][0x8A76647E94009C3][0xDF5E6BB54765F4C]
		local f36_local11 = f36_local9[0x766CE60E25569A3][0xA8BD5071BCB463C]
		if not f36_local3(f36_local10) then
			f36_local10:set(f36_local2)
		end
		if f36_local4(f36_local10) then
			f36_local11:set(f36_local10:get())
		end
		for f36_local15, f36_local16 in ipairs(Lobby.Stats.GetDefaultSprayGestures()) do
			f36_local9[0x766CE60E25569A3][0xF48E22CED35E56D][f36_local16]:set(1)
		end
		for f36_local15, f36_local16 in DDLUtils.ipairs(f36_local9[0xD8B36A24FC2E466]) do
			if f36_local16[0xFAC82D8B8152CBE] and f36_local16[0xFAC82D8B8152CBE]:get() ~= Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5] then
				f36_local16[0xFAC82D8B8152CBE]:set(Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5])
			end
			if f36_local16[0xBD5E7FE64A21BCC] and f36_local16[0xBD5E7FE64A21BCC]:get() ~= 0 and not f36_local7(f36_local16[0xBD5E7FE64A21BCC]:get()) then
				f36_local16[0xBD5E7FE64A21BCC]:set(0)
			end
			if f36_local16[0xE86D585FF221CC1] and f36_local16[0xE86D585FF221CC1]:get() ~= 0 and not f36_local8(f36_local16[0xE86D585FF221CC1]:get()) then
				f36_local16[0xE86D585FF221CC1]:set(0)
			end
		end
	end
	local f36_local10 = Engine[0x8BF970606552F4C](f36_arg0, Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882])
	if f36_local10 then
		local f36_local11 = f36_local10[0xF4B2C475B778E67]
		if not f36_local3(f36_local11) then
			f36_local11:set(f36_local2)
		end
	end
end
Lobby.Stats.ValidateZMWeaponArmory = function(f41_arg0)
	if not Engine[0x351C2A2F9B235FB](f41_arg0, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0]) or not Engine[0x351C2A2F9B235FB](f41_arg0, Enum[0xBBD4F9E70101BA8][0xA57D6164B91A8FC]) or not Engine[0x351C2A2F9B235FB](f41_arg0, Enum[0xBBD4F9E70101BA8][0x9E5D6DF436F1EE]) or not Engine[0x351C2A2F9B235FB](f41_arg0, Enum[0xBBD4F9E70101BA8][0x3376D9E1C3C8130]) or not Engine[0x351C2A2F9B235FB](f41_arg0, Enum[0xBBD4F9E70101BA8][0xA621D7C69E5741A]) or not Engine[0x351C2A2F9B235FB](f41_arg0, Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882]) then
		return
	end
	local f41_local0 = CoDLoadoutsShared[0x1040083716E3993](f41_arg0)
	local f41_local1 = CoDLoadoutsShared[0xF3A3045A9BEB31](f41_arg0)
	local f41_local2 = function(f42_arg0, f42_arg1)
		for f42_local3, f42_local4 in ipairs(f42_arg1) do
			if f42_local4 == f42_arg0 then
				return true
			end
		end
		return false
	end
	local f41_local3 = function(f43_arg0)
		if f43_arg0[0xBD5E7FE64A21BCC] and f43_arg0[0xBD5E7FE64A21BCC]:get() ~= 0 and not f41_local2(f43_arg0[0xBD5E7FE64A21BCC]:get(), f41_local0) then
			f43_arg0[0xBD5E7FE64A21BCC]:set(0)
		end
		if f43_arg0[0xE86D585FF221CC1] and f43_arg0[0xE86D585FF221CC1]:get() ~= 0 and not f41_local2(f43_arg0[0xE86D585FF221CC1]:get(), f41_local1) then
			f43_arg0[0xE86D585FF221CC1]:set(0)
		end
	end
	local f41_local4 = Engine[0x8BF970606552F4C](f41_arg0, Enum[0xBBD4F9E70101BA8][0x9E5D6DF436F1EE])
	if f41_local4 then
		for f41_local11, f41_local12 in DDLUtils.ipairs(f41_local4[0x766CE60E25569A3]) do
			for f41_local8, f41_local9 in DDLUtils.ipairs(f41_local12[0x596BA1A28B37AAE]) do
				f41_local3(f41_local9[0xF31137FF783E939])
				f41_local3(f41_local9[0x7FBC18FBDAA00D1])
			end
		end
		for f41_local11, f41_local12 in DDLUtils.ipairs(f41_local4[0xD8B36A24FC2E466]) do
			f41_local3(f41_local12)
		end
	end
end
Lobby.Stats.ValidateJumpkitSelection = function(f44_arg0, f44_arg1)
	local f44_local0 = Engine[0xA7E3CD65E63086F](0xC4900FCA46D6C74)
	local f44_local1 = Engine[0x8BF970606552F4C](f44_arg0, f44_arg1)
	if not f44_local0 or not f44_local1 or not f44_local1.selectedJumpkitComponents or not f44_local1.selectedJumpkitNames then
		return
	end
	local f44_local2 = false
	for f44_local7, f44_local8 in DDLUtils.pairs(characterRoot[0x4DAF419B5CE4B42]) do
		if f44_local8:get() == 0x0 then
			local f44_local6 = f44_local0[f44_local1.selectedJumpkitComponents[f44_local7]:get() + 1] or f44_local0[0]
			if f44_local6 then
				f44_local8:set(f44_local6[0x14C91FFB3BA4240])
				f44_local2 = true
			end
		end
	end
	if f44_local2 then
		Engine[0x28A466EF7723621](f44_arg0, f44_arg1)
	end
end
Lobby.Stats.OnProfileCommonStatsDownloaded = function(f45_arg0)
	local f45_local0 = Engine[0x8BF970606552F4C](f45_arg0, Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882])
	if f45_local0 == nil then
		return
	end
	local f45_local1 = false
	local f45_local2 = "gamedata/tables/common/music_player.csv"
	local f45_local3 = Engine[0x2DCF0973239E909](f45_local2, Enum[0xA3A798215B24409][0x72CBF60753992B0], Enum[0xA3A798215B24409][0xB2055150516AE30], "mus_mp_lobby_intro")
	if f45_local3 ~= "" then
		f45_local3 = tonumber(f45_local3)
	else
		f45_local3 = nil
	end
	if f45_local0.snd_defaultFrontendTracksInitialized:get() == 0 then
		f45_local0.snd_defaultFrontendTracksInitialized:set(1)
		f45_local0.snd_muteMPFrontendMusic:set(0)
		if f45_local3 then
			f45_local0.snd_playMPFrontendMusicTrack[f45_local3]:set(1)
		else
			f45_local0.snd_playMPFrontendMusicTrack[0]:set(1)
		end
		f45_local1 = true
	end
	if f45_local0.snd_defaultFrontendTracksInitialized2:get() == 0 then
		f45_local0.snd_defaultFrontendTracksInitialized2:set(1)
		local f45_local4 = Engine[0x63FBABD1982143E](f45_local2)
		local f45_local5 = false
		local f45_local6 = 0
		for f45_local7 = 0, f45_local4 - 1, 1 do
			if f45_local7 ~= f45_local3 and f45_local0.snd_playMPFrontendMusicTrack[f45_local7]:get() == 1 then
				f45_local5 = true
				break
			elseif f45_local7 == f45_local3 and f45_local0.snd_playMPFrontendMusicTrack[f45_local7]:get() == 0 then
				f45_local5 = true
				break
			end
		end
		if f45_local0.snd_muteMPFrontendMusic:get() == 1 then
			f45_local0.snd_frontendTracksState:set(Enum[0xB1683EC557190D5][0x9E98EC0B4FB4CB1])
		elseif f45_local5 then
			f45_local0.snd_frontendTracksState:set(Enum[0xB1683EC557190D5][0x347CAFCE976D0D5])
		else
			f45_local0.snd_frontendTracksState:set(Enum[0xB1683EC557190D5][0xC479400C6B5B041])
		end
		if not f45_local5 then
			for f45_local7 = 0, f45_local4 - 1, 1 do
				f45_local0.snd_playMPFrontendMusicTrack[f45_local7]:set(1)
			end
		end
		f45_local1 = true
	end
	local f45_local4 = f45_local0[0xDA66F98A9232A8E]:get()
	if f45_local4 == 0 then
		f45_local0[0xDA66F98A9232A8E]:set(1)
		f45_local1 = true
		local f45_local5 = function(f46_arg0, f46_arg1, f46_arg2)
			f46_arg0[0x3BEABDC19B7FC32]:set(0)
			f46_arg0[0xEFB826D1A3BB80A]:set(0)
			for f46_local3, f46_local4 in DDLUtils.pairs(f46_arg0[0x4DAF419B5CE4B42]) do
				f46_local4:set(0)
			end
			f46_local0 = f46_arg0[0xA616BDFE454ECB3]
			f46_local1 = f46_local0
			f46_local0 = f46_local0.set
			if f46_arg2 then
				f46_local2 = 1
				if not f46_local2 then
				else
					f46_local0(f46_local1, f46_local2)
				end
			end
			f46_local2 = 0
		end
		for f45_local9, f45_local10 in DDLUtils.ipairs(f45_local0[0xD17B4E10FA9C28C]) do
			f45_local5(f45_local10, f45_local9, false)
		end
		f45_local6 = Engine[0x1657A284F55F9CD](Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39])
		for f45_local10, f45_local16 in DDLUtils.ipairs(f45_local0[0x45B0C69A09ED208]) do
			local f45_local12 = true
			for f45_local13, f45_local14 in ipairs(f45_local6) do
				if f45_local14.bodyIndex == f45_local10 then
					local f45_local11 = Engine[0xB678B832BC9DC0](Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39], f45_local10)
					if f45_local11 and f45_local11[0xC9366DE09ED7379] == 1 then
					else
						f45_local12 = true
					end
					f45_local12 = false
				end
			end
			f45_local5(f45_local16, f45_local10, f45_local12)
		end
	else
		if f45_local4 == 1 then
			f45_local0[0xDA66F98A9232A8E]:set(2)
			f45_local1 = true
		end
		local f45_local5 = function(f47_arg0, f47_arg1, f47_arg2)
			if Engine[0x1D5921EEA87F940](f47_arg1, f47_arg2) <= f47_arg0[0xEFB826D1A3BB80A]:get() then
				f45_local1 = true
				f47_arg0[0xEFB826D1A3BB80A]:set(0)
				for f47_local3, f47_local4 in DDLUtils.pairs(f47_arg0[0x4DAF419B5CE4B42]) do
					f47_local4:set(0)
				end
			end
		end
		local f45_local6 = function(f48_arg0, f48_arg1)
			for f48_local3, f48_local4 in ipairs(Engine[0x1657A284F55F9CD](f48_arg0)) do
				if f48_local4.bodyIndex < #f48_arg1 then
					f45_local5(f48_arg1[f48_local4.bodyIndex], f48_arg0, f48_local4.bodyIndex)
				end
			end
		end
		f45_local6(Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5], f45_local0[0xD17B4E10FA9C28C])
		f45_local6(Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39], f45_local0[0x45B0C69A09ED208])
	end
	if f45_local1 then
		Engine[0x28A466EF7723621](f45_arg0, Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882])
	end
end
Lobby.Stats.InitializeCareerStats = function(f49_arg0, f49_arg1)
	local f49_local0 = Engine[0x8BF970606552F4C](f49_arg0, f49_arg1)
	if not f49_local0 then
		return
	end
	local f49_local1 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
	if Engine[0x54084D7CA2317BB]("pvp_forcePlayerTeam") == "axis" then
		f49_local1 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
	end
	f49_local0.faction:set(f49_local1)
	Engine[0x28A466EF7723621](f49_arg0, f49_arg1)
end
Lobby.Stats.SetDefaultCPLoadouts = function()
	local f50_local0 = Engine[0xC4547D19EF98B12]()
	if f50_local0 then
		local f50_local1 = Engine[0xE00B2F29271C60B](0x1C53105E8C011C4)
		local f50_local2 = Enum[0x9C0C2196D8313A0][0x60063C67132EB69]
		for f50_local3 = 1, #f50_local0.customclass, 1 do
			CoDShared.SetDefaultLoadout(f50_local0, f50_local3, f50_local1, f50_local2, nil)
		end
	end
end
function ResetZMVariants(f51_arg0)
	local f51_local0 = function(f52_arg0)
		local f52_local0 = Engine[0x8BF970606552F4C](f51_arg0, f52_arg0)
		if not f52_local0 then
			return
		end
		local f52_local1 = f52_local0.variant
		if f52_local1 then
			Engine[0x57DAE186BC06A59](f52_local1)
		end
	end
	f51_local0(Enum[0xBBD4F9E70101BA8][0x9E5D6DF436F1EE])
	f51_local0(Enum[0xBBD4F9E70101BA8][0x3376D9E1C3C8130])
	f51_local0(Enum[0xBBD4F9E70101BA8][0xA621D7C69E5741A])
end
function ResetLoadoutsForMode(f53_arg0, f53_arg1)
	if f53_arg1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		CoDLoadoutsShared[0x7243F374ADEF72D](f53_arg0, Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA], 0x705A80062BD09C2)
		CoDLoadoutsShared[0x7243F374ADEF72D](f53_arg0, Enum[0xBBD4F9E70101BA8][0xA494758C2E9B27C], 0x705A80062BD09C2)
		CoDLoadoutsShared[0x7243F374ADEF72D](f53_arg0, Enum[0xBBD4F9E70101BA8][0xF9A4C4451E3499E], 0x705A80062BD09C2)
		CoDLoadoutsShared[0x7243F374ADEF72D](f53_arg0, Enum[0xBBD4F9E70101BA8][0x67DF1879D992E], 0x4FF2B60D157BBB2)
		CoDLoadoutsShared[0x7243F374ADEF72D](f53_arg0, Enum[0xBBD4F9E70101BA8][0xCEBE62E27709AD0], 0x4FF2B60D157BBB2)
		CoDLoadoutsShared[0x7243F374ADEF72D](f53_arg0, Enum[0xBBD4F9E70101BA8][0xD062FA7B47FC13A], 0x4FF2B60D157BBB2)
	elseif f53_arg1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		local f53_local0 = function(f54_arg0)
			local f54_local0 = Engine[0x8BF970606552F4C](f53_arg0, f54_arg0)
			if not f54_local0 then
				return
			end
			local f54_local1 = f54_local0.cacLoadouts
			if f54_local1 then
				local f54_local2 = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]
				local f54_local3 = Engine[0xE00B2F29271C60B](0x9EEE28789FE067A)
				for f54_local4 = 0, #f54_local1 - 1, 1 do
					local f54_local7 = f54_local1[f54_local4]
					for f54_local8 = 1, #f54_local7.customclass, 1 do
						CoDShared.SetCustomDefaultLoadout(f54_local7, f54_local8, f54_local3, f54_local2, f54_local4)
					end
					for f54_local8 = 1, #f54_local7.bubbleGumPack, 1 do
						CoDShared.SetDefaultBubbleGumBuffs(f54_local7, f54_local8, f54_local3, f54_local2, f54_local4)
					end
				end
				Engine[0xE6C09FDF6C8D188](f53_arg0, f54_local2)
			end
		end
		f53_local0(Enum[0xBBD4F9E70101BA8][0x9E5D6DF436F1EE])
		f53_local0(Enum[0xBBD4F9E70101BA8][0x3376D9E1C3C8130])
		f53_local0(Enum[0xBBD4F9E70101BA8][0xA621D7C69E5741A])
	end
end
Lobby.Stats.OnPrePrestige = function(f55_arg0)
	local f55_local0 = f55_arg0.controller
	local f55_local1 = f55_arg0.mode
	if f55_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		Engine[0x5217EA14A38494C](f55_local0)
	end
	ResetLoadoutsForMode(f55_local0, f55_local1)
end
Lobby.Stats.OnPostPrestige = function(f56_arg0)
	local f56_local0 = f56_arg0.controller
	local f56_local1 = f56_arg0.mode
	if f56_arg0.success and f56_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		Engine[0x39A49F8F53E0E89]()
		local f56_local2 = Engine[0xA6C26EBACD7322D](f56_local0, Enum[0x303F77CADBF82AB][0xF27E237306A62E0], f56_local1)
		if f56_local2 then
			local f56_local3 = f56_local2[0xD59E8BFAC78A33B][0x1E79BD3853D120F][0x3BF77799B56C06C]:get()
			for f56_local7, f56_local8 in ipairs(Engine[0xA5B5E7CABA5C3AB](f56_local1)) do
				local f56_local9 = Engine[0xB678B832BC9DC0](f56_local1, f56_local8.bodyIndex)
				if f56_local9 and f56_local9[0x8E63886F9B0BAB] == 1 then
					Engine[0xFD8CC50F67C9E2](f56_local0, f56_local1, f56_local8.bodyIndex, 0, Enum[0xFCC6A2D2EB0FDA7][0x7852FCB3BFCC8D1], f56_local3)
				end
			end
			f56_local2[0x6BFF22CED3C153C][0x792C1F90C3A5C7F]:set(Engine[0x69811927938FCD7]())
		end
		Lobby.Stats.ValidateWZCharacterSelection(f56_local0)
		Engine[0x28A466EF7723621](f56_local0, Enum[0xBBD4F9E70101BA8][0xDF87425733853AE])
		Engine[0x6EB835BA632E5DB](f56_local0, 0x85B4E472DBA4DAA, 0)
	end
end
Lobby.Stats.OnPrePrestigeFreshStart = function(f57_arg0)
	local f57_local0 = f57_arg0.controller
	local f57_local1 = f57_arg0.mode
	if f57_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		Engine[0x5217EA14A38494C](f57_local0)
	elseif f57_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		ResetZMVariants(f57_local0)
	end
	ResetLoadoutsForMode(f57_local0, f57_local1)
end
Lobby.Stats.OnPrestigeFreshStartSuccess = function(f58_arg0) end
Lobby.Stats.OnPrestigeFreshStartFailure = function(f59_arg0) end
Lobby.Stats.OnPrestigeFreshStartPreRestart = function(f60_arg0)
	if f60_arg0.wasError == nil or f60_arg0.wasError == false then
		local f60_local0 = Engine[0x8DF2E5447F384B9]()
		f60_local0 = f60_local0:create("FreshRestartOccurred", true)
		f60_local0:set(true)
	end
end
Lobby.Stats.PopulatePrematchData = function(f61_arg0)
	local f61_local0 = f61_arg0.controller
	local f61_local1 = f61_arg0.ddlData
	if Engine[0x8BF601ABD141DF9]() then
		f61_local1.tier_boost:set(CoDShared.Loot.GetCurrentTierBoost(f61_local0))
		f61_local1.bo_pass_tier_boost:set(CoDShared.Loot.GetBOPassTierBoost(f61_local0))
		f61_local1.bo_pass_party_tier_boost:set(CoDShared.Loot.GetBOPassPartyTierBoost(f61_local0))
		if Dvar[0x89838993D5412B6]:get() == true then
			CoDShared.Loot.GetWeaponPurchasedData(f61_local0, f61_local1)
		end
		CoDShared.LootContracts.GetActiveContracts(f61_local0, f61_local1)
	end
end
