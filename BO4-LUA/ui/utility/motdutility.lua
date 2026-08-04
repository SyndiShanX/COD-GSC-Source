CoD.MOTDUtility = {}
CoD.MOTDUtility.MOTD_GetMOTDChannel = function()
	if Engine[@"hash_5CB675CA7856DA25"]() and Dvar[@"hash_167981552D919873"]:exists() and Dvar[@"hash_167981552D919873"]:get() then
		return "motd_trial"
	else
		return "motd"
	end
end
CoD.MOTDUtility.MOTD_IsLocationEnabled = function(f2_arg0)
	return Engine[@"hash_2CF9DD4167E9CE89"](f2_arg0)
end
CoD.MOTDUtility.MOTD_AlreadyOpened = function()
	return Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.shownMOTD") ~= nil
end
CoD.MOTDUtility.MOTD_ShouldShowMOTD = function(f4_arg0)
	if not Dvar[@"motd_enabled"]:get() then
		return false
	elseif Dvar[@"hash_261B37B5CD0C5CC1"]:get() then
		return true
	end
	local f4_local0 = Engine[@"hash_1D30724405ED0D69"](CoD.MOTDUtility.MOTD_GetMOTDChannel())
	for f4_local1 = 1, f4_local0, 1 do
		local f4_local4 = f4_local1 - 1
		local f4_local5 = Engine[@"hash_15451F941503DA5A"](f4_arg0, CoD.MOTDUtility.MOTD_GetMOTDChannel(), f4_local4)
		if f4_local5 ~= nil and f4_local5.messageID > 0 and CoD.MOTDUtility.MOTD_IsLocationEnabled(f4_local5.locationID) and not CoD.MOTDUtility.ShouldSkipMessage(f4_local5, f4_local4, f4_arg0) and (CoDShared.IsERegEnabled(f4_arg0) or f4_local5.action == nil or f4_local5.action ~= "registration") then
			return true
		end
	end
	return false
end
CoD.MOTDUtility.MOTD_OpenMOTDPopup = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	if f5_arg3 and f5_arg3 == true then
		CoD.perController[f5_arg2].isMOTDInLobbyVM = true
	else
		CoD.perController[f5_arg2].isMOTDInLobbyVM = false
	end
	OpenOverlay(f5_arg4, "MOTD", f5_arg2, nil)
end
CoD.MOTDUtility.MOTD_OpenMOTDFromFW = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	CoD.perController[f6_arg2].isMOTDInLobbyVM = false
	OpenOverlay(f6_arg4, "MOTD", f6_arg2, {
		_messageOffset = f6_arg3,
	})
end
CoD.MOTDUtility.MOTD_GetFocusedBannerOffset = function(f7_arg0)
	return f7_arg0._messageOffset or 0
end
CoD.MOTDUtility.MOTD_GetFirstMOTDTab = function(f8_arg0)
	for f8_local3, f8_local4 in ipairs(CoD.MOTDUtility.MOTD_TABS) do
		local f8_local5 = Engine[@"hash_15451F941503DA5A"](f8_arg0, f8_local4.location)
		if f8_local5 ~= nil then
			return f8_local5
		end
	end
	return nil
end
CoD.MOTDUtility.MOTD_UnhandledAction = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = -1
	local f9_local1 = CoD.MOTDUtility.MOTD_GetModel(f9_arg2, "offset")
	if f9_local1 then
		f9_local0 = Engine.GetModelValue(f9_local1)
	end
	Engine.PrintError(Enum[@"consolelabel_e"][@"con_label_default"], "MOTD: Unhandled action: " .. f9_arg3 .. " at offset: " .. tostring(f9_local0) .. ".\n")
	CoD.MOTDUtility.Close(f9_arg0, f9_arg1, true)
end
CoD.MOTDUtility.MOTD_HandlePopAction = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4, f10_arg5)
	if f10_arg5 == "store" then
		OpenStore(f10_arg0, f10_arg2, f10_arg1, f10_arg3.menuName, f10_arg3)
	elseif f10_arg5 == "registration" then
		CoD.MOTDUtility.EReg_OpenOverlay(f10_arg0, f10_arg2, f10_arg1, nil, f10_arg3)
	elseif f10_arg5 == "liveevent" then
		CoD.MOTDUtility.FeatureCard_OpenLEVAction(f10_arg0, f10_arg2, f10_arg1, nil, f10_arg3)
	elseif f10_arg5 == "vod" then
		CoD.MOTDUtility.FeatureCard_OpenVodAction(f10_arg0, f10_arg2, f10_arg1, "vod.hiResVideo", f10_arg3)
	elseif f10_arg5 == "depot" then
		if CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_HIGHEST_DROP_VERSION) then
			OpenQuarterMaster(f10_arg0, f10_arg2, f10_arg1, "supplychain", f10_arg3)
		end
	elseif f10_arg5 == "shop" then
		OpenQuarterMaster(f10_arg0, f10_arg2, f10_arg1, "itemshop", f10_arg3)
	elseif f10_arg5 == "inventory" then
		OpenQuarterMaster(f10_arg0, f10_arg2, f10_arg1, "inventory", f10_arg3)
	elseif f10_arg5 == "bj_reserves" then
		OpenQuarterMaster(f10_arg0, f10_arg2, f10_arg1, "reserves", f10_arg3)
	elseif f10_arg5 == "mp_contracts" then
		CoD.MOTDUtility.FeatureCard_OpenContracts(f10_arg0, f10_arg2, f10_arg1, Enum[@"hash_41B899F51A938E95"][@"hash_6F1D72D16310405B"], f10_arg3)
	elseif f10_arg5 == "wl_contracts" then
		CoD.MOTDUtility.FeatureCard_OpenContracts(f10_arg0, f10_arg2, f10_arg1, Enum[@"hash_41B899F51A938E95"][@"hash_6EFB62D162F33EC5"], f10_arg3)
	elseif f10_arg5 == "zm_contracts" then
		CoD.MOTDUtility.FeatureCard_OpenContracts(f10_arg0, f10_arg2, f10_arg1, Enum[@"hash_41B899F51A938E95"][@"hash_6EEA5DD162E4C313"], f10_arg3)
	elseif f10_arg5 == "wz_contracts" then
		CoD.MOTDUtility.FeatureCard_OpenContracts(f10_arg0, f10_arg2, f10_arg1, Enum[@"hash_41B899F51A938E95"][@"hash_6EFB6CD162F34FC3"], f10_arg3)
	elseif f10_arg5 == "crate_purchase" then
		CoD.BlackMarketUtility.OpenBlackjackReservesAndItemPurchaseOverlay(f10_arg0, f10_arg2, f10_arg1, "crate", f10_arg3)
	elseif f10_arg5 == "challenge_status" then
		CoD.MOTDUtility.FeatureCard_OpenCommunityChallengeAction(f10_arg0, f10_arg2, f10_arg1, nil, f10_arg3)
	elseif f10_arg5 == "redeem" then
		CoD.MOTDUtility.Coupons_RedeemCode(f10_arg0, f10_arg2, f10_arg1, nil, f10_arg3)
	else
		CoD.MOTDUtility.MOTD_UnhandledAction(f10_arg0, f10_arg1, f10_arg4, f10_arg5)
	end
