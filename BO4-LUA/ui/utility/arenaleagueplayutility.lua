CoD.ArenaLeaguePlayUtility = {}
require("x64:f3c5259f470592d")
CoD.ArenaLeaguePlaySavedLadder = {}
CoD.ArenaLeaguePlayUtility.DefaultRubyRequirement = 3
CoD.ArenaLeaguePlayUtility.MaxRubySlotsForLevel = 6
CoD.ArenaLeaguePlayUtility.GetBestLeaguePlayStats = function(f1_arg0)
	local f1_local0 = Engine[@"storagegetbuffer"](f1_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	if f1_local0 then
		return f1_local0.arenaBest.leaguePlayStats
	else
		return nil
	end
end
CoD.ArenaLeaguePlayUtility.GetCurrentLeaguePlayStats = function(f2_arg0)
	local f2_local0 = CoD.ArenaUtility.GetArenaSlot(Engine[@"getplaylistid"]())
	local f2_local1 = Engine[@"storagegetbuffer"](f2_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	if f2_local0 and f2_local1 then
		return f2_local1.arenaStats[f2_local0].leaguePlayStats
	else
		return nil
	end
end
CoD.ArenaLeaguePlayUtility.GetDivisionData = function(f3_arg0, f3_arg1)
	local f3_local0 = nil
	local f3_local1 = CoD.ArenaRankedPlayUtility.GetRank(f3_arg1) + 1
	local f3_local2 = Engine[@"hash_7A7E3CD65E63086F"](f3_arg0[@"hash_1AB48C7EDAF790D2"])
	local f3_local3 = {}
	for f3_local7, f3_local8 in ipairs(f3_local2) do
		if f3_local8[@"rankmin"] <= f3_local1 and f3_local1 <= f3_local8[@"rankmax"] and (f3_local8[@"teamonly"] ~= 1 or Engine[@"hash_1FB9BB235992D6F7"]()) then
			f3_local0 = f3_local8
			break
		end
	end
	return f3_local0
end
CoD.ArenaLeaguePlayUtility.GetPoints = function(f4_arg0)
	local f4_local0 = Dvar[@"hash_3168B1098A7F8834"]:get()
	if f4_local0 and f4_local0 > 0 then
		return f4_local0
	else
		return Engine[@"hash_508F1FE2273B46A"](f4_arg0, 0)
	end
end
CoD.ArenaLeaguePlayUtility.HasPoints = function(f5_arg0, f5_arg1)
	return CoD.ArenaLeaguePlayUtility.GetPoints(f5_arg1) > 0
end
CoD.ArenaLeaguePlayUtility.GetStreak = function(f6_arg0)
	return Engine[@"hash_25DE0C15EF8B6EB2"](f6_arg0)
end
CoD.ArenaLeaguePlayUtility.GetBestRank = function(f7_arg0)
	return Engine[@"hash_3ED02D429DCCEE76"](f7_arg0)
end
CoD.ArenaLeaguePlayUtility.GetFirstPlaceCount = function(f8_arg0)
	return Engine[@"hash_3DE17B43424AB6BA"](f8_arg0)
end
CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual = function(f9_arg0, f9_arg1)
	if f9_arg1 == nil then
		return false
	else
		return CoD.ArenaLeaguePlayUtility.GetSkillDivisionTier(CoD.ArenaLeaguePlayUtility.GetSkillDivisionRating(f9_arg0)) == f9_arg1
	end
end
CoD.ArenaLeaguePlayUtility.GetSkillDivisionRating = function(f10_arg0)
	local f10_local0 = 0
	local f10_local1 = Engine[@"storagegetbuffer"](f10_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	if f10_local1 then
		local f10_local2 = Engine[@"getcurrentarenaslot"]()
		if f10_local1.arenaStats[f10_local2] then
			f10_local0 = f10_local1.arenaStats[f10_local2].performanceValue:get()
			if f10_local0 < -1 or f10_local0 > 1 then
				f10_local0 = f10_local1.arenaBest.performanceValue:get()
			end
		end
	end
	if Dvar[@"hash_7812F2EED3017CF4"]:get() == false or f10_local0 == 0 then
		f10_local0 = -1
	end
	local f10_local2 = Dvar[@"hash_3FF458743E663EC0"]:get()
	if f10_local2 and f10_local2 >= -1 and f10_local2 <= 1 then
		f10_local0 = f10_local2
	end
	return f10_local0
end
CoD.ArenaLeaguePlayUtility.DLogSkillDivision = function(f11_arg0)
	local f11_local0 = Engine[@"storagegetbuffer"](f11_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	if f11_local0 then
		local f11_local1 = Engine[@"getcurrentarenaslot"]()
		local f11_local2 = f11_local0.arenaBest.performanceValue:get()
		local f11_local3 = CoD.ArenaLeaguePlayUtility.GetSkillDivisionTier(f11_local0.arenaBest.performanceValue:get())
		local f11_local4 = CoD.ArenaLeaguePlayUtility.GetSkillDivisionTier(f11_local0.arenaStats[f11_local1].performanceValue:get())
		if f11_local3 ~= f11_local4 or f11_local2 < -1 then
			local f11_local5
			if f11_local2 < -1 then
				f11_local5 = -1
				if not f11_local5 then
				else
					Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_68F7B5107F69C638", {
						[@"hash_7CBA99B42A817EBC"] = f11_local5,
						[@"hash_7C47473E1BF6C087"] = f11_local4,
					})
				end
			end
			f11_local5 = f11_local3
		end
	end
end
CoD.ArenaLeaguePlayUtility.GetRankAndRankData = function(f12_arg0)
	local f12_local0 = 0
	local f12_local1 = LuaUtils.GetLeaguePlayTierTable()
	if f12_local1 == nil then
		return f12_local0, f12_local1, 0, 0, 0, 0
	end
	local f12_local2 = 0
	local f12_local3 = 0
	local f12_local4 = 0
	local f12_local5 = 0
	for f12_local9, f12_local10 in ipairs(f12_local1.leagueplayranklist) do
		if f12_local10[@"hash_3FBCEAD98C734175"] == 0 then
			f12_local2 = f12_local9
		end
		if f12_local10[@"hash_662F8A6B3EB980C8"] == 0 then
			f12_local3 = f12_local9
		end
		if f12_local10[@"hash_CDCA5C2109FF5DC"] == 0 then
			f12_local4 = f12_local9
		end
		if f12_arg0 == 0 or f12_local5 + 1 <= f12_arg0 and f12_arg0 <= f12_local5 + f12_local10[@"points"] then
			f12_local0 = f12_local9
			break
		end
		f12_local5 = f12_local5 + f12_local10[@"points"]
	end
	return f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5
end
CoD.ArenaLeaguePlayUtility.GetRubyCountForRank = function(f13_arg0)
	local f13_local0 = LuaUtils.GetLeaguePlayTierTable()
	if f13_local0 == nil then
		return 0
	end
	local f13_local1 = 0
	for f13_local5, f13_local6 in ipairs(f13_local0.leagueplayranklist) do
		if f13_local5 < f13_arg0 then
		elseif f13_local5 == f13_arg0 and f13_arg0 ~= 1 then
			f13_local1 = f13_local1 + 1
		end
		f13_local1 = f13_local1 + f13_local6[@"points"]
	end
	return f13_local1
end
CoD.ArenaLeaguePlayUtility.GetRankInfoFieldAtRank = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = LuaUtils.GetLeaguePlayTierTable()
	if f14_local0 and f14_arg0 > 0 and f14_local0.leagueplayranklist and f14_local0.leagueplayranklist[f14_arg0] then
		return f14_local0.leagueplayranklist[f14_arg0][f14_arg1] or f14_arg2
	else
		return f14_arg2
	end
end
CoD.ArenaLeaguePlayUtility.GetRankIconAtRank = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4, f15_arg5)
	local f15_local0 = 0x214ECBA8C04D44C
	local f15_local1 = 0x214ECBA8C04D44C
	local f15_local2 = LuaUtils.GetLeaguePlayTierTable()
	if f15_local2 and f15_arg0 > 0 then
		local f15_local3 = f15_local2.leagueplayranklist[f15_arg0]
		if f15_arg5 <= f15_arg0 and f15_arg5 > 0 then
			f15_local0 = f15_local3[@"hash_1A57F824907CF24C"]
			f15_local1 = f15_local3[@"hash_358771E83A1EE17B"]
		elseif f15_arg4 <= f15_arg0 and f15_arg4 > 0 then
			f15_local0 = f15_local3[@"hash_34E9E4E3510C99C2"]
			f15_local1 = f15_local3[@"hash_6C624401F495A64D"]
		elseif f15_arg3 <= f15_arg0 and f15_arg3 > 0 then
			f15_local0 = f15_local3[@"hash_64926D32FD2B1F5E"]
			f15_local1 = f15_local3[@"hash_5969F43362718139"]
		elseif f15_arg2 <= f15_arg0 and f15_arg2 > 0 then
			f15_local0 = f15_local3[@"hash_51F00F09797768A4"]
			f15_local1 = f15_local3[@"hash_31B777C502D63BF3"]
		else
			f15_local0 = f15_local3[@"hash_43DC9BE37DB09A54"]
			f15_local1 = f15_local3[@"hash_49A53F16E423D3A3"]
		end
	end
	return f15_local0, f15_local1
end
CoD.ArenaLeaguePlayUtility.GetRankAndIcon = function(f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = 0x214ECBA8C04D44C
	local f16_local1 = 0x214ECBA8C04D44C
	if CoDShared.IsInGame() and not LuaUtils.IsArenaMode() then
		return 0, f16_local0, f16_local1
	end
	local f16_local2, f16_local3, f16_local4 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f16_arg0)
	if f16_local4 > 0 then
		local f16_local5 = f16_local3.leagueplayranklist[f16_local4]
		if f16_arg0 == 0 or f16_local3.tierlist[4][@"placement"] < f16_arg1 then
			f16_local0 = f16_local3[@"hash_1A8E260EBFD2E472"]
			f16_local1 = f16_local3[@"hash_66D016A95DBF812D"]
		elseif f16_arg1 == f16_local3.tierlist[1][@"placement"] then
			if f16_local3[@"masterrank"] <= f16_arg2 then
				f16_local0 = f16_local5[@"hash_1A57F824907CF24C"]
				f16_local1 = f16_local5[@"hash_358771E83A1EE17B"]
			else
				f16_local0 = f16_local5[@"hash_34E9E4E3510C99C2"]
				f16_local1 = f16_local5[@"hash_6C624401F495A64D"]
			end
		elseif f16_arg1 <= f16_local3.tierlist[2][@"placement"] and f16_arg1 then
			f16_local0 = f16_local5[@"hash_64926D32FD2B1F5E"]
			f16_local1 = f16_local5[@"hash_5969F43362718139"]
		elseif f16_arg1 <= f16_local3.tierlist[3][@"placement"] and f16_arg1 then
			f16_local0 = f16_local5[@"hash_51F00F09797768A4"]
			f16_local1 = f16_local5[@"hash_31B777C502D63BF3"]
		elseif f16_arg1 <= f16_local3.tierlist[4][@"placement"] then
			f16_local0 = f16_local5[@"hash_43DC9BE37DB09A54"]
			f16_local1 = f16_local5[@"hash_49A53F16E423D3A3"]
		end
	end
	return f16_local2, f16_local0, f16_local1
end
CoD.ArenaLeaguePlayUtility.GetBanner = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = 0x214ECBA8C04D44C
	local f17_local1 = @"hash_2C79EA24AB1A2BA"
	local f17_local2, f17_local3, f17_local4, f17_local5 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f17_arg0)
	if f17_local5 > 0 then
		local f17_local6 = f17_local3.leagueplayranklist[f17_local5]
		if f17_arg0 == 0 or f17_local3.tierlist[4][@"placement"] < f17_arg1 then
			f17_local0 = f17_local6[@"hash_3C2B4817BCA0439B"]
			f17_local1 = @"hash_4EFE33C160485A2C"
		elseif f17_arg1 <= f17_local3.tierlist[1][@"placement"] then
			if f17_local3[@"masterrank"] <= f17_arg2 then
				f17_local0 = f17_local6[@"hash_4A58229045244343"]
				f17_local1 = @"hash_5C2DBB4DDEAAE038"
			else
				f17_local0 = f17_local6[@"hash_63F32DE6EFB4165"]
				f17_local1 = @"hash_7BF6BC3B88895A2"
			end
		elseif f17_arg1 <= f17_local3.tierlist[2][@"placement"] then
			f17_local0 = f17_local6[@"hash_5683D820FAE40089"]
			f17_local1 = @"hash_43C4673AB2D80153"
		elseif f17_arg1 <= f17_local3.tierlist[3][@"placement"] then
			f17_local0 = f17_local6[@"hash_4623656EF291D2CB"]
			f17_local1 = @"hash_6A0E0FFD62BDDBA5"
		elseif f17_arg1 <= f17_local3.tierlist[4][@"placement"] then
			f17_local0 = f17_local6[@"hash_3C2B4817BCA0439B"]
			f17_local1 = @"hash_4EFE33C160485A2C"
		end
	end
	return f17_local0, f17_local1
