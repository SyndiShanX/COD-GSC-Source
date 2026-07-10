require("x64:f3c5259f470592d")
CoD.LeaderboardUtility = {}
CoD.LeaderboardUtility.PLAYER_POSITION_IN_LEADERBOARD = 6
CoD.LeaderboardUtility.DEFAULT_ZM_MAPS_NUM_PLAYERS = 1
CoD.LeaderboardUtility.TOP = 0
CoD.LeaderboardUtility.BOTTOM = 1
CoD.LeaderboardUtility.LB_ZM_GB_PERKS_DRANK_TITLE = 0x0
CoD.LeaderboardUtility.LB_ZM_GB_PERKS_DRANK_TITLE = @"hash_24CC7C08B5DC2887"
CoD.LeaderboardUtility.DefaultTrackTypes = {
	Enum[@"lbtracktype"][@"lb_trk_alltime"],
	Enum[@"lbtracktype"][@"lb_trk_monthly"],
	Enum[@"lbtracktype"][@"lb_trk_weekly"],
}
CoD.LeaderboardUtility.leaderboardListCore = {
	@"lb_mp_gb_score",
	@"hash_49A021342E7D43D2",
	@"hash_51C8643AF845B430",
	@"hash_7C7E01EC88252CA5",
	@"hash_3D3DB133DE779F81",
	@"hash_7C0E7AA2563F999",
	@"hash_51E74B3AF8603A44",
	@"hash_4A041D1F27A5D913",
	@"hash_23921533D003B197",
	@"hash_AB831384CFA3838",
	@"hash_1305F1C4D44A197C",
}
CoD.LeaderboardUtility.leaderboardListHardcore = {
	@"hash_34882830C8D7CC2",
	@"hash_6A2EC118019192A",
	@"hash_6587D5708CBC82C4",
	@"hash_79C1F35350983A03",
	@"hash_46FD89D1041D210F",
	@"hash_6ECE28903B4C4878",
	@"hash_1F937E5C8BD79380",
}
CoD.LeaderboardUtility.leaderboardListArena = {
	@"hash_7684509A5266DAA5",
	0x437480E4F75EEC,
	@"hash_764D7F553AF03804",
}
CoD.LeaderboardUtility.leaderboardListZMGlobal = {
	@"hash_70366E5C4470353",
}
CoD.LeaderboardUtility.leaderboardListZMGauntlet = {
	@"hash_74789E547635C17C",
	@"hash_442F5184A8BB8CF9",
	@"hash_F72136904B594BF",
	@"hash_64EAA0418FCFD3FC",
	@"hash_35205CE55E1DA16C",
	@"hash_ADA909B618D4A",
	@"hash_9EE8CC91C547BB9",
	@"hash_2378C349A2F89514",
	@"hash_3444F6E41BCB1A81",
}
CoD.LeaderboardUtility.leaderboardListZMMaps = {}
CoD.LeaderboardUtility.leaderboardListWZModes = {
	@"hash_320437C01157B674",
	@"hash_42F5097768B0B81A",
	@"hash_38F29CAA4F9941D5",
}
CoD.LeaderboardUtility.leaderboardTab = {
	[@"core"] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListCore,
		leaderboardHeaderText = @"hash_4A293EB64E03142F",
	},
	[@"hardcore"] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListHardcore,
		leaderboardHeaderText = @"hash_577B92AED87A9600",
	},
	[@"arena"] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListArena,
		leaderboardHeaderText = @"hash_2866F2CC78940BCF",
	},
	[@"zm_global"] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListZMGlobal,
		leaderboardHeaderText = @"hash_48FDE5CC46116294",
	},
	[@"zm_gauntlet"] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListZMGauntlet,
		leaderboardHeaderText = @"hash_55D8B5C3E9420F7",
	},
	[@"wz_modes"] = {
		leaderboardList = CoD.LeaderboardUtility.leaderboardListWZModes,
		leaderboardHeaderText = @"hash_4A9DC4B9726B8B6B",
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
		f1_local0(@"hash_49A021342E7D43D2", @"hash_6A2EC118019192A", @"hash_1CCA8BEC64E44876", @"tdm")
		f1_local0(@"hash_51C8643AF845B430", @"hash_6587D5708CBC82C4", @"hash_5D4577D7A38160A0", @"dm")
		f1_local0(@"hash_3D3DB133DE779F81", @"hash_46FD89D1041D210F", @"hash_EDE29B3F8E07ACD", @"dom")
		f1_local0(@"hash_51E74B3AF8603A44", @"hash_6ECE28903B4C4878", 0x437480E4F75EEC, @"sd")
		f1_local0(@"hash_3246733BE471886", @"hash_7EE348E57439D79E", @"hash_5665027CFD36A1A2", @"ctf")
		f1_local0(@"hash_3D518D33DE880B5F", @"hash_3A85485E8DF5DD21", @"hash_2456CC65AB4F1E1F", @"dem")
		f1_local0(@"hash_7C0E7AA2563F999", @"hash_62600DDDA44669D7", @"hash_7684509A5266DAA5", @"koth")
		f1_local0(@"hash_7C7E01EC88252CA5", @"hash_79C1F35350983A03", @"hash_3E40C7C87AF2CA49", @"conf")
		f1_local0(@"hash_46A3FFF2696DF3AE", @"hash_C90718E681E23F6", 0xA2F14A9BE3602A, @"ball")
		f1_local0(@"hash_4A041D1F27A5D913", @"hash_4C7B52324D6947A5", @"hash_35C9E9AD2E1FC42B", @"escort")
		f1_local0(@"hash_23921533D003B197", @"hash_789DF1C27E15A69", @"hash_5ADC15C75B399B97", @"gun")
		f1_local0(@"hash_AB831384CFA3838", @"hash_635A25A6313758BC", @"hash_AB831384CFA3838", @"bounty")
		f1_local0(@"hash_1305F1C4D44A197C", @"hash_1F937E5C8BD79380", @"hash_764D7F553AF03804", @"control")
		local f1_local1 = function(f3_arg0, f3_arg1, f3_arg2)
			local f3_local0 = CoD.MapUtility.GetMapValue(f3_arg1, "mapName", 0x0)
			local f3_local1 = CoD.MapUtility.GetMapValue(f3_arg1, "previewImage", 0x0)
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0].title = f3_local0
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0].icon = f3_local1
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0].dlcBit = f3_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f3_arg0].trackTypes = {
				Enum[@"lbtracktype"][@"lb_trk_alltime"],
			}
		end
		f1_local1(@"hash_44F315BDBA60FE82", @"zm_zodt8", CoD.DLCBits.CONTENT_ORIGINALMAPS)
		f1_local1(@"hash_6429613456337DCB", @"zm_towers", CoD.DLCBits.CONTENT_ORIGINALMAPS)
		f1_local1(@"hash_225671F57AABAF7E", @"zm_escape", CoD.DLCBits.CONTENT_ORIGINALMAPS)
		f1_local1(@"hash_45965088D73B7EE9", @"zm_office", CoD.DLCBits.CONTENT_DLC0ZM)
		f1_local1(@"hash_DDC26B6F35FF5A", @"zm_mansion", CoD.DLCBits.CONTENT_DLC1ZM)
		f1_local1(@"hash_530E78C01B2597B0", @"zm_red", CoD.DLCBits.CONTENT_DLC2ZM)
		local f1_local2 = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg0].title = f4_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg0].icon = f4_arg3
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg0].trackTypes = {
				Enum[@"lbtracktype"][@"lb_trk_alltime"],
			}
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg1] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg1].title = f4_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg1].icon = f4_arg3
			CoD.LeaderboardUtility.LeaderboardInfo[f4_arg1].trackTypes = {
				Enum[@"lbtracktype"][@"lb_trk_alltime"],
			}
		end
		f1_local2(@"hash_70366E5C4470353", @"hash_7FE262587F35DFB1", @"hash_36E45BDFB807BA0C", @"ui_icon_gamemode_career_zm")
		f1_local2(@"hash_77A5E67291AD99C5", @"lb_zm_gb_kills_at", @"hash_4978F253BCF5F16A", @"hash_79C950584F9BA7CC")
		f1_local2(@"hash_71B596331A39E41A", @"hash_1E7B2EF603C4940A", @"hash_B5036476F2D18F1", @"hash_130B4EA5A901E99C")
		f1_local2(@"hash_7BF3DFFA806B8637", @"lb_zm_gb_bullets_hit_at", @"hash_7F8C05A932C222F4", @"hash_34E7167C63987A08")
		f1_local2(@"hash_45B680443AABC3E7", @"lb_zm_gb_headshots_at", @"hash_5F84CA9A12A74B9C", @"hash_5270D7A0C7EEDB7A")
		f1_local2(0x354184A955F73C, @"lb_zm_gb_grenade_kills_at", @"hash_1FE639D81A7245CE", @"hash_58D2DAB62E02B423")
		f1_local2(@"hash_2EFC6FFE429EFD62", @"lb_zm_gb_revives_at", @"hash_E547CF1C5C945B5", @"hash_1C43523103B7C377")
		f1_local2(@"hash_5898F8FCA9925F65", @"lb_zm_gb_distance_traveled_at", @"hash_247553162E2176CE", @"hash_7D5CF1E78FE3AC15")
		f1_local2(@"hash_62DB713B9F144A4B", @"lb_zm_gb_doors_purchased_at", @"hash_183F7E6E94807EDA", @"hash_64E5F257F9EB3955")
		f1_local2(@"hash_358B29DAD4A59664", @"lb_zm_gb_perks_drank_at", CoD.LeaderboardUtility.LB_ZM_GB_PERKS_DRANK_TITLE, @"hash_CCD4A473580CF6B")
		local f1_local3 = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
			local f5_local0 = CoD.DirectorUtility.TrialsMapEnabledDvars[f5_arg2]
			if f5_local0 and not IsBooleanDvarSet(f5_local0) then
				return
			else
				CoD.LeaderboardUtility.LeaderboardInfo[f5_arg0] = {}
				CoD.LeaderboardUtility.LeaderboardInfo[f5_arg0].title = f5_arg1
				CoD.LeaderboardUtility.LeaderboardInfo[f5_arg0].icon = f5_arg3
				CoD.LeaderboardUtility.LeaderboardInfo[f5_arg0].trackTypes = {
					Enum[@"lbtracktype"][@"lb_trk_alltime"],
				}
			end
		end
		f1_local3(@"hash_74789E547635C17C", 0xC6DC1A7FAC1E48, @"zm_zodt8", @"hash_11AEA8301D2466F7")
		f1_local3(@"hash_442F5184A8BB8CF9", @"hash_3DEADD371D74E38C", @"zm_towers", @"hash_6B551941FB81823B")
		f1_local3(@"hash_F72136904B594BF", @"hash_7D04C533DC2235E6", @"zm_escape", @"hash_793D1D7EA7B44F24")
		f1_local3(@"hash_64EAA0418FCFD3FC", @"hash_1F075735A3BB5BB6", @"zm_office", @"hash_23DCD6B96C1F06A4")
		f1_local3(@"hash_35205CE55E1DA16C", @"hash_316859B1C782F9F2", @"zm_mansion", @"hash_33F8E0237F44B0E2")
		f1_local3(@"hash_ADA909B618D4A", @"hash_757782883FEE8976", @"zm_red", @"hash_7821F71DD7A88AC1")
		f1_local3(@"hash_9EE8CC91C547BB9", @"hash_74BADFDCF63F6338", @"zm_zodt8", @"hash_11AEA8301D2466F7")
		f1_local3(@"hash_2378C349A2F89514", @"hash_640D886BB4070112", @"zm_white", @"hash_D70CAD0E674AF1F")
		f1_local3(@"hash_3444F6E41BCB1A81", @"hash_37702CF66B8230F9", @"zm_orange", @"hash_361BC83FAA4939C")
		local f1_local4 = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
			CoD.LeaderboardUtility.LeaderboardInfo[f6_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f6_arg0].title = f6_arg1
			CoD.LeaderboardUtility.LeaderboardInfo[f6_arg0].icon = f6_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f6_arg0].trackTypes = f6_arg3
		end
		f1_local4(@"lb_mp_gb_score", @"hash_1577FFBA4A51E340", @"ui_icon_gamemode_career_mp", CoD.LeaderboardUtility.DefaultTrackTypes)
		f1_local4(@"hash_34882830C8D7CC2", @"hash_1577FFBA4A51E340", @"ui_icon_gamemode_career_mp", CoD.LeaderboardUtility.DefaultTrackTypes)
		f1_local4(@"hash_68CF593C6FE1D09E", @"hash_1577FFBA4A51E340", @"ui_icon_gamemode_career_mp", CoD.LeaderboardUtility.DefaultTrackTypes)
		local f1_local5 = function(f7_arg0, f7_arg1, f7_arg2)
			CoD.LeaderboardUtility.LeaderboardInfo[f7_arg0] = {}
			CoD.LeaderboardUtility.LeaderboardInfo[f7_arg0].title = f7_arg1
			CoD.LeaderboardUtility.LeaderboardInfo[f7_arg0].icon = f7_arg2
			CoD.LeaderboardUtility.LeaderboardInfo[f7_arg0].trackTypes = {
				Enum[@"lbtracktype"][@"lb_trk_alltime"],
			}
		end
		f1_local5(@"hash_320437C01157B674", @"hash_5D66A3D1AAD8BEB3", @"ui_icon_gamemode_wz_solo")
		f1_local5(@"hash_42F5097768B0B81A", @"hash_12661E19A0FBC131", @"ui_icon_gamemode_wz_duo")
		f1_local5(@"hash_38F29CAA4F9941D5", @"hash_1E2841875AF78500", @"ui_icon_gamemode_wz_quad")
		f1_local5(@"hash_5BBDB7C1C2499251", 0x2346D505817A54, @"hash_B0691C41F056744")
	end
	return CoD.LeaderboardUtility.LeaderboardInfo[f1_arg0]