end
CoD.MOTDUtility.Close = function(f11_arg0, f11_arg1, f11_arg2)
	if CoD.isPC then
		local f11_local0 = Engine.GetGlobalModel()
		f11_local0 = f11_local0["lobbyRoot.postPopups"]
		if f11_local0 then
			f11_local0:set(CoD.BitUtility.ClearBit(f11_local0:get(), LuaEnum.POST_POPUPS.MOTD))
		end
	end
	local f11_local0 = Engine.GetGlobalModel()
	f11_local0 = f11_local0:create("lobbyRoot.motdOpened", true)
	f11_local0:set(true)
	if CoD.perController[f11_arg1].isMOTDInLobbyVM and Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
		Engine[@"lobbyevent"]("OnGoForward", {
			controller = f11_arg1,
			navToMenu = "director",
			showMOTD = false,
		})
	end
	CoD.perController[f11_arg1].isMOTDInLobbyVM = nil
	if f11_arg2 then
		GoBack(f11_arg0, f11_arg1)
	else
		Close(f11_arg0, f11_arg1)
	end
end
CoD.MOTDUtility.AllActionsDisabled = function()
	return false
end
CoD.MOTDUtility.MOTD_HasAction = function(f13_arg0)
	local f13_local0
	if Engine.GetModelValue(f13_arg0) ~= "" then
		f13_local0 = not CoD.MOTDUtility.AllActionsDisabled()
	else
		f13_local0 = false
	end
	return f13_local0
end
CoD.MOTDUtility.MOTD_ShouldReportMessage = function()
	return not Dvar[@"hash_261B37B5CD0C5CC1"]:get()
end
CoD.MOTDUtility.MOTD_AttemptToReportMessage = function(f15_arg0, f15_arg1)
	if CoD.MOTDUtility.MOTD_ShouldReportMessage() then
		local f15_local0 = CoD.MOTDUtility.MOTD_GetModel(f15_arg1, "offset")
		local f15_local1 = CoD.MOTDUtility.MOTD_GetMOTDChannel()
		if f15_local0 then
			Engine.exec(f15_arg0, "marketing_markmessageasviewed " .. f15_local1 .. " " .. f15_local0:get())
		else
			print("Error: MOTDBannerList Datasource is missing model <offset> for current banner.")
		end
	end
end
CoD.MOTDUtility.MOTD_ReportMessageasViewed = function(f16_arg0, f16_arg1)
	if CoD.MOTDUtility.MOTD_ShouldReportMessage() then
		Engine.exec(f16_arg0, "marketing_markmessageasviewed " .. CoD.MOTDUtility.MOTD_GetMOTDChannel() .. " " .. f16_arg1)
	end
end
CoD.MOTDUtility.ShouldSkipMessage = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = CoD.isPC
	if f17_local0 then
		f17_local0 = CoD.PCKoreaUtility.ShowKorea15Plus()
	end
	local f17_local1
	if not f17_arg0.safe then
		f17_local1 = f17_local0
	else
		f17_local1 = false
	end
	local f17_local2 = CoD.MOTDUtility.MOTD_GetMOTDChannel()
	if f17_local1 and CoD.MOTDUtility.MOTD_ShouldReportMessage() then
		Engine.exec(f17_arg2, "marketing_markmessageasviewed " .. f17_local2 .. " " .. f17_arg1)
		return true
	elseif (f17_arg0.action == "registration" or f17_arg0.popupAction == "registration") and not CoD.CoDAccountUtility.IsAccountFeatureEnabled(f17_arg2) then
		Engine.exec(f17_arg2, "marketing_markmessageasviewed " .. f17_local2 .. " " .. f17_arg1)
		return true
	else
		return false
	end
end
CoD.MOTDUtility.MOTD_GetModel = function(f18_arg0, f18_arg1)
	if f18_arg0 ~= nil then
		return f18_arg0[f18_arg1]
	else
		return nil
	end
end
CoD.MOTDUtility.MOTD_GetActiveTabModel = function(f19_arg0)
	if f19_arg0 then
		local f19_local0 = f19_arg0.Tabs.grid.activeWidget
		local f19_local1 = f19_arg0.Tabs.grid.MOTDTabs
		if f19_local0 and f19_local0.tableIndex and f19_local1 then
			return f19_local1[f19_local0.tableIndex].model
		end
	end
	return nil