end
CoD.ArenaLeaguePlayUtility.GetFirestreak = function(f18_arg0, f18_arg1)
	local f18_local0 = 0x214ECBA8C04D44C
	if f18_arg0 and f18_arg1 then
		local f18_local1, f18_local2, f18_local3, f18_local4, f18_local5 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f18_arg0)
		if f18_local5 > 0 then
			local f18_local6 = f18_local2.leagueplayranklist[f18_local5]
			if f18_arg1 >= 3 then
				f18_local0 = f18_local6[@"hash_66EAEDC31AD7D069"]
			elseif f18_arg1 == 2 then
				f18_local0 = f18_local6[@"hash_66EAECC31AD7CEB6"]
			elseif f18_arg1 == 1 then
				f18_local0 = f18_local6[@"hash_66EAEBC31AD7CD03"]
			end
		end
	end
	return f18_local0
end
CoD.ArenaLeaguePlayUtility.ShowSkillDivisionInformation = function()
	return Dvar[@"hash_7812F2EED3017CF4"]:get() == true
end
CoD.ArenaLeaguePlayUtility.GetSkillDivisionTier = function(f20_arg0)
	local f20_local0 = 0
	local f20_local1 = nil
	local f20_local2 = LuaUtils.GetCurrentEventEntry()
	if LuaUtils.ArenaSeasonAsset and LuaUtils.ArenaSeasonAsset.skillBuckets and f20_local2 then
		f20_local1 = LuaUtils.GetArenaSkillBucketFromEvent(f20_local2)
	end
	local f20_local3 = Engine[@"hash_2E00B2F29271C60B"](@"arena_league_play_skill_divisions_default")
	if f20_local3 and #f20_local3.skilldivisiontierlist then
		if f20_local1 == nil or #f20_local1 ~= #f20_local3.skilldivisiontierlist then
			for f20_local7, f20_local8 in ipairs(f20_local3.skilldivisiontierlist) do
				if f20_arg0 < f20_local8[@"hash_EF4A299024B430B"] then
					f20_local0 = f20_local7
				end
			end
		else
			for f20_local7, f20_local8 in ipairs(f20_local1) do
				if f20_local8.startRange <= f20_arg0 and (not (not f20_local8.endInclusive or f20_arg0 > f20_local8.endRange) or f20_arg0 < f20_local8.endRange) then
					f20_local0 = f20_local7
					break
				end
			end
		end
	end
	return f20_local0
end
CoD.ArenaLeaguePlayUtility.GetSkillDivisionBannerAndName = function(f21_arg0, f21_arg1)
	local f21_local0 = 0x214ECBA8C04D44C
	local f21_local1 = 0x214ECBA8C04D44C
	local f21_local2 = 0x214ECBA8C04D44C
	local f21_local3 = @"hash_2F88D8B975B0F42A"
	if f21_arg0 ~= nil then
		local f21_local4 = nil
		local f21_local5 = LuaUtils.GetCurrentEventEntry()
		if LuaUtils.ArenaSeasonAsset and LuaUtils.ArenaSeasonAsset.skillBuckets and f21_local5 then
			f21_local4 = LuaUtils.GetArenaSkillBucketFromEvent(f21_local5)
		end
		local f21_local6 = Engine[@"hash_2E00B2F29271C60B"](@"arena_league_play_skill_divisions_default")
		if f21_local4 == nil or #f21_local4 ~= #f21_local6.skilldivisiontierlist then
			if f21_local6 and #f21_local6.skilldivisiontierlist then
				for f21_local15, f21_local16 in ipairs(f21_local6.skilldivisiontierlist) do
					if f21_arg0 < f21_local16[@"hash_EF4A299024B430B"] then
						f21_local2 = f21_local16[@"hash_6DC1B5D80C1B7F38"]
						f21_local3 = f21_local16[@"hash_57118DE1BE688883"]
						for f21_local13, f21_local14 in ipairs(f21_local16.bannerlist) do
							if f21_arg1 <= f21_local14[@"maxplacement"] then
								f21_local0 = f21_local14[@"hash_4FF83716B23EA712"]
								f21_local1 = f21_local14[@"hash_4D851989EE1BDF5D"]
							end
						end
					end
				end
			end
		else
			for f21_local15, f21_local16 in ipairs(f21_local4) do
				if f21_local16.startRange <= f21_arg0 and (not (not f21_local16.endInclusive or f21_arg0 > f21_local16.endRange) or f21_arg0 < f21_local16.endRange) then
					local f21_local10 = f21_local6.skilldivisiontierlist[f21_local15]
					if f21_local10 then
						f21_local2 = f21_local10[@"hash_6DC1B5D80C1B7F38"]
						f21_local3 = f21_local10[@"hash_57118DE1BE688883"]
						for f21_local14, f21_local17 in ipairs(f21_local10.bannerlist) do
							if f21_arg1 <= f21_local17[@"maxplacement"] then
								f21_local0 = f21_local17[@"hash_4FF83716B23EA712"]
								f21_local1 = f21_local17[@"hash_4D851989EE1BDF5D"]
							end
						end
					end
				end
			end
		end
	end
	return f21_local0, f21_local1, f21_local2, f21_local3
end
CoD.ArenaLeaguePlayUtility.GetCurrentLeaguePlayWinStreak = function(f22_arg0)
	local f22_local0 = CoD.ArenaLeaguePlayUtility.GetCurrentLeaguePlayStats(f22_arg0)
	if f22_local0 then
		return f22_local0.firstSubdivisionRankStreak:get()
	else
		return 0
	end