end
CoD.LeaderboardUtility.SetZMMapsNumPlayersFilter = function(f8_arg0)
	local f8_local0 = Engine[@"getmodelvalue"]
	local f8_local1 = Engine[@"getmodel"]
	local f8_local2 = Engine[@"getglobalmodel"]()
	CoD.perController[f8_local0(f8_local1(Engine[@"getglobalmodel"](), "LeaderboardFilter_LastUsedController"))].leaderboardZMMapsNumPlayersFilterTemp = f8_arg0
end
CoD.LeaderboardUtility.SetPlayerFilter = function(f9_arg0)
	local f9_local0 = Engine[@"getmodelvalue"]
	local f9_local1 = Engine[@"getmodel"]
	local f9_local2 = Engine[@"getglobalmodel"]()
	CoD.perController[f9_local0(f9_local1(Engine[@"getglobalmodel"](), "LeaderboardFilter_LastUsedController"))].leaderboardPlayerFilterTemp = f9_arg0
end
CoD.LeaderboardUtility.SetDurationFilter = function(f10_arg0)
	local f10_local0 = Engine[@"getmodelvalue"]
	local f10_local1 = Engine[@"getmodel"]
	local f10_local2 = Engine[@"getglobalmodel"]()
	CoD.perController[f10_local0(f10_local1(Engine[@"getglobalmodel"](), "LeaderboardFilter_LastUsedController"))].leaderboardDurationFilterTemp = f10_arg0
