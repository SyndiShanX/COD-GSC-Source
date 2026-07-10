CoD.MetricsUtility = {}
CoD.MetricsUtility.NextReportTime = 0
CoD.MetricsUtility.LobbyInit = function()
	if not CoD.MetricsUtility.lobbyElement then
		CoD.MetricsUtility.lobbyElement = LUI.UIElement.new()
		CoD.MetricsUtility.lobbyElement:subscribeToModel(Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav"), function(model)
			local f2_local0 = Engine[0x614D394F6F9A18D](model)
			if CoD.MetricsUtility.menuID ~= nil and f2_local0 ~= CoD.MetricsUtility.menuID then
				local f2_local1 = 0
				local f2_local2 = LobbyData.GetLobbyMenuByID(CoD.MetricsUtility.menuID)
				CoD.MetricsUtility.ScreenView(f2_local1, f2_local2[0x4BCADBA8E631B86], Engine[0x9D33D652B9B0F3B]() - CoD.MetricsUtility.openTime, nil)
			end
			CoD.MetricsUtility.menuID = f2_local0
			CoD.MetricsUtility.openTime = Engine[0x9D33D652B9B0F3B]()
		end)
	end
end
CoD.MetricsUtility.OpenMenu = function(f3_arg0)
	f3_arg0.openTime = Engine[0x9D33D652B9B0F3B]()
end
CoD.MetricsUtility.CloseMenu = function(f4_arg0)
	local f4_local0 = f4_arg0:getOwner()
	if f4_local0 == nil then
		f4_local0 = 0
	end
	local f4_local1 = 0
	if f4_arg0.openTime then
		f4_local1 = Engine[0x9D33D652B9B0F3B]() - f4_arg0.openTime
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
	for f6_local0 = 1, Enum[0x3DD78803F918E9D][0x95F016E15E34356], 1 do
		local f6_local3 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f6_arg0), "ButtonBits." .. f6_local0)
		if f6_local3 and CoD.BitUtility.IsBitwiseAndNonZero(Engine[0x614D394F6F9A18D](f6_local3), Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464]) then
			return f6_local0
		end
	end
end
CoD.MetricsUtility.ScreenView = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8]
	for f7_local1 = 1, Enum[0x3DD78803F918E9D][0x95F016E15E34356], 1 do
		local f7_local4 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f7_arg0), "ButtonBits." .. f7_local1)
		if f7_local4 and CoD.BitUtility.IsBitwiseAndNonZero(Engine[0x614D394F6F9A18D](f7_local4), Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464]) then
			f7_local0 = f7_local1
		end
	end
	Engine[0xDE279ECDDDD966](f7_arg0, 0xE564E1B1EAF4F17, {
		[0x807A9F9A0F22827] = f7_arg1,
		[0xA2EDD0D449524F6] = f7_arg2,
		[0xA6F594B9F4471D1] = f7_local0,
		[0x3A1A70556201A2D] = f7_arg3,
		[0x357215DFA16830D] = Engine[0x9882F293C327557](),
	})
end
CoD.MetricsUtility.BlackMarketCratePurchasedEvent = function(f8_arg0, f8_arg1, f8_arg2)
	Engine[0xDE279ECDDDD966](f8_arg0, 0x2F4DF4CDCC668F6, {
		[0x8F54E2E72E0EA12] = f8_arg2,
		[0xF01D845CFE72CBB] = f8_arg1,
		[0x8DFD5E2759BA3F8] = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER),
	})
end
CoD.MetricsUtility.BlackMarketTierPurchasedEvent = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	Engine[0xDE279ECDDDD966](f9_arg0, 0xC6197ED6B5112CF, {
		[0xF01D845CFE72CBB] = f9_arg1,
		[0x8F54E2E72E0EA12] = f9_arg2,
		[0xDD8DC6C5FDAE3CE] = f9_arg3,
		[0x8DFD5E2759BA3F8] = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER),
	})
end
CoD.MetricsUtility.BlackMarketEntryEvent = function(f10_arg0, f10_arg1)
	Engine[0xDE279ECDDDD966](f10_arg0, 0x17AE67806EEB45B, {
		[0xF01D845CFE72CBB] = f10_arg1._entrypoint or "",
		[0x6DC5E18E28E2409] = f10_arg1._shop or false,
		[0x37934F15B706913] = f10_arg1._contraband or false,
		[0x7707FCCD201C228] = f10_arg1._reserves or false,
		[0xDE86446633071DF] = f10_arg1._inventory or false,
		[0x8DFD5E2759BA3F8] = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER),
	})