end
CoD.ArenaLeaguePlayUtility.RubiesUnlockedAtRank = function(f23_arg0, f23_arg1, f23_arg2)
	if f23_arg2 < f23_arg1 then
		return CoD.ArenaLeaguePlayUtility.GetRubyRequirementForRank(f23_arg2 + 1)
	elseif f23_arg1 < f23_arg2 then
		return 0
	else
		local f23_local0, f23_local1 = CoD.ArenaLeaguePlayUtility.GetRubies(f23_arg0)
		return f23_local1
	end
end
CoD.ArenaLeaguePlayUtility.DoesRubyRequirementForModelEqualValue = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
	local f24_local0 = CoD.SafeGetModelValue(f24_arg0:getModel(), f24_arg2)
	return f24_local0 and CoD.ArenaLeaguePlayUtility.GetRubyRequirementForRank(f24_local0) == f24_arg3
end
CoD.ArenaLeaguePlayUtility.DoesRubyRequirementEqualValue = function(f25_arg0, f25_arg1)
	local f25_local0, f25_local1, f25_local2, f25_local3, f25_local4, f25_local5 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(CoD.ArenaLeaguePlayUtility.GetPoints(f25_arg0))
	return CoD.ArenaLeaguePlayUtility.GetRubyRequirementForRank(f25_local0) == f25_arg1
end
CoD.ArenaLeaguePlayUtility.DoesRankRubyRequirementEqualValue = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = CoD.SafeGetModelValue(f26_arg0 and f26_arg0:getModel(), f26_arg1)
	return f26_local0 and CoD.ArenaLeaguePlayUtility.GetRubyRequirementForRank(f26_local0) == f26_arg2
end
CoD.ArenaLeaguePlayUtility.GetRubyRequirementForRank = function(f27_arg0)
	local f27_local0 = LuaUtils.GetLeaguePlayTierTable()
	if f27_local0 and f27_arg0 > 0 and f27_arg0 <= #f27_local0.leagueplayranklist then
		return f27_local0.leagueplayranklist[f27_arg0][@"points"]
	else
		return CoD.ArenaLeaguePlayUtility.DefaultRubyRequirement
	end
end
CoD.ArenaLeaguePlayUtility.DoesRubyCountEqualValue = function(f28_arg0, f28_arg1)
	local f28_local0, f28_local1 = CoD.ArenaLeaguePlayUtility.GetRubies(CoD.ArenaLeaguePlayUtility.GetPoints(f28_arg0))
	return f28_local1 == f28_arg1
end
CoD.ArenaLeaguePlayUtility.DoesRubyCountForModelEqualValue = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
	local f29_local0 = CoD.SafeGetModelValue(f29_arg0:getModel(), f29_arg2)
	return f29_local0 and f29_local0 == f29_arg3
end
CoD.ArenaLeaguePlayUtility.GetRubies = function(f30_arg0)
	local f30_local0 = 0x214ECBA8C04D44C
	local f30_local1, f30_local2, f30_local3, f30_local4, f30_local5, f30_local6 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f30_arg0)
	if f30_local2 == nil then
		return f30_local0, 0
	else
		return f30_local2[@"hash_49A6C3D877EF1136"], f30_arg0 - f30_local6
	end
end
CoD.ArenaLeaguePlayUtility.DoesSocialArenaPointsProgressEqualValue = function(f31_arg0, f31_arg1, f31_arg2)
	local f31_local0 = CoD.SafeGetModelValue(f31_arg0:getModel(), f31_arg1)
	if f31_local0 == nil then
		return false
	else
		return CoD.ArenaLeaguePlayUtility.GetRubies(f31_local0) == f31_arg2
	end
end
CoD.ArenaLeaguePlayUtility.HasPlayerCompletedPlacementMatches = function(f32_arg0)
	return Engine[@"hash_5439AFE2B09A5DC9"](f32_arg0)
end
CoD.ArenaLeaguePlayUtility.DoesCurrentRankRequireXPoints = function(f33_arg0, f33_arg1, f33_arg2)
	local f33_local0 = f33_arg0:getModel()
	if f33_local0 then
		return f33_arg2 <= CoD.ArenaLeaguePlayUtility.GetRankInfoFieldAtRank(f33_local0.leaguePlayRank:get(), @"points", 0)
	else
		return false
	end
end
CoD.ArenaLeaguePlayUtility.LeaverLockoutActive = function()
	if Dvar[@"hash_3F1DE3CEF5A9E0DB"]:get() == false then
		return false
	end
	local f34_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "Arena"), "lockoutTimeRemaining")
	local f34_local1
	if f34_local0:get() == nil or f34_local0:get() == "" then
		f34_local1 = false
	else
		f34_local1 = true
	end
	return f34_local1
end
CoD.ArenaLeaguePlayUtility.ForceCheckLeaverLockoutActive = function()
	if Dvar[@"hash_3F1DE3CEF5A9E0DB"]:get() == false then
		return false
	end
	local f35_local0 = Engine[@"hash_277FB2E755901A66"]()
	local f35_local1 = Engine[@"hash_52C6A9625D001089"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_private"])
	local f35_local2
	if f35_local0 <= 0 then
		f35_local2 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"])
		if f35_local2 then
			if f35_local1 <= 0 then
				f35_local2 = false
			else
				f35_local2 = true
			end
		end
	else
		f35_local2 = true
	end
	return f35_local2
end
CoD.ArenaLeaguePlayUtility.GetDivisionIcon = function(f36_arg0, f36_arg1)
	local f36_local0 = nil
	if f36_arg0 ~= nil then
		if f36_arg0 == 1 then
			f36_local0 = f36_arg1[@"hash_3C7B8F7C6EB337C3"]
		elseif f36_arg0 <= 10 then
			f36_local0 = f36_arg1[@"hash_792CC3701A8811E9"]
		elseif f36_arg0 <= 25 then
			f36_local0 = f36_arg1[@"hash_792FC6701A8A4CD9"]
		end
	end
	if f36_local0 == nil then
		f36_local0 = f36_arg1[@"hash_EA19377C8CD5A1D"]
	end
	return f36_local0
end
CoD.ArenaLeaguePlayUtility.GetLeaguePlayIconAndRank = function(f37_arg0, f37_arg1, f37_arg2)
	local f37_local0, f37_local1, f37_local2 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f37_arg0, f37_arg1, f37_arg2)
	return {
		displayRank = f37_local0,
		rankIcon = f37_local1,
		rankIconLarge = f37_local2,
	}
