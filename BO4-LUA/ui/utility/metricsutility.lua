CoD.MetricsUtility = {}
CoD.MetricsUtility.NextReportTime = 0
CoD.MetricsUtility.LobbyInit = function()
	if not CoD.MetricsUtility.lobbyElement then
		CoD.MetricsUtility.lobbyElement = LUI.UIElement.new()
		CoD.MetricsUtility.lobbyElement:subscribeToModel(Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"), function(model)
			local f2_local0 = Engine[@"getmodelvalue"](model)
			if CoD.MetricsUtility.menuID ~= nil and f2_local0 ~= CoD.MetricsUtility.menuID then
				local f2_local1 = 0
				local f2_local2 = LobbyData.GetLobbyMenuByID(CoD.MetricsUtility.menuID)
				CoD.MetricsUtility.ScreenView(f2_local1, f2_local2[@"name"], Engine[@"milliseconds"]() - CoD.MetricsUtility.openTime, nil)
			end
			CoD.MetricsUtility.menuID = f2_local0
			CoD.MetricsUtility.openTime = Engine[@"milliseconds"]()
		end)
	end
end
CoD.MetricsUtility.OpenMenu = function(f3_arg0)
	f3_arg0.openTime = Engine[@"milliseconds"]()
end
CoD.MetricsUtility.CloseMenu = function(f4_arg0)
	local f4_local0 = f4_arg0:getOwner()
	if f4_local0 == nil then
		f4_local0 = 0
	end
	local f4_local1 = 0
	if f4_arg0.openTime then
		f4_local1 = Engine[@"milliseconds"]() - f4_arg0.openTime
	end
	CoD.MetricsUtility.ScreenView(f4_local0, f4_arg0.menuName, f4_local1, f4_arg0.crm_message_id)
end
CoD.MetricsUtility.BlackMarketTabChange = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = CoD.SafeGetModelValue(f5_arg1:getModel(), "frameWidget")
	if f5_local0 ~= nil and f5_arg0.menuName ~= nil then
		CoD.MetricsUtility.ScreenView(f5_arg2, f5_arg0.menuName .. "," .. f5_local0, 0, nil)
	end
end
CoD.MetricsUtility.GetButtonPressed = function(f6_arg0)
	for f6_local0 = 1, Enum[@"luibutton"][@"lui_button_count"], 1 do
		local f6_local3 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f6_arg0), "ButtonBits." .. f6_local0)
		if f6_local3 and CoD.BitUtility.IsBitwiseAndNonZero(Engine[@"getmodelvalue"](f6_local3), Enum[@"luibuttonflags"][@"flag_down"]) then
			return f6_local0
		end
	end
end
CoD.MetricsUtility.ScreenView = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = Enum[@"luibutton"][@"lui_key_none"]
	for f7_local1 = 1, Enum[@"luibutton"][@"lui_button_count"], 1 do
		local f7_local4 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f7_arg0), "ButtonBits." .. f7_local1)
		if f7_local4 and CoD.BitUtility.IsBitwiseAndNonZero(Engine[@"getmodelvalue"](f7_local4), Enum[@"luibuttonflags"][@"flag_down"]) then
			f7_local0 = f7_local1
		end
	end
	Engine[0xDE279ECDDDD966](f7_arg0, @"hash_E564E1B1EAF4F17", {
		[@"screen_id"] = f7_arg1,
		[@"screen_duration"] = f7_arg2,
		[@"hash_3A6F594B9F4471D1"] = f7_local0,
		[@"hash_13A1A70556201A2D"] = f7_arg3,
		[@"hash_7357215DFA16830D"] = Engine[@"getlobbyuiscreen"](),
	})
end
CoD.MetricsUtility.BlackMarketCratePurchasedEvent = function(f8_arg0, f8_arg1, f8_arg2)
	Engine[0xDE279ECDDDD966](f8_arg0, @"hash_2F4DF4CDCC668F6", {
		[@"purchased"] = f8_arg2,
		[@"entrypoint"] = f8_arg1,
		[@"season"] = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER),
	})
end
CoD.MetricsUtility.BlackMarketTierPurchasedEvent = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	Engine[0xDE279ECDDDD966](f9_arg0, @"hash_C6197ED6B5112CF", {
		[@"entrypoint"] = f9_arg1,
		[@"purchased"] = f9_arg2,
		[@"tiers"] = f9_arg3,
		[@"season"] = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER),
	})