end
CoD.MOTDUtility.CreateMOTDFeatureCard = function(f20_arg0, f20_arg1)
	if Dvar[@"hash_261B37B5CD0C5CC1"]:exists() and Dvar[@"hash_261B37B5CD0C5CC1"]:get() then
		table.insert(f20_arg0, {
			models = {
				locked = false,
				name = Engine[@"hash_4F9F1239CFD921FE"](@"menu/motd"),
				iconBackground = "ui_icon_crm_featured_thanks",
				iconBackgroundFocus = "ui_icon_crm_featured_thanks",
				descriptionText = "menu/message_of_the_day",
				action = CoD.MOTDUtility.MOTD_OpenMOTDPopup,
				actionString = "motd",
				param = false,
				showForAllClients = true,
				hasDoubleXP = false,
				hasDoubleWeaponXP = false,
			},
		})
	end
end
CoD.MOTDUtility.MOTD_GetAction = function(f21_arg0, f21_arg1)
	return CoD.MOTDUtility.MOTD_OpenMOTDFromFW, f21_arg1
end
CoD.MOTDUtility.MOTD_AddMOTDCards = function(f22_arg0, f22_arg1)
	CoD.MOTDUtility.FeatureCard_AddFeatureCardsByLocation(f22_arg0, f22_arg1, CoD.MOTDUtility.MOTD_GetMOTDChannel(), CoD.MOTDUtility.MOTD_GetAction)
end
CoD.MOTDUtility.ReportCount = 0
CoD.MOTDUtility.MaxReportCount = 3
CoD.MOTDUtility.NextReportTime = 0
CoD.MOTDUtility.ReportInterval = 30
CoD.MOTDUtility.LastMessageID = LuaDefine.ZERO_X64
CoD.MOTDUtility.MOTD_ShouldLogInteraction = function(f23_arg0)
	if CoD.MOTDUtility.ReportCount ~= 0 and f23_arg0 == CoD.MOTDUtility.LastMessageID then
		return false
	else
		CoD.MOTDUtility.LastMessageID = f23_arg0
		if CoD.MOTDUtility.ReportCount < CoD.MOTDUtility.MaxReportCount then
			CoD.MOTDUtility.ReportCount = CoD.MOTDUtility.ReportCount + 1
			return true
		elseif CoD.MOTDUtility.NextReportTime > Engine[@"milliseconds"]() then
			return false
		else
			CoD.MOTDUtility.NextReportTime = Engine[@"milliseconds"]() + CoD.MOTDUtility.ReportInterval * 1000
			return true
		end
	end
end
CoD.MOTDUtility.MOTD_DLogInteraction = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
	if not Dvar[@"hash_261B37B5CD0C5CC1"]:exists() or not Dvar[@"hash_261B37B5CD0C5CC1"]:get() then
		local f24_local0, f24_local1 = nil
		if f24_arg3 == "FW" then
			f24_local0 = CoD.MOTDUtility.MOTD_GetModel(f24_arg1, "actionString")
			f24_local1 = CoD.MOTDUtility.MOTD_GetModel(f24_arg1, "id")
		else
			f24_local0 = CoD.MOTDUtility.MOTD_GetModel(f24_arg1, "action")
			f24_local1 = CoD.MOTDUtility.MOTD_GetModel(f24_arg1, "messageID")
		end
		local f24_local2
		if f24_local0 then
			f24_local2 = f24_local0:get()
			if not f24_local2 then
			else
				local f24_local3
				if f24_local1 then
					f24_local3 = f24_local1:get()
					if not f24_local3 then
					else
						local f24_local4 = Engine[@"hash_36D9D7474CDD485B"]()
						local f24_local5 = 0
						if f24_arg2 then
							f24_local5 = CoD.MetricsUtility.GetButtonPressed(f24_arg0)
						end
						if f24_local3 and f24_local4 and (f24_arg2 or CoD.MOTDUtility.MOTD_ShouldLogInteraction(f24_local3)) then
							Engine[0xDE279ECDDDD966](f24_arg0, @"hash_46647F4E58A2A212", {
								interaction_type = f24_local2,
								[@"hash_43C83260DD96C90C"] = f24_arg3,
								[@"hash_13A1A70556201A2D"] = f24_local3,
								[@"hash_31A5D51248A1D2C"] = f24_local5,
								language = f24_local4,
							})
						end
					end
				end
				f24_local3 = nil
			end
		end
		f24_local2 = ""
	end