end
CoD.LeaderboardUtility.GetZMMapsNumPlayersFilterString = function(f11_arg0)
	if f11_arg0 == 1 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"menu/solo")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](0xCA1F9779DCA08D, f11_arg0)
	end
end
CoD.LeaderboardUtility.GetPlayerFilterString = function(f12_arg0)
	if f12_arg0 == Enum[@"lbfilter"][@"lb_filter_friends"] then
		return Engine[@"hash_4F9F1239CFD921FE"](0x8396FC4289ACDA)
	elseif f12_arg0 == Enum[@"lbfilter"][@"lb_filter_lobby_members"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_48EEFC66339125B3")
	elseif f12_arg0 == Enum[@"lbfilter"][@"lb_filter_none"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5B692D0423F11724")
	elseif f12_arg0 == Enum[@"lbfilter"][@"hash_38B32F474F53EFDC"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_66B9DBC36598BF9E")
	else
	end
end
CoD.LeaderboardUtility.GetDurationFilterString = function(f13_arg0)
	if f13_arg0 == Enum[@"lbtracktype"][@"lb_trk_alltime"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5941D0ABA4C78F94")
	elseif f13_arg0 == Enum[@"lbtracktype"][@"lb_trk_monthly"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_51E51AF1FC9826A2")
	elseif f13_arg0 == Enum[@"lbtracktype"][@"lb_trk_weekly"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_3379CAAA3E8196A")
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
			local f15_local4 = tonumber(Engine[@"getmodelvalue"](Engine[@"getmodel"](f15_arg1:getModel(), "position")))
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
			local f17_local5 = tonumber(Engine[@"getmodelvalue"](Engine[@"getmodel"](f17_arg1:getModel(), "position")))
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
	if tonumber(Engine[@"getmodelvalue"](Engine[@"getmodel"](f19_local1:getModel(), "position"))) == 1 then
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
		local f21_local2 = Enum[@"lbfilter"][@"hash_38B32F474F53EFDC"]
	end
	local f21_local3 = CoD.perController[f21_arg1].leaderboardZMMapsNumPlayersFilter
	if not f21_local3 then
		f21_local3 = CoD.LeaderboardUtility.DEFAULT_ZM_MAPS_NUM_PLAYERS
	end
	CoD.perController[f21_arg1].pivotPosition = nil
	local f21_local4 = Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "leaderboardDef"))
	local f21_local5 = CoD.LeaderboardUtility.GetLeaderboardInfo(f21_local4)
	local f21_local6 = CoD.perController[f21_arg1].leaderboardDurationFilter
	if f21_local0 then
		f21_local4 = f21_local4 .. "_" .. tostring(f21_local3) .. "PLAYER"
	end
	if f21_local1 then
		local f21_local2 = Enum[@"lbfilter"][@"lb_filter_lobby_members"]
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
	if not Dvar[@"ui_hideleaderboards"]:get() and Engine[@"loadleaderboard"](f21_local4, f21_local6) == true then
		DataSources.LeaderboardRows.refresh(f21_arg1)
	end
	f21_local8 = CoD.LeaderboardUtility.GetPlayerFilterString(f21_local2)
	f21_local9 = CoD.LeaderboardUtility.GetDurationFilterString(f21_local6)
	f21_local10 = ""
	if f21_local0 then
		f21_local10 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", CoD.LeaderboardUtility.GetZMMapsNumPlayersFilterString(f21_local3), f21_local8)
	elseif f21_local1 then
		f21_local10 = f21_local9
	elseif #f21_local5.trackTypes > 1 then
		f21_local10 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f21_local8, f21_local9)
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
	if CoD.perController[f23_arg2].leaderboardPlayerFilter == Enum[@"lbfilter"][@"lb_filter_none"] then
		CoD.LeaderboardUtility.PageUpAll(f23_arg0, f23_arg1, f23_arg2)
	else
		CoD.LeaderboardUtility.PageUpFriends(f23_arg0, f23_arg1, f23_arg2)
	end
end
CoD.LeaderboardUtility.LeaderboardPageDown = function(f24_arg0, f24_arg1, f24_arg2)
	if CoD.perController[f24_arg2].leaderboardPlayerFilter == Enum[@"lbfilter"][@"lb_filter_none"] then
		CoD.LeaderboardUtility.PageDownAll(f24_arg0, f24_arg1, f24_arg2)
	else
		CoD.LeaderboardUtility.PageDownFriends(f24_arg0, f24_arg1, f24_arg2)
	end
end
CoD.LeaderboardUtility.LeaderboardGoToTopOfList = function(f25_arg0, f25_arg1, f25_arg2)
	if CoD.perController[f25_arg2].leaderboardPlayerFilter == Enum[@"lbfilter"][@"lb_filter_none"] then
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
		local f29_local0 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f29_arg1:getModel(), "name"))
		local f29_local1 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f29_arg1:getModel(), "xuid"))
		local f29_local2 = Engine[@"getplayerinfo"](f29_arg2, f29_local1)
		local f29_local3 = Engine[@"getmodelforcontroller"](f29_arg2)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f29_local3, "Social.selectedFriendXUID"), f29_local1)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f29_local3, "Social.selectedFriendGamertag"), f29_local0)
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
			f30_arg1:setupPlayerBackgroundIdUpdateByXUID(Engine[@"getmodelvalue"](f31_local2))
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
	local f33_local1 = Engine[@"getglobalmodel"]()
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
		elseif CoD.SafeGetModelValue(f35_local1:getModel(), "xuid") == Engine[@"getxuid64"](f34_arg1) then
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
	local f36_local0 = Engine[@"createmodel"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "socialRoot"), "playersListFull")
	f36_local0:set(Engine[@"hash_63B1FD53757FE607"](Engine[@"getprimarycontroller"]()) == 0)
