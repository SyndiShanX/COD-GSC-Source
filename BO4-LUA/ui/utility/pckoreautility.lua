CoD.PCKoreaUtility = {}
CoD.PCKoreaUtility.WaitOutKoreanBootWarning = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = tonumber(f1_arg2)
	assert(f1_local0)
	f1_arg0.koreaTimer = LUI.UITimer.newElementTimer(f1_local0, true, function()
		local f2_local0 = Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.postPopups")
		Engine.SetModelValue(f2_local0, CoD.BitUtility.ClearBit(Engine.GetModelValue(f2_local0), LuaEnum.START_POPUPS.KoreaRating))
		ForceNotifyGlobalModel(f1_arg1, "lobbyRoot.closePopups")
		if Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			Engine[@"lobbyevent"]("OnGoForward", {
				controller = f1_arg1,
				navToMenu = "director",
			})
		end
		f1_arg0.koreaTimer:close()
		f1_arg0.koreaTimer = nil
		f1_arg0:close()
	end)
	f1_arg0:addElement(f1_arg0.koreaTimer)
end
CoD.PCKoreaUtility.StartKoreaIndulgenceChecks = function(f3_arg0)
	if not CoD.PCKoreaUtility.IsInKorea() then
		return
	end
	local f3_local0 = Engine.GetGlobalModel()
	f3_local0 = f3_local0["Korea.ShowIndulgenceMessage"]
	if f3_local0 then
		f3_arg0:subscribeToModel(f3_local0, function(model)
			if model:get() then
				CoD.PCUtility.ShowGameEvent(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5A6E08C14146C1A", CoD.PCWidgetUtility.round(Dvar[@"hash_5E52C202C50C2CB"]:get() / 3600)))
				model:set(false)
			end
		end)
	end
end
CoD.PCKoreaUtility.LocalizeInjectDvarAndConvertToPercent = function(f5_arg0, f5_arg1)
	return Engine[@"hash_4F9F1239CFD921FE"](f5_arg0, math.floor(f5_arg1:get() * 100 - 100))
end
CoD.PCKoreaUtility.InjectBonusXP = function(f6_arg0)
	return CoD.PCKoreaUtility.LocalizeInjectDvarAndConvertToPercent(f6_arg0, Dvar[@"hash_1351CDA06208BE7B"])
end
CoD.PCKoreaUtility.InjectBonusGunXP = function(f7_arg0)
	return CoD.PCKoreaUtility.LocalizeInjectDvarAndConvertToPercent(f7_arg0, Dvar[@"hash_7C246AA543012B8D"])
end
CoD.PCKoreaUtility.InjectBonusCredits = function(f8_arg0)
	return CoD.PCKoreaUtility.LocalizeInjectDvarAndConvertToPercent(f8_arg0, Dvar[@"hash_4DA039B4BC312FC1"])
end
CoD.PCKoreaUtility.InjectBonusMerits = function(f9_arg0)
	return CoD.PCKoreaUtility.LocalizeInjectDvarAndConvertToPercent(f9_arg0, Dvar[@"hash_1351CDA06208BE7B"])
end
CoD.PCKoreaUtility.HasNewIGRPerks = function()
	return false
end
CoD.PCKoreaUtility.IsInIGR = function()
	return Engine[@"hash_2343E1D78ABC6BF1"]()
end
CoD.PCKoreaUtility.ShowTransactionHistoryButton = function()
	return false
end
CoD.PCKoreaUtility.IsInKorea = function()
	return Engine[@"hash_3E78C83C300F9368"]()
end
CoD.PCKoreaUtility.ShowKorea18Plus = function()
	return CoD.PCKoreaUtility.IsInKorea() and not Engine[@"hash_3A8FBC7AC4C3F3A6"]()
end
CoD.PCKoreaUtility.ShowKorea15Plus = function()
	return CoD.PCKoreaUtility.IsInKorea() and Engine[@"hash_3A8FBC7AC4C3F3A6"]()
end
CoD.PCKoreaUtility.IsSeasonPromoVideoSafe = function()
	return not CoD.PCKoreaUtility.ShowKorea15Plus()
end
CoD.PCKoreaUtility.IsPlaylistEntryBlacklisted = function(f17_arg0)
	if CoD.PCKoreaUtility.ShowKorea15Plus() then
		local f17_local0 = Dvar[@"hash_411DCA380AC3E24"]:exists()
		if f17_local0 then
			f17_local0 = Dvar[@"hash_411DCA380AC3E24"]:get()
		end
		if CoD.PCKoreaUtility.IsHashInSemicolonSeperatedList(f17_arg0.uniqueName, f17_local0) then
			return true
		end
		for f17_local4, f17_local5 in ipairs(f17_arg0.rotationList) do
			if CoD.PCKoreaUtility.IsMapBlacklisted(f17_local5.map) then
				return true
			end
		end
	end
	return false
end
CoD.PCKoreaUtility.IsMapBlacklisted = function(f18_arg0)
	if CoD.PCKoreaUtility.ShowKorea15Plus() then
		local f18_local0 = Dvar[@"hash_2E9F0FE31B020699"]:exists()
		if f18_local0 then
			f18_local0 = Dvar[@"hash_2E9F0FE31B020699"]:get()
		end
		return CoD.PCKoreaUtility.IsHashInSemicolonSeperatedList(f18_arg0, f18_local0)
	else
		return false
	end
end
CoD.PCKoreaUtility.IsHashInSemicolonSeperatedList = function(f19_arg0, f19_arg1)
	if f19_arg1 and f19_arg1 ~= "" then
		for f19_local3 in string.gmatch(f19_arg1, "[^%s;]+") do
			if f19_local3 and f19_local3 ~= "" and Engine[@"converttoxhash"](f19_local3) == f19_arg0 then
				return true
			end
		end
	end
	return false
end
CoD.PCKoreaUtility.OpenTransactionsDeepLinkStore = function(f20_arg0)
	Engine.ExecNow(f20_arg0, "ui_browser_new 2 http:www.activision.com")
end
CoD.PCKoreaUtility.OpenTransactionsDeepLinkBlackmarket = function(f21_arg0)
	Engine.ExecNow(f21_arg0, "ui_browser_new 2 http:www.activision.com")
end
CoD.PCKoreaUtility.OpenTransactionsDeepLinkLab = function(f22_arg0)
	Engine.ExecNow(f22_arg0, "ui_browser_new 2 http:www.activision.com")
end
DataSources.PCKoreaRefundWarning = {
	prepare = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4, f23_arg5, f23_arg6, f23_arg7, f23_arg8, f23_arg9, f23_arg10, f23_arg11, f23_arg12, f23_arg13, f23_arg14, f23_arg15, f23_arg16)
		local f23_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "PCKoreaRefundWarning")
		local f23_local1 = f23_local0:create("title")
		f23_local1:set(tostring(f23_arg3))
		f23_local1 = f23_local0:create("description")
		f23_local1:set(f23_arg4)
		f23_local1 = f23_local0:create("confirmButtonTextHash")
		f23_local1:set(f23_arg16)
		if type(f23_arg5) == "number" then
			f23_local1 = f23_local0:create("cost")
			f23_local1:set(f23_arg5)
			f23_local1 = f23_local0:create("costString")
			f23_local1:set("")
		else
			f23_local1 = f23_local0:create("costString")
			f23_local1:set(f23_arg5)
		end
		f23_local1 = f23_local0:create("legalText")
		local f23_local2 = f23_local1
		f23_local1 = f23_local1.set
		if type(f23_arg6) == "string" then
			local f23_local3 = f23_arg6
		end
		f23_local1(f23_local2, f23_local3 or Engine[@"hash_4F9F1239CFD921FE"](f23_arg6))
		f23_local1 = f23_local0:create("validityPeriod")
		f23_local1:set(f23_arg14)
		f23_local1 = f23_local0:create("callback")
		f23_local1:set(f23_arg1)
		f23_local1 = f23_local0:create("cancelCallback")
		f23_local1:set(f23_arg2)
		f23_local1 = f23_local0:create("currency")
		f23_local1:set(f23_arg7)
		f23_local1 = f23_local0:create("productImage")
		f23_local1:set(f23_arg8)
		f23_local1 = f23_local0:create("largeProductImage")
		f23_local1:set(f23_arg9)
		f23_local1 = f23_local0:create("isTiers")
		f23_local1:set(f23_arg10 ~= nil)
		if f23_arg10 then
			f23_local1 = f23_local0:create("tiersToBuy")
			f23_local1:set(f23_arg10.tiers)
			f23_local1 = f23_local0:create("price")
			f23_local1:set(f23_arg10.cost)
			f23_local1 = f23_local0:create("nextTier")
			f23_local1:set(f23_arg10.nextTier)
			f23_local1 = f23_local0:create("lastTier")
			f23_local1:set(f23_arg10.lastTier)
			f23_local1 = f23_local0:create("tierRef")
			f23_local1:set(f23_arg10.tierRef)
		end
		f23_local1 = f23_local0:create("isContract")
		f23_local1:set(f23_arg15)
		f23_local1 = f23_local0:create("hasDropRates")
		f23_local1:set(f23_arg11)
		f23_local1 = f23_local0:create("hasTermsOfSale")
		f23_local1:set(f23_arg12)
		f23_local1 = f23_local0:create("hasRefundPolicy")
		f23_local1:set(f23_arg13)
		return f23_local0
	end,
	getModel = function()
		local f24_local0 = Engine.GetGlobalModel()
		return f24_local0.PCKoreaRefundWarning
	end,
}
CoD.PCKoreaUtility.DeclineRefundPopup = function(f25_arg0, f25_arg1)
	local f25_local0 = Engine.GetModel(Engine.GetGlobalModel(), "PCStoreKoreaAccepts")
	f25_local0:set(false)
	local f25_local1 = DataSources.PCKoreaRefundWarning.getModel()
	local f25_local2 = f25_local1.cancelCallback:get()
	if f25_local2 then
		f25_local2(f25_arg1)
	end
	GoBack(f25_arg0, f25_arg1)
