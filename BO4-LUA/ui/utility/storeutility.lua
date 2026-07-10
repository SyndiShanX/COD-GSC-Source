CoD.StoreUtility = {}
require("x64:f3c5259f470592d")
CoD.StoreUtility.StoreFeaturedCategory = "featured"
CoD.StoreUtility.IsStoreEnabled = function(f1_arg0)
	if not Dvar[0x14F69F96CEB06F9]:get() then
		return false
	elseif CoD.isPS4 and Dvar[0xED2201F94165577]:get() == Dvar[0x46B5D9C4A7CE4C0]:get() and Dvar[0xA06182194A98F5F]:get() == Engine[0xF9D3DC938A17E74]() then
		return false
	else
		return true
	end
end
CoD.StoreUtility.InitSingleCategoryStoreMenu = function(f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = DataSources.StoreRoot.getModel(f2_arg1)
	f2_local0.isCategoryListInFocus:set(0)
	CoD.perController[f2_arg1].selectedStoreCategory = f2_arg2
	Engine[0xED84BE5BCA388FA](f2_arg1, f2_arg2, false)
	f2_arg0.disablePopupOpenCloseAnim = true
end
CoD.StoreUtility.AddUpsellToDescriptionIfNeeded = function(f3_arg0, f3_arg1, f3_arg2)
	if not Engine[0xC3C68A8BA45A52D](f3_arg1) and ShowPurchasableMap(f3_arg0, f3_arg1) then
		local f3_local0 = Engine[0x943893A16399DCF](f3_arg1)
		local f3_local1 = f3_local0 and CoD.DLCPackFromBit[f3_local0]
		if f3_local1 then
			return Engine[0xF9F1239CFD921FE](0x5D4B2D29288ADDF, f3_arg2, Engine[0xED84C33EC5F01EA]("MENU/" .. f3_local1 .. "_REQUIRED_HINT"))
		end
	end
	return f3_arg2
end
CoD.StoreUtility.PrependPurchaseIconIfNeeded = function(f4_arg0, f4_arg1, f4_arg2)
	if not Engine[0xC3C68A8BA45A52D](f4_arg1) and ShowPurchasableMap(f4_arg0, f4_arg1) then
		local f4_local0 = Engine[0x943893A16399DCF](f4_arg1)
		if f4_local0 and CoD.DLCPackFromBit[f4_local0] then
			return Engine[0xF9F1239CFD921FE](0x1001FF6B558E68C, f4_arg2)
		end
	end
	return f4_arg2
end
CoD.StoreUtility.AddListDLCListener = function(f5_arg0)
	f5_arg0._previousDLCBits = Engine[0xFD1E02C14853724]()
	if not f5_arg0._updateTimer then
		f5_arg0._updateTimer = LUI.UITimer.newElementTimer(1000, false, function()
			if f5_arg0._previousDLCBits ~= Engine[0xFD1E02C14853724]() then
				f5_arg0._previousDLCBits = Engine[0xFD1E02C14853724]()
				f5_arg0:updateDataSource()
			end
		end)
		f5_arg0:addElement(f5_arg0._updateTimer)
	end
	LUI.OverrideFunction_CallOriginalSecond(f5_arg0, "close", function(element)
		if element._updateTimer then
			element._updateTimer:close()
			element._updateTimer = nil
		end
	end)
end
CoD.StoreUtility.CreateStoreFeatureCard = function(f8_arg0, f8_arg1)
	table.insert(f8_arg0, {
		models = {
			locked = false,
			name = Engine[0xF9F1239CFD921FE](0x191CDDA584B4408),
			iconBackground = 0xEEC1B33FCDD11A6,
			iconBackgroundFocus = 0xEEC1B33FCDD11A6,
			descriptionText = 0xC93BEA7D80F41C6,
			action = OpenStore,
			actionParam = "FeaturedCard",
			actionString = "store",
			showForAllClients = true,
			hasDoubleXP = false,
			hasDoubleWeaponXP = false,
			interactable = true,
		},
	})
end
CoD.OverlayUtility.AddSystemOverlay("PurchaseMapPackConfirmation", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.SystemOverlay_MapPackFrame",
	title = function(f9_arg0, f9_arg1)
		return Engine[0xF9F1239CFD921FE](0x93E7CC7D7789D8F .. f9_arg1.dlcPack .. "_REQUIRED_HINT")
	end,
	description = function(f10_arg0, f10_arg1)
		return Engine[0xF9F1239CFD921FE](0x93E7CC7D7789D8F .. f10_arg1.dlcPack .. "_DESC")
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = function(f11_arg0, f11_arg1)
		DataSources.PurchaseMapPackMenuList = DataSourceHelpers.ListSetup("PurchaseMapPackMenuList", function(f12_arg0, f12_arg1)
			local f12_local0 = {}
			local f12_local1 = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
				return {
					models = {
						displayText = f13_arg0,
						disabled = f13_arg3,
					},
					properties = {
						action = f13_arg1,
						actionParam = f11_arg1,
						selectIndex = f13_arg2,
					},
				}
			end
			table.insert(
				f12_local0,
				f12_local1(Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x69530752CA38E65)), function(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4)
					GoBackAndOpenOverlayOnParent(f14_arg4, "Store_DLC", f14_arg2)
				end, true, false)
			)
			table.insert(
				f12_local0,
				f12_local1(0x6DA4540B4705513, function(f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4)
					GoBack(f15_arg4, f15_arg2)
				end, false, false)
			)
			return f12_local0
		end, true)
		return "PurchaseMapPackMenuList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
})
CoD.StoreUtility.GetExperimentModifier = function(f16_arg0, f16_arg1)
	local f16_local0 = Engine[0x1661D5D921598F5](f16_arg0)
	for f16_local1 = 1, #f16_local0, 1 do
		local f16_local4 = f16_local0[f16_local1]
		if f16_local4.startsInSeconds == 0 and f16_local4.endsInSeconds > 0 then
			local f16_local5 = f16_local4.rules
			if f16_local5 ~= nil and f16_local5 ~= "" then
				local f16_local6 = string.match(f16_local5, '"' .. f16_arg1 .. '":%s+"([^"]+)')
				if f16_local6 ~= nil and f16_local6 ~= "" then
					return f16_local6
				end
				f16_local6 = string.match(f16_local5, '"' .. f16_arg1 .. '":+"([^"]+)')
				if f16_local6 ~= nil and f16_local6 ~= "" then
					return f16_local6
				end
			end
		end
	end
	return ""