end
DataSourceHelpers.GlobalDataSourceSetup(
	"LeaguePlayLadderMemberList",
	"LeaguePlayLadderMemberList",
	function(f38_arg0, f38_arg1)
		if not f38_arg0.count then
			local f38_local0 = f38_arg0:create("count")
			f38_local0:set(0)
		end
	end,
	false,
	{
		prepare = function(f39_arg0, f39_arg1, f39_arg2)
			if not f39_arg1._rootModel then
				f39_arg1._rootModel = DataSources.LeaguePlayLadderMemberList.getModel(f39_arg0)
				f39_arg1:subscribeToModel(f39_arg1._rootModel.count, function()
					f39_arg1:updateDataSource(false, true)
				end, false)
			end
		end,
		getCount = function(f41_arg0)
			return f41_arg0._rootModel.count:get()
		end,
		getItem = function(f42_arg0, f42_arg1, f42_arg2)
			return f42_arg1._rootModel[f42_arg2]
		end,
	}
)
DataSourceHelpers.GlobalDataSourceSetup("LeaguePlayLadder", "LeaguePlayLadder", function(f43_arg0)
	f43_arg0:create("leagueNameCode")
	f43_arg0:create("entityLadderRank")
end, false)
DataSources.LeaguePlayLadderMarkerFiller = DataSourceHelpers.ListSetup("LeaguePlayLadderMarkerFiller", function(f44_arg0)
	local f44_local0 = {}
	for f44_local1 = 1, 10, 1 do
		table.insert(f44_local0, {
			models = {
				id = f44_local1,
			},
			properties = {},
		})
	end
	return f44_local0
end, true)
DataSources.LeaguePlay = {
	PopulateWidget = function(f45_arg0, f45_arg1, f45_arg2)
		local f45_local0 = CoD.ArenaLeaguePlayUtility.GetPoints(f45_arg0)
		local f45_local1 = CoD.ArenaLeaguePlayUtility.GetStreak(f45_arg0)
		local f45_local2 = CoD.ArenaLeaguePlayUtility.GetBestRank(f45_arg0)
		local f45_local3 = CoD.ArenaLeaguePlayUtility.GetFirstPlaceCount(f45_arg0)
		local f45_local4, f45_local5, f45_local6 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f45_local0, f45_local2, f45_local3)
		local f45_local7, f45_local8 = CoD.ArenaLeaguePlayUtility.GetBanner(f45_local0, f45_local2, f45_local3)
		local f45_local9, f45_local10 = CoD.ArenaLeaguePlayUtility.GetRubies(f45_local0)
		local f45_local11 = CoD.ArenaLeaguePlayUtility.GetFirestreak(f45_local0, f45_local1)
		local f45_local12, f45_local13, f45_local14, f45_local15 = CoD.ArenaLeaguePlayUtility.GetSkillDivisionBannerAndName(CoD.ArenaLeaguePlayUtility.GetSkillDivisionRating(f45_arg0), f45_local2)
		local f45_local16 = Engine[@"hash_2BDFA234965884C0"](f45_arg0)
		local f45_local17 = LuaUtils.GetRubiesForPosition(f45_local16)
		local f45_local18 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "LeaguePlay")
		local f45_local19 = f45_local18:create("leaguePlayRank")
		f45_local19:set(f45_local4)
		f45_local19 = f45_local18:create("leaguePlayIcon")
		f45_local19:set(f45_local5)
		f45_local19 = f45_local18:create("leaguePlayIconLarge")
		f45_local19:set(f45_local6)
		f45_local19 = f45_local18:create("leaguePlayBanner")
		f45_local19:set(f45_local7)
		f45_local19 = f45_local18:create("leaguePlayBannerName")
		f45_local19:set(f45_local8)
		f45_local19 = f45_local18:create("leaguePlayRubiesIcon")
		f45_local19:set(f45_local9)
		f45_local19 = f45_local18:create("leaguePlayRubiesCount")
		f45_local19:set(f45_local10)
		f45_local19 = f45_local18:create("leaguePlaySkillDivisionGem")
		f45_local19:set(f45_local14)
		f45_local19 = f45_local18:create("leaguePlaySkillDivisionName")
		f45_local19:set(f45_local15)
		f45_local19 = f45_local18:create("leaguePlaySkillDivisionBanner")
		f45_local19:set(f45_local12)
		f45_local19 = f45_local18:create("leaguePlaySkillDivisionBannerLarge")
		f45_local19:set(f45_local13)
		f45_local19 = Engine[@"hash_1FB9BB235992D6F7"]() and @"hash_13BDB4E24C0E7309" or @"hash_4985BCDC6AB58FFF"
		local f45_local20 = f45_local18:create("ladderRankType")
		f45_local20:set(Engine[@"hash_4F9F1239CFD921FE"](f45_local19))
		f45_local20 = f45_local18:create("lastLadderRank")
		f45_local20:set(f45_local16)
		f45_local20 = f45_local18:create("lastRubyRewardCount")
		f45_local20:set(f45_local17)
		f45_local20 = f45_local18:create("firstPlaceCount")
		f45_local20:set(f45_local3)
		f45_local20 = f45_local18:create("leaguePlayFirestreakIcon")
		f45_local20:set(f45_local11)
		if f45_arg2 then
			f45_local20 = CoD.ArenaLeaguePlayUtility.GetDailyPoolBonus(f45_arg0, f45_arg2, f45_arg1)
			local f45_local21 = f45_local18:create("dailyBonusPool")
			f45_local21:set(f45_local20)
		end
	end,
	getModel = function(f46_arg0)
		local f46_local0 = Engine[@"getglobalmodel"]()
		if not f46_local0.LeaguePlay then
			local f46_local1 = f46_local0:create("LeaguePlay")
			local f46_local2 = f46_local1:create("leaguePlayName")
			f46_local2:set(@"hash_EA9804CE492884E")
			f46_local1:create("leaguePlayRank")
			f46_local1:create("leaguePlayIcon")
			f46_local1:create("leaguePlayIconLarge")
			f46_local1:create("leaguePlayBanner")
			f46_local1:create("leaguePlayBannerName")
			f46_local1:create("ladderRankType")
			f46_local1:create("ladderRank")
			f46_local1:create("dailyBonusPool")
			f46_local1:create("lastLadderRank")
			f46_local1:create("lastRubyRewardCount")
			f46_local1:create("leaguePlayRubiesIcon")
			f46_local1:create("leaguePlayRubiesCount")
			f46_local1:create("leaguePlayFirestreakIcon")
			f46_local1:create("leaguePlaySkillDivisionGem")
			f46_local1:create("leaguePlaySkillDivisionBanner")
			f46_local1:create("leaguePlaySkillDivisionBannerLarge")
			f46_local1:create("leaguePlaySkillDivisionBannerName")
			f46_local2 = f46_local1:create("rankUpUpdateRubies")
			f46_local2:set(false)
		end
		return f46_local0.LeaguePlay
	end,
}
DataSources.ArenaGauntlet = {
	PopulateWidget = function(f47_arg0)
		local f47_local0 = Engine[@"getglobalmodel"]()
		f47_local0 = f47_local0:create("ArenaGauntlet")
		local f47_local1 = 5
		local f47_local2 = 2
		local f47_local3 = 8
		local f47_local4 = f47_local0:create("title")
		f47_local4:set(@"hash_720E1BA0CC1B9064")
		f47_local4 = f47_local0:create("wins")
		f47_local4:set(f47_local1)
		f47_local4 = f47_local0:create("losses")
		f47_local4:set(f47_local2)
		f47_local4 = f47_local0:create("currentTierWinRequirement")
		f47_local4:set(f47_local3)
		f47_local4 = f47_local0:create("lossesListDataSource")
		f47_local4:set("ArenaGauntletLossesList")
		f47_local4 = f47_local0:create("rubyActive")
		f47_local4:set(true)
	end,
	getModel = function(f48_arg0)
		local f48_local0 = Engine[@"getglobalmodel"]()
		f48_local0 = f48_local0:create("ArenaGauntlet")
		f48_local0:create("title")
		f48_local0:create("wins")
		f48_local0:create("losses")
		f48_local0:create("currentTierWinRequirement")
		f48_local0:create("lossesListDataSource")
		f48_local0:create("rubyActive")
		return f48_local0
	end,
}
DataSources.ArenaGauntletLossesList = DataSourceHelpers.ListSetup("ArenaGauntletLossesList", function(f49_arg0, f49_arg1)
	local f49_local0 = {}
	local f49_local1 = 3
	local f49_local2 = 2
	for f49_local3 = 1, f49_local1, 1 do
		table.insert(f49_local0, {
			models = {
				active = f49_local3 <= f49_local2,
			},
		})
	end
	return f49_local0
end, true)
CoD.ArenaLeaguePlayUtility.GetArenaGauntletWinFillShaderVector = function(f50_arg0, f50_arg1, f50_arg2, f50_arg3, f50_arg4)
	local f50_local0 = DataSources.ArenaGauntlet.getModel(f50_arg0)
	return 0, 1, 0, (f50_local0.wins:get() or 0) / (f50_local0.currentTierWinRequirement:get() or 1)
end
CoD.ArenaLeaguePlayUtility.GetRankForEachPlacement = function(f51_arg0)
	local f51_local0 = Engine[@"storagegetbuffer"](f51_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	local f51_local1 = 0
	local f51_local2 = 0
	local f51_local3 = 0
	local f51_local4 = 0
	local f51_local5 = 0
	if f51_local0 then
		local f51_local6 = f51_local0.arenaBest.leaguePlayStats
		if f51_local6 then
			if f51_local6.firstBronzePointsBarrack:get() > 0 then
				f51_local1 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f51_local6.firstBronzePointsBarrack:get())
			end
			if f51_local6.firstSilverPointsBarrack:get() > 0 then
				f51_local2 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f51_local6.firstSilverPointsBarrack:get())
			end
			if f51_local6.firstSilverGoldPointsBarrack:get() > 0 then
				f51_local3 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f51_local6.firstSilverGoldPointsBarrack:get())
			end
			if f51_local6.firstGoldPointsBarrack:get() > 0 then
				f51_local4 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f51_local6.firstGoldPointsBarrack:get())
			end
			if f51_local6.firstDiamondPointsBarrack:get() > 0 then
				f51_local5 = CoD.ArenaLeaguePlayUtility.GetRankAndRankData(f51_local6.firstDiamondPointsBarrack:get())
			end
		end
	end
	if Dvar[@"hash_14B2B0D47C360D40"]:get() then
		return 5, 10, 15, 20, 25
	else
		return f51_local1, f51_local2, f51_local3, f51_local4, f51_local5
	end
end
DataSources.LeaguePlayPlacementPips = DataSourceHelpers.ListSetup("LeaguePlayPlacementPips", function(f52_arg0)
	local f52_local0 = {}
	local f52_local1 = Dvar[@"hash_5BBB90C70820C04"]:get()
	local f52_local2 = Engine[0x9A2CB2B8FC21A9](f52_arg0)
	local f52_local3 = {
		models = {
			on = true,
		},
	}
	local f52_local4 = {
		models = {
			on = false,
		},
	}
	for f52_local5 = 1, f52_local2, 1 do
		local f52_local8 = f52_local5
		table.insert(f52_local0, f52_local3)
	end
	local f52_local5 = math.max(0, f52_local1 - f52_local2)
	for f52_local6 = 1, f52_local5, 1 do
		local f52_local9 = f52_local6
		table.insert(f52_local0, f52_local4)
	end
	return f52_local0
end)
CoD.ArenaLeaguePlayUtility.ClearEndOfEventTrigger = function()
	local f53_local0 = Engine[@"getglobalmodel"]()
	local f53_local1 = f53_local0.Arena:create("triggerEndOfEvent")
	if f53_local1 then
		f53_local1:set(false)
	end
end
CoD.ArenaLeaguePlayUtility.OpenEndOfEventPopup = function(f54_arg0, f54_arg1)
	local f54_local0 = Engine[@"getglobalmodel"]()
	local f54_local1 = f54_local0.Arena:create("triggerEndOfEvent")
	if f54_local1 and f54_local1:get() then
		OpenOverlay(f54_arg0, "ArenaEventDone", f54_arg1, "", "")
	end
end
CoD.ArenaLeaguePlayUtility.OpenLeaguePlayEndRankUp = function(f55_arg0, f55_arg1)
	local f55_local0 = Engine[@"getglobalmodel"]()
	local f55_local1 = f55_local0.Arena:create("arenaLeaguePlayShowEndRankUp")
	if f55_local1 and f55_local1:get() == true then
		CoD.ArenaLeaguePlayUtility.ClearEndOfEventTrigger()
		OpenOverlay(f55_arg0, "LeaguePlayEndRankUp", f55_arg1, "", "")
		f55_local1:set(false)
	end