end
DataSources.PCKoreaRefundButtons = DataSourceHelpers.ListSetup("PCKoreaRefundButtons", function(f26_arg0)
	local f26_local0 = {}
	local f26_local1 = function(f27_arg0, f27_arg1, f27_arg2)
		CoD.PCKoreaUtility.DeclineRefundPopup(f27_arg1, f27_arg2)
	end
	local f26_local2 = function(f28_arg0, f28_arg1, f28_arg2)
		local f28_local0 = Engine.GetModel(Engine.GetGlobalModel(), "PCStoreKoreaAccepts")
		if not f28_local0 then
			return
		else
			local f28_local1 = DataSources.PCKoreaRefundWarning.getModel()
			local f28_local2 = f28_local1.callback:get()
			f28_local2()
			f28_local0:set(false)
			GoBack(f28_arg0, f28_arg2)
		end
	end
	local f26_local3 = function(f29_arg0, f29_arg1, f29_arg2)
		Engine.ExecNow(f29_arg2, "ui_browser_new 2 https:\\\\support.activision.com\\servlet\\servlet.FileDownload?retURL=%2Fapex%2Fmanuals&file=00P0B000018GAugUAG")
	end
	local f26_local4 = function(f30_arg0, f30_arg1, f30_arg2)
		Engine.ExecNow(f30_arg2, "ui_browser_new 2 https:\\\\support.activision.com\\articles\\ko\\FAQ\\Call-of-Duty-Black-Ops-4-Purchases")
	end
	local f26_local5 = function(f31_arg0, f31_arg1, f31_arg2)
		Engine.ExecNow(f31_arg2, "ui_browser_new 2 https:\\\\support.activision.com\\articles\\ko\\FAQ\\Call-of-Duty-Black-Ops-4-Tiers")
	end
	local f26_local6 = function(f32_arg0, f32_arg1, f32_arg2)
		local f32_local0 = Engine.GetModel(Engine.GetGlobalModel(), "PCStoreKoreaAccepts")
		return not f32_local0:get()
	end
	local f26_local7 = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4, f33_arg5)
		return {
			models = {
				displayText = f33_arg0,
				description = f33_arg1,
				currentText = f33_arg2,
				disabledFunction = f33_arg4,
				hidden = f33_arg5,
			},
			properties = {
				action = f33_arg3,
			},
		}
	end
	local f26_local8 = DataSources.PCKoreaRefundWarning.getModel()
	table.insert(f26_local0, f26_local7(f26_local8.confirmButtonTextHash:get(), 0x0, nil, f26_local2, f26_local6, false))
	table.insert(f26_local0, f26_local7(@"menu/cancel", 0x0, nil, f26_local1, nil, false))
	local f26_local9 = {}
	if f26_local8.hasTermsOfSale:get() then
		table.insert(f26_local0, f26_local7(@"hash_38770CBF493EC79D", 0x0, nil, f26_local3, nil, false))
	else
		table.insert(f26_local9, f26_local7(@"hash_38770CBF493EC79D", 0x0, nil, f26_local3, nil, true))
	end
	if f26_local8.hasRefundPolicy:get() then
		table.insert(f26_local0, f26_local7(@"hash_54D63B43357A2C1B", 0x0, nil, f26_local4, nil, false))
	else
		table.insert(f26_local9, f26_local7(@"hash_54D63B43357A2C1B", 0x0, nil, f26_local4, nil, true))
	end
	if f26_local8.hasDropRates:get() then
		table.insert(f26_local0, f26_local7(@"hash_2B4D9AF6DB53EB97", 0x0, nil, f26_local5, nil, false))
	else
		table.insert(f26_local9, f26_local7(@"hash_2B4D9AF6DB53EB97", 0x0, nil, f26_local5, nil, true))
	end
	for f26_local13, f26_local14 in ipairs(f26_local9) do
		table.insert(f26_local0, f26_local14)
	end
	return f26_local0
