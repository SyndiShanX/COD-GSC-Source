require("x64:fbffc86e9a93477")
require("x64:2d64ca9d3c705ce")
require("x64:1e49bf76681d2a3")
require("x64:38c11a77e96e48c")
require("x64:c7e896ee4bc3f8")
require("x64:e092a33d3fffe9")
CoD.MPSpecialistHUBGesturesInternal = InheritFrom(LUI.UIElement)
CoD.MPSpecialistHUBGesturesInternal.__defaultWidth = 1920
CoD.MPSpecialistHUBGesturesInternal.__defaultHeight = 1080
CoD.MPSpecialistHUBGesturesInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PlayerRoleUtility.SendClientNotifyGestureMenu(f1_arg0, f1_arg1)
	CoD.PlayerRoleUtility.RefreshAnim(f1_arg1)
	self:setClass(CoD.MPSpecialistHUBGesturesInternal)
	self.id = "MPSpecialistHUBGesturesInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0, 0, 299.5, 1166.5, 0, 0, 139.5, 871.5)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local emblemListBg = LUI.UIImage.new(0, 0, 209, 1258, 0, 0, 74.5, 919.5)
	emblemListBg:setScale(0.77, 0.77)
	emblemListBg:setImage(RegisterImage(@"uie_ui_menu_emblem_empty_bg"))
	emblemListBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	emblemListBg:setShaderVector(0, 0, 0, 0, 0)
	emblemListBg:setupNineSliceShader(212, 212)
	self:addElement(emblemListBg)
	self.emblemListBg = emblemListBg
	local gestures = LUI.UIList.new(f1_arg0, f1_arg1, 11, 0, nil, true, false, false, false)
	gestures:setLeftRight(0, 0, 331.5, 1135.5)
	gestures:setTopBottom(0, 0, 172.5, 813.5)
	gestures:setWidgetType(CoD.HubGestureButton)
	gestures:setHorizontalCount(5)
	gestures:setVerticalCount(4)
	gestures:setSpacing(11)
	gestures:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	gestures:setDataSource("SpecialistGesturesList")
	gestures:linkToElementModel(gestures, "owned", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	gestures:linkToElementModel(gestures, "trialLocked", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	gestures:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	local verticalCounter = gestures
	local PreviewMessagePC = gestures.subscribeToModel
	local ItemInfoPanel = Engine[@"getmodelforcontroller"](f1_arg1)
	PreviewMessagePC(verticalCounter, ItemInfoPanel.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	gestures:linkToElementModel(gestures, "available", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end)
	gestures:registerEventHandler("list_item_gain_focus", function(element, event)
		local f7_local0 = nil
		if IsMouseOrKeyboard(f1_arg1) and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available") then
			CoD.PlayerRoleUtility.PreviewGesture(f1_arg0, element, f1_arg1, false)
		end
		return f7_local0
	end)
	gestures:registerEventHandler("list_item_lose_focus", function(element, event)
		local f8_local0 = nil
		CoD.BreadcrumbUtility.SetSprayGestureAsOld(f1_arg0, element, f1_arg1)
		return f8_local0
	end)
	gestures:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(gestures, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			PlaySoundAlias("uin_main_edit")
			CoD.PlayerRoleUtility.BindGestureTagToSlot(menu, element, controller)
			return true
		elseif IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.PlayerRoleUtility.PreviewGesture(menu, element, controller, false)
			PlaySoundAlias("uin_main_edit")
			CoD.PlayerRoleUtility.BindGestureTagToSlot(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(gestures, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "available") then
			PlaySoundAlias("uin_toggle_generic")
			CoD.PlayerRoleUtility.PreviewGesture(menu, element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "available") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/preview", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(gestures, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE2", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "available") then
			PlaySoundAlias("uin_toggle_generic")
			CoD.PlayerRoleUtility.PreviewGesture(menu, element, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "available") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE2")
			return false
		else
			return false
		end
	end, false)
	self:addElement(gestures)
	self.gestures = gestures
	PreviewMessagePC = nil
	PreviewMessagePC = CoD.PCStartMenuOptionsUnbindKeybindMessage.new(f1_arg0, f1_arg1, 0, 0, 152.5, 278.5, 0, 0, 181.5, 205.5)
	PreviewMessagePC:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PreviewMessagePC:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PreviewMessagePC, f17_arg1)
	end)
	ItemInfoPanel = PreviewMessagePC
	verticalCounter = PreviewMessagePC.subscribeToModel
	local DotLineBottom = Engine[@"getmodelforcontroller"](f1_arg1)
	verticalCounter(ItemInfoPanel, DotLineBottom.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(PreviewMessagePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	PreviewMessagePC:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	PreviewMessagePC:setAlpha(0)
	PreviewMessagePC.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_66325526C09EADAB"))
	self:addElement(PreviewMessagePC)
	self.PreviewMessagePC = PreviewMessagePC
	verticalCounter = CoD.verticalCounter.new(f1_arg0, f1_arg1, 0, 0, 331.5, 1135.5, 0, 0, 813.5, 850.5)
	self:addElement(verticalCounter)
	self.verticalCounter = verticalCounter
	ItemInfoPanel = CoD.BM_ItemInfoPanel.new(f1_arg0, f1_arg1, 1, 1, -692.5, -152.5, 0.5, 0.5, 247.5, 397.5)
	self:addElement(ItemInfoPanel)
	self.ItemInfoPanel = ItemInfoPanel
	DotLineBottom = LUI.UIImage.new(0, 0, 328, 1139, 0, 0, 852.5, 856.5)
	DotLineBottom:setAlpha(0.4)
	DotLineBottom:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	DotLineBottom:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(DotLineBottom)
	self.DotLineBottom = DotLineBottom
	local DotLineTop = LUI.UIImage.new(0, 0, 328, 1139, 0, 0, 154.5, 158.5)
	DotLineTop:setAlpha(0.4)
	DotLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	DotLineTop:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(DotLineTop)
	self.DotLineTop = DotLineTop
	local TrialWidget = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 1, 1, -692.5, -152.5, 0.5, 0.5, 204.5, 239.5)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
	})
	TrialWidget:linkToElementModel(TrialWidget, "trialLocked", true, function(model)
		f1_arg0:updateElementState(TrialWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	local TrialWidgetLocked = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 1, 1, -692.5, -152.5, 0.5, 0.5, 204.5, 239.5)
	TrialWidgetLocked:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "lootLocked")
			end,
		},
	})
	TrialWidgetLocked:linkToElementModel(TrialWidgetLocked, "lootLocked", true, function(model)
		f1_arg0:updateElementState(TrialWidgetLocked, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lootLocked",
		})
	end)
	TrialWidgetLocked.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_48C8E3A75045BE50"))
	self:addElement(TrialWidgetLocked)
	self.TrialWidgetLocked = TrialWidgetLocked
	ItemInfoPanel:linkToElementModel(gestures, nil, false, function(model)
		ItemInfoPanel:setModel(model, f1_arg1)
	end)
	TrialWidget:linkToElementModel(gestures, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg1)
	end)
	TrialWidgetLocked:linkToElementModel(gestures, nil, false, function(model)
		TrialWidgetLocked:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendCustomClientScriptMenuChangeNotify(f1_arg1, "MPSpecialistHUBGestures", false)
		SetControllerModelValue(f1_arg1, "MPSpecialistHUBBindWheel.NoBackground", false)
		CoD.PlayerRoleUtility.StopGesturePreview(f1_arg0, f1_arg1)
		CoD.PlayerRoleUtility.RefreshAnim(f1_arg1)
	end)
	gestures.id = "gestures"
	verticalCounter.id = "verticalCounter"
	self.__defaultFocus = gestures
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local11 = self
	SetControllerModelValue(f1_arg1, "MPSpecialistHUBBindWheel.NoBackground", true)
	SetAsListVerticalCounter(self, verticalCounter, "gestures")
	return self