end
CoD.MetricsUtility.BlackMarketEntryEvent = function(f10_arg0, f10_arg1)
	Engine[0xDE279ECDDDD966](f10_arg0, @"hash_717AE67806EEB45B", {
		[@"entrypoint"] = f10_arg1._entrypoint or "",
		[@"shop"] = f10_arg1._shop or false,
		[@"contraband"] = f10_arg1._contraband or false,
		[@"reserves"] = f10_arg1._reserves or false,
		[@"inventory"] = f10_arg1._inventory or false,
		[@"season"] = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER),
	})
end
CoD.MetricsUtility.BlackMarketItemShopEvent = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4, f11_arg5, f11_arg6, f11_arg7, f11_arg8, f11_arg9, f11_arg10)
	Engine[0xDE279ECDDDD966](f11_arg0, @"hash_2E92ED589816851F", {
		[@"slot"] = f11_arg1,
		[@"action"] = f11_arg2,
		[@"sku"] = f11_arg3,
		[@"itemname"] = f11_arg4,
		[@"season"] = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER),
		[@"tierboost"] = CoDShared.Loot.GetTierBoostItemTotal(f11_arg0),
		[@"stackposition"] = f11_arg5,
		[@"stacktotal"] = f11_arg6,
		[@"codpoints"] = Engine[@"hash_2F40679B550DCCA2"](f11_arg0, CoD.Currencies.COD_POINTS),
		[@"casecount"] = CoDShared.Loot.GetLootCaseOwnedCount(f11_arg0),
		[@"timeremaining"] = f11_arg7,
		[@"rotationtime"] = f11_arg8,
		[@"cpcost"] = f11_arg9,
		[@"hash_15C56D778DF1BB04"] = f11_arg10,
	})
end
CoD.MetricsUtility.StoreEntry = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	Engine[0xDE279ECDDDD966](f12_arg1, @"hash_4B3D4FD4D4299D51", {
		[@"store_source"] = f12_arg3[@"name"],
		[@"store_gamemode"] = Engine[@"getmodename"](),
		[@"store_action_source"] = f12_arg2,
		[@"store_region"] = Engine[@"getskuregion"](),
	})
end
CoD.MetricsUtility.StoreItemViewed = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	local f13_local0 = DataSources.StoreRoot.getModel(f13_arg1)
	Engine[0xDE279ECDDDD966](f13_arg1, @"hash_4C0B45CDE1F34BEF", {
		[@"store_source"] = f13_local0.storeSource:get(),
		[@"store_gamemode"] = Engine[@"getmodename"](),
		[@"store_action_source"] = f13_local0.actionSource:get(),
		[@"product_id"] = f13_arg2,
		[@"hash_2B880C16983CE21C"] = f13_arg3,
		[@"store_region"] = Engine[@"getskuregion"](),
	})
end
CoD.MetricsUtility.AccountCreated = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
	Engine[0xDE279ECDDDD966](f14_arg1, @"hash_4CD48A645BAF10CD", {
		[@"hash_37406C6A6CBF2DFB"] = f14_arg2,
		[@"hash_35A7370DA18FB6C4"] = f14_arg3,
	})
end
CoD.MetricsUtility.CRMMessageImpression = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = nil
	if f15_arg2 == "crm_featured" then
		local f15_local1 = Engine[@"getmodel"](Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f15_arg1), "FeaturedCards"), Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "FeaturedCardsRoot"), "CardSequence")) + 1)
		if not f15_local1 then
			return
		end
		local f15_local2 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f15_local1, "index"))
		local f15_local3 = Engine[@"getfeaturedcard"](f15_local2)
		if not f15_local3 then
			return
		elseif f15_local3.type ~= Enum[@"featuredcardtype"][@"featured_card_type_crm"] then
			return
		end
		f15_local0 = Engine[@"getmarketingmessage"](f15_arg1, f15_arg2, f15_local2)
	else
		f15_local0 = Engine[@"getmarketingmessage"](f15_arg1, f15_arg2)
	end
	if not f15_local0 then
		return
	end
	local f15_local4 = 0
	if f15_arg0.openTime then
		f15_local4 = Engine[@"milliseconds"]() - f15_arg0.openTime
	end
	Engine[0xDE279ECDDDD966](f15_arg1, @"hash_2DFC4F3FC5FE9585", {
		[@"hash_13A1A70556201A2D"] = f15_local0.messageID,
		[@"hash_43C83260DD96C90C"] = f15_local0.locationID,
		[@"hash_22F063E57AD61490"] = f15_local4,
	})