end
CoD.ArenaLeaguePlayUtility.ForceRefreshLadder = function(f56_arg0, f56_arg1)
	local f56_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "LeaguePlayLadderMemberList")
	local f56_local1 = f56_local0:create("count")
	f56_local1 = f56_local1:get() or 0
	for f56_local2 = 1, f56_local1, 1 do
		local f56_local5 = f56_local0:create(f56_local2)
		f56_local5 = f56_local5:create("xuid")
		f56_local5 = f56_local5:get()
		local f56_local6 = f56_local0:create(f56_local2)
		f56_local6 = f56_local6:create("position")
		CoD.ArenaLeaguePlaySavedLadder[f56_local2] = {
			xuid = f56_local5,
			position = f56_local6:get(),
		}
	end
	local f56_local2 = f56_local0:create("loaded")
	f56_local2:set(0)
end
CoD.ArenaLeaguePlayUtility.ForceLadderPlayerArrows = function(f57_arg0, f57_arg1)
	local f57_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "LeaguePlayLadderMemberList")
	local f57_local1 = f57_local0:create("count")
	f57_local1 = f57_local1:get()
	for f57_local2 = 1, f57_local1, 1 do
		for f57_local5 = 1, #CoD.ArenaLeaguePlaySavedLadder, 1 do
			local f57_local8 = f57_local0:create(f57_local2)
			f57_local8 = f57_local8:create("xuid")
			f57_local8 = f57_local8:get()
			local f57_local9 = f57_local0:create(f57_local2)
			f57_local9 = f57_local9:create("position")
			f57_local9 = f57_local9:get()
			local f57_local10 = CoD.ArenaLeaguePlaySavedLadder[f57_local5].xuid
			local f57_local11 = CoD.ArenaLeaguePlaySavedLadder[f57_local5].position
			if f57_local8 == f57_local10 then
				if f57_local9 < f57_local11 then
					local f57_local12 = f57_local0:create(f57_local2)
					f57_local12 = f57_local12:create("arrow")
					f57_local12:set("uie_arena_ladder_up")
				end
				if f57_local11 < f57_local9 then
					local f57_local12 = f57_local0:create(f57_local2)
					f57_local12 = f57_local12:create("arrow")
					f57_local12:set("uie_arena_ladder_down")
				end
			end
		end
	end
end
CoD.ArenaLeaguePlayUtility.DisplayRankUpIfPossible = function(f58_arg0, f58_arg1, f58_arg2)
	local f58_local0 = Engine[@"getglobalmodel"]()
	f58_local0 = f58_local0.LeaguePlay
	local f58_local1 = false
	if f58_local0 then
		local f58_local2 = f58_local0.lastLadderRank:get()
		local f58_local3 = LuaUtils.GetLeaguePlayTierTable()
		if f58_local2 and f58_local2 <= (f58_local3 and f58_local3.tierlist[4][@"placement"]) then
			f58_local1 = true
		end
	end
	if f58_local1 then
		local f58_local3 = OpenOverlay(f58_arg0, "LeaguePlayEndRankUpAnim", f58_arg2, nil)
	end
	GoBack(f58_arg0, f58_arg2)
end
CoD.ArenaLeaguePlayUtility.LevelUpPlacementUpdateDelay = 1000
CoD.ArenaLeaguePlayUtility.LevelUpRubyDelay = 2000
CoD.ArenaLeaguePlayUtility.SetupRankUpInfo = function(f59_arg0, f59_arg1)
	local f59_local0 = Engine[@"getglobalmodel"]()
	f59_local0 = f59_local0.LeaguePlay
	if f59_local0 then
		f59_local0.rankUpUpdateRubies:set(false)
		local f59_local1 = CoD.ArenaLeaguePlayUtility.GetPoints(f59_arg1)
		f59_arg0._startPoints = f59_local1 - LuaUtils.GetRubiesForPosition(Engine[@"hash_2BDFA234965884C0"](f59_arg1)) or 0
		f59_arg0._endPoints = f59_local1
		f59_arg0._currentPoints = f59_arg0._startPoints
		if CoD.BaseUtility.IsDvarEnabled("ui_fakeArenaLevelUp") then
			f59_arg0._startPoints = 22
			f59_arg0._endPoints = 25
			f59_arg0._currentPoints = f59_arg0._startPoints
		end
		local f59_local2, f59_local3, f59_local4 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f59_arg0._currentPoints, f59_local0.lastLadderRank:get(), f59_local0.firstPlaceCount:get())
		f59_local0.leaguePlayRank:set(f59_local2)
		f59_local0.leaguePlayIcon:set(f59_local3)
		f59_local0.leaguePlayIconLarge:set(f59_local4)
	end
end
CoD.ArenaLeaguePlayUtility.AnimateRankUp = function(f60_arg0, f60_arg1)
	local f60_local0 = Engine[@"getglobalmodel"]()
	f60_local0 = f60_local0.LeaguePlay
	if f60_local0 then
		local f60_local1 = LuaUtils.GetLeaguePlayTierTable()
		local f60_local2 = f60_local1 and f60_local1.tierlist[1][@"placement"]
		local f60_local3 = CoD.ArenaLeaguePlayUtility.GetBestRank(f60_arg1)
		local f60_local4 = f60_local0.lastLadderRank:get()
		if f60_local3 ~= f60_local2 then
			local f60_local5 = LuaUtils.GetLeaguePlacementTierForPosition(f60_local3)
			local f60_local6 = LuaUtils.GetLeaguePlacementTierForPosition(f60_local4)
			if f60_local5 and f60_local6 and f60_local6 < f60_local5 then
				f60_arg0:addElement(LUI.UITimer.newElementTimer(CoD.ArenaLeaguePlayUtility.LevelUpPlacementUpdateDelay, true, function()
					local f61_local0, f61_local1, f61_local2 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f60_arg0._startPoints, f60_local4, f60_local0.firstPlaceCount:get())
					f60_local0.leaguePlayIconLarge:set(f61_local2)
				end))
			end
		end
		f60_arg0:addElement(LUI.UITimer.newElementTimer(CoD.ArenaLeaguePlayUtility.LevelUpRubyDelay, true, function()
			f60_local0.rankUpUpdateRubies:set(true)
		end))
	end
end
CoD.ArenaLeaguePlayUtility.SetInitialRankRubyState = function(f63_arg0, f63_arg1, f63_arg2)
	local f63_local0 = Engine[@"getglobalmodel"]()
	f63_local0 = f63_local0.LeaguePlay
	if f63_local0 then
		local f63_local1 = CoD.ArenaLeaguePlayUtility.GetRankInfoFieldAtRank(f63_local0.leaguePlayRank:get(), @"points")
		if f63_arg0._startPoints and f63_local1 and f63_local1 ~= 0 then
			local f63_local2, f63_local3 = CoD.ArenaLeaguePlayUtility.GetRubies(f63_arg0._startPoints)
			local f63_local4 = f63_arg1.Ruby
			for f63_local5 = 1, f63_local3, 1 do
				local f63_local8 = f63_local4["Ruby" .. f63_local5]
				if f63_local8 then
					f63_local8:playClip("Filled")
				end
			end
		end
	end
end
CoD.ArenaLeaguePlayUtility.AnimateRankUpRubies = function(f64_arg0, f64_arg1, f64_arg2)
	local f64_local0 = f64_arg1
	local f64_local1 = Engine[@"getglobalmodel"]()
	f64_local1 = f64_local1.LeaguePlay
	if f64_local1 and f64_arg0._currentPoints < f64_arg0._endPoints then
		local f64_local2 = -1
		local f64_local3 = f64_local1.firstPlaceCount:get()
		local f64_local4 = f64_local1.lastLadderRank:get()
		local f64_local5 = CoD.ArenaLeaguePlayUtility.GetRankInfoFieldAtRank(f64_local1.leaguePlayRank:get(), @"points")
		local f64_local6, f64_local7 = CoD.ArenaLeaguePlayUtility.GetRubies(f64_arg0._currentPoints)
		local f64_local8 = f64_local7 + 1
		local f64_local9 = function(f65_arg0)
			local f65_local0, f65_local1, f65_local2 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f64_arg0._currentPoints + 1, f64_local4, f64_local3)
			f64_local1.leaguePlayRank:set(f65_local0)
			f64_local1.leaguePlayIcon:set(f65_local1)
			f64_local1.leaguePlayIconLarge:set(f65_local2)
		end
		local f64_local10 = function()
			local f66_local0 = CoD.ArenaLeaguePlayUtility.MaxRubySlotsForLevel
			for f66_local1 = 1, f66_local0, 1 do
				local f66_local4 = f64_local0["Ruby" .. f66_local1]
				if f66_local4 then
					f66_local4:registerEventHandler("clip_over", LUI.UIElement.clipOver)
					f66_local4:playClip("DefaultClip")
				end
			end
		end
		if f64_local5 <= f64_local7 then
			f64_local10()
			f64_local8 = 1
			local f64_local11 = f64_local9
			f64_local11(f64_arg0._currentPoints + 1)
		end
		local f64_local12 = function(f67_arg0, f67_arg1)
			if f67_arg1 then
				f64_local10()
				f67_arg0 = 1
			end
			if f64_arg0._currentPoints < f64_arg0._endPoints then
				local f67_local0 = f64_local0["Ruby" .. f67_arg0]
				if f67_local0 then
					f67_local0:playClip("Filling")
				end
				f67_local0:registerEventHandler("clip_over", function(element, event)
					local f68_local0 = false
					f64_arg0._currentPoints = f64_arg0._currentPoints + 1
					if f64_arg0._currentPoints + 1 <= f64_arg0._endPoints and f64_local5 == f67_arg0 then
						f64_local9(f64_arg0._currentPoints + 1)
						f68_local0 = true
					else
						f67_arg0 = f67_arg0 + 1
					end
					f64_local11(f67_arg0, f68_local0)
				end)
			end
		end
		f64_local12(f64_local8)
	end