end
CoD.StoreUtility.GetExperimentModifierValue = function(f17_arg0, f17_arg1)
	local f17_local0 = Engine[0x1661D5D921598F5](f17_arg0)
	for f17_local1 = 1, #f17_local0, 1 do
		local f17_local4 = f17_local0[f17_local1]
		if f17_local4.startsInSeconds == 0 and f17_local4.endsInSeconds > 0 then
			local f17_local5 = f17_local4.rules
			if f17_local5 ~= nil and f17_local5 ~= "" then
				local f17_local6 = string.match(f17_local5, '"' .. f17_arg1 .. '": %d')
				if f17_local6 ~= nil and f17_local6 ~= "" then
					local f17_local7 = string.gsub(f17_local6, '"' .. f17_arg1 .. '": ', "")
					if f17_local7 ~= nil and f17_local7 ~= "" then
						return tonumber(f17_local7)
					end
				end
			end
		end
	end
	return 0
end
CoD.StoreUtility.ShouldUpsellOrDownloadPlaylist = function(f18_arg0, f18_arg1)
	local f18_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(f18_arg1, f18_arg0, "lockState", Enum[0xDACBB5C5F26BCD9][0x4BDEB566326AC98])
	if not f18_local0 then
		f18_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(f18_arg1, f18_arg0, "lockState", Enum[0xDACBB5C5F26BCD9][0x9B632F6362EA1BE])
	end
	return f18_local0
