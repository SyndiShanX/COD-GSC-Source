require("x64:9b528a05aba52d6")
require("x64:79a2abecba85306")
require("x64:93604c7b6b216ac")
require("x64:137eb392d404a1a")
require("x64:67940364f14a232")
CoD.ItemShopFrameInternal = InheritFrom(LUI.UIElement)
CoD.ItemShopFrameInternal.__defaultWidth = 1920
CoD.ItemShopFrameInternal.__defaultHeight = 1080
CoD.ItemShopFrameInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopFrameInternal)
	self.id = "ItemShopFrameInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local DailyListLabel = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -248, 107, 0.5, 0.5, -361, -311)
	DailyListLabel:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot3_timer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DailyListLabel.TextBox2:setText(LocalizeIntoStringIfNotEmpty(0xC0CE2452CF87DB1, f2_local0))
		end
	end)
	self:addElement(DailyListLabel)
	self.DailyListLabel = DailyListLabel
	local FeaturedListLabel = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -835, -593, 0, 0, 178, 228)
	FeaturedListLabel:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot1_timer", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FeaturedListLabel.TextBox2:setText(LocalizeIntoStringIfNotEmpty(0xC0CE2452CF87DB1, f3_local0))
		end
	end)
	self:addElement(FeaturedListLabel)
	self.FeaturedListLabel = FeaturedListLabel
	local FeaturedListLabel2 = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -563, -321, 0, 0, 178, 228)
	FeaturedListLabel2:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot2_timer", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			FeaturedListLabel2.TextBox2:setText(LocalizeIntoStringIfNotEmpty(0xC0CE2452CF87DB1, f4_local0))
		end
	end)
	self:addElement(FeaturedListLabel2)
	self.FeaturedListLabel2 = FeaturedListLabel2
	local DailyItems = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, false, false, false, false)
	DailyItems:setLeftRight(0.5, 0.5, -248, 262)
	DailyItems:setTopBottom(0.5, 0.5, -319, 191)
	DailyItems:setWidgetType(CoD.PurchaseableItem)
	DailyItems:setHorizontalCount(2)
	DailyItems:setVerticalCount(2)
	DailyItems:setSpacing(30)
	DailyItems:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DailyItems:setDataSource("ItemShopList")
	DailyItems:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		return f5_local0
	end)
	DailyItems:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DailyItems, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	DailyItems:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f9_local0 = DailyItems
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f9_local0, true, true, true)
		end
	end)
	self:addElement(DailyItems)
	self.DailyItems = DailyItems
	local FeaturedItems = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, false, false, false, false)
	FeaturedItems:setLeftRight(0.5, 0.5, -834, -324)
	FeaturedItems:setTopBottom(0.5, 0.5, -319, 191)
	FeaturedItems:setWidgetType(CoD.PurchaseableItem)
	FeaturedItems:setHorizontalCount(2)
	FeaturedItems:setVerticalCount(2)
	FeaturedItems:setSpacing(30)
	FeaturedItems:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FeaturedItems:setDataSource("ItemShopFeaturedList")
	FeaturedItems:registerEventHandler("list_item_gain_focus", function(element, event)
		local f10_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		return f10_local0
	end)
	FeaturedItems:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FeaturedItems, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x85952ACC6D0C1B0, nil, nil)
		return true
	end, false)
	FeaturedItems:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f14_local0 = FeaturedItems
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f14_local0, true, true, true)
		end
	end)
	self:addElement(FeaturedItems)
	self.FeaturedItems = FeaturedItems
	local BottomBracket9Slice2 = LUI.UIImage.new(0.5, 0.5, -255, 270, 0, 0, 176, 185)
	BottomBracket9Slice2:setAlpha(0.5)
	BottomBracket9Slice2:setZRot(180)
	BottomBracket9Slice2:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket9Slice2:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice2:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice2)
	self.BottomBracket9Slice2 = BottomBracket9Slice2
	local TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -835, -605, 0, 0, 921, 991)
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkBlackmarket(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkBlackmarket(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(TransactionDeepLinkButton)
	self.TransactionDeepLinkButton = TransactionDeepLinkButton
	local infoBracketBot = LUI.UIImage.new(0.5, 0.5, -841, -316, 0, 0, 176, 184)
	infoBracketBot:setRGB(0.98, 1, 0.89)
	infoBracketBot:setAlpha(0.35)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local SupplyChainDetails = CoD.ContractSupplyChainDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, 310, 910, 0, 0, -79, 1001)
	SupplyChainDetails:mergeStateConditions({
		{
			stateName = "NoInfoPanel",
			condition = function(menu, element, event)
				local f20_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f20_local0 = AlwaysFalse()
				else
					f20_local0 = false
				end
				return f20_local0
			end,
		},
	})
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "name", true, function(model)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	SupplyChainDetails:appendEventHandler("input_source_changed", function(f22_arg0, f22_arg1)
		f22_arg1.menu = f22_arg1.menu or f1_arg0
		f1_arg0:updateElementState(SupplyChainDetails, f22_arg1)
	end)
	local TextBox = SupplyChainDetails
	local TextBox2 = SupplyChainDetails.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	TextBox2(TextBox, f1_local12.LastInput, function(f23_arg0)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "character", true, function(model)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "character",
		})
	end)
	SupplyChainDetails:linkToElementModel(SupplyChainDetails, "weaponRef", true, function(model)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponRef",
		})
	end)
	self:addElement(SupplyChainDetails)
	self.SupplyChainDetails = SupplyChainDetails
	TextBox2 = LUI.UIText.new(0.5, 0.5, -835, -480, 0, 0, 152, 170)
	TextBox2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TextBox2:setText(LocalizeToUpperString(0x169F716D6484E8A))
	TextBox2:setTTF("ttmussels_regular")
	TextBox2:setLetterSpacing(4)
	TextBox2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox2:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox2)
	self.TextBox2 = TextBox2
	TextBox = LUI.UIText.new(0.5, 0.5, -249, 106, 0, 0, 152, 170)
	TextBox:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TextBox:setText(LocalizeToUpperString(0xDE9B59A6E570A4B))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setLetterSpacing(4)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "RefreshDWInventoryMenu", function(model)
		local f26_local0 = self
		UpdateDataSource(self, self.DailyItems, f1_arg1)
		UpdateDataSource(self, self.FeaturedItems, f1_arg1)
	end)
	DailyItems.id = "DailyItems"
	FeaturedItems.id = "FeaturedItems"
	if CoD.isPC then
		TransactionDeepLinkButton.id = "TransactionDeepLinkButton"
	end
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	SendClientScriptMenuChangeNotifyWithState(f1_arg1, f1_arg0, true, "character")
	f1_local12 = TransactionDeepLinkButton
	if IsPC() and not CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
		ReplaceElementWithFake(self, "TransactionDeepLinkButton")
	end
	return self
end
CoD.ItemShopFrameInternal.__onClose = function(f27_arg0)
	f27_arg0.DailyListLabel:close()
	f27_arg0.FeaturedListLabel:close()
	f27_arg0.FeaturedListLabel2:close()
	f27_arg0.DailyItems:close()
	f27_arg0.FeaturedItems:close()
	f27_arg0.TransactionDeepLinkButton:close()
	f27_arg0.SupplyChainDetails:close()
end