end
CoD.ArenaLeaguePlayUtility.GetRewardsForRankUp = function(f69_arg0)
	local f69_local0 = Engine[@"getglobalmodel"]()
	if f69_local0.LeaguePlay then
		local f69_local1 = CoD.ArenaLeaguePlayUtility.GetPoints(f69_arg0)
		local f69_local2 = f69_local1 - LuaUtils.GetRubiesForPosition(Engine[@"hash_2BDFA234965884C0"](f69_arg0))
		local f69_local3 = 0
		local f69_local4 = 0
		for f69_local5 = f69_local2 + 1, f69_local1, 1 do
			local f69_local8 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f69_local5, 0, 0)
			if f69_local8 ~= f69_local3 then
				f69_local4 = CoD.ArenaLeaguePlayUtility.GetRubyCountForRank(f69_local8)
			end
			if f69_local5 == f69_local4 then
				f69_local3 = f69_local8
				local f69_local9 = CoD.ArenaLeaguePlayUtility.GetRankInfoFieldAtRank(f69_local3, "rankrewards", nil)
				if f69_local9 then
					return f69_local9
				end
			end
		end
	end
	return nil
end
CoD.ArenaLeaguePlayUtility.ShouldShowLeaguePlayRankReward = function(f70_arg0)
	local f70_local0 = CoD.ArenaLeaguePlayUtility.GetRewardsForRankUp(f70_arg0)
	if f70_local0 then
		return #f70_local0 > 0
	else
		return false
	end
end
CoD.ArenaLeaguePlayUtility.SetupLeaguePlayRankReward = function(f71_arg0)
	local f71_local0 = DataSources.LeaguePlayRankUpRewards:getModel()
	if f71_local0 then
		local f71_local1 = CoD.ArenaLeaguePlayUtility.GetRewardsForRankUp(f71_arg0)
		if f71_local1 and f71_local1[1] then
			f71_local0.rewardImage:set(Engine[@"converttoxhash"](f71_local1[1][@"rewarditem"]))
		end
	end
end
CoD.ArenaLeaguePlayUtility.OpenLeaguePlayRankRewardsIfPossible = function(f72_arg0, f72_arg1)
	if CoD.ArenaLeaguePlayUtility.ShouldShowLeaguePlayRankReward(f72_arg1) then
		OpenOverlay(f72_arg0, "LeaguePlayEndRankUpRewards", f72_arg1, "", "")
	end
	GoBack(f72_arg0, f72_arg1)
end
DataSources.LeaguePlayRankUpRewards = {
	getModel = function()
		local f73_local0 = Engine[@"getglobalmodel"]()
		f73_local0 = f73_local0:get("LeaguePlayRankUpRewards")
		if not f73_local0 then
			local f73_local1 = Engine[@"getglobalmodel"]()
			f73_local0 = f73_local1:create("LeaguePlayRankUpRewards")
			f73_local0:create("rewardImage")
		end
		return f73_local0
	end,
}
CoD.ArenaLeaguePlayUtility.UpdateLastRubyRewardCount = function(f74_arg0)
	local f74_local0 = LuaUtils.GetRubiesForPosition(Engine[@"hash_2BDFA234965884C0"](f74_arg0))
	local f74_local1 = DataSources.LeaguePlay
	if f74_local1 then
		f74_local1 = DataSources.LeaguePlay:getModel()
	end
	if f74_local1 and f74_local1.lastRubyRewardCount then
		f74_local1.lastRubyRewardCount:set(f74_local0)
	end
