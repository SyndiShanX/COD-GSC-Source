require("x64:2fa26438cae31e9")
require("x64:7a4ceca81c49387")
require("x64:9b528a05aba52d6")
require("x64:ffbc64370f13dd9")
require("x64:67940364f14a232")
require("x64:b25db840a191172")
require("x64:79a2abecba85306")
require("x64:c8666fff462a645")
require("x64:93604c7b6b216ac")
require("x64:35653ef4ad2299d")
require("x64:b1b346e32476a2e")
CoD.BlackMarketItemShopFrame = InheritFrom(LUI.UIElement)
CoD.BlackMarketItemShopFrame.__defaultWidth = 1920
CoD.BlackMarketItemShopFrame.__defaultHeight = 1080
CoD.BlackMarketItemShopFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg1, "BlackjackShopIntroduction")
	self:setClass(CoD.BlackMarketItemShopFrame)
	self.id = "BlackMarketItemShopFrame"
	self.soundSet = "ItemShop"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FeaturedSlot1Timer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -841, -599, 0.5, 0.5, -369, -319)
	FeaturedSlot1Timer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot1_timer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FeaturedSlot1Timer.TextBox2:setText(f2_local0)
		end
	end)
	self:addElement(FeaturedSlot1Timer)
	self.FeaturedSlot1Timer = FeaturedSlot1Timer
	local NoMyShopOffers = LUI.UIText.new(0.5, 0.5, 12, 252, 0.5, 0.5, -218.5, -181.5)
	NoMyShopOffers:setText(Engine[0xF9F1239CFD921FE](0x40A4373BEE19526))
	NoMyShopOffers:setTTF("default")
	NoMyShopOffers:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NoMyShopOffers:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(NoMyShopOffers)
	self.NoMyShopOffers = NoMyShopOffers
	local FeaturedSlot1 = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	FeaturedSlot1:setLeftRight(0.5, 0.5, -840, -600)
	FeaturedSlot1:setTopBottom(0.5, 0.5, -319, 191)
	FeaturedSlot1:setWidgetType(CoD.BMTallItemContainer)
	FeaturedSlot1:setSpacing(30)
	FeaturedSlot1:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FeaturedSlot1:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	FeaturedSlot1:setDataSource("ItemShopSlot1List")
	FeaturedSlot1:linkToElementModel(FeaturedSlot1, "movieName", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	FeaturedSlot1:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	local FeaturedLabel = FeaturedSlot1
	local SpecialOrdersBracket = FeaturedSlot1.subscribeToModel
	local FeaturedSlot2Timer = Engine[0x4DF5CFBC1771947](f1_arg1)
	SpecialOrdersBracket(FeaturedLabel, FeaturedSlot2Timer.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	FeaturedSlot1:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f6_local0
	end)
	FeaturedSlot1:registerEventHandler("occlusion_change", function(element, event)
		local f7_local0 = nil
		if element.OcclusionChange then
			f7_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f7_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	FeaturedSlot1:registerEventHandler("gain_list_focus", function(element, event)
		local f8_local0 = nil
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, self.FeaturedSlot1)
		return f8_local0
	end)
	FeaturedSlot1:registerEventHandler("lose_list_focus", function(element, event)
		local f9_local0 = nil
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, self.FeaturedSlot1)
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		return f9_local0
	end)
	FeaturedSlot1:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		OpenOverlay(self, "BlackMarketBountyDetails", controller, {
			_model = element:getModel(),
		})
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x52FB29ED3A3CA79, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x0, nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(FeaturedSlot1, "updateDataSource", function(element, controller, f21_arg2, f21_arg3)
		if CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) then
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		end
	end)
	FeaturedSlot1:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f22_local0 = FeaturedSlot1
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f22_local0, true, true, true)
		end
	end)
	FeaturedSlot1:AddContextualMenuAction(f1_arg0, f1_arg1, 0x52FB29ED3A3CA79, function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f23_arg0, f23_arg2, "movieName") then
			return function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
				SetControllerModelValue(f24_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f24_arg2, f24_arg0, "")
				DelayOpenOverlay(f24_arg1, "VoDViewer", f24_arg2, {
					fullscreen = true,
				})
			end
		else
		end
	end)
	self:addElement(FeaturedSlot1)
	self.FeaturedSlot1 = FeaturedSlot1
	SpecialOrdersBracket = LUI.UIImage.new(0.5, 0.5, -277, -27, 0.5, 0.5, -364, -356)
	SpecialOrdersBracket:setRGB(0.98, 1, 0.89)
	SpecialOrdersBracket:setAlpha(0.5)
	SpecialOrdersBracket:setZRot(180)
	SpecialOrdersBracket:setImage(RegisterImage(0xC325BED3F226657))
	SpecialOrdersBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	SpecialOrdersBracket:setShaderVector(0, 0, 0, 0, 0)
	SpecialOrdersBracket:setupNineSliceShader(16, 4)
	self:addElement(SpecialOrdersBracket)
	self.SpecialOrdersBracket = SpecialOrdersBracket
	FeaturedLabel = LUI.UIText.new(0.5, 0.5, -845, -605, 0.5, 0.5, -388, -370)
	FeaturedLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FeaturedLabel:setText(LocalizeToUpperString(0xF29BEFC80072FF5))
	FeaturedLabel:setTTF("ttmussels_regular")
	FeaturedLabel:setLetterSpacing(4)
	FeaturedLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FeaturedLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(FeaturedLabel)
	self.FeaturedLabel = FeaturedLabel
	FeaturedSlot2Timer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -557, -316, 0.5, 0.5, -369, -319)
	FeaturedSlot2Timer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot2_timer", function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			FeaturedSlot2Timer.TextBox2:setText(f25_local0)
		end
	end)
	self:addElement(FeaturedSlot2Timer)
	self.FeaturedSlot2Timer = FeaturedSlot2Timer
	local FeaturedSlot2 = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	FeaturedSlot2:setLeftRight(0.5, 0.5, -556, -316)
	FeaturedSlot2:setTopBottom(0.5, 0.5, -319, 191)
	FeaturedSlot2:setWidgetType(CoD.BMTallItemContainer)
	FeaturedSlot2:setSpacing(30)
	FeaturedSlot2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FeaturedSlot2:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	FeaturedSlot2:setDataSource("ItemShopSlot2List")
	FeaturedSlot2:linkToElementModel(FeaturedSlot2, "movieName", true, function(model, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	FeaturedSlot2:appendEventHandler("input_source_changed", function(f27_arg0, f27_arg1)
		f27_arg1.menu = f27_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f27_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f27_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	local FeaturedItemsBracket = FeaturedSlot2
	local SpecialOrders = FeaturedSlot2.subscribeToModel
	local SpecialOrdersLabel = Engine[0x4DF5CFBC1771947](f1_arg1)
	SpecialOrders(FeaturedItemsBracket, SpecialOrdersLabel.LastInput, function(f28_arg0, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	FeaturedSlot2:registerEventHandler("list_item_gain_focus", function(element, event)
		local f29_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f29_local0
	end)
	FeaturedSlot2:registerEventHandler("occlusion_change", function(element, event)
		local f30_local0 = nil
		if element.OcclusionChange then
			f30_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f30_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f30_local0 then
			f30_local0 = element:dispatchEventToChildren(event)
		end
		return f30_local0
	end)
	FeaturedSlot2:registerEventHandler("lose_list_focus", function(element, event)
		local f31_local0 = nil
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, self.FeaturedSlot2)
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		return f31_local0
	end)
	FeaturedSlot2:registerEventHandler("gain_list_focus", function(element, event)
		local f32_local0 = nil
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, self.FeaturedSlot2)
		return f32_local0
	end)
	FeaturedSlot2:registerEventHandler("gain_focus", function(element, event)
		local f33_local0 = nil
		if element.gainFocus then
			f33_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f33_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		return f33_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		OpenOverlay(self, "BlackMarketBountyDetails", controller, {
			_model = element:getModel(),
		})
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x52FB29ED3A3CA79, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x0, nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(FeaturedSlot2, "updateDataSource", function(element, controller, f44_arg2, f44_arg3)
		if CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) then
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		end
	end)
	FeaturedSlot2:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f45_local0 = FeaturedSlot2
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f45_local0, true, true, true)
		end
	end)
	FeaturedSlot2:AddContextualMenuAction(f1_arg0, f1_arg1, 0x52FB29ED3A3CA79, function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f46_arg0, f46_arg2, "movieName") then
			return function(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
				SetControllerModelValue(f47_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f47_arg2, f47_arg0, "")
				DelayOpenOverlay(f47_arg1, "VoDViewer", f47_arg2, {
					fullscreen = true,
				})
			end
		else
		end
	end)
	self:addElement(FeaturedSlot2)
	self.FeaturedSlot2 = FeaturedSlot2
	SpecialOrders = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	SpecialOrders:setLeftRight(0.5, 0.5, -272, -32)
	SpecialOrders:setTopBottom(0.5, 0.5, -319, 191)
	SpecialOrders:setWidgetType(CoD.BMTallItemContainer)
	SpecialOrders:setSpacing(30)
	SpecialOrders:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SpecialOrders:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	SpecialOrders:setDataSource("ItemShopSlot3List")
	SpecialOrders:linkToElementModel(SpecialOrders, "movieName", true, function(model, f48_arg1)
		CoD.Menu.UpdateButtonShownState(f48_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f48_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	SpecialOrders:appendEventHandler("input_source_changed", function(f49_arg0, f49_arg1)
		f49_arg1.menu = f49_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f49_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f49_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	SpecialOrdersLabel = SpecialOrders
	FeaturedItemsBracket = SpecialOrders.subscribeToModel
	local MyShopTimer = Engine[0x4DF5CFBC1771947](f1_arg1)
	FeaturedItemsBracket(SpecialOrdersLabel, MyShopTimer.LastInput, function(f50_arg0, f50_arg1)
		CoD.Menu.UpdateButtonShownState(f50_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f50_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	SpecialOrders:registerEventHandler("list_item_gain_focus", function(element, event)
		local f51_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f51_local0
	end)
	SpecialOrders:registerEventHandler("occlusion_change", function(element, event)
		local f52_local0 = nil
		if element.OcclusionChange then
			f52_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f52_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f52_local0 then
			f52_local0 = element:dispatchEventToChildren(event)
		end
		return f52_local0
	end)
	SpecialOrders:registerEventHandler("lose_list_focus", function(element, event)
		local f53_local0 = nil
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, self.SpecialOrders)
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		return f53_local0
	end)
	SpecialOrders:registerEventHandler("gain_list_focus", function(element, event)
		local f54_local0 = nil
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, self.SpecialOrders)
		return f54_local0
	end)
	SpecialOrders:registerEventHandler("gain_focus", function(element, event)
		local f55_local0 = nil
		if element.gainFocus then
			f55_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f55_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		return f55_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		CoD.ContractUtility.OpenContractDetails(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x52FB29ED3A3CA79, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x0, nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(SpecialOrders, "updateDataSource", function(element, controller, f66_arg2, f66_arg3)
		if CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) then
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		end
	end)
	SpecialOrders:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f67_local0 = SpecialOrders
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f67_local0, true, true, true)
		end
	end)
	SpecialOrders:AddContextualMenuAction(f1_arg0, f1_arg1, 0x52FB29ED3A3CA79, function(f68_arg0, f68_arg1, f68_arg2, f68_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f68_arg0, f68_arg2, "movieName") then
			return function(f69_arg0, f69_arg1, f69_arg2, f69_arg3)
				SetControllerModelValue(f69_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f69_arg2, f69_arg0, "")
				DelayOpenOverlay(f69_arg1, "VoDViewer", f69_arg2, {
					fullscreen = true,
				})
			end
		else
		end
	end)
	self:addElement(SpecialOrders)
	self.SpecialOrders = SpecialOrders
	FeaturedItemsBracket = LUI.UIImage.new(0.5, 0.5, -846, -311, 0.5, 0.5, -364, -356)
	FeaturedItemsBracket:setAlpha(0.5)
	FeaturedItemsBracket:setZRot(180)
	FeaturedItemsBracket:setImage(RegisterImage(0xC325BED3F226657))
	FeaturedItemsBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FeaturedItemsBracket:setShaderVector(0, 0, 0, 0, 0)
	FeaturedItemsBracket:setupNineSliceShader(16, 4)
	self:addElement(FeaturedItemsBracket)
	self.FeaturedItemsBracket = FeaturedItemsBracket
	SpecialOrdersLabel = LUI.UIText.new(0.5, 0.5, -277, -36, 0.5, 0.5, -388, -370)
	SpecialOrdersLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SpecialOrdersLabel:setText(LocalizeToUpperString(0xD3C4B3D8C22E57C))
	SpecialOrdersLabel:setTTF("ttmussels_regular")
	SpecialOrdersLabel:setLetterSpacing(4)
	SpecialOrdersLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SpecialOrdersLabel:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(SpecialOrdersLabel)
	self.SpecialOrdersLabel = SpecialOrdersLabel
	MyShopTimer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, 11, 253, 0.5, 0.5, -369, -319)
	MyShopTimer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot4_timer", function(model)
		local f70_local0 = model:get()
		if f70_local0 ~= nil then
			MyShopTimer.TextBox2:setText(f70_local0)
		end
	end)
	self:addElement(MyShopTimer)
	self.MyShopTimer = MyShopTimer
	local SpecialOrdersTimer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -273, -33, 0.5, 0.5, -369, -319)
	SpecialOrdersTimer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot3_timer", function(model)
		local f71_local0 = model:get()
		if f71_local0 ~= nil then
			SpecialOrdersTimer.TextBox2:setText(f71_local0)
		end
	end)
	self:addElement(SpecialOrdersTimer)
	self.SpecialOrdersTimer = SpecialOrdersTimer
	local MyShop = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	MyShop:setLeftRight(0.5, 0.5, 12, 252)
	MyShop:setTopBottom(0.5, 0.5, -319, 191)
	MyShop:setWidgetType(CoD.BMTallItemContainer)
	MyShop:setSpacing(30)
	MyShop:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MyShop:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	MyShop:setDataSource("MyShopItemList")
	MyShop:linkToElementModel(MyShop, "lootType", true, function(model, f72_arg1)
		CoD.Menu.UpdateButtonShownState(f72_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	MyShop:registerEventHandler("list_item_lose_focus", function(element, event)
		local f73_local0 = nil
		CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		return f73_local0
	end)
	MyShop:registerEventHandler("occlusion_change", function(element, event)
		local f74_local0 = nil
		if element.OcclusionChange then
			f74_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f74_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
			CoD.GridAndListUtility.UpdateDataSource(element, true, true, true)
		end
		if not f74_local0 then
			f74_local0 = element:dispatchEventToChildren(event)
		end
		return f74_local0
	end)
	MyShop:registerEventHandler("lose_list_focus", function(element, event)
		local f75_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		return f75_local0
	end)
	MyShop:registerEventHandler("list_item_gain_focus", function(element, event)
		local f76_local0 = nil
		if not IsListElementChildInState(element, "BMTallItem", "MysteryItem") then
			SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		end
		return f76_local0
	end)
	MyShop:registerEventHandler("gain_focus", function(element, event)
		local f77_local0 = nil
		if element.gainFocus then
			f77_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f77_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		return f77_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MyShop, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) and IsListElementChildInState(element, "BMTallItem", "DefaultState") then
			CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			OpenOverlay(self, "ItemShopDetails", controller, {
				_model = element:getModel(),
			})
			return true
		elseif IsListElementChildInState(element, "BMTallItem", "MysteryItem") then
			PlaySoundAlias("uin_toggle_generic")
			CoD.BlackMarketUtility.RevealMyShopItem(controller, self.MyShop)
			return true
		elseif IsListElementChildInState(element, "BMTallItem", "DefaultState") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) then
			PlaySoundAlias("uin_toggle_generic")
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.ContractUtility.OpenContractDetails(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) and IsListElementChildInState(element, "BMTallItem", "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif IsListElementChildInState(element, "BMTallItem", "MysteryItem") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif IsListElementChildInState(element, "BMTallItem", "DefaultState") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(MyShop, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x0, nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(MyShop, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(MyShop, "updateDataSource", function(element, controller, f84_arg2, f84_arg3)
		if CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.EMPTY) then
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
			SetAlpha(self.MyShopTimer, 0)
		elseif CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.EMPTY) then
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
			SetAlpha(self.MyShopTimer, 1)
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.EMPTY) then
			SetAlpha(self.MyShopTimer, 0)
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.EMPTY) then
			SetAlpha(self.MyShopTimer, 1)
		end
	end)
	MyShop:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f85_local0 = MyShop
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f85_local0, true, true, true)
		end
	end)
	self:addElement(MyShop)
	self.MyShop = MyShop
	local MyShopLabel = LUI.UIText.new(0.5, 0.5, 7, 247, 0.5, 0.5, -388, -370)
	MyShopLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MyShopLabel:setText(LocalizeToUpperString(0x5DAEFC4C9B0A8FA))
	MyShopLabel:setTTF("ttmussels_regular")
	MyShopLabel:setLetterSpacing(4)
	MyShopLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MyShopLabel:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(MyShopLabel)
	self.MyShopLabel = MyShopLabel
	local TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -840, -610, 0, 0, 748, 818)
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f86_local0 = nil
		if element.gainFocus then
			f86_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f86_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f86_local0
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
	local MyShopBracket = LUI.UIImage.new(0.5, 0.5, 7, 257, 0.5, 0.5, -364, -356)
	MyShopBracket:setAlpha(0.5)
	MyShopBracket:setZRot(180)
	MyShopBracket:setImage(RegisterImage(0xC325BED3F226657))
	MyShopBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	MyShopBracket:setShaderVector(0, 0, 0, 0, 0)
	MyShopBracket:setupNineSliceShader(16, 4)
	self:addElement(MyShopBracket)
	self.MyShopBracket = MyShopBracket
	local SupplyChainDetails = CoD.ContractSupplyChainDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, 310, 910, 0.5, 0.5, -619, 461)
	SupplyChainDetails:mergeStateConditions({
		{
			stateName = "NoInfoPanel",
			condition = function(menu, element, event)
				local f91_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f91_local0 = AlwaysTrue()
				else
					f91_local0 = false
				end
				return f91_local0
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
	SupplyChainDetails:appendEventHandler("input_source_changed", function(f93_arg0, f93_arg1)
		f93_arg1.menu = f93_arg1.menu or f1_arg0
		f1_arg0:updateElementState(SupplyChainDetails, f93_arg1)
	end)
	local DirectorPreGameButton = SupplyChainDetails
	local DiscountTiersWidget = SupplyChainDetails.subscribeToModel
	local f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DiscountTiersWidget(DirectorPreGameButton, f1_local20.LastInput, function(f94_arg0)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f94_arg0:get(),
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
	DiscountTiersWidget = CoD.DiscountTiersContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	DiscountTiersWidget:registerEventHandler("gain_list_focus", function(element, event)
		local f97_local0 = nil
		SetElementState(self, self.SupplyChainDetails, f1_arg1, "Hidden")
		SetElementState(self, self.DiscountTiersWidget, f1_arg1, "DefaultState")
		return f97_local0
	end)
	DiscountTiersWidget:registerEventHandler("lose_list_focus", function(element, event)
		local f98_local0 = nil
		UpdateElementState(self, "SupplyChainDetails", f1_arg1)
		UpdateElementState(self, "DiscountTiersWidget", f1_arg1)
		return f98_local0
	end)
	DiscountTiersWidget:registerEventHandler("list_item_gain_focus", function(element, event)
		local f99_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		return f99_local0
	end)
	self:addElement(DiscountTiersWidget)
	self.DiscountTiersWidget = DiscountTiersWidget
	DirectorPreGameButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0, 0, 1217, 1447, 0, 0, 875, 945)
	DirectorPreGameButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x616EBD2B8F67E64))
	DirectorPreGameButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x616EBD2B8F67E64))
	DirectorPreGameButton:registerEventHandler("gain_focus", function(element, event)
		local f100_local0 = nil
		if element.gainFocus then
			f100_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f100_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f100_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorPreGameButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenOverlay(self, "BlackMarketContracts", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(DirectorPreGameButton)
	self.DirectorPreGameButton = DirectorPreGameButton
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f104_arg0, f104_arg1)
		f104_arg1.menu = f104_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f104_arg1)
	end)
	local f1_local21 = self
	f1_local20 = self.subscribeToModel
	local f1_local22 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local20(f1_local21, f1_local22.LastInput, function(f105_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f105_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "RefreshDWInventoryMenu", function(model)
		local f106_local0 = self
		if not CoD.BlackMarketUtility.IsMenuOccluded(f1_arg0) then
			UpdateDataSource(self, self.MyShop, f1_arg1)
			UpdateDataSource(self, self.FeaturedSlot1, f1_arg1)
			UpdateDataSource(self, self.SpecialOrders, f1_arg1)
			UpdateDataSource(self, self.FeaturedSlot2, f1_arg1)
		end
	end)
	FeaturedSlot1.id = "FeaturedSlot1"
	FeaturedSlot2.id = "FeaturedSlot2"
	SpecialOrders.id = "SpecialOrders"
	MyShop.id = "MyShop"
	if CoD.isPC then
		TransactionDeepLinkButton.id = "TransactionDeepLinkButton"
	end
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	DiscountTiersWidget.id = "DiscountTiersWidget"
	DirectorPreGameButton.id = "DirectorPreGameButton"
	self.__defaultFocus = SpecialOrders
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local20 = self
	SendClientScriptMenuChangeNotifyWithState(f1_arg1, f1_arg0, true, "character")
	SetMenuProperty(f1_arg0, "__hideSupplyChainDetailsButtons", true)
	CoD.BlackMarketUtility.ForceStreamStoreImages(f1_arg1)
	CoD.BlackMarketUtility.TriggerGreetingVO(self, f1_arg1)
	CoD.BlackMarketUtility.SetupBlackJackFrameContextualMenus(self, f1_arg1)
	f1_local20 = FeaturedSlot1
	CoD.BaseUtility.DisableNavigation(f1_local20)
	SetElementProperty(f1_local20, "__loopOnSameRow", true)
	SetElementProperty(f1_local20, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local20)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local20, 0.5)
	f1_local20 = FeaturedSlot2
	CoD.BaseUtility.DisableNavigation(f1_local20)
	SetElementProperty(f1_local20, "__loopOnSameRow", true)
	SetElementProperty(f1_local20, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local20)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local20, 0.5)
	f1_local20 = SpecialOrders
	CoD.BaseUtility.DisableNavigation(f1_local20)
	SetElementProperty(f1_local20, "__loopOnSameRow", true)
	SetElementProperty(f1_local20, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local20)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local20, 0.5)
	f1_local20 = MyShop
	CoD.BaseUtility.DisableNavigation(f1_local20)
	SetElementProperty(f1_local20, "__loopOnSameRow", true)
	SetElementProperty(f1_local20, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local20)
	f1_local20 = TransactionDeepLinkButton
	if IsPC() and not CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
		ReplaceElementWithFake(self, "TransactionDeepLinkButton")
	end
	return self