end
DataSources.PCMOTDOptions = DataSourceHelpers.ListSetup("PCMOTDOptions", function(f25_arg0, f25_arg1)
	local f25_local0 = {}
	local f25_local1 = f25_arg1:getMenu()
	local f25_local2 = function(f26_arg0)
		local f26_local0 = f26_arg0
		local f26_local1 = f26_arg0.MOTDBanners
		if f26_local1 then
			f26_local1 = f26_arg0.MOTDBanners.MOTDBanners
			if f26_local1 then
				f26_local1 = f26_local0 and f26_arg0.MOTDBanners.MOTDBanners.activeWidget
			end
		end
		return f26_local1
	end
	local f25_local3 = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4)
		CoD.MOTDUtility.MOTD_AcceptAction(f27_arg0, f27_arg2, f27_arg4, f25_local2(f27_arg4))
	end
	local f25_local4 = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3, f28_arg4)
		CoD.MOTDUtility.MOTD_Close(f28_arg0, f28_arg2, f28_arg4, f25_local2(f28_arg4))
	end
	local f25_local5 = function()
		local f29_local0
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "store") then
			f29_local0 = not IsCommerceEnabledOnPC()
		else
			f29_local0 = true
		end
		return f29_local0
	end
	local f25_local6 = function()
		return not CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "registration")
	end
	local f25_local7 = function()
		local f31_local0
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "depot") then
			f31_local0 = not IsCommerceEnabledOnPC()
		else
			f31_local0 = true
		end
		return f31_local0
	end
	local f25_local8 = function()
		local f32_local0
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "shop") then
			f32_local0 = not IsCommerceEnabledOnPC()
		else
			f32_local0 = true
		end
		return f32_local0
	end
	local f25_local9 = function()
		local f33_local0
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "bj_reserves") then
			f33_local0 = not IsCommerceEnabledOnPC()
		else
			f33_local0 = true
		end
		return f33_local0
	end
	local f25_local10 = function()
		local f34_local0
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "mp_contracts") or CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "wl_contracts") or CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "zm_contracts") or CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "wz_contracts") then
			f34_local0 = not IsCommerceEnabledOnPC()
		else
			f34_local0 = true
		end
		return f34_local0
	end
	local f25_local11 = function()
		local f35_local0
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "crate_purchase") then
			f35_local0 = not IsCommerceEnabledOnPC()
		else
			f35_local0 = true
		end
		return f35_local0
	end
	local f25_local12 = function()
		return not CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "inventory")
	end
	local f25_local13 = function()
		local f37_local0
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "crate_bundle") then
			f37_local0 = not IsCommerceEnabledOnPC()
		else
			f37_local0 = true
		end
		return f37_local0
	end
	local f25_local14 = function()
		return not CoD.ModelUtility.IsSelfModelPathValueEqualTo(f25_local2(f25_local1), f25_arg0, "action", "vod")
	end
	if f25_local2(f25_local1) then
		if not CoD.MOTDUtility.AllActionsDisabled() then
			if not f25_local5() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData("menu/store_caps", f25_local3, f25_local5))
			end
			if not f25_local6() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData("menu/register_caps", f25_local3, f25_local6))
			end
			if not f25_local7() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData(@"menu/black_market", f25_local3, f25_local7))
			end
			if not f25_local8() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData("menu/item_shop", f25_local3, f25_local8))
			end
			if not f25_local9() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData(@"hash_7655207CC013B5BD", f25_local3, f25_local9))
			end
			if not f25_local10() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData(@"menu/motd_contracts", f25_local3, f25_local10))
			end
			if not f25_local11() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData(@"hash_3AF6650B811A502B", f25_local3, f25_local11))
			end
			if not f25_local12() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData(@"menu/motd_inventory", f25_local3, f25_local12))
			end
			if not f25_local13() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData(@"hash_3E1FEFD9287CA008", f25_local3, f25_local13))
			end
			if not f25_local14() then
				table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData(@"menu/play", f25_local3, f25_local14))
			end
		end
		table.insert(f25_local0, CoD.MOTDUtility.packageMOTDButtonData(@"menu/close", f25_local4, AlwaysFalse))
	end
	return f25_local0
end, true)
CoD.MOTDUtility.packageMOTDButtonData = function(f39_arg0, f39_arg1, f39_arg2)
	return {
		models = {
			displayText = f39_arg0,
			disabled = f39_arg2(),
		},
		properties = {
			action = f39_arg1,
		},
	}
end
CoD.MOTDUtility.HasMessageAtLocation = function(f40_arg0, f40_arg1)
	local f40_local0 = Engine[@"hash_1D30724405ED0D69"](f40_arg1)
	for f40_local1 = 1, f40_local0, 1 do
		local f40_local4 = Engine.GetMarketingMessage(f40_arg0, f40_arg1, f40_local1 - 1)
		if f40_local4 and f40_local4.messageID > 0 then
			return true
		end
	end
	return false
end
CoD.MOTDUtility.MOTD_MarkAsViewed = function(f41_arg0, f41_arg1, f41_arg2)
	local f41_local0 = f41_arg2:getModel()
	CoD.MOTDUtility.MOTD_AttemptToReportMessage(f41_arg1, f41_local0)
	CoD.MOTDUtility.MOTD_DLogInteraction(f41_arg1, f41_local0, false, "MOTD")
end
CoD.MOTDUtility.MOTD_MarkAsClicked = function(f42_arg0, f42_arg1, f42_arg2)
	local f42_local0 = f42_arg2:getModel()
	CoD.MOTDUtility.MOTD_AttemptToReportMessage(f42_arg1, f42_local0)
	CoD.MOTDUtility.MOTD_DLogInteraction(f42_arg1, f42_local0, true, "MOTD")
end
CoD.MOTDUtility.MOTD_SelectItemPC = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
	local f43_local0 = f43_arg1:getParent()
	f43_local0 = f43_local0:getParent()
	f43_local0:setActiveItem(f43_arg1)
	CoD.MOTDUtility.MOTD_MarkAsViewed(f43_arg1, f43_arg2, f43_arg1)
	f43_arg0[f43_arg3]:updateDataSource()
end
CoD.MOTDUtility.MOTD_UpdateItemSelectionPC = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4)
	f44_arg0:registerEventHandler("grid_updated", function(element, event)
		local f45_local0 = f44_arg3:getFirstSelectableItem()
		if event.grid == f44_arg3 and f45_local0 then
			CoD.MOTDUtility.MOTD_MarkAsViewed(f45_local0, f44_arg2, f45_local0)
			f44_arg4:updateDataSource()
		end
	end)
