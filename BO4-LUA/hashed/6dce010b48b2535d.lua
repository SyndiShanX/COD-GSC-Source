require("x64:9b528a05aba52d6")
require("x64:ffbc64370f13dd9")
require("x64:b25db840a191172")
require("x64:c8666fff462a645")
require("x64:93604c7b6b216ac")
require("x64:35653ef4ad2299d")
require("x64:67940364f14a232")
require("x64:b1b346e32476a2e")
CoD.BlackJacksShopFrameNoPreview = InheritFrom(LUI.UIElement)
CoD.BlackJacksShopFrameNoPreview.__defaultWidth = 1920
CoD.BlackJacksShopFrameNoPreview.__defaultHeight = 1080
CoD.BlackJacksShopFrameNoPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg1, "BlackjackShopIntroduction")
	self:setClass(CoD.BlackJacksShopFrameNoPreview)
	self.id = "BlackJacksShopFrameNoPreview"
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
	NoMyShopOffers:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_640A4373BEE19526"))
	NoMyShopOffers:setTTF("default")
	NoMyShopOffers:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NoMyShopOffers:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(NoMyShopOffers)
	self.NoMyShopOffers = NoMyShopOffers
	local FeaturedSlot1 = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	FeaturedSlot1:setLeftRight(0.5, 0.5, -840, -600)
	FeaturedSlot1:setTopBottom(0.5, 0.5, -319, 191)
	FeaturedSlot1:setWidgetType(CoD.BMTallItemContainer)
	FeaturedSlot1:setSpacing(30)
	FeaturedSlot1:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FeaturedSlot1:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	FeaturedSlot1:setDataSource("ItemShopSlot1List")
	FeaturedSlot1:linkToElementModel(FeaturedSlot1, "movieName", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	FeaturedSlot1:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local FeaturedLabel = FeaturedSlot1
	local SpecialOrdersBracket = FeaturedSlot1.subscribeToModel
	local FeaturedSlot2Timer = Engine[@"getmodelforcontroller"](f1_arg1)
	SpecialOrdersBracket(FeaturedLabel, FeaturedSlot2Timer.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	FeaturedSlot1:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
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
		return f9_local0
	end)
	FeaturedSlot1:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/preview", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_remove", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"menu/preview", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot1, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	FeaturedSlot1:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f21_local0 = FeaturedSlot1
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f21_local0, true, true, true)
		end
	end)
	FeaturedSlot1:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/preview", function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f22_arg0, f22_arg2, "movieName") then
			return function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
				SetControllerModelValue(f23_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f23_arg2, f23_arg0, "")
				DelayOpenOverlay(f23_arg1, "VoDViewer", f23_arg2, {
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
	SpecialOrdersBracket:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	SpecialOrdersBracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	SpecialOrdersBracket:setShaderVector(0, 0, 0, 0, 0)
	SpecialOrdersBracket:setupNineSliceShader(16, 4)
	self:addElement(SpecialOrdersBracket)
	self.SpecialOrdersBracket = SpecialOrdersBracket
	FeaturedLabel = LUI.UIText.new(0.5, 0.5, -845, -605, 0.5, 0.5, -388, -370)
	FeaturedLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FeaturedLabel:setText(LocalizeToUpperString(@"menu/featured"))
	FeaturedLabel:setTTF("ttmussels_regular")
	FeaturedLabel:setLetterSpacing(4)
	FeaturedLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FeaturedLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(FeaturedLabel)
	self.FeaturedLabel = FeaturedLabel
	FeaturedSlot2Timer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -557, -316, 0.5, 0.5, -369, -319)
	FeaturedSlot2Timer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot2_timer", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			FeaturedSlot2Timer.TextBox2:setText(f24_local0)
		end
	end)
	self:addElement(FeaturedSlot2Timer)
	self.FeaturedSlot2Timer = FeaturedSlot2Timer
	local FeaturedSlot2 = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	FeaturedSlot2:setLeftRight(0.5, 0.5, -556, -316)
	FeaturedSlot2:setTopBottom(0.5, 0.5, -319, 191)
	FeaturedSlot2:setWidgetType(CoD.BMTallItemContainer)
	FeaturedSlot2:setSpacing(30)
	FeaturedSlot2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FeaturedSlot2:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	FeaturedSlot2:setDataSource("ItemShopSlot2List")
	FeaturedSlot2:linkToElementModel(FeaturedSlot2, "movieName", true, function(model, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	FeaturedSlot2:appendEventHandler("input_source_changed", function(f26_arg0, f26_arg1)
		f26_arg1.menu = f26_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f26_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f26_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local FeaturedItemsBracket = FeaturedSlot2
	local SpecialOrders = FeaturedSlot2.subscribeToModel
	local SpecialOrdersLabel = Engine[@"getmodelforcontroller"](f1_arg1)
	SpecialOrders(FeaturedItemsBracket, SpecialOrdersLabel.LastInput, function(f27_arg0, f27_arg1)
		CoD.Menu.UpdateButtonShownState(f27_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f27_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	FeaturedSlot2:registerEventHandler("list_item_gain_focus", function(element, event)
		local f28_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f28_local0
	end)
	FeaturedSlot2:registerEventHandler("occlusion_change", function(element, event)
		local f29_local0 = nil
		if element.OcclusionChange then
			f29_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f29_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f29_local0 then
			f29_local0 = element:dispatchEventToChildren(event)
		end
		return f29_local0
	end)
	FeaturedSlot2:registerEventHandler("lose_list_focus", function(element, event)
		local f30_local0 = nil
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, self.FeaturedSlot2)
		return f30_local0
	end)
	FeaturedSlot2:registerEventHandler("gain_list_focus", function(element, event)
		local f31_local0 = nil
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, self.FeaturedSlot2)
		return f31_local0
	end)
	FeaturedSlot2:registerEventHandler("gain_focus", function(element, event)
		local f32_local0 = nil
		if element.gainFocus then
			f32_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f32_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		return f32_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		OpenOverlay(self, "ItemShopDetails", controller, {
			_model = element:getModel(),
		})
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/preview", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_remove", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"menu/preview", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FeaturedSlot2, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	FeaturedSlot2:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f43_local0 = FeaturedSlot2
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f43_local0, true, true, true)
		end
	end)
	FeaturedSlot2:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/preview", function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f44_arg0, f44_arg2, "movieName") then
			return function(f45_arg0, f45_arg1, f45_arg2, f45_arg3)
				SetControllerModelValue(f45_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f45_arg2, f45_arg0, "")
				DelayOpenOverlay(f45_arg1, "VoDViewer", f45_arg2, {
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
	SpecialOrders:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpecialOrders:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	SpecialOrders:setDataSource("ItemShopSlot3List")
	SpecialOrders:linkToElementModel(SpecialOrders, "movieName", true, function(model, f46_arg1)
		CoD.Menu.UpdateButtonShownState(f46_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f46_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	SpecialOrders:appendEventHandler("input_source_changed", function(f47_arg0, f47_arg1)
		f47_arg1.menu = f47_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f47_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f47_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	SpecialOrdersLabel = SpecialOrders
	FeaturedItemsBracket = SpecialOrders.subscribeToModel
	local MyShopTimer = Engine[@"getmodelforcontroller"](f1_arg1)
	FeaturedItemsBracket(SpecialOrdersLabel, MyShopTimer.LastInput, function(f48_arg0, f48_arg1)
		CoD.Menu.UpdateButtonShownState(f48_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f48_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	SpecialOrders:registerEventHandler("list_item_gain_focus", function(element, event)
		local f49_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
		CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		return f49_local0
	end)
	SpecialOrders:registerEventHandler("occlusion_change", function(element, event)
		local f50_local0 = nil
		if element.OcclusionChange then
			f50_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f50_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
		end
		if not f50_local0 then
			f50_local0 = element:dispatchEventToChildren(event)
		end
		return f50_local0
	end)
	SpecialOrders:registerEventHandler("lose_list_focus", function(element, event)
		local f51_local0 = nil
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, self.SpecialOrders)
		return f51_local0
	end)
	SpecialOrders:registerEventHandler("gain_list_focus", function(element, event)
		local f52_local0 = nil
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, self.SpecialOrders)
		return f52_local0
	end)
	SpecialOrders:registerEventHandler("gain_focus", function(element, event)
		local f53_local0 = nil
		if element.gainFocus then
			f53_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f53_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		return f53_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.PlayItemShopSelectSound(element, controller)
		SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
		CoD.ContractUtility.OpenContractDetails(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/preview", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_remove", function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"menu/preview", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(SpecialOrders, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	SpecialOrders:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f64_local0 = SpecialOrders
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f64_local0, true, true, true)
		end
	end)
	SpecialOrders:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/preview", function(f65_arg0, f65_arg1, f65_arg2, f65_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f65_arg0, f65_arg2, "movieName") then
			return function(f66_arg0, f66_arg1, f66_arg2, f66_arg3)
				SetControllerModelValue(f66_arg2, "LootStreamProgress.playAnimation", false)
				CoD.VideoStreamingUtility.SetupVoDMovie(f66_arg2, f66_arg0, "")
				DelayOpenOverlay(f66_arg1, "VoDViewer", f66_arg2, {
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
	FeaturedItemsBracket:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	FeaturedItemsBracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FeaturedItemsBracket:setShaderVector(0, 0, 0, 0, 0)
	FeaturedItemsBracket:setupNineSliceShader(16, 4)
	self:addElement(FeaturedItemsBracket)
	self.FeaturedItemsBracket = FeaturedItemsBracket
	SpecialOrdersLabel = LUI.UIText.new(0.5, 0.5, -277, -36, 0.5, 0.5, -388, -370)
	SpecialOrdersLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SpecialOrdersLabel:setText(LocalizeToUpperString(@"hash_3D3C4B3D8C22E57C"))
	SpecialOrdersLabel:setTTF("ttmussels_regular")
	SpecialOrdersLabel:setLetterSpacing(4)
	SpecialOrdersLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpecialOrdersLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(SpecialOrdersLabel)
	self.SpecialOrdersLabel = SpecialOrdersLabel
	MyShopTimer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, 11, 253, 0.5, 0.5, -369, -319)
	MyShopTimer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot4_timer", function(model)
		local f67_local0 = model:get()
		if f67_local0 ~= nil then
			MyShopTimer.TextBox2:setText(f67_local0)
		end
	end)
	self:addElement(MyShopTimer)
	self.MyShopTimer = MyShopTimer
	local SpecialOrdersTimer = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -273, -33, 0.5, 0.5, -369, -319)
	SpecialOrdersTimer:subscribeToGlobalModel(f1_arg1, "ItemshopRotation", "loot_itemshop_slot3_timer", function(model)
		local f68_local0 = model:get()
		if f68_local0 ~= nil then
			SpecialOrdersTimer.TextBox2:setText(f68_local0)
		end
	end)
	self:addElement(SpecialOrdersTimer)
	self.SpecialOrdersTimer = SpecialOrdersTimer
	local MyShop = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	MyShop:setLeftRight(0.5, 0.5, 12, 252)
	MyShop:setTopBottom(0.5, 0.5, -319, 191)
	MyShop:setWidgetType(CoD.BMTallItemContainer)
	MyShop:setSpacing(30)
	MyShop:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MyShop:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	MyShop:setDataSource("MyShopItemList")
	MyShop:linkToElementModel(MyShop, "lootType", true, function(model, f69_arg1)
		CoD.Menu.UpdateButtonShownState(f69_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	MyShop:registerEventHandler("list_item_lose_focus", function(element, event)
		local f70_local0 = nil
		CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		return f70_local0
	end)
	MyShop:registerEventHandler("occlusion_change", function(element, event)
		local f71_local0 = nil
		if element.OcclusionChange then
			f71_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f71_local0 = element.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", false) then
			CoD.BlackMarketUtility.TriggerItemShopRevealAnimation(f1_arg1, element)
			CoD.GridAndListUtility.UpdateDataSource(element, true, true, true)
		end
		if not f71_local0 then
			f71_local0 = element:dispatchEventToChildren(event)
		end
		return f71_local0
	end)
	MyShop:registerEventHandler("list_item_gain_focus", function(element, event)
		local f72_local0 = nil
		if not IsListElementChildInState(element, "BMTallItem", "MysteryItem") then
			SetElementModelToFocusedElementModel(f1_arg1, self, element, "SupplyChainDetails")
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
		end
		return f72_local0
	end)
	MyShop:registerEventHandler("gain_focus", function(element, event)
		local f73_local0 = nil
		if element.gainFocus then
			f73_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f73_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		return f73_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MyShop, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsListElementChildInState(element, "BMTallItem", "MysteryItem") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsListElementChildInState(element, "BMTallItem", "DefaultState") and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lootType", LuaEnum.LOOT_TYPE.CONTRACT) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(MyShop, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(MyShop, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItemOnParentGridOrList(element, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(MyShop, "updateDataSource", function(element, controller, f80_arg2, f80_arg3)
		if CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.EMPTY) then
			SetAlpha(self.MyShopTimer, 0)
		elseif CoD.BlackMarketUtility.IsShopListInFocus(f1_arg1, element) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.EMPTY) then
			CoD.BlackMarketUtility.AutoPlayGestureIfApplicable(f1_arg0, element, f1_arg1)
			SetAlpha(self.MyShopTimer, 1)
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.EMPTY) then
			SetAlpha(self.MyShopTimer, 0)
		elseif not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.EMPTY) then
			SetAlpha(self.MyShopTimer, 1)
		end
	end)
	MyShop:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f81_local0 = MyShop
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f81_local0, true, true, true)
		end
	end)
	self:addElement(MyShop)
	self.MyShop = MyShop
	local MyShopLabel = LUI.UIText.new(0.5, 0.5, 7, 247, 0.5, 0.5, -388, -370)
	MyShopLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MyShopLabel:setText(LocalizeToUpperString(@"menu/my_shop"))
	MyShopLabel:setTTF("ttmussels_regular")
	MyShopLabel:setLetterSpacing(4)
	MyShopLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MyShopLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(MyShopLabel)
	self.MyShopLabel = MyShopLabel
	local TransactionDeepLinkButton = nil
	TransactionDeepLinkButton = CoD.DirectorPreGameButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -840, -610, 0, 0, 748, 818)
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(@"hash_44031C820A02E7BA"))
	TransactionDeepLinkButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_44031C820A02E7BA"))
	TransactionDeepLinkButton:registerEventHandler("gain_focus", function(element, event)
		local f82_local0 = nil
		if element.gainFocus then
			f82_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f82_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f82_local0
	end)
	f1_arg0:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkBlackmarket(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(TransactionDeepLinkButton, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.OpenTransactionsDeepLinkBlackmarket(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCKoreaUtility.IsInKorea() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
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
	MyShopBracket:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	MyShopBracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	MyShopBracket:setShaderVector(0, 0, 0, 0, 0)
	MyShopBracket:setupNineSliceShader(16, 4)
	self:addElement(MyShopBracket)
	self.MyShopBracket = MyShopBracket
	local DiscountTiersWidget = CoD.DiscountTiersContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	DiscountTiersWidget:registerEventHandler("gain_list_focus", function(element, event)
		local f87_local0 = nil
		SetElementState(self, self.DiscountTiersWidget, f1_arg1, "DefaultState")
		return f87_local0
	end)
	DiscountTiersWidget:registerEventHandler("lose_list_focus", function(element, event)
		local f88_local0 = nil
		UpdateElementState(self, "DiscountTiersWidget", f1_arg1)
		return f88_local0
	end)
	DiscountTiersWidget:registerEventHandler("list_item_gain_focus", function(element, event)
		local f89_local0 = nil
		CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		return f89_local0
	end)
	self:addElement(DiscountTiersWidget)
	self.DiscountTiersWidget = DiscountTiersWidget
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f91_arg0, f91_arg1)
		f91_arg1.menu = f91_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f91_arg1)
	end)
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local19(f1_local18, f1_local20.LastInput, function(f92_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f92_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "RefreshDWInventoryMenu", function(model)
		local f93_local0 = self
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
	DiscountTiersWidget.id = "DiscountTiersWidget"
	self.__defaultFocus = SpecialOrders
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local19 = self
	SendClientScriptMenuChangeNotifyWithState(f1_arg1, f1_arg0, true, "character")
	SetMenuProperty(f1_arg0, "__hideSupplyChainDetailsButtons", true)
	CoD.BlackMarketUtility.ForceStreamStoreImages(f1_arg1)
	CoD.BlackMarketUtility.TriggerGreetingVO(self, f1_arg1)
	CoD.BlackMarketUtility.SetupBlackJackFrameContextualMenus(self, f1_arg1)
	CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, f1_local19)
	f1_local19 = FeaturedSlot1
	CoD.BaseUtility.DisableNavigation(f1_local19)
	SetElementProperty(f1_local19, "__loopOnSameRow", true)
	SetElementProperty(f1_local19, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local19)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local19, 0.5)
	f1_local19 = FeaturedSlot2
	CoD.BaseUtility.DisableNavigation(f1_local19)
	SetElementProperty(f1_local19, "__loopOnSameRow", true)
	SetElementProperty(f1_local19, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local19)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local19, 0.5)
	f1_local19 = SpecialOrders
	CoD.BaseUtility.DisableNavigation(f1_local19)
	SetElementProperty(f1_local19, "__loopOnSameRow", true)
	SetElementProperty(f1_local19, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local19)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local19, 0.5)
	f1_local19 = MyShop
	CoD.BaseUtility.DisableNavigation(f1_local19)
	SetElementProperty(f1_local19, "__loopOnSameRow", true)
	SetElementProperty(f1_local19, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local19)
	f1_local19 = TransactionDeepLinkButton
	if IsPC() and not CoD.PCKoreaUtility.ShowTransactionHistoryButton() then
		ReplaceElementWithFake(self, "TransactionDeepLinkButton")
	end
	return self