end
CoD.BlackMarketItemShopFrame.__resetProperties = function(f107_arg0)
	f107_arg0.MyShop:completeAnimation()
	f107_arg0.SpecialOrders:completeAnimation()
	f107_arg0.FeaturedSlot2:completeAnimation()
	f107_arg0.FeaturedSlot1:completeAnimation()
	f107_arg0.MyShop:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	f107_arg0.SpecialOrders:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	f107_arg0.FeaturedSlot2:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	f107_arg0.FeaturedSlot1:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
end
CoD.BlackMarketItemShopFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f108_arg0, f108_arg1)
			f108_arg0:__resetProperties()
			f108_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f109_arg0, f109_arg1)
			f109_arg0:__resetProperties()
			f109_arg0:setupElementClipCounter(4)
			f109_arg0.FeaturedSlot1:completeAnimation()
			f109_arg0.FeaturedSlot1:setHorizontalCounter(CoD.horizontalCounter)
			f109_arg0.clipFinished(f109_arg0.FeaturedSlot1)
			f109_arg0.FeaturedSlot2:completeAnimation()
			f109_arg0.FeaturedSlot2:setHorizontalCounter(CoD.horizontalCounter)
			f109_arg0.clipFinished(f109_arg0.FeaturedSlot2)
			f109_arg0.SpecialOrders:completeAnimation()
			f109_arg0.SpecialOrders:setHorizontalCounter(CoD.horizontalCounter)
			f109_arg0.clipFinished(f109_arg0.SpecialOrders)
			f109_arg0.MyShop:completeAnimation()
			f109_arg0.MyShop:setHorizontalCounter(CoD.horizontalCounter)
			f109_arg0.clipFinished(f109_arg0.MyShop)
		end,
	},
}
CoD.BlackMarketItemShopFrame.__onClose = function(f110_arg0)
	f110_arg0.FeaturedSlot1Timer:close()
	f110_arg0.FeaturedSlot1:close()
	f110_arg0.FeaturedSlot2Timer:close()
	f110_arg0.FeaturedSlot2:close()
	f110_arg0.SpecialOrders:close()
	f110_arg0.MyShopTimer:close()
	f110_arg0.SpecialOrdersTimer:close()
	f110_arg0.MyShop:close()
	f110_arg0.TransactionDeepLinkButton:close()
	f110_arg0.SupplyChainDetails:close()
	f110_arg0.DiscountTiersWidget:close()
	f110_arg0.DirectorPreGameButton:close()
end