end
CoD.MetricsUtility.BlackMarketItemShopEvent = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4, f11_arg5, f11_arg6, f11_arg7, f11_arg8, f11_arg9, f11_arg10)
	Engine[0xDE279ECDDDD966](f11_arg0, 0xE92ED589816851F, {
		[0xA771618F6FE31D1] = f11_arg1,
		[0x568640B035A56DF] = f11_arg2,
		[0x2429A195CE84D1A] = f11_arg3,
		[0x4F5DF80758A6345] = f11_arg4,
		[0x8DFD5E2759BA3F8] = CoDShared.Loot.GetSeasonInfoParam(CoDShared.Loot.GetCurrentSeason(), CoDShared.Loot.SEASON_INFO_NUMBER),
		[0x82F5F2F5FB1340] = CoDShared.Loot.GetTierBoostItemTotal(f11_arg0),
		[0x4C576376A0BBFFC] = f11_arg5,
		[0xB19CA31C6396947] = f11_arg6,
		[0x98197E5BC91D712] = Engine[0xF40679B550DCCA2](f11_arg0, CoD.Currencies.COD_POINTS),
		[0x28E78264DD0C908] = CoDShared.Loot.GetLootCaseOwnedCount(f11_arg0),
		[0x6BD92EC4B0578E0] = f11_arg7,
		[0x7989C1D95F393EE] = f11_arg8,
		[0xB8D66C9384C2577] = f11_arg9,
		[0x5C56D778DF1BB04] = f11_arg10,
	})
end
CoD.MetricsUtility.StoreEntry = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	Engine[0xDE279ECDDDD966](f12_arg1, 0xB3D4FD4D4299D51, {
		[0xC881611F0802316] = f12_arg3[0x4BCADBA8E631B86],
		[0xE7CCD6B25C00B8E] = Engine[0x5AA137994DA7513](),
		[0x34268CDEE080E77] = f12_arg2,
		[0x642DB161AD4BEAB] = Engine[0xF9D3DC938A17E74](),
	})
end
CoD.MetricsUtility.StoreItemViewed = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	local f13_local0 = DataSources.StoreRoot.getModel(f13_arg1)
	Engine[0xDE279ECDDDD966](f13_arg1, 0xC0B45CDE1F34BEF, {
		[0xC881611F0802316] = f13_local0.storeSource:get(),
		[0xE7CCD6B25C00B8E] = Engine[0x5AA137994DA7513](),
		[0x34268CDEE080E77] = f13_local0.actionSource:get(),
		[0x4DC92EB0D5A42AC] = f13_arg2,
		[0xB880C16983CE21C] = f13_arg3,
		[0x642DB161AD4BEAB] = Engine[0xF9D3DC938A17E74](),
	})
end
CoD.MetricsUtility.AccountCreated = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
	Engine[0xDE279ECDDDD966](f14_arg1, 0xCD48A645BAF10CD, {
		[0x7406C6A6CBF2DFB] = f14_arg2,
		[0x5A7370DA18FB6C4] = f14_arg3,
	})
end
CoD.MetricsUtility.CRMMessageImpression = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = nil
	if f15_arg2 == "crm_featured" then
		local f15_local1 = Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f15_arg1), "FeaturedCards"), Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "FeaturedCardsRoot"), "CardSequence")) + 1)
		if not f15_local1 then
			return
		end
		local f15_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f15_local1, "index"))
		local f15_local3 = Engine[0x7C4F126297B2ED7](f15_local2)
		if not f15_local3 then
			return
		elseif f15_local3.type ~= Enum[0xC2DED9979C43E85][0x924017B575CECF4] then
			return
		end
		f15_local0 = Engine[0xE205100C694EF74](f15_arg1, f15_arg2, f15_local2)
	else
		f15_local0 = Engine[0xE205100C694EF74](f15_arg1, f15_arg2)
	end
	if not f15_local0 then
		return
	end
	local f15_local4 = 0
	if f15_arg0.openTime then
		f15_local4 = Engine[0x9D33D652B9B0F3B]() - f15_arg0.openTime
	end
	Engine[0xDE279ECDDDD966](f15_arg1, 0xDFC4F3FC5FE9585, {
		[0x3A1A70556201A2D] = f15_local0.messageID,
		[0x3C83260DD96C90C] = f15_local0.locationID,
		[0x2F063E57AD61490] = f15_local4,
	})