end
CoD.StoreUtility.GetDLCImageFromDLCName = function(f19_arg0, f19_arg1)
	if f19_arg1 then
		local f19_local0 = Engine[0xE4C9240A618B3D3](0xE45AEA6EE3C751B)
		for f19_local1 = 1, #f19_local0, 1 do
			local f19_local4 = f19_local0[f19_local1]
			if f19_arg1 == f19_local4.metadata then
				return f19_local4.productImage
			end
		end
	end
	return 0x8D65B062C99264E
end
CoD.StoreUtility.GetDLCImageByPlaylistId = function(f20_arg0, f20_arg1)
	if f20_arg1 then
		local f20_local0 = Engine[0x3ACB99DBAD24D55](f20_arg1)
		if f20_local0 and f20_local0.locked and f20_local0.mainMode == Enum[0x89C1455C5032969][0x79D01499920B292] then
			return CoD.StoreUtility.GetDLCImageFromDLCName(f20_arg0, CoD.DLCPackFromBit[CoD.StoreUtility.FindMissingDLC(f20_local0.usedDLCMask & Engine[0x3A5F21D4434E1F8]())])
		end
	end
	return CoD.StoreUtility.GetDLCImageFromDLCName(f20_arg0, "SEASONPASS")
end
CoD.StoreUtility.GetDLCPackByPlaylistId = function(f21_arg0, f21_arg1)
	if f21_arg1 then
		local f21_local0 = Engine[0x3ACB99DBAD24D55](f21_arg1)
		if f21_local0 and f21_local0.locked then
			return CoD.DLCPackFromBit[CoD.StoreUtility.FindMissingDLC(f21_local0.usedDLCMask & Engine[0x3A5F21D4434E1F8]())]
		end
	end
	return "SEASONPASS"
end
CoD.StoreUtility.GetDLCImageFromPlaylist = function(f22_arg0, f22_arg1)
	return CoD.StoreUtility.GetDLCImageByPlaylistId(f22_arg0, f22_arg1)
end
CoD.StoreUtility.FindMissingDLC = function(f23_arg0)
	for f23_local3, f23_local4 in pairs(CoD.DLCBits) do
		if CoD.BitUtility.IsBitwiseAndNonZero(f23_arg0, f23_local4) then
			return f23_local4
		end
	end
	return CoD.DLCBits.CONTENT_UNKNOWN
end
CoD.StoreUtility.OpenStoreToDLCPack = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4)
	if CoD.StoreUtility.IsStoreEnabled(f24_arg2) then
		local f24_local0 = LobbyData.GetCurrentMenuTarget()
		CoD.MetricsUtility.StoreEntry(f24_arg4, f24_arg2, f24_arg3, f24_local0)
		local f24_local1 = DataSources.StoreRoot.getModel(f24_arg2)
		f24_local1.ready:set(false)
		f24_local1.actionSource:set(f24_arg3)
		f24_local1.storeSource:set(f24_local0[0x4BCADBA8E631B86])
		OpenOverlay(f24_arg4, "Store", f24_arg2, {
			_focusProduct = CoD.StoreUtility.GetDLCPackByPlaylistId(f24_arg2, CoD.SafeGetModelValue(f24_arg1:getModel(), "playlist")),
		})
	end
end
CoD.StoreUtility.OpenStoreToDLCPackByPlaylist = function(f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4)
	if CoD.StoreUtility.IsStoreEnabled(f25_arg2) then
		local f25_local0 = LobbyData.GetCurrentMenuTarget()
		CoD.MetricsUtility.StoreEntry(f25_arg4, f25_arg2, f25_arg3, f25_local0)
		local f25_local1 = DataSources.StoreRoot.getModel(f25_arg2)
		f25_local1.ready:set(false)
		f25_local1.actionSource:set(f25_arg3)
		f25_local1.storeSource:set(f25_local0[0x4BCADBA8E631B86])
		OpenOverlay(f25_arg4, "Store", f25_arg2, {
			_focusProduct = CoD.StoreUtility.GetDLCPackByPlaylistId(f25_arg2, f25_arg1),
		})
	end
end
