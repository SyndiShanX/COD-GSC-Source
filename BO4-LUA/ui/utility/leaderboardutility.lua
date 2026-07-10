require("x64:f3c5259f470592d")
CoD.LeaderboardUtility = {}
CoD.LeaderboardUtility.PLAYER_POSITION_IN_LEADERBOARD = 6
CoD.LeaderboardUtility.DEFAULT_ZM_MAPS_NUM_PLAYERS = 1
CoD.LeaderboardUtility.TOP = 0
CoD.LeaderboardUtility.BOTTOM = 1
CoD.LeaderboardUtility.LB_ZM_GB_PERKS_DRANK_TITLE = 0x0
CoD.LeaderboardUtility.LB_ZM_GB_PERKS_DRANK_TITLE = 0x4CC7C08B5DC2887
CoD.LeaderboardUtility.DefaultTrackTypes = {
	Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A],
	Enum[0x4AA9747C7FD29AA][0x4ADDC81D8048FD],
	Enum[0x4AA9747C7FD29AA][0x59A119C31BDA10B],
}
CoD.LeaderboardUtility.leaderboardListCore = {
	0xEFEF03E4254449A,
	0x9A021342E7D43D2,
	0x1C8643AF845B430,
	0xC7E01EC88252CA5,
	0xD3DB133DE779F81,
	0x7C0E7AA2563F999,
	0x1E74B3AF8603A44,
	0xA041D1F27A5D913,
	0x3921533D003B197,
	0xAB831384CFA3838,
	0x305F1C4D44A197C,
}
CoD.LeaderboardUtility.leaderboardListHardcore = {
	0x34882830C8D7CC2,
	0x6A2EC118019192A,
	0x587D5708CBC82C4,
	0x9C1F35350983A03,
	0x6FD89D1041D210F,
	0xECE28903B4C4878,
	0xF937E5C8BD79380,
}
CoD.LeaderboardUtility.leaderboardListArena = {
	0x684509A5266DAA5,
	0x437480E4F75EEC,
	0x64D7F553AF03804,
}
CoD.LeaderboardUtility.leaderboardListZMGlobal = {
	0x70366E5C4470353,
}
CoD.LeaderboardUtility.leaderboardListZMGauntlet = {
	0x4789E547635C17C,
	0x42F5184A8BB8CF9,
	0xF72136904B594BF,
	0x4EAA0418FCFD3FC,
	0x5205CE55E1DA16C,
	0xADA909B618D4A,
	0x9EE8CC91C547BB9,
	0x378C349A2F89514,
	0x444F6E41BCB1A81,
}
CoD.LeaderboardUtility.leaderboardListZMMaps = {}
CoD.LeaderboardUtility.leaderboardListWZModes = {
	0x20437C01157B674,
	0x2F5097768B0B81A,
	0x8F29CAA4F9941D5,
}
CoD.LeaderboardUtility.leaderboardTab = {
	[0xBF2FB911980759E] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListCore,
		leaderboardHeaderText = 0xA293EB64E03142F,
	},
	[0xB4E65040CD1305B] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListHardcore,
		leaderboardHeaderText = 0x77B92AED87A9600,
	},
	[0x5D8D7B6A4C553C8] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListArena,
		leaderboardHeaderText = 0x866F2CC78940BCF,
	},
	[0xA6EBC84C86D7FC6] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListZMGlobal,
		leaderboardHeaderText = 0x8FDE5CC46116294,
	},
	[0x351883667F5B15B] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListZMGauntlet,
		leaderboardHeaderText = 0x55D8B5C3E9420F7,
	},
	[0x98504EEA71F7A17] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListWZModes,
		leaderboardHeaderText = 0xA9DC4B9726B8B6B,
	},
}
CoD.LeaderboardUtility.GetLeaderboardInfo = function(f1_arg0)
	if not CoD.LeaderboardUtility.LeaderboardInfo then
		CoD.LeaderboardUtility.LeaderboardInfo = {}
		local f1_local0 = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
			local f2_local0 = CoD.GameTypeUtility.GetGameTypeValue(f2_arg3, "nameRef", 0x0)
			local f2_local1 = CoD.GameTypeUtility.GetGameTypeValue(f2_arg3, "image", 0x0)
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg0].title = f2_local0
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg0].icon = f2_local1
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg0].gametype = f2_arg3
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg0].trackTypes = CoD.LeaderboardUtility.DefaultTrackTypes
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg1] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg1].title = f2_local0
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg1].icon = f2_local1
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg1].gametype = f2_arg3
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg1].trackTypes = CoD.LeaderboardUtility.DefaultTrackTypes
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg2] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg2].title = f2_local0
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg2].icon = f2_local1
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg2].gametype = f2_arg3
			CoD.LeaderboardUtility.LeaderboardInfo[f2_arg2].trackTypes = CoD.LeaderboardUtility.DefaultTrackTypes
		end
		f1_local0(0x9A021342E7D43D2, 0x6A2EC118019192A, 0xCCA8BEC64E44876, 0x6E8B11944572258)
		f1_local0(0x1C8643AF845B430, 0x587D5708CBC82C4, 0xD4577D7A38160A0, 0x8915B07B53BB7FA)
		f1_local0(0xD3DB133DE779F81, 0x6FD89D1041D210F, 0xEDE29B3F8E07ACD, 0xAAF4118F474831B)
		f1_local0(0x1E74B3AF8603A44, 0xECE28903B4C4878, 0x437480E4F75EEC, 0x8D93207B57927F2)
		f1_local0(0x3246733BE471886, 0xEE348E57439D79E, 0x665027CFD36A1A2, 0x5B707190CBF683C)
		f1_local0(0xD518D33DE880B5F, 0xA85485E8DF5DD21, 0x456CC65AB4F1E1F, 0xA9A2518F461F77D)
		f1_local0(0x7C0E7AA2563F999, 0x2600DDDA44669D7, 0x684509A5266DAA5, 0x18BECD72BBC155B)
		f1_local0(0xC7E01EC88252CA5, 0x9C1F35350983A03, 0xE40C7C87AF2CA49, 0xBC9FA91195D6ED7)
		f1_local0(0x6A3FFF2696DF3AE, 0xC90718E681E23F6, 0xA2F14A9BE3602A, 0xA13D89BA9FBCA24)
		f1_local0(0xA041D1F27A5D913, 0xC7B52324D6947A5, 0x5C9E9AD2E1FC42B, 0xB60DB445FBF5155)
		f1_local0(0x3921533D003B197, 0x789DF1C27E15A69, 0xADC15C75B399B97, 0x5194D18FAD99705)
		f1_local0(0xAB831384CFA3838, 0x35A25A6313758BC, 0xAB831384CFA3838, 0x32C064CAF1E3CA6)
		f1_local0(0x305F1C4D44A197C, 0xF937E5C8BD79380, 0x64D7F553AF03804, 0x84E1CB596B7E53E)
		local f1_local1 = function(f3_arg0, f3_arg1, f3_arg2)
			local f3_local0 = CoD.MapUtility.GetMapValue(f3_arg1, "mapName", 0x0)
			local f3_local1 = CoD.MapUtility.GetMapValue(f3_arg1, "previewImage", 0x0)
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0].title = f3_local0
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0].icon = f3_local1
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0].dlcBit = f3_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0].trackTypes = {
				Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A],
			}
		end
		f1_local1(0x4F315BDBA60FE82, 0x7E9384351288E52, CoD.DLCBits.CONTENT_ORIGINALMAPS)
		f1_local1(0x429613456337DCB, 0xAFE286CA5500B9B, CoD.DLCBits.CONTENT_ORIGINALMAPS)
		f1_local1(0x25671F57AABAF7E, 0x51FD293040F234E, CoD.DLCBits.CONTENT_ORIGINALMAPS)
		f1_local1(0x5965088D73B7EE9, 0xAA390030BE9DEF9, CoD.DLCBits.CONTENT_DLC0ZM)
		f1_local1(0xDDC26B6F35FF5A, 0xA005252D762E06A, CoD.DLCBits.CONTENT_DLC1ZM)
		f1_local1(0x30E78C01B2597B0, 0x63EFA8337233574, CoD.DLCBits.CONTENT_DLC2ZM)
		local f1_local2 = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg0].title = f4_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg0].icon = f4_arg3
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg0].trackTypes = {
				Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A],
			}
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg1] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg1].title = f4_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg1].icon = f4_arg3
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg1].trackTypes = {
				Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A],
			}
		end
		f1_local2(0x70366E5C4470353, 0xFE262587F35DFB1, 0x6E45BDFB807BA0C, 0xBA23494805B2D16)
		f1_local2(0x7A5E67291AD99C5, 0x205F51D8FB1C28B, 0x978F253BCF5F16A, 0x9C950584F9BA7CC)
		f1_local2(0x1B596331A39E41A, 0xE7B2EF603C4940A, 0xB5036476F2D18F1, 0x30B4EA5A901E99C)
		f1_local2(0xBF3DFFA806B8637, 0xDD8E8DE5F6561BD, 0xF8C05A932C222F4, 0x4E7167C63987A08)
		f1_local2(0x5B680443AABC3E7, 0xE9901D61854594D, 0xF84CA9A12A74B9C, 0x270D7A0C7EEDB7A)
		f1_local2(0x354184A955F73C, 0x28FE7102E8FC034, 0xFE639D81A7245CE, 0x8D2DAB62E02B423)
		f1_local2(0xEFC6FFE429EFD62, 0xA8FEB5BB5D97832, 0xE547CF1C5C945B5, 0xC43523103B7C377)
		f1_local2(0x898F8FCA9925F65, 0x6311D9555AFBB6B, 0x47553162E2176CE, 0xD5CF1E78FE3AC15)
		f1_local2(0x2DB713B9F144A4B, 0x3BF55208B06E529, 0x83F7E6E94807EDA, 0x4E5F257F9EB3955)
		f1_local2(0x58B29DAD4A59664, 0xAF572EBD08719FC, CoD.LeaderboardUtility.LB_ZM_GB_PERKS_DRANK_TITLE, 0xCCD4A473580CF6B)
		local f1_local3 = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
			local f5_local0 = CoD.DirectorUtility.TrialsMapEnabledDvars[f5_arg2]
			if f5_local0 and not IsBooleanDvarSet(f5_local0) then
				return
			else
				CoD.LeaderboardUtility.LeaderboardInfo[f5_arg0] = {}
				CoD.LeaderboardUtility.LeaderboardInfo[f5_arg0].title = f5_arg1
				CoD.LeaderboardUtility.LeaderboardInfo[f5_arg0].icon = f5_arg3
				CoD.LeaderboardUtility.LeaderboardInfo[f5_arg0].trackTypes = {
					Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A],
				}
			end
		end
		f1_local3(0x4789E547635C17C, 0xC6DC1A7FAC1E48, 0x7E9384351288E52, 0x1AEA8301D2466F7)
		f1_local3(0x42F5184A8BB8CF9, 0xDEADD371D74E38C, 0xAFE286CA5500B9B, 0xB551941FB81823B)
		f1_local3(0xF72136904B594BF, 0xD04C533DC2235E6, 0x51FD293040F234E, 0x93D1D7EA7B44F24)
		f1_local3(0x4EAA0418FCFD3FC, 0xF075735A3BB5BB6, 0xAA390030BE9DEF9, 0x3DCD6B96C1F06A4)
		f1_local3(0x5205CE55E1DA16C, 0x16859B1C782F9F2, 0xA005252D762E06A, 0x3F8E0237F44B0E2)
		f1_local3(0xADA909B618D4A, 0x57782883FEE8976, 0x63EFA8337233574, 0x821F71DD7A88AC1)
		f1_local3(0x9EE8CC91C547BB9, 0x4BADFDCF63F6338, 0x7E9384351288E52, 0x1AEA8301D2466F7)
		f1_local3(0x378C349A2F89514, 0x40D886BB4070112, 0x57B253FE0702E3E, 0xD70CAD0E674AF1F)
		f1_local3(0x444F6E41BCB1A81, 0x7702CF66B8230F9, 0x9E4FEA5D255373, 0x361BC83FAA4939C)
		local f1_local4 = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
			CoD.LeaderboardUtility.LeaderboardInfo[f6_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f6_arg0].title = f6_arg1
			CoD.LeaderboardUtility.LeaderboardInfo[f6_arg0].icon = f6_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f6_arg0].trackTypes = f6_arg3
		end
		f1_local4(0xEFEF03E4254449A, 0x577FFBA4A51E340, 0xBCF1F948081F752, CoD.LeaderboardUtility.DefaultTrackTypes)
		f1_local4(0x34882830C8D7CC2, 0x577FFBA4A51E340, 0xBCF1F948081F752, CoD.LeaderboardUtility.DefaultTrackTypes)
		f1_local4(0x8CF593C6FE1D09E, 0x577FFBA4A51E340, 0xBCF1F948081F752, CoD.LeaderboardUtility.DefaultTrackTypes)
		local f1_local5 = function(f7_arg0, f7_arg1, f7_arg2)
			CoD.LeaderboardUtility.LeaderboardInfo[f7_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f7_arg0].title = f7_arg1
			CoD.LeaderboardUtility.LeaderboardInfo[f7_arg0].icon = f7_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f7_arg0].trackTypes = {
				Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A],
			}
		end
		f1_local5(0x20437C01157B674, 0xD66A3D1AAD8BEB3, 0xB3E364C4EA77601)
		f1_local5(0x2F5097768B0B81A, 0x2661E19A0FBC131, 0x5AA115E951DC562)
		f1_local5(0x8F29CAA4F9941D5, 0xE2841875AF78500, 0xC43E75D7A81BE65)
		f1_local5(0xBBDB7C1C2499251, 0x2346D505817A54, 0xB0691C41F056744)
	end
	return CoD.LeaderboardUtility.LeaderboardInfo[f1_arg0]