end
CoD.MOTDUtility.MOTD_AcceptAction = function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
	local f46_local0 = f46_arg3:getModel()
	CoD.MOTDUtility.MOTD_DLogInteraction(f46_arg1, f46_local0, true, "MOTD")
	local f46_local1 = CoD.MOTDUtility.MOTD_GetModel(f46_local0, "action")
	if f46_local1 ~= nil and CoD.MOTDUtility.MOTD_HasAction(f46_local1) then
		CoD.MOTDUtility.MOTD_HandlePopAction(f46_arg0, f46_arg1, f46_arg3, f46_arg2, f46_local0, Engine.GetModelValue(f46_local1))
	else
		CoD.MOTDUtility.Close(f46_arg0, f46_arg1, true)
	end
end
CoD.MOTDUtility.MOTD_Close = function(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
	CoD.MOTDUtility.MOTD_DLogInteraction(f47_arg1, f47_arg3:getModel(), true, "MOTD")
	CoD.MOTDUtility.Close(f47_arg0, f47_arg1, true)
end
CoD.MOTDUtility.MOTD_IsBannerPNGImage = function(f48_arg0, f48_arg1, f48_arg2)
	local f48_local0 = f48_arg2:getModel(f48_arg1, "image")
	if f48_local0 and string.match(Engine.GetModelValue(f48_local0), ".png") then
		return true
	else
		return false
	end
end
CoD.MOTDUtility.MOTD_IsContractAction = function(f49_arg0, f49_arg1, f49_arg2)
	local f49_local0 = f49_arg2:getModel(f49_arg1, "action")
	if f49_local0 then
		local f49_local1 = f49_local0:get()
		local f49_local2
		if f49_local1 ~= "mp_contracts" and f49_local1 ~= "wl_contracts" and f49_local1 ~= "zm_contracts" and f49_local1 ~= "wz_contracts" then
			f49_local2 = false
		else
			f49_local2 = true
		end
		return f49_local2
	else
		return false
	end
end
CoD.MOTDUtility.FeatureCard_PopupActionExist = function(f50_arg0, f50_arg1)
	local f50_local0 = f50_arg1:getModel(f50_arg0, "popupAction")
	if f50_local0 and f50_local0:get() then
		return true
	else
		return false
	end
end
DataSources.MOTDBannerList = ListHelper_SetupDataSource("MOTDBannerList", function(f51_arg0, f51_arg1)
	local f51_local0 = {}
	local f51_local1 = 1
	if Dvar[@"hash_261B37B5CD0C5CC1"]:get() then
		local f51_local2 = function(f52_arg0, f52_arg1, f52_arg2, f52_arg3, f52_arg4, f52_arg5, f52_arg6, f52_arg7, f52_arg8, f52_arg9, f52_arg10)
			return {
				models = {},
				models = "",
				models = f52_arg0,
				models = f52_arg1,
				models = f52_arg4,
				models = "",
				models = f52_arg3,
				models = false,
				models = Engine[@"numbertouint64"](1),
				models = f52_arg2,
				models = Engine[@"numbertouint64"](f52_arg9),
				models = f52_arg6,
				models = f52_arg7,
				models = f52_arg5,
				models = f52_arg10 - 1,
				models = f52_arg8,
			}
		end
		table.insert(
			f51_local0,
			f51_local2("This is testing content layout A.", "Content Layout A Test", "t7_store_featured_message", "t7_store_featured_message", "CoD.MOTD_VoDPreviewWidget", "", "vod", nil, {
				stillPreview = "t7_store_featured_message",
				lowResVideo = {
					movieName = "mlg_vod/VptUcdCCdZA",
					isStreamed = true,
					isLooping = false,
				},
				hiResVideo = {
					movieName = "mlg_vod/VptUcdCCdZA",
					isStreamed = true,
					isLooping = false,
				},
			}, 1, 1)
		)
		table.insert(f51_local0, f51_local2("This is testing content layout B. You should not see this.", "Live Event (Content B Test)", "t7_store_featured_message", "t7_store_featured_message", "CoD.MOTD_NoText_HeavyImage", "", "mp_contracts", nil, nil, 2, 2))
		table.insert(f51_local0, f51_local2("This is testing content layout C.", "Content Layout C Test", "t7_store_featured_message", "t7_store_featured_message", "CoD.MOTD_MediumText_MediumImage", "", nil, nil, nil, 3, 3))
		table.insert(f51_local0, f51_local2("This is testing content layout D. You should not see this.", "Content Layout D Test", "t7_store_featured_message", "t7_store_featured_message", "CoD.MOTD_TopBottomText_HeavyImage", "Testing content layout D. You should see this.", nil, nil, nil, 4, 4))
	else
		local f51_local2 = false
		local f51_local3 = Engine[@"hash_1D30724405ED0D69"](CoD.MOTDUtility.MOTD_GetMOTDChannel())
		for f51_local4 = 1, f51_local3, 1 do
			local f51_local7 = f51_local4 - 1
			local f51_local8 = Engine[@"hash_15451F941503DA5A"](f51_arg0, CoD.MOTDUtility.MOTD_GetMOTDChannel(), f51_local7)
			if f51_local8 ~= nil and f51_local8.messageID > 0 and CoD.MOTDUtility.MOTD_IsLocationEnabled(f51_local8.locationID) and not CoD.MOTDUtility.ShouldSkipMessage(f51_local8, f51_local7, f51_arg0) then
				CoD.MOTDUtility.MOTD_ReportMessageasViewed(f51_arg0, f51_local7)
				local f51_local9 = {}
				local f51_local10 = f51_local8.movieName and string.match("mlg_vod/", f51_local8.movieName) or false
				f51_local9.models = {
					offset = f51_local7,
					vod = {
						stillPreview = f51_local8.popup_image,
						lowResVideo = {
							movieName = f51_local8.movieName,
							isStreamed = f51_local8.isStreamed or f51_local10,
							isLooping = f51_local8.isLooping,
						},
						hiResVideo = {
							movieName = f51_local8.movieName,
							isStreamed = f51_local8.isStreamed or f51_local10,
							isLooping = f51_local8.isLooping,
						},
					},
				}
				f51_local9.properties = {
					selectIndex = CoD.MOTDUtility.MOTD_GetFocusedBannerOffset(f51_arg1.menu) == f51_local7,
				}
				for f51_local14, f51_local15 in pairs(f51_local8) do
					if not f51_local2 and f51_local14 == "priority" then
						f51_local2 = true
					end
					f51_local9.models[f51_local14] = f51_local15
				end
				if f51_local9.models.frameLayout == nil then
					if f51_local8.action == "vod" and Dvar[@"hash_194C1F8422ADD572"]:get() then
						f51_local9.models.frameLayout = "CoD.MOTD_VoDPreviewWidget"
					else
						f51_local9.models.frameLayout = "CoD.MOTD_LightText_HeavyImage"
					end
				end
				if Dvar[@"hash_39138E75A5678EB5"]:get() and Dvar[@"hash_4DEE3EA6C922C336"]:get() and f51_local9.models.image then
					f51_local11 = f51_local9.models.image:get()
					if f51_local11 and not LuaUtils.EndsWith(f51_local11, ".png") then
						f51_local9.models.image:set(f51_local11 .. ".png")
					end
				end
				table.insert(f51_local0, f51_local9)
				f51_local1 = f51_local1 + 1
			end
		end
		if f51_local2 then
			table.sort(f51_local0, function(f53_arg0, f53_arg1)
				return (f53_arg1.models.priority or 0) < (f53_arg0.models.priority or 0)
			end)
		end
	end
	return f51_local0
end)
DataSources.MOTDVoDPreview = {
	getModel = function(f54_arg0)
		local f54_local0 = Engine.GetModel(Engine.GetGlobalModel(), "MOTDVoDPreviewFrame")
		if not f54_local0 then
			f54_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "MOTDVoDPreviewFrame")
			local f54_local1 = f54_local0:create("frame")
			f54_local1:set("CoD.VoDPreviewWidgetImage")
		end
		return f54_local0
	end,
}
CoD.MOTDUtility.FeatureCard_OpenVodAction = function(f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4)
	CoD.VideoStreamingUtility.SetupVoDMovie(f55_arg2, f55_arg1, f55_arg3)
	DelayOpenOverlay(f55_arg4, "VoDViewer", f55_arg2, nil)