end
CoD.LeaderboardUtility.AutoAddFriends = function(f37_arg0)
	Engine[@"hash_4C547432E64838B6"](f37_arg0)
end
CoD.LeaderboardUtility.SetAutoAddFriendsTrue = function(f38_arg0)
	Engine[@"hash_11776FDF9D77DC58"](f38_arg0, true)
end
CoD.LeaderboardUtility.SetAutoAddFriendsFalse = function(f39_arg0)
	Engine[@"hash_11776FDF9D77DC58"](f39_arg0, false)
end
CoD.LeaderboardUtility.UpdatePlayersListCount = function(f40_arg0)
	local f40_local0 = Engine[@"createmodel"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "socialRoot"), "playersListCount")
	f40_local0:set(Engine[@"hash_5469E79D58A190B2"](f40_arg0))
end
CoD.LeaderboardUtility.AutoAddFriendsCheckboxDisabled = function(f41_arg0)
	return not Engine[@"hash_4E48DAA41997DD66"](f41_arg0)
end
CoD.LeaderboardUtility.GetAutoAddFriends = function(f42_arg0)
	return Engine[@"hash_52FCD8424924CB2C"](f42_arg0)
end
CoD.LeaderboardUtility.LeaderboardsDownForMaintanence = function()
	return Dvar[@"hash_2F1F9C30FB608A2E"]:get()
