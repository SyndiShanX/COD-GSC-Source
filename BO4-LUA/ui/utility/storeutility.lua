CoD.StoreUtility = {}
require("ui/utility/overlayutility")
CoD.StoreUtility.StoreFeaturedCategory = "featured"
CoD.StoreUtility.IsStoreEnabled = function(f1_arg0)
	if not Dvar[@"live_store_enable"]:get() then
		return false
	elseif CoD.isPS4 and Dvar[@"live_store_disable_lang"]:get() == Dvar[@"loc_availablelanguages"]:get() and Dvar[@"live_store_disable_region"]:get() == Engine.GetSkuRegion() then
		return false
	else
		return true
	end
end
CoD.StoreUtility.InitSingleCategoryStoreMenu = function(f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = DataSources.StoreRoot.getModel(f2_arg1)
	f2_local0.isCategoryListInFocus:set(0)
	CoD.perController[f2_arg1].selectedStoreCategory = f2_arg2
	Engine[@"hash_3ED84BE5BCA388FA"](f2_arg1, f2_arg2, false)
	f2_arg0.disablePopupOpenCloseAnim = true
end
CoD.StoreUtility.AddUpsellToDescriptionIfNeeded = function(f3_arg0, f3_arg1, f3_arg2)
	if not Engine.IsMapValid(f3_arg1) and ShowPurchasableMap(f3_arg0, f3_arg1) then
		local f3_local0 = Engine[@"getdlcbitformapname"](f3_arg1)
		local f3_local1 = f3_local0 and CoD.DLCPackFromBit[f3_local0]
		if f3_local1 then
			return Engine[@"hash_4F9F1239CFD921FE"]("menu/description_and_upsell", f3_arg2, Engine.Localize("MENU/" .. f3_local1 .. "_REQUIRED_HINT"))
		end
	end
	return f3_arg2
end
CoD.StoreUtility.PrependPurchaseIconIfNeeded = function(f4_arg0, f4_arg1, f4_arg2)
	if not Engine.IsMapValid(f4_arg1) and ShowPurchasableMap(f4_arg0, f4_arg1) then
		local f4_local0 = Engine[@"getdlcbitformapname"](f4_arg1)
		if f4_local0 and CoD.DLCPackFromBit[f4_local0] then
			return Engine[@"hash_4F9F1239CFD921FE"]("menu/purchase_icon_and_text", f4_arg2)
		end
	end
	return f4_arg2
end
CoD.StoreUtility.AddListDLCListener = function(f5_arg0)
	f5_arg0._previousDLCBits = Engine[@"getdlcbits"]()
	if not f5_arg0._updateTimer then
		f5_arg0._updateTimer = LUI.UITimer.newElementTimer(1000, false, function()
			if f5_arg0._previousDLCBits ~= Engine[@"getdlcbits"]() then
				f5_arg0._previousDLCBits = Engine[@"getdlcbits"]()
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
			name = Engine[@"hash_4F9F1239CFD921FE"]("menu/store_caps"),
			iconBackground = "ui_icon_crm_featured_welcome",
			iconBackgroundFocus = "ui_icon_crm_featured_welcome",
			descriptionText = @"menu/upgrade_now",
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
		return Engine[@"hash_4F9F1239CFD921FE"](@"menu/" .. f9_arg1.dlcPack .. "_REQUIRED_HINT")
	end,
	description = function(f10_arg0, f10_arg1)
		return Engine[@"hash_4F9F1239CFD921FE"](@"menu/" .. f10_arg1.dlcPack .. "_DESC")
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
				f12_local1(Engine.ToUpper(Engine[@"hash_4F9F1239CFD921FE"]("menu/go_to_store")), function(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4)
					GoBackAndOpenOverlayOnParent(f14_arg4, "Store_DLC", f14_arg2)
				end, true, false)
			)
			table.insert(
				f12_local0,
				f12_local1("menu/cancel_caps", function(f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4)
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
	local f16_local0 = Engine[@"hash_51661D5D921598F5"](f16_arg0)
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
	local f17_local0 = Engine[@"hash_51661D5D921598F5"](f17_arg0)
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
	local f18_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(f18_arg1, f18_arg0, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"])
	if not f18_local0 then
		f18_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(f18_arg1, f18_arg0, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"])
	end
	return f18_local0
end
CoD.StoreUtility.GetDLCImageFromDLCName = function(f19_arg0, f19_arg1)
	if f19_arg1 then
		local f19_local0 = Engine[@"hash_6E4C9240A618B3D3"]("featured")
		for f19_local1 = 1, #f19_local0, 1 do
			local f19_local4 = f19_local0[f19_local1]
			if f19_arg1 == f19_local4.metadata then
				return f19_local4.productImage
			end
		end
	end
	return "ui_menu_store_product_b04_blops_pass_new_large"
end
CoD.StoreUtility.GetDLCImageByPlaylistId = function(f20_arg0, f20_arg1)
	if f20_arg1 then
		local f20_local0 = Engine[@"getplaylistinfobyid"](f20_arg1)
		if f20_local0 and f20_local0.locked and f20_local0.mainMode == Enum.LobbyMainMode[@"lobby_mainmode_zm"] then
			return CoD.StoreUtility.GetDLCImageFromDLCName(f20_arg0, CoD.DLCPackFromBit[CoD.StoreUtility.FindMissingDLC(f20_local0.usedDLCMask & Engine[@"hash_63A5F21D4434E1F8"]())])
		end
	end
	return CoD.StoreUtility.GetDLCImageFromDLCName(f20_arg0, "SEASONPASS")
end
CoD.StoreUtility.GetDLCPackByPlaylistId = function(f21_arg0, f21_arg1)
	if f21_arg1 then
		local f21_local0 = Engine[@"getplaylistinfobyid"](f21_arg1)
		if f21_local0 and f21_local0.locked then
			return CoD.DLCPackFromBit[CoD.StoreUtility.FindMissingDLC(f21_local0.usedDLCMask & Engine[@"hash_63A5F21D4434E1F8"]())]
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
		f24_local1.storeSource:set(f24_local0.name)
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
		f25_local1.storeSource:set(f25_local0.name)
		OpenOverlay(f25_arg4, "Store", f25_arg2, {
			_focusProduct = CoD.StoreUtility.GetDLCPackByPlaylistId(f25_arg2, f25_arg1),
		})
	end
end