end
CoD.MOTDUtility.FeatureCard_DelayOpenVoD = function(f56_arg0, f56_arg1, f56_arg2, f56_arg3)
	DelayOpenOverlay(f56_arg0, "VoDViewer", f56_arg2, nil)
end
CoD.MOTDUtility.FeatureCard_OpenLEVAction = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4)
	DelayOpenOverlay(f57_arg4, "LiveEventViewer", f57_arg2, nil)
end
CoD.MOTDUtility.FeatureCard_OpenFeaturedPopupAction = function(f58_arg0, f58_arg1, f58_arg2, f58_arg3, f58_arg4)
	DelayOpenOverlay(f58_arg4, "FeaturedPopup", f58_arg2, {
		_model = f58_arg1:getModel(),
	})
end
CoD.MOTDUtility.FeatureCard_OpenCommunityChallengeAction = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3, f59_arg4)
	DelayOpenOverlay(f59_arg4, "ReservesSpecialContractMenu", f59_arg2, {
		_model = DataSources.ReservesSpecialContract.getModel(f59_arg2),
	})
end
CoD.MOTDUtility.FeatureCard_OpenContracts = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3, f60_arg4)
	local f60_local0 = f60_arg3
	local f60_local1 = DataSources.LootContracts.getModel(f60_arg2)
	local f60_local2 = f60_local1:create("modeOverride")
	f60_local2:set(f60_local0)
	DelayOpenOverlay(f60_arg4, "BlackMarketContracts", f60_arg2, nil)
end
CoD.MOTDUtility.FeatureCard_GetAction = function(f61_arg0, f61_arg1)
	if f61_arg0.action == "store" then
		return OpenStore, "FeaturedCard"
	elseif f61_arg0.action == "motd" then
		return CoD.MOTDUtility.MOTD_OpenMOTDPopup, f61_arg1 + 1
	elseif f61_arg0.action == "registration" then
		return CoD.MOTDUtility.EReg_OpenOverlay, nil
	elseif f61_arg0.action == "vod" then
		return CoD.MOTDUtility.FeatureCard_OpenVodAction, "vod.hiResVideo"
	elseif f61_arg0.action == "liveevent" then
		return CoD.MOTDUtility.FeatureCard_OpenLEVAction, nil
	elseif f61_arg0.action == "popup" then
		return CoD.MOTDUtility.FeatureCard_OpenFeaturedPopupAction, nil
	elseif f61_arg0.action == "depot" then
		return OpenQuarterMaster, "supplychain"
	elseif f61_arg0.action == "shop" then
		return OpenQuarterMaster, "itemshop"
	elseif f61_arg0.action == "inventory" then
		return OpenQuarterMaster, "inventory"
	elseif f61_arg0.action == "bj_reserves" then
		return OpenQuarterMaster, "reserves"
	elseif f61_arg0.action == "mp_contracts" then
		return FeatureCard_OpenContracts, Enum[@"hash_41B899F51A938E95"][@"hash_6F1D72D16310405B"]
	elseif f61_arg0.action == "wl_contracts" then
		return FeatureCard_OpenContracts, Enum[@"hash_41B899F51A938E95"][@"hash_6EFB62D162F33EC5"]
	elseif f61_arg0.action == "zm_contracts" then
		return FeatureCard_OpenContracts, Enum[@"hash_41B899F51A938E95"][@"hash_6EEA5DD162E4C313"]
	elseif f61_arg0.action == "wz_contracts" then
		return FeatureCard_OpenContracts, Enum[@"hash_41B899F51A938E95"][@"hash_6EFB6CD162F34FC3"]
	elseif f61_arg0.action == "crate_purchase" then
		return CoD.BlackMarketUtility.OpenBlackjackReservesAndItemPurchaseOverlay, "crate"
	elseif f61_arg0.action == "challenge_status" then
		return CoD.MOTDUtility.FeatureCard_OpenCommunityChallengeAction, nil
	elseif action == "redeem" then
		return CoD.MOTDUtility.Coupons_RedeemCode, nil
	else
		return nil, nil
	end