end
CoD.LeaderboardUtility.SetZMMapsNumPlayersFilter = function(f8_arg0)
	local f8_local0 = Engine[0x614D394F6F9A18D]
	local f8_local1 = Engine[0x40E824FE270E174]
	local f8_local2 = Engine[0x8DF2E5447F384B9]()
	CoD.perController[f8_local0(f8_local1(Engine[0x8DF2E5447F384B9](), "LeaderboardFilter_LastUsedController"))].leaderboardZMMapsNumPlayersFilterTemp = f8_arg0
end
CoD.LeaderboardUtility.SetPlayerFilter = function(f9_arg0)
	local f9_local0 = Engine[0x614D394F6F9A18D]
	local f9_local1 = Engine[0x40E824FE270E174]
	local f9_local2 = Engine[0x8DF2E5447F384B9]()
	CoD.perController[f9_local0(f9_local1(Engine[0x8DF2E5447F384B9](), "LeaderboardFilter_LastUsedController"))].leaderboardPlayerFilterTemp = f9_arg0
end
CoD.LeaderboardUtility.SetDurationFilter = function(f10_arg0)
	local f10_local0 = Engine[0x614D394F6F9A18D]
	local f10_local1 = Engine[0x40E824FE270E174]
	local f10_local2 = Engine[0x8DF2E5447F384B9]()
	CoD.perController[f10_local0(f10_local1(Engine[0x8DF2E5447F384B9](), "LeaderboardFilter_LastUsedController"))].leaderboardDurationFilterTemp = f10_arg0
end
CoD.LeaderboardUtility.GetZMMapsNumPlayersFilterString = function(f11_arg0)
	if f11_arg0 == 1 then
		return Engine[0xF9F1239CFD921FE](0xC32F659BC592E28)
	else
		return Engine[0xF9F1239CFD921FE](0xCA1F9779DCA08D, f11_arg0)
	end
end
CoD.LeaderboardUtility.GetPlayerFilterString = function(f12_arg0)
	if f12_arg0 == Enum[0xFB32CA7FF48A235][0x88054F6C5380C0C] then
		return Engine[0xF9F1239CFD921FE](0x8396FC4289ACDA)
	elseif f12_arg0 == Enum[0xFB32CA7FF48A235][0x7C601779D30B9FD] then
		return Engine[0xF9F1239CFD921FE](0x8EEFC66339125B3)
	elseif f12_arg0 == Enum[0xFB32CA7FF48A235][0xFC988076708BDA5] then
		return Engine[0xF9F1239CFD921FE](0xB692D0423F11724)
	elseif f12_arg0 == Enum[0xFB32CA7FF48A235][0x8B32F474F53EFDC] then
		return Engine[0xF9F1239CFD921FE](0x6B9DBC36598BF9E)
	else
	end
end
CoD.LeaderboardUtility.GetDurationFilterString = function(f13_arg0)
	if f13_arg0 == Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A] then
		return Engine[0xF9F1239CFD921FE](0x941D0ABA4C78F94)
	elseif f13_arg0 == Enum[0x4AA9747C7FD29AA][0x4ADDC81D8048FD] then
		return Engine[0xF9F1239CFD921FE](0x1E51AF1FC9826A2)
	elseif f13_arg0 == Enum[0x4AA9747C7FD29AA][0x59A119C31BDA10B] then
		return Engine[0xF9F1239CFD921FE](0x3379CAAA3E8196A)
	else
	end
end
CoD.LeaderboardUtility.PageUpFriends = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = GetListItem(f14_arg0, f14_arg1)
	local f14_local1 = nil
	if f14_local0.activeWidget ~= nil then
		local f14_local2 = f14_local0.vCount
		local f14_local3 = f14_local0.activeWidget.gridInfoTable.gridRowIndex
		if f14_local3 == 1 then
			return
		end
		f14_local1 = f14_local0:getItemAtPosition(math.max(f14_local3 - f14_local2, 1), 1, true)
	end
	if f14_local1 then
		f14_local0:setActiveItem(f14_local1)
	end
end
CoD.LeaderboardUtility.PageUpAll = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = GetListItem(f15_arg0, f15_arg1)
	local f15_local1 = nil
	if not f15_local0.activeWidget then
		return
	else
		local f15_local2 = f15_local0.vCount
		local f15_local3 = f15_local0.activeWidget.gridInfoTable.gridRowIndex - f15_local2
		if f15_local3 > 0 then
			f15_local0:setActiveItem(f15_local0:getItemAtPosition(f15_local3, 1, true))
			return
		elseif not f15_arg1:getModel() then
			return
		else
			local f15_local4 = tonumber(Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f15_arg1:getModel(), "position")))
			local f15_local5 = f15_local4 - f15_local2
			if f15_local4 == 1 then
				return
			elseif f15_local5 < 1 then
				f15_local0:setActiveItem(f15_local0:getItemAtPosition(1, 1, true))
				return
			else
				CoD.perController[f15_arg2].pivotPosition = f15_local5
				CoD.perController[f15_arg2].leaderboardTopOrBottom = CoD.LeaderboardUtility.TOP
			end
		end
	end
