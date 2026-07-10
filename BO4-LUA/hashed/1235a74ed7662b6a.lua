require("x64:e587cf1bb800f1f")
require("x64:ca897ba9d64c37c")
CoD.ReservesBribeStackCarouselTall = InheritFrom(LUI.UIElement)
CoD.ReservesBribeStackCarouselTall.__defaultWidth = 240
CoD.ReservesBribeStackCarouselTall.__defaultHeight = 510
CoD.ReservesBribeStackCarouselTall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesBribeStackCarouselTall)
	self.id = "ReservesBribeStackCarouselTall"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CrateCarousel = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, true, false, false, false)
	CrateCarousel:setLeftRight(0, 0, 0, 240)
	CrateCarousel:setTopBottom(0, 0, 0, 510)
	CrateCarousel:setWidgetType(CoD.ReservesBribeStackTall)
	CrateCarousel:setSpacing(12)
	CrateCarousel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CrateCarousel:setDataSource("BribeMenuList")
	CrateCarousel:registerEventHandler("gain_list_focus", function(element, event)
		local f2_local0 = nil
		SetControllerModelValue(f1_arg1, "reservesViewingCrates", false)
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, element)
		return f2_local0
	end)
	CrateCarousel:registerEventHandler("lose_list_focus", function(element, event)
		local f3_local0 = nil
		SetControllerModelValue(f1_arg1, "reservesViewingCrates", true)
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, element)
		return f3_local0
	end)
	CrateCarousel:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "MWHEELDOWN", function(element, menu, controller, model)
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
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MWHEELUP", function(element, menu, controller, model)
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
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		OpenOverlay(self, "WeaponBribeSelection", controller)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(CrateCarousel, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.PlayReservesPreviewVideo(controller, menu, false, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(CrateCarousel, "updateDataSource", function(element, controller, f13_arg2, f13_arg3)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(element)
	end)
	self:addElement(CrateCarousel)
	self.CrateCarousel = CrateCarousel
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f15_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	CrateCarousel.id = "CrateCarousel"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = CrateCarousel
	CoD.BaseUtility.DisableNavigation(f1_local3)
	SetElementProperty(f1_local3, "__loopOnSameRow", true)
	SetElementProperty(f1_local3, "__allowCreateOnLoop", true)
	CoD.BlackMarketUtility.InitialHideScrollPrompts(self, f1_arg1, f1_local3)
	CoD.BlackMarketUtility.ShopCycleThroughItems(f1_arg0, f1_arg1, f1_local3, 0.5)
	CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f1_local3)
	return self
end
CoD.ReservesBribeStackCarouselTall.__resetProperties = function(f17_arg0)
	f17_arg0.CrateCarousel:completeAnimation()
	f17_arg0.CrateCarousel:setScale(1, 1)
end
CoD.ReservesBribeStackCarouselTall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.CrateCarousel:completeAnimation()
			f19_arg0.CrateCarousel:setScale(1.05, 1.05)
			f19_arg0.clipFinished(f19_arg0.CrateCarousel)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.CrateCarousel:beginAnimation(200)
				f20_arg0.CrateCarousel:setScale(1.05, 1.05)
				f20_arg0.CrateCarousel:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.CrateCarousel:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.CrateCarousel:completeAnimation()
			f20_arg0.CrateCarousel:setScale(1, 1)
			f20_local0(f20_arg0.CrateCarousel)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.CrateCarousel:beginAnimation(200)
				f22_arg0.CrateCarousel:setScale(1, 1)
				f22_arg0.CrateCarousel:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.CrateCarousel:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.CrateCarousel:completeAnimation()
			f22_arg0.CrateCarousel:setScale(1.05, 1.05)
			f22_local0(f22_arg0.CrateCarousel)
		end,
	},
	KBM = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.CrateCarousel:completeAnimation()
			f25_arg0.CrateCarousel:setScale(1.05, 1.05)
			f25_arg0.clipFinished(f25_arg0.CrateCarousel)
		end,
		GainChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.CrateCarousel:beginAnimation(200)
				f26_arg0.CrateCarousel:setScale(1.05, 1.05)
				f26_arg0.CrateCarousel:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.CrateCarousel:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.CrateCarousel:completeAnimation()
			f26_arg0.CrateCarousel:setScale(1, 1)
			f26_local0(f26_arg0.CrateCarousel)
		end,
		LoseChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.CrateCarousel:beginAnimation(200)
				f28_arg0.CrateCarousel:setScale(1, 1)
				f28_arg0.CrateCarousel:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.CrateCarousel:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.CrateCarousel:completeAnimation()
			f28_arg0.CrateCarousel:setScale(1.05, 1.05)
			f28_local0(f28_arg0.CrateCarousel)
		end,
	},
}
CoD.ReservesBribeStackCarouselTall.__onClose = function(f30_arg0)
	f30_arg0.CrateCarousel:close()
end