end
CoD.MOTDUtility.FeatureCard_GetPopupAction = function(f62_arg0, f62_arg1)
	if f62_arg0.popup_action == "store" then
		return OpenStore, "FeaturedCard"
	elseif f62_arg0.popup_action == "registration" then
		return CoD.MOTDUtility.EReg_OpenOverlay, nil
	elseif f62_arg0.popup_action == "depot" then
		return OpenQuarterMaster, "supplychain"
	elseif f62_arg0.popup_action == "shop" then
		return OpenQuarterMaster, "itemshop"
	elseif f62_arg0.popup_action == "inventory" then
		return OpenQuarterMaster, "inventory"
	elseif f62_arg0.popup_action == "bj_reserves" then
		return OpenQuarterMaster, "reserves"
	elseif f62_arg0.popup_action == "mp_contracts" then
		return FeatureCard_OpenContracts, Enum[@"hash_41B899F51A938E95"][@"hash_6F1D72D16310405B"]
	elseif f62_arg0.popup_action == "wl_contracts" then
		return FeatureCard_OpenContracts, Enum[@"hash_41B899F51A938E95"][@"hash_6EFB62D162F33EC5"]
	elseif f62_arg0.popup_action == "zm_contracts" then
		return FeatureCard_OpenContracts, Enum[@"hash_41B899F51A938E95"][@"hash_6EEA5DD162E4C313"]
	elseif f62_arg0.popup_action == "wz_contracts" then
		return FeatureCard_OpenContracts, Enum[@"hash_41B899F51A938E95"][@"hash_6EFB6CD162F34FC3"]
	elseif f62_arg0.popup_action == "crate_purchase" then
		return CoD.BlackMarketUtility.OpenBlackjackReservesAndItemPurchaseOverlay, "crate"
	elseif f62_arg0.popup_action == "challenge_status" then
		return CoD.MOTDUtility.FeatureCard_OpenCommunityChallengeAction, nil
	elseif f62_arg0.popup_action == "redeem" then
		return CoD.MOTDUtility.Coupons_RedeemCode, nil
	else
	end
end
CoD.MOTDUtility.FeatureCard_AddFeatureCardsByLocation = function(f63_arg0, f63_arg1, f63_arg2, f63_arg3)
	local f63_local0 = Engine[@"hash_1D30724405ED0D69"](f63_arg2)
	local f63_local1 = function(f64_arg0, f64_arg1)
		if f64_arg1 == CoD.MOTDUtility.MOTD_GetMOTDChannel() then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_3EA2339DFD00ADED")
		else
			return f64_arg0.content_short or ""
		end
	end
	for f63_local2 = 1, f63_local0, 1 do
		local f63_local5 = f63_local2 - 1
		local f63_local6 = Engine.GetMarketingMessage(f63_arg1, f63_arg2, f63_local5)
		if f63_local6 and f63_local6.messageID > 0 then
			if not CoD.MOTDUtility.ShouldSkipMessage(f63_local6, f63_local5, f63_arg1) then
				local f63_local7, f63_local8 = f63_arg3(f63_local6, f63_local5)
				local f63_local9, f63_local10 = CoD.MOTDUtility.FeatureCard_GetPopupAction(f63_local6, f63_local5)
				local f63_local11 = {
					id = f63_local6.messageID,
					name = f63_local6.title,
					descriptionText = f63_local1(f63_local6, f63_arg2),
					iconBackground = f63_local6.image or "blacktransparent",
					action = f63_local7,
					param = f63_local8,
					actionString = f63_local6.action,
					popupAction = f63_local9,
					popupActionParam = f63_local10,
					popupActionString = f63_local6.popup_action,
					popup_image = f63_local6.popup_image,
					popup_action_title = f63_local6.popup_action_title,
					content_long = f63_local6.content_long,
					location = f63_arg2,
					vod = {
						movieName = f63_local6.movieName,
						isStreamed = f63_local6.isStreamed,
						isMLGVoD = f63_local6.isMLDVoD,
					},
					messageOffset = f63_local5,
					showForAllClients = true,
					hasDoubleXP = false,
					hasDoubleWeaponXP = false,
					interactable = f63_local6.action ~= nil,
				}
				if CoDShared.IsERegEnabled(f63_arg1) or f63_local6.action == nil or f63_local6.action ~= "registration" then
					table.insert(f63_arg0, {
						models = f63_local11,
						properties = {
							param = f63_local11,
						},
					})
				end
			end
		end
	end
end
CoD.MOTDUtility.FeatureCard_AddFeatureCards = function(f65_arg0, f65_arg1)
	CoD.MOTDUtility.FeatureCard_AddFeatureCardsByLocation(f65_arg0, f65_arg1, "crm_featured", CoD.MOTDUtility.FeatureCard_GetAction)
