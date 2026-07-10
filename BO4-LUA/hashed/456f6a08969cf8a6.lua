require("x64:9b528a05aba52d6")
require("x64:79a2abecba85306")
require("x64:93604c7b6b216ac")
require("x64:137eb392d404a1a")
require("x64:67940364f14a232")
CoD.ItemShopFrame = InheritFrom(LUI.UIElement)
CoD.ItemShopFrame.__defaultWidth = 1920
CoD.ItemShopFrame.__defaultHeight = 1080
CoD.ItemShopFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopFrame)
	self.id = "ItemShopFrame"
	self.soundSet = "ItemShop"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local WeeklyItemsTimer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -835, -593, 0.5, 0.5, -362, -312)
	WeeklyItemsTimer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot1_timer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeeklyItemsTimer.TextBox2:setText(f2_local0)
		end
	end)
	self:addElement(WeeklyItemsTimer)
	self.WeeklyItemsTimer = WeeklyItemsTimer
	local WeeklyItems = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, false, false, false, false)
	WeeklyItems:setLeftRight(0.5, 0.5, -834, -594)
	WeeklyItems:setTopBottom(0.5, 0.5, -319, 191)
	WeeklyItems:setWidgetType(CoD.PurchaseableItem)
	WeeklyItems:setVerticalCount(2)
	WeeklyItems:setSpacing(30)
	WeeklyItems:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WeeklyItems:setDataSource("ItemShopFeaturedList")
	WeeklyItems:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f3_local0
	end)
	WeeklyItems:registerEventHandler("list_item_lose_focus", function(element, event)
		local f4_local0 = nil
		CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		return f4_local0
	end)
	WeeklyItems:registerEventHandler("occlusion_change", function(element, event)
		local f5_local0 = nil
		if element.OcclusionChange then
			f5_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f5_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	WeeklyItems:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeeklyItems, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	WeeklyItems:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f9_local0 = WeeklyItems
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f9_local0, true, true, true)
		end
	end)
	self:addElement(WeeklyItems)
	self.WeeklyItems = WeeklyItems
	local WeeklyItemsBracket = LUI.UIImage.new(0.5, 0.5, -841, -586, 0.5, 0.5, -364, -356)
	WeeklyItemsBracket:setRGB(0.98, 1, 0.89)
	WeeklyItemsBracket:setAlpha(0.35)
	WeeklyItemsBracket:setZRot(180)
	WeeklyItemsBracket:setImage(RegisterImage(0xC325BED3F226657))
	WeeklyItemsBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	WeeklyItemsBracket:setShaderVector(0, 0, 0, 0, 0)
	WeeklyItemsBracket:setupNineSliceShader(16, 4)
	self:addElement(WeeklyItemsBracket)
	self.WeeklyItemsBracket = WeeklyItemsBracket
	local WeeklyItemsLabel = LUI.UIText.new(0.5, 0.5, -835, -595, 0.5, 0.5, -388, -370)
	WeeklyItemsLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	WeeklyItemsLabel:setText(LocalizeToUpperString(0x5F57FAD08B3728F))
	WeeklyItemsLabel:setTTF("ttmussels_regular")
	WeeklyItemsLabel:setLetterSpacing(4)
	WeeklyItemsLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WeeklyItemsLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WeeklyItemsLabel)
	self.WeeklyItemsLabel = WeeklyItemsLabel
	local BiweeklyItemsTimer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -546, -34, 0.5, 0.5, -362, -312)
	BiweeklyItemsTimer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot2_timer", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			BiweeklyItemsTimer.TextBox2:setText(f10_local0)
		end
	end)
	self:addElement(BiweeklyItemsTimer)
	self.BiweeklyItemsTimer = BiweeklyItemsTimer
	local ByweeklyFeatureItems = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, false, false, false, false)
	ByweeklyFeatureItems:setLeftRight(0.5, 0.5, -545, -305)
	ByweeklyFeatureItems:setTopBottom(0.5, 0.5, -319, 191)
	ByweeklyFeatureItems:setWidgetType(CoD.PurchaseableItem)
	ByweeklyFeatureItems:setVerticalCount(2)
	ByweeklyFeatureItems:setSpacing(30)
	ByweeklyFeatureItems:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ByweeklyFeatureItems:setDataSource("ItemShopBiweeklyFeaturedList")
	ByweeklyFeatureItems:registerEventHandler("list_item_gain_focus", function(element, event)
		local f11_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f11_local0
	end)
	ByweeklyFeatureItems:registerEventHandler("list_item_lose_focus", function(element, event)
		local f12_local0 = nil
		CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		return f12_local0
	end)
	ByweeklyFeatureItems:registerEventHandler("occlusion_change", function(element, event)
		local f13_local0 = nil
		if element.OcclusionChange then
			f13_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f13_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f13_local0 then
			f13_local0 = element:dispatchEventToChildren(event)
		end
		return f13_local0
	end)
	ByweeklyFeatureItems:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ByweeklyFeatureItems, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	ByweeklyFeatureItems:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f17_local0 = ByweeklyFeatureItems
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f17_local0, true, true, true)
		end
	end)
	self:addElement(ByweeklyFeatureItems)
	self.ByweeklyFeatureItems = ByweeklyFeatureItems
	local ByweeklyItems = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, false, false, false, false)
	ByweeklyItems:setLeftRight(0.5, 0.5, -275, -35)
	ByweeklyItems:setTopBottom(0.5, 0.5, -319, 191)
	ByweeklyItems:setWidgetType(CoD.PurchaseableItem)
	ByweeklyItems:setVerticalCount(2)
	ByweeklyItems:setSpacing(30)
	ByweeklyItems:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ByweeklyItems:setDataSource("ItemShopBiweeklyList")
	ByweeklyItems:registerEventHandler("list_item_gain_focus", function(element, event)
		local f18_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f18_local0
	end)
	ByweeklyItems:registerEventHandler("list_item_lose_focus", function(element, event)
		local f19_local0 = nil
		CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		return f19_local0
	end)
	ByweeklyItems:registerEventHandler("occlusion_change", function(element, event)
		local f20_local0 = nil
		if element.OcclusionChange then
			f20_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f20_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f20_local0 then
			f20_local0 = element:dispatchEventToChildren(event)
		end
		return f20_local0
	end)
	ByweeklyItems:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f21_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ByweeklyItems, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	ByweeklyItems:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f24_local0 = ByweeklyItems
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f24_local0, true, true, true)
		end
	end)
	self:addElement(ByweeklyItems)
	self.ByweeklyItems = ByweeklyItems
	local ByweeklyItemsBracket = LUI.UIImage.new(0.5, 0.5, -552, -27, 0.5, 0.5, -364, -355)
	ByweeklyItemsBracket:setAlpha(0.5)
	ByweeklyItemsBracket:setZRot(180)
	ByweeklyItemsBracket:setImage(RegisterImage(0xC325BED3F226657))
	ByweeklyItemsBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ByweeklyItemsBracket:setShaderVector(0, 0, 0, 0, 0)
	ByweeklyItemsBracket:setupNineSliceShader(16, 4)
	self:addElement(ByweeklyItemsBracket)
	self.ByweeklyItemsBracket = ByweeklyItemsBracket
	local BiweeklyItemsLabel = LUI.UIText.new(0.5, 0.5, -546, -34, 0.5, 0.5, -388, -370)
	BiweeklyItemsLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BiweeklyItemsLabel:setText(LocalizeToUpperString(0x4A06F9DA99ECD3A))
	BiweeklyItemsLabel:setTTF("ttmussels_regular")
	BiweeklyItemsLabel:setLetterSpacing(4)
	BiweeklyItemsLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	BiweeklyItemsLabel:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(BiweeklyItemsLabel)
	self.BiweeklyItemsLabel = BiweeklyItemsLabel
	local DailyItemsTimer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, 24, 266, 0.5, 0.5, -362, -312)
	DailyItemsTimer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot5_timer", function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			DailyItemsTimer.TextBox2:setText(f25_local0)
		end
	end)
	self:addElement(DailyItemsTimer)
	self.DailyItemsTimer = DailyItemsTimer
	local DailyItems = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, false, false, false, false)
	DailyItems:setLeftRight(0.5, 0.5, 22, 262)
	DailyItems:setTopBottom(0.5, 0.5, -319, 191)
	DailyItems:setWidgetType(CoD.PurchaseableItem)
	DailyItems:setVerticalCount(2)
	DailyItems:setSpacing(30)
	DailyItems:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DailyItems:setDataSource("ItemShopList")
	DailyItems:registerEventHandler("list_item_gain_focus", function(element, event)
		local f26_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f26_local0
	end)
	DailyItems:registerEventHandler("list_item_lose_focus", function(element, event)
		local f27_local0 = nil
		CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		return f27_local0
	end)
	DailyItems:registerEventHandler("occlusion_change", function(element, event)
		local f28_local0 = nil
		if element.OcclusionChange then
			f28_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f28_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f28_local0 then
			f28_local0 = element:dispatchEventToChildren(event)
		end
		return f28_local0
	end)
	DailyItems:registerEventHandler("gain_focus", function(element, event)
		local f29_local0 = nil
		if element.gainFocus then
			f29_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f29_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f29_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DailyItems, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	DailyItems:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f32_local0 = DailyItems
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f32_local0, true, true, true)
		end
	end)
	self:addElement(DailyItems)
	self.DailyItems = DailyItems
	local DailyItemsBracket = LUI.UIImage.new(0.5, 0.5, -841, -586, 0.5, 0.5, -364, -355)
	DailyItemsBracket:setAlpha(0.5)
	DailyItemsBracket:setZRot(180)
	DailyItemsBracket:setImage(RegisterImage(0xC325BED3F226657))
	DailyItemsBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	DailyItemsBracket:setShaderVector(0, 0, 0, 0, 0)
	DailyItemsBracket:setupNineSliceShader(16, 4)
	self:addElement(DailyItemsBracket)
	self.DailyItemsBracket = DailyItemsBracket
	local DailyItemsLabel = LUI.UIText.new(0.5, 0.5, 22, 262, 0.5, 0.5, -388, -370)
	DailyItemsLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DailyItemsLabel:setText(LocalizeToUpperString(0xDE9B59A6E570A4B))
	DailyItemsLabel:setTTF("ttmussels_regular")
	DailyItemsLabel:setLetterSpacing(4)
	DailyItemsLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DailyItemsLabel:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(DailyItemsLabel)
	self.DailyItemsLabel = DailyItemsLabel
	local TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -835, -605, 0, 0, 921, 991)
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f33_local0 = nil
		if element.gainFocus then
			f33_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f33_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f33_local0
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
	local SupplyChainDetails = CoD.ContractSupplyChainDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, 310, 910, 0.5, 0.5, -619, 461)
	SupplyChainDetails:mergeStateConditions({
		{
			stateName = "NoInfoPanel",
			condition = function(menu, element, event)
				local f38_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f38_local0 = AlwaysFalse()
				else
					f38_local0 = false
				end
				return f38_local0
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
	SupplyChainDetails:appendEventHandler("input_source_changed", function(f40_arg0, f40_arg1)
		f40_arg1.menu = f40_arg1.menu or f1_arg0
		f1_arg0:updateElementState(SupplyChainDetails, f40_arg1)
	end)
	local f1_local16 = SupplyChainDetails
	local f1_local17 = SupplyChainDetails.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18.LastInput, function(f41_arg0)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
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
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "RefreshDWInventoryMenu", function(model)
		local f44_local0 = self
		UpdateDataSource(self, self.DailyItems, f1_arg1)
		UpdateDataSource(self, self.WeeklyItems, f1_arg1)
		UpdateDataSource(self, self.ByweeklyItems, f1_arg1)
		UpdateDataSource(self, self.ByweeklyFeatureItems, f1_arg1)
	end)
	WeeklyItems.id = "WeeklyItems"
	ByweeklyFeatureItems.id = "ByweeklyFeatureItems"
	ByweeklyItems.id = "ByweeklyItems"
	DailyItems.id = "DailyItems"
	if CoD.isPC then
		TransactionDeepLinkButton.id = "TransactionDeepLinkButton"
	end
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	self.__defaultFocus = WeeklyItems
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local17 = self
	SendClientScriptMenuChangeNotifyWithState(f1_arg1, f1_arg0, true, "character")
	SetMenuProperty(f1_arg0, "__hideSupplyChainDetailsButtons", true)
	f1_local17 = TransactionDeepLinkButton
	if IsPC() and not CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
		ReplaceElementWithFake(self, "TransactionDeepLinkButton")
	end
	return self
end
CoD.ItemShopFrame.__onClose = function(f45_arg0)
	f45_arg0.WeeklyItemsTimer:close()
	f45_arg0.WeeklyItems:close()
	f45_arg0.BiweeklyItemsTimer:close()
	f45_arg0.ByweeklyFeatureItems:close()
	f45_arg0.ByweeklyItems:close()
	f45_arg0.DailyItemsTimer:close()
	f45_arg0.DailyItems:close()
	f45_arg0.TransactionDeepLinkButton:close()
	f45_arg0.SupplyChainDetails:close()
end