end
CoD.ArenaLeaguePlayUtility.CheckLeagueID = function(f75_arg0, f75_arg1)
	local f75_local0 = false
	if not IsPlayerConnectedToCodServers(f75_arg0) then
		return f75_local0
	end
	local f75_local1 = LuaUtils.GetCurrentEventEntry()
	if not f75_local1 or f75_local1.eventType ~= Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		return f75_local0
	end
	local f75_local2 = f75_local1.leagueID
	local f75_local3 = Engine[@"storagegetbuffer"](f75_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	if f75_local3 and f75_local2 then
		local f75_local4 = f75_local3.arenaStats
		if f75_local4 then
			local f75_local5 = f75_local4[f75_arg1]
			if f75_local5 then
				local f75_local6 = f75_local5.leaguePlayStats.leagueID:get()
				if f75_local6 and f75_local2 ~= f75_local6 then
					local f75_local7 = f75_local5.performanceValue:get()
					if Dvar[@"hash_7812F2EED3017CF4"]:get() == true and f75_local7 >= -1 and f75_local7 <= 1 then
						f75_local3.arenaBest.performanceValue:set(f75_local7)
					end
					CoD.ArenaLeaguePlayUtility.SetLeagueIDForProcessing(f75_arg0, f75_local3.arenaBest.leaguePlayStats, f75_local5, f75_local6)
					CoD.ArenaLeaguePlayUtility.ClearSlot(f75_local5, f75_local2)
					f75_local0 = true
					local f75_local8 = Engine[@"getglobalmodel"]()
					if f75_local8 then
						if f75_local8.Arena then
							local f75_local9 = f75_local8.Arena:create("triggerDelayedResultsPopup")
							f75_local9:set(true)
						end
						if f75_local8.LeaguePlayLadder and f75_local8.LeaguePlayLadder.entityLadderRank then
							f75_local8.LeaguePlayLadder.entityLadderRank:set(0)
						end
					end
				end
			end
		end
	end
	return f75_local0
end
CoD.ArenaLeaguePlayUtility.IsProcessingLeagueID = function()
	local f76_local0 = DataSources.Arena.getModel()
	if f76_local0 then
		local f76_local1 = f76_local0.processingEvent
		local f76_local2 = f76_local0.processingEvent:get()
	end
	return f76_local1 and f76_local2 or CoD.BaseUtility.IsDvarEnabled("ui_wlhLobbyResultsDelayMessage")
end
CoD.ArenaLeaguePlayUtility.CheckIfProcessingLeagueID = function(f77_arg0)
	local f77_local0 = Engine[@"storagegetbuffer"](f77_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
	if f77_local0 and f77_local0.arenaBest.leaguePlayStats.processLeagueID:get() > 0 then
		CoD.ArenaUtility.SetArenaModel("processingEvent", true)
	end
end
CoD.ArenaLeaguePlayUtility.SetLeagueIDForProcessing = function(f78_arg0, f78_arg1, f78_arg2, f78_arg3)
	if f78_arg2 and f78_arg1 and f78_arg2.leaguePlayStats.matchesStats.matchCount:get() > 0 and CoD.ArenaLeaguePlayUtility.HasPlayerCompletedPlacementMatches(f78_arg0) then
		f78_arg1.processLeagueID:set(f78_arg3)
		CoD.ArenaUtility.SetArenaModel("processingEvent", true)
	end
end
CoD.ArenaLeaguePlayUtility.ClearSlot = function(f79_arg0, f79_arg1)
	if f79_arg0 ~= nil then
		local f79_local0 = f79_arg0.leaguePlayStats
		f79_local0.leagueID:set(f79_arg1)
		f79_local0.leagueNameCode:set(0)
		f79_local0.subdivisionPoints:set(0)
		f79_local0.subdivisionRank:set(0)
		f79_local0.dailyBonusPool:set(0)
		f79_local0.dailyBonusPoolTimeRemaining:set(0)
		f79_arg0.performanceValue:set(-2)
		CoD.ArenaUtility.ClearMatchesStats(f79_local0.matchesStats)
	end
end
CoD.ArenaLeaguePlayUtility.UpdateLeaderboardMarkerInternal = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3, f80_arg4)
	if f80_arg2 == nil then
		return
	elseif type(f80_arg3) == "string" then
		f80_arg3 = tonumber(f80_arg3)
	end
	if type(f80_arg4) == "string" then
		f80_arg4 = tonumber(f80_arg4)
	end
	local f80_local0 = GetListItem(f80_arg0, f80_arg1)
	local f80_local1 = f80_local0.currentStartRow
	if not f80_local1 then
		return
	end
	local f80_local2 = f80_local1 + f80_local0.vCount - 1
	local f80_local3, f80_local4, f80_local5, f80_local6 = f80_local0:getLocalRect()
	local f80_local7 = f80_local4
	local f80_local8 = f80_local6
	local f80_local9 = 0
	local f80_local10 = f80_local0.widgetType.__defaultHeight
	local f80_local11 = f80_local0.spacing
	local f80_local12 = f80_local0._rootModel
	local f80_local13 = f80_local12:create("count")
	f80_local13 = f80_local13:get()
	local f80_local14 = -1
	local f80_local15 = -1
	for f80_local16 = 1, f80_local13, 1 do
		local f80_local19 = f80_local12:create(f80_local16)
		f80_local19 = f80_local19:create("position")
		f80_local19 = f80_local19:get()
		if f80_arg3 <= f80_local19 and f80_local19 <= f80_arg4 then
			if f80_local14 == -1 then
				f80_local14 = f80_local16
			end
			f80_local15 = f80_local16
		end
	end
	local f80_local16 = function(f81_arg0)
		local f81_local0
		if f80_local1 > f81_arg0 or f81_arg0 > f80_local2 then
			f81_local0 = false
		else
			f81_local0 = true
		end
		return f81_local0
	end
	local f80_local17 = function(f82_arg0)
		local f82_local0 = f82_arg0 * f80_local10 + f80_local4
		if 0 < f82_arg0 then
			f82_local0 = f82_local0 + (f82_arg0 - 1) * f80_local11
		end
		return f82_local0
	end
	if f80_local16(f80_local14) then
		f80_local7 = f80_local17(f80_local14 - f80_local1)
		f80_local9 = 1
	end
	if f80_local16(f80_local15) then
		f80_local8 = f80_local17(f80_local15 - f80_local1 + 1)
		f80_local9 = 1
	end
	if f80_local14 < f80_local1 and f80_local2 < f80_local15 then
		f80_local9 = 1
	end
	f80_arg2:setTopBottom(true, false, f80_local7, f80_local8)
	f80_arg2:setAlpha(f80_local9)
end
CoD.ArenaLeaguePlayUtility.UpdateLeaderboardMarker = function(f83_arg0, f83_arg1, f83_arg2, f83_arg3, f83_arg4)
	CoD.ArenaUtility.DelayFuncCall(f83_arg0, 0, CoD.ArenaLeaguePlayUtility.UpdateLeaderboardMarkerInternal, {
		f83_arg0,
		f83_arg1,
		f83_arg2,
		f83_arg3,
		f83_arg4,
	})
end
CoD.ArenaLeaguePlayUtility.FillRubyList = function(f84_arg0, f84_arg1)
	if f84_arg1 then
		if f84_arg1.rubiesList then
			f84_arg1.rubiesList:setDataSource("LeaguePlayLadderMarkerFiller")
		end
		if f84_arg1.rubiesListSlot then
			f84_arg1.rubiesListSlot:setDataSource("LeaguePlayLadderMarkerFiller")
		end
	end
end
CoD.ArenaLeaguePlayUtility.UpdateLadderListMemberRubyCountInternal = function(f85_arg0, f85_arg1)
	local f85_local0 = GetListItem(f85_arg0, f85_arg1)
	local f85_local1 = f85_local0._rootModel
	local f85_local2 = f85_local1:create("count")
	f85_local2 = f85_local2:get()
	for f85_local3 = 1, f85_local2, 1 do
		local f85_local6 = f85_local1:create(f85_local3)
		f85_local6 = f85_local6:create("xuid")
		local f85_local7 = Engine[@"hash_62000A30A9678274"](f85_local6:get())
		local f85_local8, f85_local9 = CoD.ArenaLeaguePlayUtility.GetRubies(f85_local7.points)
		local f85_local10 = f85_local1:create(f85_local3)
		f85_local10 = f85_local10:create("rubiesCount")
		f85_local10:set(f85_local9)
	end
end
CoD.ArenaLeaguePlayUtility.UpdateLadderListMemberRubyCount = function(f86_arg0, f86_arg1)
	CoD.ArenaUtility.DelayFuncCall(f86_arg0, 0, CoD.ArenaLeaguePlayUtility.UpdateLadderListMemberRubyCountInternal, {
		f86_arg0,
		f86_arg1,
	})
end
CoD.ArenaLeaguePlayUtility.UpdateLadderListCurrentPlayerFocusInternal = function(f87_arg0, f87_arg1)
	local f87_local0 = GetListItem(f87_arg0, f87_arg1)
	local f87_local1 = f87_local0._rootModel
	local f87_local2 = f87_local1:create("count")
	f87_local2 = f87_local2:get()
	local f87_local3 = Engine[@"getxuid64"](Engine[@"getprimarycontroller"]())
	for f87_local4 = 1, f87_local2, 1 do
		local f87_local7 = f87_local1:create(f87_local4)
		f87_local7 = f87_local7:create("xuid")
		if f87_local7:get() == f87_local3 then
			local f87_local8 = f87_local0:getItemAtPosition(f87_local4, 1, true)
			if f87_local8 then
				local f87_local9 = math.floor(f87_local0.vCount / 2)
				for f87_local10 = 1, f87_local9, 1 do
					local f87_local13 = f87_local4 + f87_local9 - f87_local10
					if f87_local13 <= f87_local2 then
						local f87_local14 = f87_local0:getItemAtPosition(f87_local13, 1, true)
						if f87_local14 then
							f87_local0:setActiveItem(f87_local14)
							break
						end
					end
				end
				f87_local0:setActiveItem(f87_local8)
				f87_local0:giveFocusToActiveWidget()
			end
		end
	end
end
CoD.ArenaLeaguePlayUtility.UpdateLadderListCurrentPlayerFocus = function(f88_arg0, f88_arg1)
	CoD.ArenaUtility.DelayFuncCall(f88_arg0, 0, CoD.ArenaLeaguePlayUtility.UpdateLadderListCurrentPlayerFocusInternal, {
		f88_arg0,
		f88_arg1,
	})
end
CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRubiesCountFromXuid = function(f89_arg0)
	local f89_local0 = Engine[@"hash_62000A30A9678274"](f89_arg0)
	local f89_local1, f89_local2 = CoD.ArenaLeaguePlayUtility.GetRubies(f89_local0.points)
	return f89_local2
end
CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankFromXuid = function(f90_arg0)
	local f90_local0 = 0x214ECBA8C04D44C
	local f90_local1 = nil
	local f90_local2 = ""
	if f90_arg0 ~= 0 then
		local f90_local3 = Engine[@"hash_62000A30A9678274"](f90_arg0)
		f90_local2, f90_local0, f90_local1 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f90_local3.points, f90_local3.bestSubdivisionRank, f90_local3.firstSubdivisionRankTotal)
	end
	return f90_local2
end
CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankIconFromXuid = function(f91_arg0)
	local f91_local0 = Engine[@"hash_62000A30A9678274"](f91_arg0)
	local f91_local1, f91_local2, f91_local3 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f91_local0.points, f91_local0.bestSubdivisionRank, f91_local0.firstSubdivisionRankTotal)
	return f91_local3
end
CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSkillDivisionIconFromXuid = function(f92_arg0)
	if f92_arg0 == 0 or Dvar[@"hash_7812F2EED3017CF4"]:get() ~= true then
		return 0x214ECBA8C04D44C
	end
	local f92_local0 = Engine[@"hash_62000A30A9678274"](f92_arg0)
	if f92_local0.performanceValue == 0 then
		f92_local0.performanceValue = -2
	end
	local f92_local1, f92_local2, f92_local3, f92_local4 = CoD.ArenaLeaguePlayUtility.GetSkillDivisionBannerAndName(f92_local0.performanceValue, f92_local0.bestSubdivisionRank)
	return f92_local2
end
CoD.ArenaLeaguePlayUtility.GetClientSkillDivisionIconLage = function(f93_arg0)
	if f93_arg0 == 0 or Dvar[@"hash_7812F2EED3017CF4"]:get() ~= true then
		return 0x214ECBA8C04D44C
	end
	local f93_local0 = Engine[@"hash_62000A30A9678274"](f93_arg0)
	if f93_local0.performanceValue == 0 then
		f93_local0.performanceValue = -2
	end
	local f93_local1, f93_local2, f93_local3, f93_local4 = CoD.ArenaLeaguePlayUtility.GetSkillDivisionBannerAndName(f93_local0.performanceValue, f93_local0.bestSubdivisionRank)
	return f93_local2
end
CoD.ArenaLeaguePlayUtility.GetClientSkillDivisionIconSmall = function(f94_arg0)
	if f94_arg0 == 0 or Dvar[@"hash_7812F2EED3017CF4"]:get() ~= true then
		return 0x214ECBA8C04D44C
	end
	local f94_local0 = Engine[@"hash_62000A30A9678274"](f94_arg0)
	if f94_local0.performanceValue == 0 then
		f94_local0.performanceValue = -2
	end
	local f94_local1, f94_local2, f94_local3, f94_local4 = CoD.ArenaLeaguePlayUtility.GetSkillDivisionBannerAndName(f94_local0.performanceValue, f94_local0.bestSubdivisionRank)
	return f94_local1
end
CoD.ArenaLeaguePlayUtility.GetClientSkillDivisionIconForScoreboardSmall = function(f95_arg0)
	if f95_arg0 == 0 or LuaUtils.IsArenaMode() == false or Dvar[@"hash_7812F2EED3017CF4"]:get() ~= true then
		return 0x214ECBA8C04D44C
	end
	local f95_local0 = Engine[@"hash_62000A30A9678274"](f95_arg0)
	if f95_local0.performanceValue == 0 then
		f95_local0.performanceValue = -2
	end
	local f95_local1, f95_local2, f95_local3, f95_local4 = CoD.ArenaLeaguePlayUtility.GetSkillDivisionBannerAndName(f95_local0.performanceValue, f95_local0.bestSubdivisionRank)
	return f95_local1
end
CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSmallRankIconFromXuid = function(f96_arg0)
	local f96_local0 = 0x214ECBA8C04D44C
	local f96_local1 = nil
	local f96_local2 = 0
	if f96_arg0 ~= 0 then
		local f96_local3 = Engine[@"hash_62000A30A9678274"](f96_arg0)
		f96_local2, f96_local0, f96_local1 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f96_local3.points, f96_local3.bestSubdivisionRank, f96_local3.firstSubdivisionRankTotal)
	end
	return f96_local0