end
CoD.MOTDUtility.FeatureCard_MarkAsViewed = function(f66_arg0, f66_arg1, f66_arg2)
	local f66_local0 = f66_arg2:getModel(f66_arg1, "messageOffset")
	local f66_local1 = f66_arg2:getModel(f66_arg1, "location")
	if f66_local0 and f66_local1 then
		if f66_local1:get() == "crm_featured" then
			Engine.exec(f66_arg1, "marketing_markmessageasviewed" .. " " .. f66_local1:get() .. " " .. f66_local0:get())
		end
		CoD.MOTDUtility.MOTD_DLogInteraction(f66_arg1, f66_arg2:getModel(), false, "FW")
	end
end
CoD.MOTDUtility.FeatureCard_HandlePopupAction = function(f67_arg0, f67_arg1, f67_arg2, f67_arg3)
	local f67_local0 = f67_arg2:getModel(f67_arg1, "popupAction")
	if f67_local0 then
		local f67_local1 = f67_local0:get()
		if f67_local1 then
			local f67_local2 = f67_arg2:getModel(f67_arg1, "popupActionParam")
			f67_local1(f67_arg0, f67_arg2, f67_arg1, f67_local2 and f67_local2:get(), f67_arg3)
			return
		end
	end
	GoBack(f67_arg0, f67_arg1)
end
CoD.MOTDUtility.FeatureCard_SetPopupActionButtonName = function(f68_arg0, f68_arg1, f68_arg2, f68_arg3)
	local f68_local0 = f68_arg2:getModel(f68_arg1, "popupActionString")
	if f68_local0 then
		local f68_local1 = f68_local0:get()
		if f68_local1 == "store" then
			CoD.Menu.SetButtonLabel(f68_arg3, Enum.LUIButton[@"lui_key_xbx_pssquare"], @"menu/store")
		elseif f68_local1 == "registration" then
			CoD.Menu.SetButtonLabel(f68_arg3, Enum.LUIButton[@"lui_key_xbx_pssquare"], "menu/registration")
		elseif f68_local1 == "depot" then
			CoD.Menu.SetButtonLabel(f68_arg3, Enum.LUIButton[@"lui_key_xbx_pssquare"], @"menu/black_market")
		elseif f68_local1 == "shop" then
			CoD.Menu.SetButtonLabel(f68_arg3, Enum.LUIButton[@"lui_key_xbx_pssquare"], "menu/item_shop")
		end
	end
end
DataSources.RedeemCouponTask = {
	getModel = function(f69_arg0)
		local f69_local0 = Engine.GetModel(Engine.GetGlobalModel(), "RedeemCouponTask")
		if not f69_local0 then
			f69_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "RedeemCouponTask")
			local f69_local1 = f69_local0:create("status")
			f69_local1:set(Enum[@"hash_669792B066B9E7F9"][0xDAD2C8A42CA7DE])
			f69_local1 = f69_local0:create("errorCode")
			f69_local1:set(0)
		end
		return f69_local0
	end,
}
CoD.MOTDUtility.Coupons_RedeemCode = function(f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4)
	local f70_local0 = f70_arg1:getModel(f70_arg2, "location")
	local f70_local1 = f70_arg1:getModel(f70_arg2, "messageOffset")
	if f70_local0 and f70_local1 then
		return CoD.MOTDUtility.Coupons_TriggerRedeemptionTask(f70_arg2, f70_local0:get(), f70_local1:get())
	else
		return false
	end
end
CoD.MOTDUtility.Coupons_TriggerRedeemptionTask = function(f71_arg0, f71_arg1, f71_arg2)
	local f71_local0 = DataSources.RedeemCouponTask.getModel(data.controlller)
	f71_local0.status:set(Enum[@"hash_669792B066B9E7F9"][@"hash_19A59ED2AED67A97"])
	f71_local0.errorCode:set(0)
	return Engine[@"hash_5C4C5E6C6D96727D"](f71_arg0, f71_arg1, f71_arg2)
end
CoD.MOTDUtility.Coupons_RedeemTaskSuccess = function(f72_arg0)
	local f72_local0 = DataSources.RedeemCouponTask.getModel(f72_arg0.controlller)
	f72_local0.status:set(Enum[@"hash_669792B066B9E7F9"][@"hash_7F5FB6532EFCD65F"])
end
CoD.MOTDUtility.Coupons_RedeemTaskFailure = function(f73_arg0)
	local f73_local0 = DataSources.RedeemCouponTask.getModel(f73_arg0.controlller)
	f73_local0.status:set(Enum[@"hash_669792B066B9E7F9"][@"hash_7141FD2303EB637E"])
	f73_local0.errorCode:set(f73_arg0.errorCode)
end
CoD.MOTDUtility.IsLibPNGImage = function(f74_arg0, f74_arg1, f74_arg2)
	if Dvar[@"hash_39138E75A5678EB5"]:get() then
		local f74_local0 = f74_arg2:getModel(f74_arg1, "image")
		if f74_local0 then
			return LuaUtils.EndsWith(f74_local0:get(), ".png")
		end
	end
	return false
end
CoD.MOTDUtility.SetTextAsHTMLText = function(f75_arg0, f75_arg1, f75_arg2)
	f75_arg2:hasHTMLContent(true)
end
CoD.MOTDUtility.EReg_OpenOverlay = function(f76_arg0, f76_arg1, f76_arg2, f76_arg3, f76_arg4)
	if Engine[@"hash_24A9D1DAC0556BB1"](f76_arg2) then
		OpenOverlay(f76_arg4, "StartMenu_Options_CoDAccount_ManageAccount", f76_arg2)
	else
		OpenOverlay(f76_arg4, "StartMenu_Options_CoDAccount_CTA", f76_arg2)
	end
end