end
CoD.MPSpecialistHUBGesturesInternal.__resetProperties = function(f27_arg0)
	f27_arg0.gestures:completeAnimation()
	f27_arg0.ItemInfoPanel:completeAnimation()
	f27_arg0.gestures:setAlpha(1)
	f27_arg0.ItemInfoPanel:setAlpha(1)
end
CoD.MPSpecialistHUBGesturesInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			local f28_local0 = function(f29_arg0)
				f29_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f29_arg0:setAlpha(1)
				f29_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.gestures:beginAnimation(100)
			f28_arg0.gestures:setAlpha(0)
			f28_arg0.gestures:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
			f28_arg0.gestures:registerEventHandler("transition_complete_keyframe", f28_local0)
			local f28_local1 = function(f30_arg0)
				f30_arg0:beginAnimation(149)
				f30_arg0:setAlpha(1)
				f30_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.ItemInfoPanel:beginAnimation(300)
			f28_arg0.ItemInfoPanel:setAlpha(0)
			f28_arg0.ItemInfoPanel:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
			f28_arg0.ItemInfoPanel:registerEventHandler("transition_complete_keyframe", f28_local1)
		end,
	},
}
CoD.MPSpecialistHUBGesturesInternal.__onClose = function(f31_arg0)
	f31_arg0.ItemInfoPanel:close()
	f31_arg0.TrialWidget:close()
	f31_arg0.TrialWidgetLocked:close()
	f31_arg0.FramingCornerBrackets:close()
	f31_arg0.gestures:close()
	f31_arg0.PreviewMessagePC:close()
	f31_arg0.verticalCounter:close()
end