end
CoD.LeaderboardUtility.IsLobbyLeaderboard = function(f44_arg0)
	return CoD.perController[f44_arg0].isInLobbyLeaderboard == true
end
CoD.LeaderboardUtility.IsLeaderboardCategory = function(f45_arg0, f45_arg1, f45_arg2)
	return f45_arg0._category and f45_arg0._category == f45_arg2
end
CoD.LeaderboardUtility.IsZMMapsLeaderboard = function(f46_arg0)
	local f46_local0 = Engine[@"getglobalmodel"]()
	f46_local0 = f46_local0.leaderboardCategoryName
	if f46_local0 then
		return f46_local0:get() == "zm_maps"
	else
		return false
	end
end
CoD.LeaderboardUtility.IsMPGameModeLeaderboard = function(f47_arg0)
	local f47_local0 = Engine[@"getglobalmodel"]()
	f47_local0 = f47_local0.leaderboardDef
	if f47_local0 then
		return string.sub(f47_local0:get(), 1, string.len("LB_MP_GM_")) == "LB_MP_GM_"
	else
		return false
	end
end
CoD.LeaderboardUtility.IsLeaderboardUpdating = function()
	return CoD.SafeGetModelValue(DataSources.LeaderboardRows.getModel(), "status") == Enum[@"fetchliststate"][@"fetch_list_state_fetching"]
end
CoD.LeaderboardUtility.IsLeaderboardEmpty = function()
	return DataSources.LeaderboardRows.getCount() == 0