end
CoD.LeaderboardUtility.PageDownFriends = function(f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = GetListItem(f16_arg0, f16_arg1)
	local f16_local1 = nil
	if f16_local0.activeWidget ~= nil then
		local f16_local2 = f16_local0.vCount
		local f16_local3 = f16_local0.activeWidget.gridInfoTable.gridRowIndex
		if f16_local3 == f16_local0.requestedRowCount then
			return
		end
		f16_local1 = f16_local0:getItemAtPosition(math.min(f16_local3 + f16_local2, f16_local0.requestedRowCount), 1, true)
	end
	if f16_local1 then
		f16_local0:setActiveItem(f16_local1)
	end
end
CoD.LeaderboardUtility.PageDownAll = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = GetListItem(f17_arg0, f17_arg1)
	local f17_local1 = nil
	if not f17_local0.activeWidget then
		return
	else
		local f17_local2 = f17_local0.vCount
		local f17_local3 = f17_local0.activeWidget.gridInfoTable.gridRowIndex + f17_local2
		if f17_local3 <= f17_local0.requestedRowCount then
			f17_local0:setActiveItem(f17_local0:getItemAtPosition(f17_local3, 1, true))
			return
		elseif not f17_arg1:getModel() then
			return
		else
			local f17_local4 = DataSources.LeaderBoardRows.getModel()
			f17_local4 = f17_local4.totalCount:get()
			local f17_local5 = tonumber(Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f17_arg1:getModel(), "position")))
			local f17_local6 = f17_local5 + f17_local2
			if f17_local5 == f17_local4 then
				return
			elseif f17_local4 < f17_local6 then
				f17_local0:setActiveItem(f17_local0:getItemAtPosition(f17_local0.requestedRowCount, 1, true))
				return
			else
				CoD.perController[f17_arg2].pivotPosition = f17_local6
				CoD.perController[f17_arg2].leaderboardTopOrBottom = CoD.LeaderboardUtility.BOTTOM
			end
		end
	end
end
CoD.LeaderboardUtility.GoToTopOfListFriends = function(f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = GetListItem(f18_arg0, f18_arg1)
	local f18_local1 = f18_local0:getItemAtPosition(1, 1, true)
	if f18_local1 == f18_arg1 then
		return
	elseif f18_local1 then
		f18_local0:setActiveItem(f18_local1)
	end
end
CoD.LeaderboardUtility.GoToTopOfListAll = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = GetListItem(f19_arg0, f19_arg1)
	local f19_local1 = f19_local0:getItemAtPosition(1, 1, true)
	if tonumber(Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f19_local1:getModel(), "position"))) == 1 then
		if f19_local1 ~= f19_arg1 then
			f19_local0:setActiveItem(f19_local1)
		end
		return
	else
		CoD.perController[f19_arg2].pivotPosition = 1
		CoD.perController[f19_arg2].leaderboardTopOrBottom = CoD.LeaderboardUtility.TOP
	end
end
CoD.LeaderboardUtility.OpenLeaderboardMaintanencePopup = function(f20_arg0, f20_arg1)
	CoD.OverlayUtility.CreateOverlay(f20_arg1, f20_arg0, "LeaderboardsDownForMaintanence")
end
CoD.LeaderboardUtility.LoadLeaderboard = function(f21_arg0, f21_arg1)
	local f21_local0 = CoD.LeaderboardUtility.IsZMMapsLeaderboard(f21_arg1)
	local f21_local1 = CoD.LeaderboardUtility.IsLobbyLeaderboard(f21_arg1)
	if not CoD.perController[f21_arg1].leaderboardPlayerFilter then
		local f21_local2 = Enum[0xFB32CA7FF48A235][0x8B32F474F53EFDC]
	end
	local f21_local3 = CoD.perController[f21_arg1].leaderboardZMMapsNumPlayersFilter
	if not f21_local3 then
		f21_local3 = CoD.LeaderboardUtility.DEFAULT_ZM_MAPS_NUM_PLAYERS
	end
	CoD.perController[f21_arg1].pivotPosition = nil
	local f21_local4 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "leaderboardDef"))
	local f21_local5 = CoD.LeaderboardUtility.GetLeaderboardInfo(f21_local4)
	local f21_local6 = CoD.perController[f21_arg1].leaderboardDurationFilter
	if f21_local0 then
		f21_local4 = f21_local4 .. "_" .. tostring(f21_local3) .. "PLAYER"
	end
	if f21_local1 then
		local f21_local2 = Enum[0xFB32CA7FF48A235][0x7C601779D30B9FD]
	end
	local f21_local7 = false
	for f21_local11, f21_local12 in ipairs(f21_local5.trackTypes) do
		if f21_local6 == f21_local12 then
			f21_local7 = true
			break
		end
	end
	if f21_local7 == false then
		f21_local6 = f21_local5.trackTypes[1]
	end
	if not Dvar[0x2C8BE4B980621A0]:get() and Engine[0xC92E3E8802494F8](f21_local4, f21_local6) == true then
		DataSources.LeaderboardRows.refresh(f21_arg1)
	end
	f21_local8 = CoD.LeaderboardUtility.GetPlayerFilterString(f21_local2)
	f21_local9 = CoD.LeaderboardUtility.GetDurationFilterString(f21_local6)
	f21_local10 = ""
	if f21_local0 then
		f21_local10 = Engine[0xF9F1239CFD921FE](0x31CF0F51CCA3A27, CoD.LeaderboardUtility.GetZMMapsNumPlayersFilterString(f21_local3), f21_local8)
	elseif f21_local1 then
		f21_local10 = f21_local9
	elseif #f21_local5.trackTypes > 1 then
		f21_local10 = Engine[0xF9F1239CFD921FE](0x31CF0F51CCA3A27, f21_local8, f21_local9)
	else
		f21_local10 = f21_local8
	end
	SetGlobalModelValue("FilterInfo", f21_local10)
end
CoD.LeaderboardUtility.SetLeaderboardDef = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = f22_arg1:getModel()
	if f22_local0 then
		local f22_local1 = f22_local0.lbDef
		if f22_local1 then
			f22_local1 = f22_local0.lbDef:get()
		end
		if f22_local1 then
			SetGlobalModelValue("leaderboardDef", f22_local1)
		end
	end
end
CoD.LeaderboardUtility.LeaderboardPageUp = function(f23_arg0, f23_arg1, f23_arg2)
	if CoD.perController[f23_arg2].leaderboardPlayerFilter == Enum[0xFB32CA7FF48A235][0xFC988076708BDA5] then
		CoD.LeaderboardUtility.PageUpAll(f23_arg0, f23_arg1, f23_arg2)
	else
		CoD.LeaderboardUtility.PageUpFriends(f23_arg0, f23_arg1, f23_arg2)
	end
end
CoD.LeaderboardUtility.LeaderboardPageDown = function(f24_arg0, f24_arg1, f24_arg2)
	if CoD.perController[f24_arg2].leaderboardPlayerFilter == Enum[0xFB32CA7FF48A235][0xFC988076708BDA5] then
		CoD.LeaderboardUtility.PageDownAll(f24_arg0, f24_arg1, f24_arg2)
	else
		CoD.LeaderboardUtility.PageDownFriends(f24_arg0, f24_arg1, f24_arg2)
	end
end
CoD.LeaderboardUtility.LeaderboardGoToTopOfList = function(f25_arg0, f25_arg1, f25_arg2)
	if CoD.perController[f25_arg2].leaderboardPlayerFilter == Enum[0xFB32CA7FF48A235][0xFC988076708BDA5] then
		CoD.LeaderboardUtility.GoToTopOfListAll(f25_arg0, f25_arg1, f25_arg2)
	else
		CoD.LeaderboardUtility.GoToTopOfListFriends(f25_arg0, f25_arg1, f25_arg2)
	end
end
CoD.LeaderboardUtility.LeaderboardUpdateHeaderModel = function(f26_arg0, f26_arg1)
	local f26_local0 = f26_arg0.LeaderboardHeader
	if not f26_local0 then
		return
	else
		f26_local0:setModel(nil, f26_arg1)
		f26_local0:setModel(DataSources.LeaderboardHeader.getModel(f26_arg1), f26_arg1)
	end
end
CoD.LeaderboardUtility.LeaderboardApplyFilters = function(f27_arg0, f27_arg1)
	local f27_local0 = CoD.perController[f27_arg1].leaderboardPlayerFilter == CoD.perController[f27_arg1].leaderboardPlayerFilterTemp
	local f27_local1 = CoD.perController[f27_arg1].leaderboardDurationFilter == CoD.perController[f27_arg1].leaderboardDurationFilterTemp
	local f27_local2 = true
	if CoD.LeaderboardUtility.IsZMMapsLeaderboard(f27_arg1) then
		f27_local2 = CoD.perController[f27_arg1].leaderboardZMMapsNumPlayersFilter == CoD.perController[f27_arg1].leaderboardZMMapsNumPlayersFilterTemp
	end
	if f27_local0 and f27_local1 and f27_local2 then
		return
	else
		CoD.perController[f27_arg1].leaderboardPlayerFilter = CoD.perController[f27_arg1].leaderboardPlayerFilterTemp
		CoD.perController[f27_arg1].leaderboardDurationFilter = CoD.perController[f27_arg1].leaderboardDurationFilterTemp
		CoD.perController[f27_arg1].leaderboardZMMapsNumPlayersFilter = CoD.perController[f27_arg1].leaderboardZMMapsNumPlayersFilterTemp
		CoD.LeaderboardUtility.LoadLeaderboard(f27_arg0, f27_arg1)
	end