end
CoD.MetricsUtility.CRMMessageInteraction = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4)
	local f16_local0 = nil
	if f16_arg2 == "crm_featured" then
		local f16_local1 = Engine[@"getmodel"](Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f16_arg1), "FeaturedCards"), Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "FeaturedCardsRoot"), "CardSequence")) + 1)
		if not f16_local1 then
			return
		end
		local f16_local2 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f16_local1, "index"))
		local f16_local3 = Engine[@"getfeaturedcard"](f16_local2)
		if not f16_local3 then
			return
		elseif f16_local3.type ~= Enum[@"featuredcardtype"][@"featured_card_type_crm"] then
			return
		end
		f16_local0 = Engine[@"getmarketingmessage"](f16_arg1, f16_arg2, f16_local2)
	else
		f16_local0 = Engine[@"getmarketingmessage"](f16_arg1, f16_arg2)
	end
	if not f16_local0 then
		return
	elseif not f16_arg3 then
		f16_arg3 = ""
	end
	if not f16_arg4 then
		f16_arg4 = ""
	end
	Engine[0xDE279ECDDDD966](f16_arg1, @"hash_1F4D09865FFDD4B4", {
		[@"hash_13A1A70556201A2D"] = f16_local0.messageID,
		[@"hash_43C83260DD96C90C"] = f16_local0.locationID,
		[@"interaction_type"] = f16_arg3,
		[@"interaction_details"] = f16_arg4,
	})
end
CoD.MetricsUtility.PaintshopEvent = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4, f17_arg5, f17_arg6, f17_arg7)
	Engine[0xDE279ECDDDD966](f17_arg0, @"hash_71CEF64DDE4E7F7C", {
		[@"operation"] = f17_arg1,
		[@"duration"] = f17_arg2,
		[@"weapon_id"] = f17_arg3,
		[@"hash_65C19815194E5A8E"] = f17_arg4,
		[@"assets_used"] = f17_arg5,
		[@"slots_used"] = f17_arg6,
		[@"total_slots"] = f17_arg7,
	})
end
CoD.MetricsUtility.EmblemEvent = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4)
	Engine[0xDE279ECDDDD966](f18_arg0, @"hash_4CF2128ACF6E5097", {
		[@"duration"] = f18_arg1,
		[@"assets_used"] = f18_arg2,
		[@"slots_used"] = f18_arg3,
		[@"total_slots"] = f18_arg4,
	})
end
CoD.MetricsUtility.PrestigeEvent = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	Engine[0xDE279ECDDDD966](f19_arg0, @"hash_7BB2EA7E9D9529C", {
		[@"old_prestige"] = f19_arg1,
		[@"new_prestige"] = f19_arg2,
		[@"game_mode"] = f19_arg3,
	})
end
CoD.MetricsUtility.WatchVideoEvent = function(f20_arg0, f20_arg1)
	Engine[0xDE279ECDDDD966](f20_arg0, @"hash_63602D9F9B9C6310", {
		[@"video_id"] = f20_arg1.fileID,
		[@"video_length"] = f20_arg1.duration,
		[@"video_author"] = f20_arg1.authorName,
		[@"hash_7AD364242ED0CB7E"] = f20_arg1.isPooled,
	})
end
CoD.MetricsUtility.ScreenshotEvent = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	Engine[0xDE279ECDDDD966](f21_arg0, @"hash_55150CA78539C58D", {
		[@"operation"] = f21_arg1,
		[@"slots_used"] = f21_arg3,
		[@"total_slots"] = f21_arg4,
	})
end
CoD.MetricsUtility.ClipsEvent = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	Engine[0xDE279ECDDDD966](f22_arg0, @"hash_6624ABA28DBDFBD7", {
		[@"operation"] = f22_arg1,
		[@"slots_used"] = f22_arg3,
		[@"total_slots"] = f22_arg4,
	})
end
CoD.MetricsUtility.FileshareEvent = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4)
	Engine[0xDE279ECDDDD966](f23_arg0, @"hash_3A85D33AEFD4A376", {
		[@"category"] = f23_arg2,
		[@"operation"] = f23_arg1,
		[@"slots_used"] = f23_arg3,
		[@"total_slots"] = f23_arg4,
	})
end
CoD.MetricsUtility.ReportUser = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4, f24_arg5)
	CoDShared.ReportUser(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4, f24_arg5)
end