end
CoD.LeaderboardUtility.PlayerListCountAndMax = function(f50_arg0)
	local f50_local0 = Engine[@"createmodel"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "socialRoot"), "playersListCount")
	local f50_local1 = f50_local0:get()
	if not f50_local1 then
		f50_local1 = Engine[@"hash_5469E79D58A190B2"](Engine[@"getprimarycontroller"]())
	end
	return Engine[@"hash_4F9F1239CFD921FE"](f50_arg0, f50_local1, Engine[@"hash_2A9E982FF50617CA"]())
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
		local f52_local1 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "leaderboardDef")
		if f52_local1 then
			table.insert(f52_local0, {
				models = {
					name = @"hash_0",
					tabWidget = "CoD.Leaderboard_GameModeFrame",
					lbDef = Engine[@"getmodelvalue"](f52_local1),
				},
				properties = {
					selectIndex = true,
				},
			})
		end
		return f52_local0
	end
	local f52_local1 = CoD.LeaderboardUtility.leaderboardGameModeData[1].models.lbDef
	local f52_local2 = Engine[@"getglobalmodel"]()
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
			name = Engine[@"hash_4F9F1239CFD921FE"](@"menu/solo"),
			value = 1,
		},
		{
			name = Engine[@"hash_4F9F1239CFD921FE"](0xCA1F9779DCA08D, 2),
			value = 2,
		},
		{
			name = Engine[@"hash_4F9F1239CFD921FE"](0xCA1F9779DCA08D, 3),
			value = 3,
		},
		{
			name = Engine[@"hash_4F9F1239CFD921FE"](0xCA1F9779DCA08D, 4),
			value = 4,
		},
	}
	local f53_local1 = CoD.perController[f53_arg0].leaderboardZMMapsNumPlayersFilter
	if not f53_local1 then
		f53_local1 = CoD.LeaderboardUtility.DEFAULT_ZM_MAPS_NUM_PLAYERS
	end
	return {
		models = {
			displayText = @"hash_35275E4CC68CA25",
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
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_66B9DBC36598BF9E"),
		value = Enum[@"lbfilter"][@"hash_38B32F474F53EFDC"],
	})
	table.insert(f54_local0, {
		name = Engine[@"hash_4F9F1239CFD921FE"](0x8396FC4289ACDA),
		value = Enum[@"lbfilter"][@"lb_filter_friends"],
	})
	if IsMemberOfAnyGroup(f54_arg0) then
		table.insert(f54_local0, {
			name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7FC022F454CCBACD"),
			value = Enum[@"lbfilter"][@"lb_filter_group_members"],
		})
	end
	table.insert(f54_local0, {
		name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5B692D0423F11724"),
		value = Enum[@"lbfilter"][@"lb_filter_none"],
	})
	local f54_local1 = CoD.perController[f54_arg0].leaderboardPlayerFilter
	if not f54_local1 then
		f54_local1 = Enum[@"lbfilter"][@"hash_38B32F474F53EFDC"]
	end
	return {
		models = {
			displayText = @"hash_5E20D5225108123D",
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
			name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5941D0ABA4C78F94"),
			value = Enum[@"lbtracktype"][@"lb_trk_alltime"],
		},
		{
			name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_51E51AF1FC9826A2"),
			value = Enum[@"lbtracktype"][@"lb_trk_monthly"],
		},
		{
			name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3379CAAA3E8196A"),
			value = Enum[@"lbtracktype"][@"lb_trk_weekly"],
		},
	}
	local f55_local1 = CoD.perController[f55_arg0].leaderboardDurationFilter
	if not f55_local1 then
		f55_local1 = Enum[@"lbtracktype"][@"lb_trk_alltime"]
	end
	local f55_local2 = CoD.LeaderboardUtility.GetLeaderboardInfo(Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "leaderboardDef")))
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
			displayText = @"hash_13253D68AE15D261",
			hintText = "",
			optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource(f55_arg0, "LeaderboardFilterOptions_DurationFilter", f55_local3, nil, CoD.LeaderboardUtility.SetDurationFilter, nil, nil),
			currentSelection = CoD.OptionsUtility.GetCustomProfileSelection(f55_arg0, f55_local3, f55_local1),
		},
		properties = {},
	}