end
CoD.LeaderboardUtility.LeaderboardOpenPlayerDetails = function(f28_arg0, f28_arg1, f28_arg2)
	CoD.LeaderboardUtility.LeaderboardSetSelectedFriendXUID(f28_arg0, f28_arg1, f28_arg2)
	OpenOverlay(f28_arg0, "Social_PlayerDetailsPopup", f28_arg2)
end
CoD.LeaderboardUtility.LeaderboardSetSelectedFriendXUID = function(f29_arg0, f29_arg1, f29_arg2)
	if not f29_arg1:getModel() then
		return
	else
		local f29_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f29_arg1:getModel(), "name"))
		local f29_local1 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f29_arg1:getModel(), "xuid"))
		local f29_local2 = Engine[0xDC3B811A6](f29_arg2, f29_local1)
		local f29_local3 = Engine[0x4DF5CFBC1771947](f29_arg2)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f29_local3, "Social.selectedFriendXUID"), f29_local1)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f29_local3, "Social.selectedFriendGamertag"), f29_local0)
	end
end
CoD.LeaderboardUtility.LeaderboardEnablePCacheBuffer = function(f30_arg0, f30_arg1, f30_arg2)
	f30_arg1.setVisibleTimer = LUI.UITimer.newElementTimer(250, true, function()
		local f31_local0 = f30_arg0:getParent()
		local f31_local1 = f30_arg0.PlayerProfileInfoWidget
		while f31_local0 and not f31_local1 do
			f31_local1 = f31_local0.PlayerProfileInfoWidget
			f31_local0 = f31_local0:getParent()
		end
		if f31_local1 then
			f31_local1:setState(f30_arg2, "Visible")
		end
		local f31_local2 = f30_arg1:getModel(f30_arg2, "xuid")
		if f31_local2 then
			f30_arg1:setupPlayerBackgroundIdUpdateByXUID(Engine[0x614D394F6F9A18D](f31_local2))
		end
		f30_arg1.setVisibleTimer = nil
	end)
	f30_arg1:addElement(f30_arg1.setVisibleTimer)
end
CoD.LeaderboardUtility.LeaderboardDisablePCacheBuffer = function(f32_arg0, f32_arg1, f32_arg2)
	f32_arg1:disablePlayerBackgroundIdUpdate()
	if f32_arg1.setVisibleTimer then
		f32_arg1.setVisibleTimer:close()
		f32_arg1.setVisibleTimer = nil
	end
	local f32_local0 = f32_arg0:getParent()
	local f32_local1 = f32_arg0.PlayerProfileInfoWidget
	while f32_local0 and not f32_local1 do
		f32_local1 = f32_local0.PlayerProfileInfoWidget
		f32_local0 = f32_local0:getParent()
	end
	if f32_local1 then
		f32_local1:setState(f32_arg2, "PCacheBuffer")
	end
end
CoD.LeaderboardUtility.LeaderboardGameModeTabChanged = function(f33_arg0, f33_arg1, f33_arg2)
	local f33_local0 = f33_arg1:getModel()
	local f33_local1 = Engine[0x8DF2E5447F384B9]()
	f33_local1 = f33_local1.leaderboardDef
	if f33_local0 and f33_local0.lbDef then
		local f33_local2 = f33_local0.lbDef:get()
		local f33_local3 = f33_local1:get()
		if not f33_local3 or f33_local3 ~= f33_local2 then
			SetGlobalModelValue("leaderboardDef", f33_local2)
			CoD.LeaderboardUtility.LoadLeaderboard(f33_arg0, f33_arg2)
		end
	end
end
CoD.LeaderboardUtility.LeaderboardListGridUpdated = function(f34_arg0, f34_arg1)
	f34_arg0:registerEventHandler("grid_updated", function(element, event)
		local f35_local0 = event.grid
		local f35_local1 = f35_local0.activeWidget
		if not f35_local1 then
			return
		end
		local f35_local2 = f35_local1.gridInfoTable.gridRowIndex
		local f35_local3 = f35_local0:getDataSource()
		local f35_local4 = f35_local3.getCustomPropertiesForItem(f35_local0, f35_local2)
		local f35_local5 = f35_local0.vCount
		local f35_local6 = 0
		if CoD.perController[f34_arg1].leaderboardTopOrBottom == CoD.LeaderboardUtility.TOP then
			f35_local6 = 0
		elseif CoD.perController[f34_arg1].leaderboardTopOrBottom == CoD.LeaderboardUtility.BOTTOM then
			f35_local6 = f35_local5 - 1
		elseif CoD.SafeGetModelValue(f35_local1:getModel(), "xuid") == Engine[0x93B19E01B1FD1C7](f34_arg1) then
			f35_local6 = f35_local5 - CoD.LeaderboardUtility.PLAYER_POSITION_IN_LEADERBOARD
		end
		local f35_local7 = f35_local0:getItemAtPosition(f35_local2 + f35_local6, 1, true)
		if f35_local7 then
			f35_local0:setActiveItem(f35_local7)
			f35_local0:setActiveItem(f35_local1)
		end
	end)
end
CoD.LeaderboardUtility.InitPlayersListState = function()
	local f36_local0 = Engine[0xA798E4552F5E872](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "socialRoot"), "playersListFull")
	f36_local0:set(Engine[0x3B1FD53757FE607](Engine[0xA5B9C0111291A8B]()) == 0)
end
CoD.LeaderboardUtility.AutoAddFriends = function(f37_arg0)
	Engine[0xC547432E64838B6](f37_arg0)
end
CoD.LeaderboardUtility.SetAutoAddFriendsTrue = function(f38_arg0)
	Engine[0x1776FDF9D77DC58](f38_arg0, true)
end
CoD.LeaderboardUtility.SetAutoAddFriendsFalse = function(f39_arg0)
	Engine[0x1776FDF9D77DC58](f39_arg0, false)
end
CoD.LeaderboardUtility.UpdatePlayersListCount = function(f40_arg0)
	local f40_local0 = Engine[0xA798E4552F5E872](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "socialRoot"), "playersListCount")
	f40_local0:set(Engine[0x469E79D58A190B2](f40_arg0))
end
CoD.LeaderboardUtility.AutoAddFriendsCheckboxDisabled = function(f41_arg0)
	return not Engine[0xE48DAA41997DD66](f41_arg0)
end
CoD.LeaderboardUtility.GetAutoAddFriends = function(f42_arg0)
	return Engine[0x2FCD8424924CB2C](f42_arg0)
end
CoD.LeaderboardUtility.LeaderboardsDownForMaintanence = function()
	return Dvar[0xF1F9C30FB608A2E]:get()
end
CoD.LeaderboardUtility.IsLobbyLeaderboard = function(f44_arg0)
	return CoD.perController[f44_arg0].isInLobbyLeaderboard == true
end
CoD.LeaderboardUtility.IsLeaderboardCategory = function(f45_arg0, f45_arg1, f45_arg2)
	return f45_arg0._category and f45_arg0._category == f45_arg2
end
CoD.LeaderboardUtility.IsZMMapsLeaderboard = function(f46_arg0)
	local f46_local0 = Engine[0x8DF2E5447F384B9]()
	f46_local0 = f46_local0.leaderboardCategoryName
	if f46_local0 then
		return f46_local0:get() == "zm_maps"
	else
		return false
	end
end
CoD.LeaderboardUtility.IsMPGameModeLeaderboard = function(f47_arg0)
	local f47_local0 = Engine[0x8DF2E5447F384B9]()
	f47_local0 = f47_local0.leaderboardDef
	if f47_local0 then
		return string.sub(f47_local0:get(), 1, string.len("LB_MP_GM_")) == "LB_MP_GM_"
	else
		return false
	end
end
CoD.LeaderboardUtility.IsLeaderboardUpdating = function()
	return CoD.SafeGetModelValue(DataSources.LeaderboardRows.getModel(), "status") == Enum[0xA771A22127652AC][0x524084842B0DA87]
end
CoD.LeaderboardUtility.IsLeaderboardEmpty = function()
	return DataSources.LeaderboardRows.getCount() == 0
end
CoD.LeaderboardUtility.PlayerListCountAndMax = function(f50_arg0)
	local f50_local0 = Engine[0xA798E4552F5E872](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "socialRoot"), "playersListCount")
	local f50_local1 = f50_local0:get()
	if not f50_local1 then
		f50_local1 = Engine[0x469E79D58A190B2](Engine[0xA5B9C0111291A8B]())
	end
	return Engine[0xF9F1239CFD921FE](f50_arg0, f50_local1, Engine[0xA9E982FF50617CA]())
end
CoD.LeaderboardUtility.leaderboardGameModeData = {}
CoD.LeaderboardUtility.LeaderboardGameModeButtonPrepare = function(f51_arg0, f51_arg1)
	local f51_local0 = {}
	local f51_local1 = f51_arg1.menu._category
	if not f51_local1 then
		return f51_local0
	end
	for f51_local5, f51_local6 in pairs(CoD.LeaderboardUtility.leaderboardTab[f51_local1].leaderboardList) do
		local f51_local7 = CoD.LeaderboardUtility.GetLeaderboardInfo(f51_local6)
		if f51_local7 and not CoD.BaseUtility.IsHiddenDLC(f51_local7.dlcBit) then
			table.insert(f51_local0, {
				models = {
					title = LocalizeToUpperString(f51_local7.title),
					icon = f51_local7.icon,
					lbDef = f51_local6,
				},
				properties = {
					selectIndex = f51_local5 == 1,
				},
			})
		end
	end
	CoD.LeaderboardUtility.leaderboardGameModeData = f51_local0
	return f51_local0