end, true)
CoD.PCKoreaUtility.DisplayRefundAgreement = function(f34_arg0, f34_arg1, f34_arg2, f34_arg3, f34_arg4)
	assert(f34_arg0)
	assert(f34_arg3)
	assert(CoD.PCKoreaUtility.IsInKorea())
	local f34_local0 = true
	local f34_local1 = ""
	local f34_local2 = ""
	local f34_local3 = 0
	local f34_local4 = CoD.Currencies.COD_POINTS
	local f34_local5 = @"hash_26EAF44BE32C0CDD"
	local f34_local6 = "blacktransparent"
	local f34_local7 = "blacktransparent"
	local f34_local8 = nil
	local f34_local9 = false
	local f34_local10 = true
	local f34_local11 = true
	local f34_local12 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_58E9143913959F4A")
	local f34_local13 = false
	if f34_arg3.labElement then
		local f34_local14 = f34_arg3.labElement:getModel()
		f34_local3 = f34_local14.plasmaPrice:get()
		f34_local4 = CoD.Currencies.ZM_NEBULIUM_PLASMA
		f34_local5 = @"hash_5DD488AA68F9D69F"
		f34_local9 = true
		f34_local12 = ""
		f34_local10 = false
		f34_local11 = false
		f34_local1 = Engine[@"hash_4F9F1239CFD921FE"](f34_local14.name:get())
		f34_local2 = Engine[@"hash_4F9F1239CFD921FE"](f34_local14.description:get())
		f34_local3 = f34_local14.plasmaPrice:get()
		f34_local6 = f34_local14.icon:get()
	elseif f34_arg3.tiersElement then
		local f34_local14 = f34_arg3.tiersElement:getModel()
		f34_local1 = Engine[@"hash_4F9F1239CFD921FE"](f34_local14.tierRef:get())
		f34_local2 = f34_local14.displayText:get()
		f34_local3 = f34_local14.price:get()
		f34_local4 = CoD.Currencies.COD_POINTS
		f34_local5 = @"hash_26EAF44BE32C0CDD"
		f34_local6 = nil
		f34_local9 = true
		f34_local8 = {}
		local f34_local15 = Engine.GetModelForController(f34_arg2)
		if f34_local15.tierPurchase then
			f34_local8.nextTier = f34_local15.tierPurchase.nextTier:get()
			f34_local8.lastTier = f34_local15.tierPurchase.lastTier:get()
			local f34_local16
			if f34_arg3.tiers > 1 then
				f34_local16 = @"hash_3E874E7281061241"
				if not f34_local16 then
				else
					f34_local8.tierRef = f34_local16
				end
			end
			f34_local16 = @"hash_544F1ACF71037F65"
		end
		f34_local8.cost = f34_local3
		f34_local8.tiers = f34_local14.tiersToBuy:get()
	elseif f34_arg3.purchaseProductElement then
		f34_arg0()
		return
	elseif f34_arg3.dwSKUElement then
		local f34_local14 = f34_arg3.dwSKUElement:getModel()
		if f34_local14.price then
			local f34_local17 = f34_local14.price:get()
		end
		f34_local3 = f34_local17 or 0
		if f34_local14.desc then
			f34_local2 = f34_local14.desc:get()
		else
			f34_local2 = LocalizeIntoString(@"hash_44FD368063324203", f34_local3)
		end
		f34_local4 = CoD.Currencies.COD_POINTS
		f34_local13 = f34_arg1._isContract == true
		if f34_local13 then
			f34_local1 = Engine[@"hash_4F9F1239CFD921FE"](f34_local14.name:get())
			f34_local5 = @"hash_33C74DE804D39B0B"
			f34_local9 = true
		else
			local f34_local15 = f34_local14.name:get()
			if type(f34_local15) == "string" then
				local f34_local18 = f34_local15
			end
			f34_local1 = f34_local18 or Engine[@"hash_4F9F1239CFD921FE"](f34_local15)
			if f34_local14.isBundle and f34_local14.isBundle:get() then
				f34_local5 = @"hash_18313FD9FC60BE0E"
			else
				f34_local5 = @"hash_46546413563ED75A"
			end
		end
		if f34_local14.productImage then
			local f34_local19 = f34_local14.productImage:get()
		end
		if f34_local14.icon then
			local f34_local20 = f34_local14.icon:get()
		end
		if f34_local14.popupImage then
			local f34_local21 = f34_local14.popupImage:get()
		end
		f34_local6 = f34_local14.primaryImage and (f34_local21 or f34_local20 or f34_local19 or f34_local14.primaryImage:get())
		if f34_arg1.__isPlasmaPurchase then
			f34_local5 = 0xF722F0964E5733
			f34_local9 = true
		end
	elseif f34_arg3.lootCrateElement then
		local f34_local14 = f34_arg3.lootCrateElement:getModel()
		f34_local5 = @"hash_26EAF44BE32C0CDD"
		f34_local1 = Engine[@"hash_4F9F1239CFD921FE"](f34_local14.itemName:get())
		f34_local2 = f34_local14.displayText:get()
		f34_local3 = f34_local14.itemPrice:get()
		f34_local7 = f34_local14.itemImage:get()
		f34_local9 = true
	else
		f34_local0 = false
	end
	local f34_local14 = nil
	if f34_local0 then
		local f34_local15
		if f34_local4 == CoD.Currencies.ZM_NEBULIUM_PLASMA then
			f34_local15 = 0xAEF142C6427F8A
			if not f34_local15 then
			else
				f34_local14 = DataSources.PCKoreaRefundWarning.prepare(f34_arg2, f34_arg0, f34_arg4, f34_local1, f34_local2, f34_local3, f34_local5, f34_local4, f34_local6, f34_local7, f34_local8, f34_local9, f34_local10, f34_local11, f34_local12, f34_local13, f34_local15)
			end
		end
		f34_local15 = @"hash_C09F059EB45B00F"
	end
	if f34_local14 then
		local f34_local15 = OpenPopup(f34_arg1, "PC_Store_Refund_Korea", f34_arg2)
		f34_local15:setModel(f34_local14, f34_arg2)
	else
		f34_arg0()
	end
end