end
CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerFirstPlaceStreakFromXuid = function(f97_arg0)
	local f97_local0 = Engine[@"hash_62000A30A9678274"](f97_arg0)
	return f97_local0.firstSubdivisionRankStreak
end
CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerBestFirstPlaceStreakFromXuid = function(f98_arg0)
	local f98_local0 = Engine[@"hash_62000A30A9678274"](f98_arg0)
	return f98_local0.bestFirstSubdivisionRankStreak
end
CoD.ArenaLeaguePlayUtility.GetPlayerBestCurrentEventGameStreakFromXuid = function(f99_arg0)
	local f99_local0 = Engine[@"hash_62000A30A9678274"](f99_arg0)
	return f99_local0.bestCurrentEventGameStreak
end
CoD.ArenaLeaguePlayUtility.GetPlayerFireStreak = function(f100_arg0)
	local f100_local0 = f100_arg0
	if f100_local0 ~= 0 then
		local f100_local1 = Engine[@"hash_62000A30A9678274"](f100_local0)
		return CoD.ArenaLeaguePlayUtility.GetFirestreak(f100_local1.points, f100_local1.firstSubdivisionRankStreak)
	else
		return 0x214ECBA8C04D44C
	end
end
CoD.ArenaLeaguePlayUtility.ConvertLadderNameCode = function(f101_arg0)
	local f101_local0 = 87
	local f101_local1 = 10
	if type(f101_arg0) == "string" then
		f101_arg0 = tonumber(f101_arg0)
	end
	local f101_local2 = f101_arg0
	local f101_local3 = (f101_local2 + 1) % f101_local1
	if f101_local3 <= 0 or not f101_local3 then
		f101_local3 = f101_local1
	end
	local f101_local4 = math.floor(f101_local2 / f101_local1 + 1) % f101_local1
	if f101_local4 <= 0 or not f101_local4 then
		f101_local4 = f101_local1
	end
	local f101_local5 = math.floor(f101_local2 / f101_local1 * f101_local1 + 1) % f101_local0
	if f101_local5 <= 0 or not f101_local5 then
		f101_local5 = f101_local0
	end
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_6CAC84E90D9B659", Engine[@"localize"]("ARENA/ARENA_LEAGUE_PLAY_SUBDIVISION_NAME_" .. tostring(f101_local5)), Engine[@"localize"]("ARENA/ARENA_LEAGUE_PLAY_SUBDIVISION_NAME_NUMBER_" .. tostring(f101_local4)), Engine[@"localize"]("ARENA/ARENA_LEAGUE_PLAY_SUBDIVISION_NAME_NUMBER_" .. tostring(f101_local3)))
end
CoD.ArenaLeaguePlayUtility.GetNextLeagueRank = function(f102_arg0)
	return Engine[@"localize"](@"menu/rank_n", tonumber(f102_arg0) + 1)
end
CoD.ArenaLeaguePlayUtility.SetRubyCountText = function(f103_arg0)
	return Engine[@"localize"](@"hash_531CC98FCE0C52B1", f103_arg0)
end
CoD.ArenaLeaguePlayUtility.GetRubyRequirementFromRank = function(f104_arg0)
	return CoD.ArenaLeaguePlayUtility.GetRubyRequirementForRank(tonumber(f104_arg0))
end
CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed = function(f105_arg0, f105_arg1)
	return Engine[@"hash_5439AFE2B09A5DC9"](f105_arg1) and Engine[@"hash_3A7B974CED336CF1"](f105_arg1, CoD.ArenaUtility.GetArenaSlotFromPlaylistOrEngine()) > 0
end
CoD.ArenaLeaguePlayUtility.GetDailyBonusPoolTimeRemaining = function(f106_arg0, f106_arg1)
	local f106_local0 = 0
	if 0 < Engine[@"hash_3A7B974CED336CF1"](f106_arg0, f106_arg1) then
		local f106_local1 = Engine[@"hash_D14A07FB4576C5F"](f106_arg0, f106_arg1)
		local f106_local2 = Engine[@"systemtimeuint64"]()
		if f106_local2 < f106_local1 then
			f106_local0 = f106_local1 - f106_local2
		end
	end
	return f106_local0
end
CoD.ArenaLeaguePlayUtility.GetDailyPoolBonus = function(f107_arg0, f107_arg1, f107_arg2)
	return Engine[@"hash_6C76238C78E8BFC8"](f107_arg0, f107_arg2)
end
CoD.ArenaLeaguePlayUtility.PopulateLeaguePlayDatasources = function(f108_arg0)
	DataSources.LeaguePlay.PopulateWidget(f108_arg0, CoD.ArenaUtility.GetArenaSlot(Engine[@"getplaylistid"]()), LuaUtils.GetCurrentEventData())
end
CoD.ArenaLeaguePlayUtility.ShowPlacementMatchesPopup = function(f109_arg0)
	local f109_local0 = CoD.ArenaUtility.IsArenaLeaguePlay()
	if f109_local0 then
		if Engine[@"hash_5439AFE2B09A5DC9"](f109_arg0) and Dvar[@"hash_31FB7900B3237E22"]:get() == -1 then
			f109_local0 = false
		else
			f109_local0 = true
		end
	end
	return f109_local0
end
CoD.ArenaLeaguePlayUtility.ShowArenaPlacement = function(f110_arg0)
	if CoD.ArenaUtility.IsArenaLeaguePlay() then
		local f110_local0 = CoD.ArenaUtility.GetArenaSlotFromPlaylistOrEngine()
		if Engine[@"getdvarbool"]("arena_league_play_show_division_placement") == true then
			return true
		end
		if Engine[@"hash_3A7B974CED336CF1"](f110_arg0, f110_local0) == 1 or Engine[0x9A2CB2B8FC21A9](f110_arg0) == Dvar[@"hash_5BBB90C70820C04"]:get() then
			return true
		end
	end
	return false
end
CoD.ArenaLeaguePlayUtility.ShouldShowLeaguePlayLadderResults = function(f111_arg0)
	if CoD.ArenaUtility.IsArenaLeaguePlay() and Engine[@"hash_5439AFE2B09A5DC9"](f111_arg0) then
		local f111_local0 = LuaUtils.GetCurrentEventEntry()
		if f111_local0 and f111_local0.leagueID then
			local f111_local1 = CoD.ArenaUtility.GetArenaSlotFromPlaylistOrEngine()
			if Engine[@"hash_1FCBF58203F54D39"](f111_arg0, f111_local1) == f111_local0.leagueID and Engine[@"hash_3A7B974CED336CF1"](f111_arg0, f111_local1) > 0 then
				return true
			end
		end
	end
	return false
end
CoD.ArenaLeaguePlayUtility.AARLadderBonusText = function(f112_arg0, f112_arg1)
	return Engine[@"hash_3A7B974CED336CF1"](f112_arg0, CoD.ArenaUtility.GetArenaSlotFromPlaylistOrEngine()) and 0x6CC918ABE57B73 or @"hash_1193C2AA115E0307"
end
CoD.ArenaLeaguePlayUtility.GetCompletedPlacementMatchesProgressString = function(f113_arg0, f113_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](f113_arg1, "", Dvar[@"hash_5BBB90C70820C04"]:get())
end
CoD.ArenaLeaguePlayUtility.GetCompletedPlacementMatchesString = function(f114_arg0, f114_arg1)
	return tostring(Engine[0x9A2CB2B8FC21A9](f114_arg0))
end
CoD.ArenaLeaguePlayUtility.GetMaxMatchesProgressString = function(f115_arg0, f115_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](f115_arg1, Dvar[@"hash_5BBB90C70820C04"]:get())
end
CoD.ArenaLeaguePlayUtility.GetMatchesLeftProgressString = function(f116_arg0, f116_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](f116_arg1, math.max(Dvar[@"hash_5BBB90C70820C04"]:get() - Engine[0x9A2CB2B8FC21A9](f116_arg0), 0))
end
CoD.ArenaLeaguePlayUtility.GetFirestreakFromSocialPlayerInfo = function(f117_arg0, f117_arg1)
	local f117_local0 = f117_arg0 and f117_arg0:getModel()
	local f117_local1 = f117_local0
	local f117_local2 = f117_local0.arenaLeaguePlayPoints
	if f117_local2 then
		f117_local2 = f117_local1 and f117_local0.arenaLeaguePlayPoints:get()
	end
	return CoD.ArenaLeaguePlayUtility.GetFirestreak(f117_local2, tonumber(f117_arg1))
end
CoD.OverlayUtility.AddSystemOverlay("Arena_EventEndResultsDelay", {
	menuName = "SystemOverlay_MessageDialog",
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_A7353E18F1D3EA2"),
	description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_78CD9C28CBD5D575"),
	listDatasource = function()
		DataSources.ArenaEventEndResultsDelay_List = DataSourceHelpers.ListSetup("ArenaEventEndResultsDelay_List", function(f119_arg0)
			return {
				{
					models = {
						displayText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/ok"),
					},
					properties = {
						action = function(f120_arg0, f120_arg1, f120_arg2, f120_arg3, f120_arg4)
							GoBack(f120_arg4, f120_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "ArenaEventEndResultsDelay_List"
	end,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f121_arg0)
		return function(f122_arg0, f122_arg1)
			GoBack(f122_arg0, f122_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = @"menu/ok",
})