end
DataSources.LeaderboardGameModeButton = DataSourceHelpers.ListSetup("LeaderboardGameModeButton", CoD.LeaderboardUtility.LeaderboardGameModeButtonPrepare, true)
CoD.LeaderboardUtility.LeaderboardGameModeTabsPrepare = function(f52_arg0)
	local f52_local0 = {}
	if CoD.LeaderboardUtility.IsLobbyLeaderboard(f52_arg0) then
		local f52_local1 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "leaderboardDef")
		if f52_local1 then
			table.insert(f52_local0, {
				models = {
					name = 0x0,
					tabWidget = "CoD.Leaderboard_GameModeFrame",
					lbDef = Engine[0x614D394F6F9A18D](f52_local1),
				},
				properties = {
					selectIndex = true,
				},
			})
		end
		return f52_local0
	end
	local f52_local1 = CoD.LeaderboardUtility.leaderboardGameModeData[1].models.lbDef
	local f52_local2 = Engine[0x8DF2E5447F384B9]()
	f52_local2 = f52_local2.leaderboardDef
	if f52_local2 ~= nil then
		f52_local1 = f52_local2:get()
	end
	for f52_local6, f52_local7 in pairs(CoD.LeaderboardUtility.leaderboardGameModeData) do
		table.insert(f52_local0, {
			models = {
				name = f52_local7.models.title,
				tabWidget = "CoD.Leaderboard_GameModeFrame",
				lbDef = f52_local7.models.lbDef,
			},
			properties = {
				selectIndex = f52_local7.models.lbDef == f52_local1,
			},
		})
	end
	return f52_local0
end
DataSources.LeaderboardGameModeTabs = DataSourceHelpers.ListSetup("LeaderboardGameModeTabs", CoD.LeaderboardUtility.LeaderboardGameModeTabsPrepare, true)
CoD.LeaderboardUtility.CreateModels_ZMMapsNumPlayersFilter = function(f53_arg0)
	local f53_local0 = {
		{
			name = Engine[0xF9F1239CFD921FE](0xC32F659BC592E28),
			value = 1,
		},
		{
			name = Engine[0xF9F1239CFD921FE](0xCA1F9779DCA08D, 2),
			value = 2,
		},
		{
			name = Engine[0xF9F1239CFD921FE](0xCA1F9779DCA08D, 3),
			value = 3,
		},
		{
			name = Engine[0xF9F1239CFD921FE](0xCA1F9779DCA08D, 4),
			value = 4,
		},
	}
	local f53_local1 = CoD.perController[f53_arg0].leaderboardZMMapsNumPlayersFilter
	if not f53_local1 then
		f53_local1 = CoD.LeaderboardUtility.DEFAULT_ZM_MAPS_NUM_PLAYERS
	end
	return {
		models = {
			displayText = 0x35275E4CC68CA25,
			hintText = "",
			optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource(f53_arg0, "LeaderboardFilterOptions_ZMMapsNumPlayersFilter", f53_local0, nil, CoD.LeaderboardUtility.SetZMMapsNumPlayersFilter, nil, nil),
			currentSelection = CoD.OptionsUtility.GetCustomProfileSelection(f53_arg0, f53_local0, f53_local1),
		},
		properties = {},
	}
end
CoD.LeaderboardUtility.CreateModels_PlayerFilter = function(f54_arg0)
	local f54_local0 = {}
	table.insert(f54_local0, {
		name = Engine[0xF9F1239CFD921FE](0x6B9DBC36598BF9E),
		value = Enum[0xFB32CA7FF48A235][0x8B32F474F53EFDC],
	})
	table.insert(f54_local0, {
		name = Engine[0xF9F1239CFD921FE](0x8396FC4289ACDA),
		value = Enum[0xFB32CA7FF48A235][0x88054F6C5380C0C],
	})
	if IsMemberOfAnyGroup(f54_arg0) then
		table.insert(f54_local0, {
			name = Engine[0xF9F1239CFD921FE](0xFC022F454CCBACD),
			value = Enum[0xFB32CA7FF48A235][0x967FD91B94A173A],
		})
	end
	table.insert(f54_local0, {
		name = Engine[0xF9F1239CFD921FE](0xB692D0423F11724),
		value = Enum[0xFB32CA7FF48A235][0xFC988076708BDA5],
	})
	local f54_local1 = CoD.perController[f54_arg0].leaderboardPlayerFilter
	if not f54_local1 then
		f54_local1 = Enum[0xFB32CA7FF48A235][0x8B32F474F53EFDC]
	end
	return {
		models = {
			displayText = 0xE20D5225108123D,
			hintText = "",
			optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource(f54_arg0, "LeaderboardFilterOptions_PlayerFilter", f54_local0, nil, CoD.LeaderboardUtility.SetPlayerFilter, nil, nil),
			currentSelection = CoD.OptionsUtility.GetCustomProfileSelection(f54_arg0, f54_local0, f54_local1),
		},
		properties = {},
	}
end
CoD.LeaderboardUtility.CreateModels_DurationFilter = function(f55_arg0)
	local f55_local0 = {
		{
			name = Engine[0xF9F1239CFD921FE](0x941D0ABA4C78F94),
			value = Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A],
		},
		{
			name = Engine[0xF9F1239CFD921FE](0x1E51AF1FC9826A2),
			value = Enum[0x4AA9747C7FD29AA][0x4ADDC81D8048FD],
		},
		{
			name = Engine[0xF9F1239CFD921FE](0x3379CAAA3E8196A),
			value = Enum[0x4AA9747C7FD29AA][0x59A119C31BDA10B],
		},
	}
	local f55_local1 = CoD.perController[f55_arg0].leaderboardDurationFilter
	if not f55_local1 then
		f55_local1 = Enum[0x4AA9747C7FD29AA][0x55ACA16E2268D1A]
	end
	local f55_local2 = CoD.LeaderboardUtility.GetLeaderboardInfo(Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "leaderboardDef")))
	local f55_local3 = {}
	for f55_local10, f55_local11 in ipairs(f55_local2.trackTypes) do
		for f55_local7, f55_local8 in ipairs(f55_local0) do
			if f55_local8.value == f55_local11 then
				table.insert(f55_local3, f55_local0[f55_local10])
			end
		end
	end
	return {
		models = {
			displayText = 0x3253D68AE15D261,
			hintText = "",
			optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource(f55_arg0, "LeaderboardFilterOptions_DurationFilter", f55_local3, nil, CoD.LeaderboardUtility.SetDurationFilter, nil, nil),
			currentSelection = CoD.OptionsUtility.GetCustomProfileSelection(f55_arg0, f55_local3, f55_local1),
		},
		properties = {},
	}
end
CoD.LeaderboardUtility.LeaderboardFilterOptionsPrepare = function(f56_arg0)
	local f56_local0 = {}
	local f56_local1 = CoD.LeaderboardUtility.GetLeaderboardInfo(Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "leaderboardDef")))
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "LeaderboardFilter_LastUsedController"), f56_arg0)
	if CoD.LeaderboardUtility.IsZMMapsLeaderboard(f56_arg0) then
		table.insert(f56_local0, CoD.LeaderboardUtility.CreateModels_ZMMapsNumPlayersFilter(f56_arg0))
	end
	if not CoD.LeaderboardUtility.IsLobbyLeaderboard(f56_arg0) then
		table.insert(f56_local0, CoD.LeaderboardUtility.CreateModels_PlayerFilter(f56_arg0))
	end
	if #f56_local1.trackTypes > 1 then
		table.insert(f56_local0, CoD.LeaderboardUtility.CreateModels_DurationFilter(f56_arg0))
	end
	return f56_local0