end
CoD.BlackJacksShopFrameNoPreview.__resetProperties = function(f94_arg0)
	f94_arg0.MyShop:completeAnimation()
	f94_arg0.SpecialOrders:completeAnimation()
	f94_arg0.FeaturedSlot2:completeAnimation()
	f94_arg0.FeaturedSlot1:completeAnimation()
	f94_arg0.MyShop:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	f94_arg0.SpecialOrders:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	f94_arg0.FeaturedSlot2:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
	f94_arg0.FeaturedSlot1:setHorizontalCounter(CoD.horizontalCounterTriggerPrompts)
end
CoD.BlackJacksShopFrameNoPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f95_arg0, f95_arg1)
			f95_arg0:__resetProperties()
			f95_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f96_arg0, f96_arg1)
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter(4)
			f96_arg0.FeaturedSlot1:completeAnimation()
			f96_arg0.FeaturedSlot1:setHorizontalCounter(CoD.horizontalCounter)
			f96_arg0.clipFinished(f96_arg0.FeaturedSlot1)
			f96_arg0.FeaturedSlot2:completeAnimation()
			f96_arg0.FeaturedSlot2:setHorizontalCounter(CoD.horizontalCounter)
			f96_arg0.clipFinished(f96_arg0.FeaturedSlot2)
			f96_arg0.SpecialOrders:completeAnimation()
			f96_arg0.SpecialOrders:setHorizontalCounter(CoD.horizontalCounter)
			f96_arg0.clipFinished(f96_arg0.SpecialOrders)
			f96_arg0.MyShop:completeAnimation()
			f96_arg0.MyShop:setHorizontalCounter(CoD.horizontalCounter)
			f96_arg0.clipFinished(f96_arg0.MyShop)
		end,
	},
}
CoD.BlackJacksShopFrameNoPreview.__onClose = function(f97_arg0)
	f97_arg0.FeaturedSlot1Timer:close()
	f97_arg0.FeaturedSlot1:close()
	f97_arg0.FeaturedSlot2Timer:close()
	f97_arg0.FeaturedSlot2:close()
	f97_arg0.SpecialOrders:close()
	f97_arg0.MyShopTimer:close()
	f97_arg0.SpecialOrdersTimer:close()
	f97_arg0.MyShop:close()
	f97_arg0.TransactionDeepLinkButton:close()
	f97_arg0.DiscountTiersWidget:close()
end