end
CoD.MetricsUtility.CRMMessageInteraction = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4)
	local f16_local0 = nil
	if f16_arg2 == "crm_featured" then
		local f16_local1 = Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f16_arg1), "FeaturedCards"), Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "FeaturedCardsRoot"), "CardSequence")) + 1)
		if not f16_local1 then
			return
		end
		local f16_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f16_local1, "index"))
		local f16_local3 = Engine[0x7C4F126297B2ED7](f16_local2)
		if not f16_local3 then
			return
		elseif f16_local3.type ~= Enum[0xC2DED9979C43E85][0x924017B575CECF4] then
			return
		end
		f16_local0 = Engine[0xE205100C694EF74](f16_arg1, f16_arg2, f16_local2)
	else
		f16_local0 = Engine[0xE205100C694EF74](f16_arg1, f16_arg2)
	end
	if not f16_local0 then
		return
	elseif not f16_arg3 then
		f16_arg3 = ""
	end
	if not f16_arg4 then
		f16_arg4 = ""
	end
	Engine[0xDE279ECDDDD966](f16_arg1, 0xF4D09865FFDD4B4, {
		[0x3A1A70556201A2D] = f16_local0.messageID,
		[0x3C83260DD96C90C] = f16_local0.locationID,
		[0x72F1795FF3E15F4] = f16_arg3,
		[0xC3213FBE680515A] = f16_arg4,
	})
end
CoD.MetricsUtility.PaintshopEvent = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4, f17_arg5, f17_arg6, f17_arg7)
	Engine[0xDE279ECDDDD966](f17_arg0, 0x1CEF64DDE4E7F7C, {
		[0x387BB5BE85C3C86] = f17_arg1,
		[0xAF203AC9DD3208D] = f17_arg2,
		[0x1B9FADEB749D5B7] = f17_arg3,
		[0x5C19815194E5A8E] = f17_arg4,
		[0xC5C0D006BB174D0] = f17_arg5,
		[0x39D0A763CEB875A] = f17_arg6,
		[0xC0CC839524F23A3] = f17_arg7,
	})
end
CoD.MetricsUtility.EmblemEvent = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4)
	Engine[0xDE279ECDDDD966](f18_arg0, 0xCF2128ACF6E5097, {
		[0xAF203AC9DD3208D] = f18_arg1,
		[0xC5C0D006BB174D0] = f18_arg2,
		[0x39D0A763CEB875A] = f18_arg3,
		[0xC0CC839524F23A3] = f18_arg4,
	})
end
CoD.MetricsUtility.PrestigeEvent = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	Engine[0xDE279ECDDDD966](f19_arg0, 0x7BB2EA7E9D9529C, {
		[0xE7BBDA657E05B6A] = f19_arg1,
		[0x622A9E6C156E077] = f19_arg2,
		[0x231A1BEA995F83B] = f19_arg3,
	})
end
CoD.MetricsUtility.WatchVideoEvent = function(f20_arg0, f20_arg1)
	Engine[0xDE279ECDDDD966](f20_arg0, 0x3602D9F9B9C6310, {
		[0xD6B0911223229CC] = f20_arg1.fileID,
		[0xA654F6A532DB871] = f20_arg1.duration,
		[0x67DF9328A690422] = f20_arg1.authorName,
		[0xAD364242ED0CB7E] = f20_arg1.isPooled,
	})
end
CoD.MetricsUtility.ScreenshotEvent = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	Engine[0xDE279ECDDDD966](f21_arg0, 0x5150CA78539C58D, {
		[0x387BB5BE85C3C86] = f21_arg1,
		[0x39D0A763CEB875A] = f21_arg3,
		[0xC0CC839524F23A3] = f21_arg4,
	})
end
CoD.MetricsUtility.ClipsEvent = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	Engine[0xDE279ECDDDD966](f22_arg0, 0x624ABA28DBDFBD7, {
		[0x387BB5BE85C3C86] = f22_arg1,
		[0x39D0A763CEB875A] = f22_arg3,
		[0xC0CC839524F23A3] = f22_arg4,
	})
end
CoD.MetricsUtility.FileshareEvent = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4)
	Engine[0xDE279ECDDDD966](f23_arg0, 0xA85D33AEFD4A376, {
		[0xBD2E7FFB1224E91] = f23_arg2,
		[0x387BB5BE85C3C86] = f23_arg1,
		[0x39D0A763CEB875A] = f23_arg3,
		[0xC0CC839524F23A3] = f23_arg4,
	})
end
CoD.MetricsUtility.ReportUser = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4, f24_arg5)
	CoDShared.ReportUser(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4, f24_arg5)
end