end
DataSources.LeaderboardFilterOptions = DataSourceHelpers.ListSetup("LeaderboardFilterOptions", CoD.LeaderboardUtility.LeaderboardFilterOptionsPrepare, true)
DataSources.LeaderboardMakerButtonList = {
	prepare = function(f57_arg0, f57_arg1, f57_arg2)
		f57_arg1.buttons = {}
		local f57_local0 = {}
		local f57_local1 = ""
		local f57_local2 = nil
		local f57_local3 = Engine[0x4DF5CFBC1771947](f57_arg0)
		local f57_local4 = Engine[0x40E824FE270E174](f57_local3, "groups.leaderboardmaker.state")
		local f57_local5 = Engine[0x614D394F6F9A18D](f57_local4)
		local f57_local6 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f57_local3, "groups.leaderboardmaker.lbIndex"))
		local f57_local7 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f57_local3, "groups.leaderboardmaker.lbSortColumn"))
		if f57_local6 ~= nil and f57_local6 > 0 then
			f57_local2 = CoD.Leaderboard_MP.GetLeaderboardCoreNameData(CoD.Leaderboard_MP.Leaderboards[f57_local6][CoD.Leaderboard_MP.CoreName])
		end
		local f57_local8 = CoD.perController[f57_arg0].selectedGroup
		local f57_local9 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f57_local8, "lbIndex"))
		local f57_local10 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f57_local8, "lbSortColumn"))
		local f57_local11 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f57_local8, "lbTimeFrame"))
		f57_arg1.leaderboardMakerStateModel = f57_local4
		if f57_local5 ~= nil then
			if f57_local5 == "SelectAction" then
				f57_local1 = 0x8458D9058E2BC71
				table.insert(f57_local0, {
					model = {
						titleText = f57_local1,
						displayText = 0x75B18157601415A,
						action = ProcessEditGroupLeaderboard,
						hintText = Engine[0xF9F1239CFD921FE](0x455C5DB2A6BBD84),
					},
					properties = {
						btnId = "EditLeaderboard",
					},
				})
				table.insert(f57_local0, {
					model = {
						titleText = f57_local1,
						displayText = 0x1FC1DA8447DE792,
						action = ProcessRemoveGroupLeaderboard,
						hintText = Engine[0xF9F1239CFD921FE](0x60B74FFBBCB381C),
					},
					properties = {
						btnId = "RemoveLeaderboard",
					},
				})
			elseif f57_local5 == "ChooseBaseLeaderboard" then
				f57_local1 = 0xE6E07A6A712F4A9
				for f57_local12 = 1, #CoD.Leaderboard_MP.LeaderboardCoreNames, 1 do
					local f57_local15 = CoD.Leaderboard_MP.LeaderboardCoreNames[f57_local12]
					local f57_local16 = false
					if f57_local9 ~= nil and f57_local12 == f57_local9 then
						f57_local16 = true
					end
					table.insert(f57_local0, {
						model = {
							titleText = f57_local1,
							displayText = f57_local15.stringRef,
							action = ProcessChooseBaseLeaderboard,
							hintText = Engine[0xED84C33EC5F01EA](f57_local15.lbMakerHint),
							icon = f57_local15.icon,
							baseLeaderboard = f57_local15.stringRef,
						},
						properties = {
							btnId = f57_local15.name,
							showSelectedIcon = f57_local16,
						},
					})
				end
			elseif f57_local5 == "ChooseDefaultSort" then
				f57_local1 = 0xE9827824EF25136
				local f57_local12 = CoD.Leaderboard_MP.Leaderboards[f57_local6][CoD.Leaderboard_MP.SortColumn]
				for f57_local13 = 1, #f57_local12, 1 do
					local f57_local16 = f57_local12[f57_local13]
					local f57_local18 = false
					if f57_local9 ~= nil and f57_local10 ~= nil and f57_local6 == f57_local9 and f57_local13 == f57_local10 then
						f57_local18 = true
					end
					for f57_local19 = 1, #CoD.Leaderboard_MP.LeaderboardSortColumns, 1 do
						local f57_local22 = CoD.Leaderboard_MP.LeaderboardSortColumns[f57_local19]
						if f57_local22.name == f57_local16 then
							table.insert(f57_local0, {
								model = {
									titleText = f57_local1,
									displayText = f57_local22.stringRef,
									action = ProcessChooseDefaultSort,
									hintText = Engine[0xF9F1239CFD921FE](0x3A108B67F92F64E, f57_local22.stringRef),
									icon = f57_local2.icon,
									baseLeaderboard = f57_local2.stringRef,
									sortColumn = f57_local22.stringRef,
								},
								properties = {
									btnId = f57_local16,
									showSelectedIcon = f57_local18,
								},
							})
						end
					end
				end
			elseif f57_local5 == "ChooseTimeFrame" then
				f57_local1 = 0x6C78CD308D6573B
				local f57_local12 = CoD.Leaderboard_MP.GetLeaderboardSortColumnData(CoD.Leaderboard_MP.Leaderboards[f57_local6][CoD.Leaderboard_MP.SortColumn][f57_local7])
				local f57_local13 = CoD.Leaderboard_MP.Leaderboards[f57_local6][CoD.Leaderboard_MP.TimeFrame]
				for f57_local14 = 1, #f57_local13, 1 do
					local f57_local18 = f57_local13[f57_local14]
					for f57_local19 = 1, #CoD.Leaderboard_MP.LeaderboardTimeFrames, 1 do
						local f57_local22 = CoD.Leaderboard_MP.LeaderboardTimeFrames[f57_local19]
						if f57_local22.name == f57_local18 then
							local f57_local23 = false
							if f57_local9 ~= nil and f57_local10 ~= nil and f57_local11 ~= nil and f57_local6 == f57_local9 and f57_local7 == f57_local10 and f57_local22.value == f57_local11 then
								f57_local23 = true
							end
							table.insert(f57_local0, {
								model = {
									titleText = f57_local1,
									displayText = f57_local22.stringRef,
									action = ProcessChooseTimeFrame,
									hintText = Engine[0xED84C33EC5F01EA](f57_local22.lbMakerHint),
									icon = f57_local2.icon,
									baseLeaderboard = f57_local2.stringRef,
									sortColumn = f57_local12.stringRef,
									timeFrame = f57_local22.stringRef,
								},
								properties = {
									btnId = f57_local18,
									showSelectedIcon = f57_local23,
								},
							})
						end
					end
				end
			end
		end
		for f57_local17, f57_local15 in ipairs(f57_local0) do
			local f57_local16 = f57_local15.model
			local f57_local18 = f57_local15.properties
			local f57_local19 = f57_local3["groups.leaderboardmaker"].create(f57_local3["groups.leaderboardmaker"], "buttonModel_" .. f57_local17)
			table.insert(f57_arg1.buttons, {
				model = f57_local19,
				properties = f57_local18,
			})
			local f57_local20 = f57_local19:create("titleText")
			f57_local20:set(Engine[0xED84C33EC5F01EA](f57_local16.titleText))
			f57_local20 = f57_local19:create("displayText")
			f57_local20:set(Engine[0xED84C33EC5F01EA](f57_local16.displayText))
			f57_local20 = f57_local19:create("hintText")
			f57_local20:set(f57_local16.hintText)
			f57_local20 = f57_local19:create("action")
			f57_local20:set(f57_local16.action)
			f57_local20 = f57_local19:create("icon")
			f57_local20:set(f57_local16.icon)
			f57_local20 = f57_local19:create("baseLeaderboard")
			f57_local20:set(f57_local16.baseLeaderboard)
			f57_local20 = f57_local19:create("sortColumn")
			f57_local20:set(f57_local16.sortColumn)
			f57_local20 = f57_local19:create("timeFrame")
			f57_local20:set(f57_local16.timeFrame)
		end
		f57_arg1:subscribeToModel(f57_arg1.leaderboardMakerStateModel, function()
			f57_arg1:updateDataSource()
		end, false)
	end,
	getCount = function(f59_arg0)
		return #f59_arg0.buttons
	end,
	getCustomPropertiesForItem = function(f60_arg0, f60_arg1)
		return f60_arg0.buttons[f60_arg1].properties
	end,
	getItem = function(f61_arg0, f61_arg1, f61_arg2)
		return f61_arg1.buttons[f61_arg2].model
	end,
}
DataSources.Leaderboard = {
	getModel = function(f62_arg0)
		local f62_local0 = Engine[0x8DF2E5447F384B9]()
		f62_local0 = f62_local0:create("leaderboard")
		f62_local0:create("controller")
		f62_local0:create("error")
		f62_local0:create("isUpdating")
		f62_local0:create("numResults")
		f62_local0:create("totalResults")
		return f62_local0
	end,
}
DataSources.LeaderboardHeader = {
	getModel = function(f63_arg0)
		local f63_local0 = Engine[0x8DF2E5447F384B9]()
		f63_local0 = f63_local0:create("leaderboard")
		local f63_local1 = f63_local0:create("header")
		local f63_local2 = 3
		local f63_local3 = 5
		local f63_local4 = f63_local2 - 1
		local f63_local5 = {}
		local f63_local6, f63_local7 = nil
		local f63_local8 = 1
		local f63_local9 = Engine[0x793EF3E269B9D8](f63_arg0)
		if f63_local9 == nil then
			local f63_local10 = f63_local1:create("baseLeaderboard")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("timeFrame")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("position")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("rank")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("name")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("column0")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("column1")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("column2")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("column3")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("column4")
			f63_local10:set(0x0)
			f63_local10 = f63_local1:create("numDataColumns")
			f63_local10:set(0)
			return f63_local1
		end
		local f63_local10 = f63_local9.lbheaders
		if f63_local2 < tonumber(f63_local10.count) then
			f63_local6 = f63_local10.count - f63_local2
		else
			f63_local6 = 0
		end
		local f63_local11 = f63_local3 - f63_local6
		for f63_local12 = 1, f63_local4, 1 do
			f63_local5[f63_local12] = f63_local10[f63_local8]
			f63_local8 = f63_local8 + 1
		end
		for f63_local12 = 1, f63_local3, 1 do
			if f63_local12 <= f63_local11 then
				f63_local5[f63_local12 + f63_local4] = 0x0
			else
				f63_local5[f63_local12 + f63_local4] = f63_local10[f63_local8]
				f63_local8 = f63_local8 + 1
			end
		end
		local f63_local12 = 0x0
		local f63_local13 = 0x0
		if HasSelectedGroup(nil, nil, {
			controller = f63_arg0,
		}) then
			local f63_local14, f63_local15, f63_local16, f63_local17, f63_local18 = Engine[0xAD164A23E04F3C1]()
			if f63_local18 == true and f63_local14 > 0 then
				local f63_local19 = CoD.Leaderboard_MP.GetLeaderboardCoreNameData(CoD.Leaderboard_MP.Leaderboards[f63_local14][CoD.Leaderboard_MP.CoreName])
				local f63_local20 = CoD.Leaderboard_MP.GetTimeFrameDataFromEnumValue(f63_local16)
				f63_local12 = f63_local19.stringRef
				f63_local13 = f63_local20.stringRef
			end
		end
		f63_local14 = 0x9B07D3D5E73E818
		if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			f63_local14 = 0x3547050A22D0BD0
		elseif LuaUtils.IsArenaMode() then
			f63_local14 = 0x3370355189B42A7
		end
		local f63_local15 = f63_local1:create("baseLeaderboard")
		f63_local15:set(f63_local12)
		f63_local15 = f63_local1:create("timeFrame")
		f63_local15:set(f63_local13)
		f63_local15 = f63_local1:create("position")
		f63_local15:set(f63_local5[1])
		f63_local15 = f63_local1:create("rank")
		f63_local15:set(f63_local14)
		f63_local15 = f63_local1:create("name")
		f63_local15:set(f63_local5[2])
		f63_local15 = f63_local1:create("column0")
		f63_local15:set(f63_local5[3])
		f63_local15 = f63_local1:create("column1")
		f63_local15:set(f63_local5[4])
		f63_local15 = f63_local1:create("column2")
		f63_local15:set(f63_local5[5])
		f63_local15 = f63_local1:create("column3")
		f63_local15:set(f63_local5[6])
		f63_local15 = f63_local1:create("column4")
		f63_local15:set(f63_local5[7])
		f63_local15 = f63_local1:create("numDataColumns")
		f63_local15:set(f63_local6)
		return f63_local1
	end,
}
DataSources.LeaderboardRows = LuaUtils.OverrideTable(DataSources.LeaderboardRows, {
	getArguments = function(f64_arg0, f64_arg1, f64_arg2)
		local f64_local0 = CoD.LeaderboardUtility.IsLobbyLeaderboard(f64_arg0)
		if not CoD.perController[f64_arg0].leaderboardPlayerFilter then
			local f64_local1 = Enum[0xFB32CA7FF48A235][0x8B32F474F53EFDC]
		end
		local f64_local2 = 0
		if f64_local0 then
			local f64_local1 = Enum[0xFB32CA7FF48A235][0x7C601779D30B9FD]
		end
		local f64_local3 = {
			filter = f64_local1,
			offset = f64_arg2,
		}
		if f64_local1 ~= f64_arg1.lastFilter then
			f64_arg1.lastFilter = f64_local1
		else
			f64_local3.offset = f64_arg2
		end
		return f64_local3, f64_local2
	end,
	prefetchOffset = 10,
	setupItem = function(f65_arg0, f65_arg1, f65_arg2, f65_arg3, f65_arg4)
		local f65_local0 = LuaUtils.LobbyMainModeData
		local f65_local1 = LobbyData.GetCurrentMenuTarget()
		f65_local0 = f65_local0[f65_local1[0xEB7DDC7F079D51B]]
		if f65_local0 then
			local f65_local2 = f65_local0.eMode
		end
		f65_local0 = f65_local2 or 0
		f65_local1 = string.format("%d %d %d", ColorSet.Orange.r * 255, ColorSet.Orange.g * 255, ColorSet.Orange.b * 255)
		local f65_local3 = string.format("%d %d %d", ColorSet.White.r * 255, ColorSet.White.g * 255, ColorSet.White.b * 255)
		local f65_local4 = string.format("%d %d %d", ColorSet.PlayerYellow.r * 255, ColorSet.PlayerYellow.g * 255, ColorSet.PlayerYellow.b * 255)
		local f65_local5 = Engine[0x93B19E01B1FD1C7](f65_arg2)
		local f65_local6 = Engine[0x793EF3E269B9D8](f65_arg2)
		local f65_local7 = 4
		local f65_local8 = 5
		local f65_local9 = 3
		local f65_local10 = CoD.perController[f65_arg2].pivotPosition
		local f65_local11 = f65_local3
		local f65_local12 = f65_local3
		if f65_local5 == f65_arg1.xuid then
			f65_local11 = f65_local4
			f65_local12 = f65_local4
		end
		local f65_local13 = {
			position = 0,
			positionUI = 0,
			gamertag = "",
			rank = 0,
			rankIcon = "",
			rankString = "",
			plevel = 0,
			paragonRank = 0,
			paragonIconId = CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID,
			colData = {},
			colColor = {},
			statData = {},
			statColor = {},
			statLabel = {},
		}
		if f65_arg1.columns then
			for f65_local14 = #f65_arg1.columns, 1, -1 do
				if f65_arg1.columns[f65_local14].rankCol then
					f65_local13.position = f65_arg1.columns[f65_local14].col
					f65_local13.positionUI = f65_local13.position
				end
				if f65_arg1.columns[f65_local14].gamertagCol then
					f65_local13.gamertag = f65_arg1.columns[f65_local14].col
				end
				if f65_arg1.columns[f65_local14].type == LuaEnum.LBCOL_TYPE.LBCOL_TYPE_PRESTIGE then
					f65_local13.plevel, f65_local13.paragonRank, f65_local13.paragonIconId = LuaUtils.ConvertFromPrestigeMerged(tonumber(f65_arg1.columns[f65_local14].col))
				end
				if f65_arg1.columns[f65_local14].type == LuaEnum.LBCOL_TYPE.LBCOL_TYPE_LEVELXP then
					f65_local13.rank = tonumber(f65_arg1.columns[f65_local14].col)
				end
				if f65_arg1.columns[f65_local14].ratingCol == true then
					if f65_arg1.columns[f65_local14].passedProbation ~= nil and f65_arg1.columns[f65_local14].passedProbation == false then
						f65_arg1.columns[f65_local14].col = "--"
					elseif f65_local6 ~= nil then
						for f65_local17 = 1, f65_local6.lbcolumnnames.count, 1 do
							local f65_local20 = f65_local6.lbcolumnnames[f65_local17]
							if f65_local20 == "Score Per Minute" or f65_local20 == "Cash Per Minute" then
								f65_arg1.columns[f65_local14].col = string.format("%i", tonumber(f65_arg1.columns[f65_local14].col))
								break
							end
						end
					end
				end
				table.insert(f65_local13.colData, f65_arg1.columns[f65_local14].col)
				table.insert(f65_local13.colColor, f65_local11)
			end
		end
		if not LuaUtils.IsArenaMode() then
			f65_local13.rankString = CoD.GetRankName(f65_local13.rank - 1, f65_local13.plevel, f65_local0)
			f65_local13.rankIcon = CoD.GetRankOrParagonIcon(f65_local13.rank - 1, f65_local13.plevel, f65_local13.paragonIconId, f65_local0)
			if LuaUtils.GameModeAvailable(f65_local0) then
				if IsGameModeParagonCapable(f65_local0) and f65_local13.plevel == CoD.PrestigeUtility.GetPrestigeCap(f65_local0) then
					f65_local13.rank = Engine[0x801A572E417CC01](f65_local13.paragonRank, f65_local0)
					f65_local12 = string.format("%d %d %d", ColorSet.ParagonRank.r * 255, ColorSet.ParagonRank.g * 255, ColorSet.ParagonRank.b * 255)
				elseif f65_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and f65_local13.rank == Engine[0xEAF2F2348AFD70B](f65_local0) then
					f65_local12 = string.format("%d %d %d", ColorSet.Orange.r * 255, ColorSet.Orange.g * 255, ColorSet.Orange.b * 255)
				end
			end
		elseif f65_arg1.xuid ~= nil then
			local f65_local14 = Engine[0x2000A30A9678274](f65_arg1.xuid)
			local f65_local15, f65_local16, f65_local21 = CoD.ArenaLeaguePlayUtility.GetRankAndIcon(f65_local14.points, f65_local14.bestSubdivisionRank, f65_local14.firstSubdivisionRankTotal)
			f65_local13.rank = f65_local15
			f65_local13.rankIcon = f65_local16
			f65_local13.rankString = 0x0
		end
		local f65_local14 = #f65_local13.colData
		local f65_local15 = f65_local8 - f65_local14
		f65_local13.colColor[f65_local14] = f65_local1
		if f65_local6 then
			for f65_local16 = 0, f65_local9 - 1, 1 do
				local f65_local19 = f65_local14 - f65_local16
				local f65_local22 = f65_local16 + 3
				if f65_local6.lbcolumnids[f65_local22] == 65534 and (f65_local6.lbcolumnnames[f65_local22] == "Score Per Minute" or f65_local6.lbcolumnnames[f65_local22] == "Points Per Game") and f65_local13.colData[f65_local19] == "-1" then
					f65_local13.positionUI = "-"
					f65_local13.colData[f65_local19] = "-"
				end
				table.insert(f65_local13.statData, f65_local13.colData[f65_local19])
				table.insert(f65_local13.statColor, f65_local13.colColor[f65_local19])
				table.insert(f65_local13.statLabel, f65_local6.lbheaders[f65_local22])
			end
		end
		for f65_local16 = 1, f65_local15, 1 do
			local f65_local18 = f65_local16
			table.insert(f65_local13.colData, "")
			table.insert(f65_local13.colColor, f65_local11)
		end
		if HasSelectedGroup(nil, nil, {
			controller = f65_arg2,
		}) then
			position = i
		end
		local f65_local16 = false
		if f65_local10 then
			f65_local16 = tonumber(f65_local13.position) == f65_local10
		else
			f65_local16 = f65_local5 == f65_arg1.xuid
		end
		local f65_local21 = f65_arg4
		if CoD.perController[f65_arg2].leaderboardPlayerFilter == Enum[0xFB32CA7FF48A235][0xFC988076708BDA5] then
			f65_local21 = tonumber(f65_local13.position)
		end
		return {
			models = {
				position = tonumber(f65_local13.position),
				positionUI = tonumber(f65_local13.positionUI),
				name = f65_local13.gamertag,
				rank = f65_local13.rank,
				rankColor = f65_local12,
				rankIcon = f65_local13.rankIcon,
				rankString = f65_local13.rankString,
				plevel = f65_local13.plevel,
				column0 = f65_local13.colData[5],
				column0color = f65_local13.colColor[5],
				column1 = f65_local13.colData[4],
				column1color = f65_local13.colColor[4],
				column2 = f65_local13.colData[3],
				column2color = f65_local13.colColor[3],
				column3 = f65_local13.colData[2],
				column3color = f65_local13.colColor[2],
				column4 = f65_local13.colData[1],
				column4color = f65_local13.colColor[1],
				stat0 = f65_local13.statData[1],
				stat0color = f65_local13.statColor[1],
				stat0label = f65_local13.statLabel[1],
				stat1 = f65_local13.statData[2],
				stat1color = f65_local13.statColor[2],
				stat1label = f65_local13.statLabel[2],
				stat2 = f65_local13.statData[3],
				stat2color = f65_local13.statColor[3],
				stat2label = f65_local13.statLabel[3],
				rowColor = f65_local11,
				xuid = f65_arg1.xuid,
				backgroundId = 0,
				counterPosition = f65_local21,
			},
			properties = {
				selectIndex = f65_local16,
			},
		}
	end,
})
CoD.LeaderboardUtility.GetRecentPlayersCount = function(f66_arg0)
	if Engine[0x9E5BE3B4BBA4E0E]("recentPlayerListEnabled") then
		local f66_local0 = Engine[0x8BF970606552F4C](f66_arg0, Enum[0xBBD4F9E70101BA8][0x2C45CE6FD0D4539])
		if f66_local0 then
			local f66_local1 = 0
			for f66_local2 = 0, f66_local0.count:get() - 1, 1 do
				local f66_local5 = Engine[0x90B6BCE69A8E08B](f66_local0.playersMet[f66_local2].xuid:get())
				if f66_local5 ~= 0 and Engine[0x28AB20F81771B7A](f66_arg0, f66_local5) == false then
					f66_local1 = f66_local1 + 1
				end
			end
			return f66_local1
		end
	end
	return 0