end
CoD.LeaderboardUtility.LeaderboardFilterOptionsPrepare = function(f56_arg0)
	local f56_local0 = {}
	local f56_local1 = CoD.LeaderboardUtility.GetLeaderboardInfo(Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "leaderboardDef")))
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "LeaderboardFilter_LastUsedController"), f56_arg0)
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
		local f57_local3 = Engine[@"getmodelforcontroller"](f57_arg0)
		local f57_local4 = Engine[@"getmodel"](f57_local3, "groups.leaderboardmaker.state")
		local f57_local5 = Engine[@"getmodelvalue"](f57_local4)
		local f57_local6 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f57_local3, "groups.leaderboardmaker.lbIndex"))
		local f57_local7 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f57_local3, "groups.leaderboardmaker.lbSortColumn"))
		if f57_local6 ~= nil and f57_local6 > 0 then
			f57_local2 = CoD.Leaderboard_MP.GetLeaderboardCoreNameData(CoD.Leaderboard_MP.Leaderboards[f57_local6][CoD.Leaderboard_MP.CoreName])
		end
		local f57_local8 = CoD.perController[f57_arg0].selectedGroup
		local f57_local9 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f57_local8, "lbIndex"))
		local f57_local10 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f57_local8, "lbSortColumn"))
		local f57_local11 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f57_local8, "lbTimeFrame"))
		f57_arg1.leaderboardMakerStateModel = f57_local4
		if f57_local5 ~= nil then
			if f57_local5 == "SelectAction" then
				f57_local1 = @"hash_68458D9058E2BC71"
				table.insert(f57_local0, {
					model = {
						titleText = f57_local1,
						displayText = @"hash_375B18157601415A",
						action = ProcessEditGroupLeaderboard,
						hintText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_455C5DB2A6BBD84"),
					},
					properties = {
						btnId = "EditLeaderboard",
					},
				})
				table.insert(f57_local0, {
					model = {
						titleText = f57_local1,
						displayText = @"hash_11FC1DA8447DE792",
						action = ProcessRemoveGroupLeaderboard,
						hintText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_60B74FFBBCB381C"),
					},
					properties = {
						btnId = "RemoveLeaderboard",
					},
				})
			elseif f57_local5 == "ChooseBaseLeaderboard" then
				f57_local1 = @"hash_1E6E07A6A712F4A9"
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
							hintText = Engine[@"localize"](f57_local15.lbMakerHint),
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
				f57_local1 = @"hash_5E9827824EF25136"
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
									hintText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_63A108B67F92F64E", f57_local22.stringRef),
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
				f57_local1 = @"hash_36C78CD308D6573B"
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
									hintText = Engine[@"localize"](f57_local22.lbMakerHint),
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
			f57_local20:set(Engine[@"localize"](f57_local16.titleText))
			f57_local20 = f57_local19:create("displayText")
			f57_local20:set(Engine[@"localize"](f57_local16.displayText))
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
		local f62_local0 = Engine[@"getglobalmodel"]()
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
		local f63_local0 = Engine[@"getglobalmodel"]()
		f63_local0 = f63_local0:create("leaderboard")
		local f63_local1 = f63_local0:create("header")
		local f63_local2 = 3
		local f63_local3 = 5
		local f63_local4 = f63_local2 - 1
		local f63_local5 = {}
		local f63_local6, f63_local7 = nil
		local f63_local8 = 1
		local f63_local9 = Engine[@"getleaderboardheaders"](f63_arg0)
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
			local f63_local14, f63_local15, f63_local16, f63_local17, f63_local18 = Engine[@"getgroupleaderboardinfo"]()
			if f63_local18 == true and f63_local14 > 0 then
				local f63_local19 = CoD.Leaderboard_MP.GetLeaderboardCoreNameData(CoD.Leaderboard_MP.Leaderboards[f63_local14][CoD.Leaderboard_MP.CoreName])
				local f63_local20 = CoD.Leaderboard_MP.GetTimeFrameDataFromEnumValue(f63_local16)
				f63_local12 = f63_local19.stringRef
				f63_local13 = f63_local20.stringRef
			end
		end
		f63_local14 = @"menu/lb_level"
		if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
			f63_local14 = @"hash_53547050A22D0BD0"
		elseif LuaUtils.IsArenaMode() then
			f63_local14 = @"arena/rank"
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
			local f64_local1 = Enum[@"lbfilter"][@"hash_38B32F474F53EFDC"]
		end
		local f64_local2 = 0
		if f64_local0 then
			local f64_local1 = Enum[@"lbfilter"][@"lb_filter_lobby_members"]
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
		f65_local0 = f65_local0[f65_local1[@"mainmode"]]
		if f65_local0 then
			local f65_local2 = f65_local0.eMode
		end
		f65_local0 = f65_local2 or 0
		f65_local1 = string.format("%d %d %d", ColorSet.Orange.r * 255, ColorSet.Orange.g * 255, ColorSet.Orange.b * 255)
		local f65_local3 = string.format("%d %d %d", ColorSet.White.r * 255, ColorSet.White.g * 255, ColorSet.White.b * 255)
		local f65_local4 = string.format("%d %d %d", ColorSet.PlayerYellow.r * 255, ColorSet.PlayerYellow.g * 255, ColorSet.PlayerYellow.b * 255)
		local f65_local5 = Engine[@"getxuid64"](f65_arg2)
		local f65_local6 = Engine[@"getleaderboardheaders"](f65_arg2)
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
					f65_local13.rank = Engine[@"getparagonrankdisplaylevel"](f65_local13.paragonRank, f65_local0)
					f65_local12 = string.format("%d %d %d", ColorSet.ParagonRank.r * 255, ColorSet.ParagonRank.g * 255, ColorSet.ParagonRank.b * 255)
				elseif f65_local0 == Enum[@"emodes"][@"mode_warzone"] and f65_local13.rank == Engine[@"getrankcap"](f65_local0) then
					f65_local12 = string.format("%d %d %d", ColorSet.Orange.r * 255, ColorSet.Orange.g * 255, ColorSet.Orange.b * 255)
				end
			end
		elseif f65_arg1.xuid ~= nil then
			local f65_local14 = Engine[@"hash_62000A30A9678274"](f65_arg1.xuid)
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
		if CoD.perController[f65_arg2].leaderboardPlayerFilter == Enum[@"lbfilter"][@"lb_filter_none"] then
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
	if Engine[@"getdvarbool"]("recentPlayerListEnabled") then
		local f66_local0 = Engine[@"storagegetbuffer"](f66_arg0, Enum[@"storagefiletype"][@"hash_22C45CE6FD0D4539"])
		if f66_local0 then
			local f66_local1 = 0
			for f66_local2 = 0, f66_local0.count:get() - 1, 1 do
				local f66_local5 = Engine[@"hash_690B6BCE69A8E08B"](f66_local0.playersMet[f66_local2].xuid:get())
				if f66_local5 ~= 0 and Engine[@"hash_328AB20F81771B7A"](f66_arg0, f66_local5) == false then
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
	local f67_local1 = Engine[@"hash_690B6BCE69A8E08B"](f67_local0.xuid:get())
	if f67_local1 ~= 0 then
		local f67_local2 = Engine[@"hash_483DD7A7721E8089"](f67_local1, f67_arg0, Enum[@"presencefilter"][@"presence_filter_all"])
		if f67_local2 then
			f67_local2.index = f67_arg2
			f67_local2.xuid = f67_local1
			f67_local2.gamertag = Engine[@"hash_61FB3481C8114A9A"](f67_local1)
			f67_local2.clantag = ""
			f67_local2.time = f67_local0.time:get()
			return f67_local2
		end
	end
	return nil
