require("x64:33a3fbb064063e0")
require("x64:ffbc64370f13dd9")
require("x64:b25db840a191172")
require("x64:79a2abecba85306")
require("x64:c8666fff462a645")
require("x64:6f654a80d1f9e86")
require("x64:c9b3f8f20c93f63")
require("x64:74643552a822614")
require("x64:77c0b4247e6330a")
require("x64:35653ef4ad2299d")
require("x64:67940364f14a232")
CoD.BlackJacksShopFrameSunset = InheritFrom(LUI.UIElement)
CoD.BlackJacksShopFrameSunset.__defaultWidth = 1920
CoD.BlackJacksShopFrameSunset.__defaultHeight = 1080
CoD.BlackJacksShopFrameSunset.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg1, "BlackMarketSunsetIntroduction")
	CoD.BaseUtility.InitControllerModel(f1_arg1, "itemShopSunsetFocus", "none")
	self:setClass(CoD.BlackJacksShopFrameSunset)
	self.id = "BlackJacksShopFrameSunset"
	self.soundSet = "ItemShop"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -840, -610, 0, 0, 748, 818)
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x4031C820A02E7BA))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f2_local0
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
	local RNGItemSlot = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	RNGItemSlot:setLeftRight(0.5, 0.5, -272, -32)
	RNGItemSlot:setTopBottom(0.5, 0.5, -319, 191)
	RNGItemSlot:setWidgetType(CoD.BMTallItemContainer)
	RNGItemSlot:setSpacing(30)
	RNGItemSlot:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RNGItemSlot:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	RNGItemSlot:setDataSource("RNGSlotList")
	RNGItemSlot:linkToElementModel(RNGItemSlot, "emptyItem", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	RNGItemSlot:linkToElementModel(RNGItemSlot, "revealed", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	RNGItemSlot:linkToElementModel(RNGItemSlot, "movieName", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	RNGItemSlot:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f10_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f10_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	local DeterministicItemSlot1 = RNGItemSlot
	local DeterministicItemSlot2 = RNGItemSlot.subscribeToModel
	local RNGItemSlotTimer = Engine[0x4DF5CFBC1771947](f1_arg1)
	DeterministicItemSlot2(DeterministicItemSlot1, RNGItemSlotTimer.LastInput, function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	RNGItemSlot:registerEventHandler("list_item_gain_focus", function(element, event)
		local f12_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f12_local0
	end)
	RNGItemSlot:registerEventHandler("occlusion_change", function(element, event)
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
	RNGItemSlot:registerEventHandler("lose_list_focus", function(element, event)
		local f14_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		return f14_local0
	end)
	RNGItemSlot:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RNGItemSlot, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
			OpenOverlay(self, "ItemShopDetailsSunset", controller, {
				_model = element:getModel(),
			})
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(RNGItemSlot, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(RNGItemSlot, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x52FB29ED3A3CA79, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(RNGItemSlot, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
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
	f1_arg0:AddButtonCallbackFunction(RNGItemSlot, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
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
	LUI.OverrideFunction_CallOriginalFirst(RNGItemSlot, "updateDataSource", function(element, controller, f26_arg2, f26_arg3)
		if CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) then
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(RNGItemSlot, "childFocusGained", function(element)
		SetControllerModelValue(f1_arg1, "itemShopSunsetFocus", "slot")
	end)
	LUI.OverrideFunction_CallOriginalFirst(RNGItemSlot, "childFocusLost", function(element)
		SetControllerModelValue(f1_arg1, "itemShopSunsetFocus", "none")
	end)
	RNGItemSlot:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f29_local0 = RNGItemSlot
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f29_local0, true, true, true)
		end
	end)
	RNGItemSlot:AddContextualMenuAction(f1_arg0, f1_arg1, 0x52FB29ED3A3CA79, function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f30_arg0, f30_arg2, "movieName") then
			return function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
				SetControllerModelValue(f31_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f31_arg2, f31_arg0, "")
				DelayOpenOverlay(f31_arg1, "VoDViewer", f31_arg2, {
					fullscreen = true,
				})
			end
		else
		end
	end)
	self:addElement(RNGItemSlot)
	self.RNGItemSlot = RNGItemSlot
	DeterministicItemSlot2 = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	DeterministicItemSlot2:setLeftRight(0.5, 0.5, -556, -316)
	DeterministicItemSlot2:setTopBottom(0.5, 0.5, -319, 191)
	DeterministicItemSlot2:setWidgetType(CoD.BMTallItemContainer)
	DeterministicItemSlot2:setSpacing(30)
	DeterministicItemSlot2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DeterministicItemSlot2:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	DeterministicItemSlot2:setDataSource("DeterministicSlot2List")
	DeterministicItemSlot2:linkToElementModel(DeterministicItemSlot2, "lootType", true, function(model, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DeterministicItemSlot2:linkToElementModel(DeterministicItemSlot2, "emptyItem", true, function(model, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DeterministicItemSlot2:linkToElementModel(DeterministicItemSlot2, "revealed", true, function(model, f34_arg1)
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DeterministicItemSlot2:linkToElementModel(DeterministicItemSlot2, "movieName", true, function(model, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DeterministicItemSlot2:appendEventHandler("input_source_changed", function(f36_arg0, f36_arg1)
		f36_arg1.menu = f36_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f36_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f36_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	RNGItemSlotTimer = DeterministicItemSlot2
	DeterministicItemSlot1 = DeterministicItemSlot2.subscribeToModel
	local DeterministicItemSlot2Timer = Engine[0x4DF5CFBC1771947](f1_arg1)
	DeterministicItemSlot1(RNGItemSlotTimer, DeterministicItemSlot2Timer.LastInput, function(f37_arg0, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	DeterministicItemSlot2:registerEventHandler("list_item_gain_focus", function(element, event)
		local f38_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f38_local0
	end)
	DeterministicItemSlot2:registerEventHandler("occlusion_change", function(element, event)
		local f39_local0 = nil
		if element.OcclusionChange then
			f39_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f39_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f39_local0 then
			f39_local0 = element:dispatchEventToChildren(event)
		end
		return f39_local0
	end)
	DeterministicItemSlot2:registerEventHandler("lose_list_focus", function(element, event)
		local f40_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		return f40_local0
	end)
	DeterministicItemSlot2:registerEventHandler("gain_focus", function(element, event)
		local f41_local0 = nil
		if element.gainFocus then
			f41_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f41_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		return f41_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			PlaySoundAlias("uin_toggle_generic")
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.ContractUtility.OpenContractDetailsSunset(self, element, controller)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
			OpenOverlay(self, "ItemShopDetailsSunset", controller, {
				_model = element:getModel(),
			})
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x52FB29ED3A3CA79, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
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
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot2, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
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
	LUI.OverrideFunction_CallOriginalFirst(DeterministicItemSlot2, "updateDataSource", function(element, controller, f52_arg2, f52_arg3)
		if CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) then
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(DeterministicItemSlot2, "childFocusGained", function(element)
		SetControllerModelValue(f1_arg1, "itemShopSunsetFocus", "slot")
	end)
	LUI.OverrideFunction_CallOriginalFirst(DeterministicItemSlot2, "childFocusLost", function(element)
		SetControllerModelValue(f1_arg1, "itemShopSunsetFocus", "none")
	end)
	DeterministicItemSlot2:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f55_local0 = DeterministicItemSlot2
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f55_local0, true, true, true)
		end
	end)
	DeterministicItemSlot2:AddContextualMenuAction(f1_arg0, f1_arg1, 0x52FB29ED3A3CA79, function(f56_arg0, f56_arg1, f56_arg2, f56_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f56_arg0, f56_arg2, "movieName") then
			return function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
				SetControllerModelValue(f57_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f57_arg2, f57_arg0, "")
				DelayOpenOverlay(f57_arg1, "VoDViewer", f57_arg2, {
					fullscreen = true,
				})
			end
		else
		end
	end)
	self:addElement(DeterministicItemSlot2)
	self.DeterministicItemSlot2 = DeterministicItemSlot2
	DeterministicItemSlot1 = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	DeterministicItemSlot1:setLeftRight(0.5, 0.5, -840, -600)
	DeterministicItemSlot1:setTopBottom(0.5, 0.5, -319, 191)
	DeterministicItemSlot1:setWidgetType(CoD.BMTallItemContainer)
	DeterministicItemSlot1:setSpacing(30)
	DeterministicItemSlot1:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DeterministicItemSlot1:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	DeterministicItemSlot1:setDataSource("DeterministicSlot1List")
	DeterministicItemSlot1:linkToElementModel(DeterministicItemSlot1, "lootType", true, function(model, f58_arg1)
		CoD.Menu.UpdateButtonShownState(f58_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DeterministicItemSlot1:linkToElementModel(DeterministicItemSlot1, "emptyItem", true, function(model, f59_arg1)
		CoD.Menu.UpdateButtonShownState(f59_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f59_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f59_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DeterministicItemSlot1:linkToElementModel(DeterministicItemSlot1, "revealed", true, function(model, f60_arg1)
		CoD.Menu.UpdateButtonShownState(f60_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(f60_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f60_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DeterministicItemSlot1:linkToElementModel(DeterministicItemSlot1, "movieName", true, function(model, f61_arg1)
		CoD.Menu.UpdateButtonShownState(f61_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f61_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DeterministicItemSlot1:appendEventHandler("input_source_changed", function(f62_arg0, f62_arg1)
		f62_arg1.menu = f62_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f62_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f62_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end)
	DeterministicItemSlot2Timer = DeterministicItemSlot1
	RNGItemSlotTimer = DeterministicItemSlot1.subscribeToModel
	local DeterministicItemSlot1Timer = Engine[0x4DF5CFBC1771947](f1_arg1)
	RNGItemSlotTimer(DeterministicItemSlot2Timer, DeterministicItemSlot1Timer.LastInput, function(f63_arg0, f63_arg1)
		CoD.Menu.UpdateButtonShownState(f63_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f63_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
	end, false)
	DeterministicItemSlot1:registerEventHandler("list_item_gain_focus", function(element, event)
		local f64_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f64_local0
	end)
	DeterministicItemSlot1:registerEventHandler("occlusion_change", function(element, event)
		local f65_local0 = nil
		if element.OcclusionChange then
			f65_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f65_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f65_local0 then
			f65_local0 = element:dispatchEventToChildren(event)
		end
		return f65_local0
	end)
	DeterministicItemSlot1:registerEventHandler("lose_list_focus", function(element, event)
		local f66_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_arg0)
		return f66_local0
	end)
	DeterministicItemSlot1:registerEventHandler("gain_focus", function(element, event)
		local f67_local0 = nil
		if element.gainFocus then
			f67_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f67_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		return f67_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			PlaySoundAlias("uin_toggle_generic")
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.ContractUtility.OpenContractDetailsSunset(self, element, controller)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
			OpenOverlay(self, "ItemShopDetailsSunset", controller, {
				_model = element:getModel(),
			})
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], "ui_remove", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "emptyItem") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "revealed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xA86619565BE54DB], 0x52FB29ED3A3CA79, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
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
	f1_arg0:AddButtonCallbackFunction(DeterministicItemSlot1, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
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
	LUI.OverrideFunction_CallOriginalFirst(DeterministicItemSlot1, "updateDataSource", function(element, controller, f78_arg2, f78_arg3)
		if CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) then
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(DeterministicItemSlot1, "childFocusGained", function(element)
		SetControllerModelValue(f1_arg1, "itemShopSunsetFocus", "slot")
	end)
	LUI.OverrideFunction_CallOriginalFirst(DeterministicItemSlot1, "childFocusLost", function(element)
		SetControllerModelValue(f1_arg1, "itemShopSunsetFocus", "none")
	end)
	DeterministicItemSlot1:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f81_local0 = DeterministicItemSlot1
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f81_local0, true, true, true)
		end
	end)
	DeterministicItemSlot1:AddContextualMenuAction(f1_arg0, f1_arg1, 0x52FB29ED3A3CA79, function(f82_arg0, f82_arg1, f82_arg2, f82_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f82_arg0, f82_arg2, "movieName") then
			return function(f83_arg0, f83_arg1, f83_arg2, f83_arg3)
				SetControllerModelValue(f83_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f83_arg2, f83_arg0, "")
				DelayOpenOverlay(f83_arg1, "VoDViewer", f83_arg2, {
					fullscreen = true,
				})
			end
		else
		end
	end)
	self:addElement(DeterministicItemSlot1)
	self.DeterministicItemSlot1 = DeterministicItemSlot1
	RNGItemSlotTimer = CoD.ItemShopSlotTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -273, -33, 0.5, 0.5, -369, -319)
	RNGItemSlotTimer:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "ItemshopRotation", "loot_itemshop_slot3_timer_active")
			end,
		},
	})
	DeterministicItemSlot1Timer = RNGItemSlotTimer
	DeterministicItemSlot2Timer = RNGItemSlotTimer.subscribeToModel
	local SpecialOrdersBracket = DataSources.ItemshopRotation.getModel(f1_arg1)
	DeterministicItemSlot2Timer(DeterministicItemSlot1Timer, SpecialOrdersBracket.loot_itemshop_slot3_timer_active, function(f85_arg0)
		f1_arg0:updateElementState(RNGItemSlotTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f85_arg0:get(),
			modelName = "loot_itemshop_slot3_timer_active",
		})
	end, false)
	RNGItemSlotTimer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot3_timer", function(model)
		local f86_local0 = model:get()
		if f86_local0 ~= nil then
			RNGItemSlotTimer.TextBox:setText(f86_local0)
		end
	end)
	self:addElement(RNGItemSlotTimer)
	self.RNGItemSlotTimer = RNGItemSlotTimer
	DeterministicItemSlot2Timer = CoD.ItemShopSlotTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -557, -316, 0.5, 0.5, -369, -319)
	DeterministicItemSlot2Timer:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "ItemshopRotation", "loot_itemshop_slot2_timer_active")
			end,
		},
	})
	SpecialOrdersBracket = DeterministicItemSlot2Timer
	DeterministicItemSlot1Timer = DeterministicItemSlot2Timer.subscribeToModel
	local FeaturedItemsBracket = DataSources.ItemshopRotation.getModel(f1_arg1)
	DeterministicItemSlot1Timer(SpecialOrdersBracket, FeaturedItemsBracket.loot_itemshop_slot2_timer_active, function(f88_arg0)
		f1_arg0:updateElementState(DeterministicItemSlot2Timer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f88_arg0:get(),
			modelName = "loot_itemshop_slot2_timer_active",
		})
	end, false)
	DeterministicItemSlot2Timer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot2_timer", function(model)
		local f89_local0 = model:get()
		if f89_local0 ~= nil then
			DeterministicItemSlot2Timer.TextBox:setText(f89_local0)
		end
	end)
	self:addElement(DeterministicItemSlot2Timer)
	self.DeterministicItemSlot2Timer = DeterministicItemSlot2Timer
	DeterministicItemSlot1Timer = CoD.ItemShopSlotTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -841, -599, 0.5, 0.5, -369, -319)
	DeterministicItemSlot1Timer:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "ItemshopRotation", "loot_itemshop_slot1_timer_active")
			end,
		},
	})
	FeaturedItemsBracket = DeterministicItemSlot1Timer
	SpecialOrdersBracket = DeterministicItemSlot1Timer.subscribeToModel
	local TiledwhiteNoiseBacking = DataSources.ItemshopRotation.getModel(f1_arg1)
	SpecialOrdersBracket(FeaturedItemsBracket, TiledwhiteNoiseBacking.loot_itemshop_slot1_timer_active, function(f91_arg0)
		f1_arg0:updateElementState(DeterministicItemSlot1Timer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f91_arg0:get(),
			modelName = "loot_itemshop_slot1_timer_active",
		})
	end, false)
	DeterministicItemSlot1Timer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot1_timer", function(model)
		local f92_local0 = model:get()
		if f92_local0 ~= nil then
			DeterministicItemSlot1Timer.TextBox:setText(f92_local0)
		end
	end)
	self:addElement(DeterministicItemSlot1Timer)
	self.DeterministicItemSlot1Timer = DeterministicItemSlot1Timer
	SpecialOrdersBracket = LUI.UIImage.new(0.5, 0.5, -277, -27, 0.5, 0.5, -373, -365)
	SpecialOrdersBracket:setRGB(0.98, 1, 0.89)
	SpecialOrdersBracket:setAlpha(0.5)
	SpecialOrdersBracket:setImage(RegisterImage(0xC325BED3F226657))
	SpecialOrdersBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	SpecialOrdersBracket:setShaderVector(0, 0, 0, 0, 0)
	SpecialOrdersBracket:setupNineSliceShader(16, 4)
	self:addElement(SpecialOrdersBracket)
	self.SpecialOrdersBracket = SpecialOrdersBracket
	FeaturedItemsBracket = LUI.UIImage.new(0.5, 0.5, -846, -311, 0.5, 0.5, -373, -365)
	FeaturedItemsBracket:setAlpha(0.5)
	FeaturedItemsBracket:setImage(RegisterImage(0xC325BED3F226657))
	FeaturedItemsBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FeaturedItemsBracket:setShaderVector(0, 0, 0, 0, 0)
	FeaturedItemsBracket:setupNineSliceShader(16, 4)
	self:addElement(FeaturedItemsBracket)
	self.FeaturedItemsBracket = FeaturedItemsBracket
	TiledwhiteNoiseBacking = LUI.UIImage.new(0, 0, 115, 649, 0, 0, 148, 174)
	TiledwhiteNoiseBacking:setRGB(0.81, 0.89, 0.93)
	TiledwhiteNoiseBacking:setAlpha(0.04)
	TiledwhiteNoiseBacking:setImage(RegisterImage(0x7167D8C33A06020))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local TiledwhiteNoiseBacking2 = LUI.UIImage.new(0, 0, 684, 933, 0, 0, 148, 174)
	TiledwhiteNoiseBacking2:setRGB(0.81, 0.89, 0.93)
	TiledwhiteNoiseBacking2:setAlpha(0.04)
	TiledwhiteNoiseBacking2:setImage(RegisterImage(0x7167D8C33A06020))
	TiledwhiteNoiseBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledwhiteNoiseBacking2:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking2:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking2)
	self.TiledwhiteNoiseBacking2 = TiledwhiteNoiseBacking2
	local TiledwhiteNoiseBacking3 = LUI.UIImage.new(0, 0, 968, 1217, 0, 0, 148, 174)
	TiledwhiteNoiseBacking3:setRGB(0.81, 0.89, 0.93)
	TiledwhiteNoiseBacking3:setAlpha(0.04)
	TiledwhiteNoiseBacking3:setImage(RegisterImage(0x7167D8C33A06020))
	TiledwhiteNoiseBacking3:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledwhiteNoiseBacking3:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking3:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking3)
	self.TiledwhiteNoiseBacking3 = TiledwhiteNoiseBacking3
	local RNGItemSlotLabel = LUI.UIText.new(0.5, 0.5, -270, -32, 0.5, 0.5, -388, -370)
	RNGItemSlotLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	RNGItemSlotLabel:setText(LocalizeToUpperString(0xDD64FB205312314))
	RNGItemSlotLabel:setTTF("ttmussels_regular")
	RNGItemSlotLabel:setLetterSpacing(4)
	RNGItemSlotLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RNGItemSlotLabel:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(RNGItemSlotLabel)
	self.RNGItemSlotLabel = RNGItemSlotLabel
	local DeterministicItemLabel = LUI.UIText.new(0.5, 0.5, -840, -316, 0.5, 0.5, -388, -370)
	DeterministicItemLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DeterministicItemLabel:setText(LocalizeToUpperString(0x5DAEFC4C9B0A8FA))
	DeterministicItemLabel:setTTF("ttmussels_regular")
	DeterministicItemLabel:setLetterSpacing(4)
	DeterministicItemLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DeterministicItemLabel:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(DeterministicItemLabel)
	self.DeterministicItemLabel = DeterministicItemLabel
	local MyShopTimer = CoD.ListLabelHideable.new(f1_arg0, f1_arg1, 0.5, 0.5, 11, 253, 0.5, 0.5, -369, -319)
	MyShopTimer:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_weaponBribeMultiPurchaseActive")
			end,
		},
	})
	MyShopTimer:subscribeToGlobalModel(f1_arg1, "BribeMenuTimer", "bribe_menu_timer", function(model)
		local f94_local0 = model:get()
		if f94_local0 ~= nil then
			MyShopTimer.TextBox2:setText(f94_local0)
		end
	end)
	MyShopTimer:subscribeToGlobalModel(f1_arg1, "BribeMenuTimer", "cycled", function(model)
		local f95_local0 = MyShopTimer
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "BribeMenuTimer", "cycled") then
			UpdateSelfElementState(f1_arg0, f95_local0, f1_arg1)
		end
	end)
	self:addElement(MyShopTimer)
	self.MyShopTimer = MyShopTimer
	local ReservesBribeStackCarouselTall = CoD.ReservesBribeStackCarouselTall.new(f1_arg0, f1_arg1, 0.5, 0.5, 12, 252, 0.5, 0.5, -319, 191)
	LUI.OverrideFunction_CallOriginalFirst(ReservesBribeStackCarouselTall, "childFocusGained", function(element)
		SetControllerModelValue(f1_arg1, "itemShopSunsetFocus", "bribe")
	end)
	LUI.OverrideFunction_CallOriginalFirst(ReservesBribeStackCarouselTall, "childFocusLost", function(element)
		SetControllerModelValue(f1_arg1, "itemShopSunsetFocus", "none")
	end)
	self:addElement(ReservesBribeStackCarouselTall)
	self.ReservesBribeStackCarouselTall = ReservesBribeStackCarouselTall
	local MyShopLabel = LUI.UIText.new(0.5, 0.5, 14, 252, 0.5, 0.5, -388, -370)
	MyShopLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MyShopLabel:setText(LocalizeToUpperString(0xFCC6C603186E74))
	MyShopLabel:setTTF("ttmussels_regular")
	MyShopLabel:setLetterSpacing(4)
	MyShopLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MyShopLabel:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(MyShopLabel)
	self.MyShopLabel = MyShopLabel
	local MyShopBracket = LUI.UIImage.new(0.5, 0.5, 7, 257, 0.5, 0.5, -373, -365)
	MyShopBracket:setAlpha(0.5)
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
				local f98_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f98_local0 = AlwaysTrue()
				else
					f98_local0 = false
				end
				return f98_local0
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
	SupplyChainDetails:appendEventHandler("input_source_changed", function(f100_arg0, f100_arg1)
		f100_arg1.menu = f100_arg1.menu or f1_arg0
		f1_arg0:updateElementState(SupplyChainDetails, f100_arg1)
	end)
	local WeaponBribePreviewWidget = SupplyChainDetails
	local DiscountTiersWidget = SupplyChainDetails.subscribeToModel
	local f1_local22 = Engine[0x4DF5CFBC1771947](f1_arg1)
	DiscountTiersWidget(WeaponBribePreviewWidget, f1_local22.LastInput, function(f101_arg0)
		f1_arg0:updateElementState(SupplyChainDetails, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f101_arg0:get(),
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
		local f104_local0 = nil
		SetElementState(self, self.SupplyChainDetails, f1_arg1, "Hidden")
		SetElementState(self, self.DiscountTiersWidget, f1_arg1, "DefaultState")
		return f104_local0
	end)
	DiscountTiersWidget:registerEventHandler("lose_list_focus", function(element, event)
		local f105_local0 = nil
		UpdateElementState(self, "SupplyChainDetails", f1_arg1)
		UpdateElementState(self, "DiscountTiersWidget", f1_arg1)
		return f105_local0
	end)
	DiscountTiersWidget:registerEventHandler("list_item_gain_focus", function(element, event)
		local f106_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		return f106_local0
	end)
	self:addElement(DiscountTiersWidget)
	self.DiscountTiersWidget = DiscountTiersWidget
	WeaponBribePreviewWidget = CoD.ItemShopWeaponBribePreviewWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 393, 843, 0.5, 0.5, -330, 170)
	self:addElement(WeaponBribePreviewWidget)
	self.WeaponBribePreviewWidget = WeaponBribePreviewWidget
	self.ReservesBribeStackCarouselTall:linkToElementModel(self, nil, false, function(model)
		ReservesBribeStackCarouselTall:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "SlotFocus",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "itemShopSunsetFocus", "slot")
			end,
		},
		{
			stateName = "BribeFocus",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "itemShopSunsetFocus", "bribe")
			end,
		},
	})
	local f1_local23 = self
	f1_local22 = self.subscribeToModel
	local f1_local24 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local22(f1_local23, f1_local24.itemShopSunsetFocus, function(f110_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f110_arg0:get(),
			modelName = "itemShopSunsetFocus",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "RefreshDWInventoryMenu", function(model)
		local f111_local0 = self
		if not CoD.BlackMarketUtility.IsMenuOccluded(f1_arg0) then
			UpdateDataSource(self, self.DeterministicItemSlot1, f1_arg1)
			UpdateDataSource(self, self.RNGItemSlot, f1_arg1)
			UpdateDataSource(self, self.DeterministicItemSlot2, f1_arg1)
		end
	end)
	if CoD.isPC then
		TransactionDeepLinkButton.id = "TransactionDeepLinkButton"
	end
	RNGItemSlot.id = "RNGItemSlot"
	DeterministicItemSlot2.id = "DeterministicItemSlot2"
	DeterministicItemSlot1.id = "DeterministicItemSlot1"
	ReservesBribeStackCarouselTall.id = "ReservesBribeStackCarouselTall"
	if CoD.isPC then
		SupplyChainDetails.id = "SupplyChainDetails"
	end
	DiscountTiersWidget.id = "DiscountTiersWidget"
	self.__defaultFocus = DeterministicItemSlot1
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local22 = self
	SendClientScriptMenuChangeNotifyWithState(f1_arg1, f1_arg0, true, "character")
	SetMenuProperty(f1_arg0, "__hideSupplyChainDetailsButtons", true)
	CoD.BlackMarketUtility.ForceStreamStoreImagesSunset(f1_arg1, f1_arg0)
	CoD.BlackMarketUtility.TriggerGreetingVO(self, f1_arg1)
	CoD.BlackMarketUtility.SetupBlackJackFrameContextualMenus(self, f1_arg1)
	f1_local22 = TransactionDeepLinkButton
	if IsPC() and not CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
		ReplaceElementWithFake(self, "TransactionDeepLinkButton")
	end
	f1_local22 = RNGItemSlot
	CoD.BaseUtility.DisableNavigation(f1_local22)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local22)
	CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, self.DeterministicItemSlot2)
	f1_local22 = DeterministicItemSlot2
	CoD.BaseUtility.DisableNavigation(f1_local22)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local22)
	CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, self.DeterministicItemSlot2)
	f1_local22 = DeterministicItemSlot1
	CoD.BaseUtility.DisableNavigation(f1_local22)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local22)
	CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, self.DeterministicItemSlot2)
	return self