end
CoD.LeaderboardUtility.GetRecentPlayerInfo = function(f67_arg0, f67_arg1, f67_arg2)
	local f67_local0 = f67_arg1.playersMet[f67_arg2]
	local f67_local1 = Engine[0x90B6BCE69A8E08B](f67_local0.xuid:get())
	if f67_local1 ~= 0 then
		local f67_local2 = Engine[0x83DD7A7721E8089](f67_local1, f67_arg0, Enum[0xEA28383B5DEC206][0x708B5057D80F5FF])
		if f67_local2 then
			f67_local2.index = f67_arg2
			f67_local2.xuid = f67_local1
			f67_local2.gamertag = Engine[0x1FB3481C8114A9A](f67_local1)
			f67_local2.clantag = ""
			f67_local2.time = f67_local0.time:get()
			return f67_local2
		end
	end
	return nil
end
CoD.LeaderboardUtility.GetRecentPlayerInfoNoUpdate = function(f68_arg0, f68_arg1, f68_arg2)
	local f68_local0 = f68_arg1.playersMet[f68_arg2]
	local f68_local1 = Engine[0x90B6BCE69A8E08B](f68_local0.xuid:get())
	if f68_local1 ~= 0 then
		return {
			xuid = f68_local1,
			time = f68_local0.time:get(),
		}
	else
		return nil
	end