end
CoD.LeaderboardUtility.GetRecentPlayerInfoNoUpdate = function(f68_arg0, f68_arg1, f68_arg2)
	local f68_local0 = f68_arg1.playersMet[f68_arg2]
	local f68_local1 = Engine[@"hash_690B6BCE69A8E08B"](f68_local0.xuid:get())
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
			xuid = Engine[@"hash_690B6BCE69A8E08B"](f69_arg1.playersMet[f69_local1].xuid:get()),
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
	if Engine[@"getdvarbool"]("recentPlayerListEnabled") then
		local f71_local1 = Engine[@"storagegetbuffer"](f71_arg0, Enum[@"storagefiletype"][@"hash_22C45CE6FD0D4539"])
		if f71_local1 then
			if f71_local1.isSorted:get() ~= 1 then
				CoD.LeaderboardUtility.SortRecentPlayersDDL(f71_arg0, f71_local1)
			end
			local f71_local2 = {}
			local f71_local3 = 0
			for f71_local4 = 0, f71_local1.count:get() - 1, 1 do
				local f71_local7 = CoD.LeaderboardUtility.GetRecentPlayerInfo(f71_arg0, f71_local1, f71_local4)
				if f71_local7 ~= nil and Engine[@"hash_328AB20F81771B7A"](f71_arg0, f71_local7.xuid) == false then
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
	if f72_local1 == Enum[@"emodes"][@"mode_multiplayer"] then
		if IsArenaMode() then
			table.insert(f72_local0, {
				models = {
					name = @"hash_2866F2CC78940BCF",
					tabCategory = "arena",
				},
				properties = {
					category = @"arena",
				},
			})
		else
			table.insert(f72_local0, {
				models = {
					name = @"hash_4A293EB64E03142F",
					tabCategory = "core",
				},
				properties = {
					category = @"core",
				},
			})
			table.insert(f72_local0, {
				models = {
					name = @"hash_577B92AED87A9600",
					tabCategory = "hardcore",
				},
				properties = {
					category = @"hardcore",
				},
			})
		end
	elseif f72_local1 == Enum[@"emodes"][@"mode_zombies"] then
		table.insert(f72_local0, {
			models = {
				name = @"hash_48FDE5CC46116294",
				tabCategory = "zm_global",
			},
			properties = {
				category = @"zm_global",
			},
		})
		table.insert(f72_local0, {
			models = {
				name = @"hash_55D8B5C3E9420F7",
				tabCategory = "zm_gauntlet",
			},
			properties = {
				category = @"zm_gauntlet",
			},
		})
	elseif f72_local1 == Enum[@"emodes"][@"mode_warzone"] then
		table.insert(f72_local0, {
			models = {
				name = @"hash_4A9DC4B9726B8B6B",
				tabCategory = "wz_modes",
			},
			properties = {
				category = @"wz_modes",
			},
		})
	end
	return f72_local0
end)
DataSources.LeaderboardMenuTitle = {
	getModel = function(f73_arg0)
		local f73_local0 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f73_arg0), "leaderboardMenuTitle")
		local f73_local1 = Engine[@"createmodel"](f73_local0, "title")
		if CoD.LeaderboardUtility.IsLobbyLeaderboard(f73_arg0) then
			local f73_local2 = CoD.LeaderboardUtility.GetLeaderboardInfo(Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "leaderboardDef")))
			Engine[@"setmodelvalue"](f73_local1, Engine[@"hash_4F9F1239CFD921FE"](f73_local2.title))
			return f73_local0
		else
			local f73_local3 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "leaderboardCategoryName")
			if not f73_local3 then
				return f73_local0
			else
				local f73_local2 = Engine[@"getmodelvalue"](f73_local3)
				if not f73_local2 then
					return f73_local0
				else
					Engine[@"setmodelvalue"](f73_local1, Engine[@"hash_4F9F1239CFD921FE"](@"hash_7A29C2EC825A6AD8", Engine[@"hash_4F9F1239CFD921FE"](CoD.LeaderboardUtility.leaderboardTab[f73_local2].leaderboardHeaderText)))
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