end
CoD.BlackJacksShopFrameSunset.__resetProperties = function(f112_arg0)
	f112_arg0.WeaponBribePreviewWidget:completeAnimation()
	f112_arg0.SupplyChainDetails:completeAnimation()
	f112_arg0.WeaponBribePreviewWidget:setAlpha(1)
	f112_arg0.SupplyChainDetails:setAlpha(1)
end
CoD.BlackJacksShopFrameSunset.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f113_arg0, f113_arg1)
			f113_arg0:__resetProperties()
			f113_arg0:setupElementClipCounter(2)
			f113_arg0.SupplyChainDetails:completeAnimation()
			f113_arg0.SupplyChainDetails:setAlpha(0)
			f113_arg0.clipFinished(f113_arg0.SupplyChainDetails)
			f113_arg0.WeaponBribePreviewWidget:completeAnimation()
			f113_arg0.WeaponBribePreviewWidget:setAlpha(0)
			f113_arg0.clipFinished(f113_arg0.WeaponBribePreviewWidget)
		end,
	},
	SlotFocus = {
		DefaultClip = function(f114_arg0, f114_arg1)
			f114_arg0:__resetProperties()
			f114_arg0:setupElementClipCounter(1)
			f114_arg0.WeaponBribePreviewWidget:completeAnimation()
			f114_arg0.WeaponBribePreviewWidget:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.WeaponBribePreviewWidget)
		end,
	},
	BribeFocus = {
		DefaultClip = function(f115_arg0, f115_arg1)
			f115_arg0:__resetProperties()
			f115_arg0:setupElementClipCounter(1)
			f115_arg0.SupplyChainDetails:completeAnimation()
			f115_arg0.SupplyChainDetails:setAlpha(0)
			f115_arg0.clipFinished(f115_arg0.SupplyChainDetails)
		end,
	},
}
CoD.BlackJacksShopFrameSunset.__onClose = function(f116_arg0)
	f116_arg0.TransactionDeepLinkButton:close()
	f116_arg0.RNGItemSlot:close()
	f116_arg0.DeterministicItemSlot2:close()
	f116_arg0.DeterministicItemSlot1:close()
	f116_arg0.RNGItemSlotTimer:close()
	f116_arg0.DeterministicItemSlot2Timer:close()
	f116_arg0.DeterministicItemSlot1Timer:close()
	f116_arg0.MyShopTimer:close()
	f116_arg0.ReservesBribeStackCarouselTall:close()
	f116_arg0.SupplyChainDetails:close()
	f116_arg0.DiscountTiersWidget:close()
	f116_arg0.WeaponBribePreviewWidget:close()
end