end
CoD.LeaderboardUtility.SortRecentPlayersDDL = function(f69_arg0, f69_arg1)
	local f69_local0 = {}
	for f69_local1 = 0, f69_arg1.count:get() - 1, 1 do
		table.insert(f69_local0, {
			xuid = Engine[0x90B6BCE69A8E08B](f69_arg1.playersMet[f69_local1].xuid:get()),
			time = f69_arg1.playersMet[f69_local1].time:get(),
		})
	end
	table.sort(f69_local0, function(f70_arg0, f70_arg1)
		if f70_arg0.xuid == 0 then
			return f70_arg1.xuid == 0
		elseif f70_arg1.xuid == 0 then
			return true
		else
			return f70_arg1.time < f70_arg0.time
		end
	end)
	for f69_local2 = 1, #f69_local0, 1 do
		local f69_local5 = f69_local2 - 1
		f69_arg1.playersMet[f69_local5].time:set(f69_local0[f69_local2].time)
		f69_arg1.playersMet[f69_local5].xuid:set(f69_local0[f69_local2].xuid)
	end
	f69_arg1.isSorted:set(1)
end
CoD.LeaderboardUtility.GetRecentPlayersList = function(f71_arg0, f71_arg1, f71_arg2)
	local f71_local0 = {}
	if Engine[0x9E5BE3B4BBA4E0E]("recentPlayerListEnabled") then
		local f71_local1 = Engine[0x8BF970606552F4C](f71_arg0, Enum[0xBBD4F9E70101BA8][0x2C45CE6FD0D4539])
		if f71_local1 then
			if f71_local1.isSorted:get() ~= 1 then
				CoD.LeaderboardUtility.SortRecentPlayersDDL(f71_arg0, f71_local1)
			end
			local f71_local2 = {}
			local f71_local3 = 0
			for f71_local4 = 0, f71_local1.count:get() - 1, 1 do
				local f71_local7 = CoD.LeaderboardUtility.GetRecentPlayerInfo(f71_arg0, f71_local1, f71_local4)
				if f71_local7 ~= nil and Engine[0x28AB20F81771B7A](f71_arg0, f71_local7.xuid) == false then
					table.insert(f71_local2, f71_local7)
					if f71_local3 + 1 == f71_arg1 + f71_arg2 then
						break
					end
				end
			end
			local f71_local4 = f71_arg1 + f71_arg2 - 1
			for f71_local5 = f71_arg1, f71_local4, 1 do
				table.insert(f71_local0, f71_local2[f71_local5 + 1])
			end
		end
	end
	return f71_local0
end
DataSources.LeaderboardTabType = ListHelper_SetupDataSource("LeaderboardTabType", function(f72_arg0, f72_arg1)
	local f72_local0 = {}
	local f72_local1 = CoD.BaseUtility.GetMenuSessionMode(f72_arg1.menu)
	if f72_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		if IsArenaMode() then
			table.insert(f72_local0, {
				models = {
					name = 0x866F2CC78940BCF,
					tabCategory = "arena",
				},
				properties = {
					category = 0x5D8D7B6A4C553C8,
				},
			})
		else
			table.insert(f72_local0, {
				models = {
					name = 0xA293EB64E03142F,
					tabCategory = "core",
				},
				properties = {
					category = 0xBF2FB911980759E,
				},
			})
			table.insert(f72_local0, {
				models = {
					name = 0x77B92AED87A9600,
					tabCategory = "hardcore",
				},
				properties = {
					category = 0xB4E65040CD1305B,
				},
			})
		end
	elseif f72_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		table.insert(f72_local0, {
			models = {
				name = 0x8FDE5CC46116294,
				tabCategory = "zm_global",
			},
			properties = {
				category = 0xA6EBC84C86D7FC6,
			},
		})
		table.insert(f72_local0, {
			models = {
				name = 0x55D8B5C3E9420F7,
				tabCategory = "zm_gauntlet",
			},
			properties = {
				category = 0x351883667F5B15B,
			},
		})
	elseif f72_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		table.insert(f72_local0, {
			models = {
				name = 0xA9DC4B9726B8B6B,
				tabCategory = "wz_modes",
			},
			properties = {
				category = 0x98504EEA71F7A17,
			},
		})
	end
	return f72_local0
end)
DataSources.LeaderboardMenuTitle = {
	getModel = function(f73_arg0)
		local f73_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f73_arg0), "leaderboardMenuTitle")
		local f73_local1 = Engine[0xA798E4552F5E872](f73_local0, "title")
		if CoD.LeaderboardUtility.IsLobbyLeaderboard(f73_arg0) then
			local f73_local2 = CoD.LeaderboardUtility.GetLeaderboardInfo(Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "leaderboardDef")))
			Engine[0x83C9B5DE1D9371](f73_local1, Engine[0xF9F1239CFD921FE](f73_local2.title))
			return f73_local0
		else
			local f73_local3 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "leaderboardCategoryName")
			if not f73_local3 then
				return f73_local0
			else
				local f73_local2 = Engine[0x614D394F6F9A18D](f73_local3)
				if not f73_local2 then
					return f73_local0
				else
					Engine[0x83C9B5DE1D9371](f73_local1, Engine[0xF9F1239CFD921FE](0xA29C2EC825A6AD8, Engine[0xF9F1239CFD921FE](CoD.LeaderboardUtility.leaderboardTab[f73_local2].leaderboardHeaderText)))
					return f73_local0
				end
			end
		end
	end,
}
CoD.OverlayUtility.AddSystemOverlay("LeaderboardsDownForMaintanence", {
	menuName = "SystemOverlay_Compact",
	title = "MENU/LEADERBOARDS_NOT_AVAILABLE",
	description = "MENU/LEADERBOARDS_NOT_AVAILABLE_DESC",
	categoryType = CoD.OverlayUtility.OverlayTypes.Notice,
	listDatasource = function()
		DataSources.LeaderboardsDownForMaintanenceList = DataSourceHelpers.ListSetup("LeaderboardsDownForMaintanenceList", function(f75_arg0)
			return {
				{
					models = {
						displayText = "MENU/OK",
					},
					properties = {
						action = function(f76_arg0, f76_arg1, f76_arg2, f76_arg3, f76_arg4)
							GoBack(f76_arg4, f76_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "LeaderboardsDownForMaintanenceList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
})
