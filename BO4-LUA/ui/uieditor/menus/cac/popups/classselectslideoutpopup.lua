require("x64:6cf3186a2428424")
require("x64:6db94b193106b49")
require("x64:2675595fa323085")
CoD.ClassSelectSlideoutPopup = InheritFrom(CoD.Menu)
LUI.createMenu.ClassSelectSlideoutPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ClassSelectSlideoutPopup", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ClassSelectSlideoutPopup)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local FullBackground = LUI.UIImage.new(-0.1, 1.1, 0, 0, -0.15, 1.15, 0, 0)
	FullBackground:setRGB(0, 0, 0)
	FullBackground:setAlpha(0.25)
	self:addElement(FullBackground)
	self.FullBackground = FullBackground
	local ChooseClassSlideOut = CoD.ChooseClassSlideOut.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, 0, 600)
	self:addElement(ChooseClassSlideOut)
	self.ChooseClassSlideOut = ChooseClassSlideOut
	local MouseFocusClose = nil
	MouseFocusClose = CoD.emptyFocusable.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MouseFocusClose:setAlpha(0)
	MouseFocusClose:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_none"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(MouseFocusClose, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.StartMenuUtility.HideClassSelectSlideout(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(MouseFocusClose)
	self.MouseFocusClose = MouseFocusClose
	local FooterContainerFrontendRight = CoD.FooterContainer_Ingame_Right.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -48, 0)
	FooterContainerFrontendRight:setAlpha(0)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	self:mergeStateConditions({
		{
			stateName = "Open",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg0, "StartMenu_Main.ShowClassSelect")
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local7(f1_local6, f1_local8["StartMenu_Main.ShowClassSelect"], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "StartMenu_Main.ShowClassSelect",
		})
	end, false)
	self:linkToElementModel(self, nil, true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if not IsPC() then
			CoD.StartMenuUtility.HideClassSelectSlideout(menu, controller)
			return true
		else
			CoD.StartMenuUtility.HideClassSelectSlideout(menu, controller)
			return true
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/dismiss", nil, nil)
			return true
		else
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCurrentClassLocked(menu, controller) and IsPC() then
			CoD.PCUtility.ConfirmChangeClass(menu, controller)
			return true
		elseif not CoD.CACUtility.IsCurrentClassLocked(menu, controller) and not IsPC() then
			CoD.BaseUtility.CallCustomElementFunction(self, self.ChooseClassSlideOut, controller, menu, "_chooseClass")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCurrentClassLocked(menu, controller) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		elseif not CoD.CACUtility.IsCurrentClassLocked(menu, controller) and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f12_arg2, f12_arg3, f12_arg4)
		if IsSelfInState(self, "Open") then
			PlaySoundAlias("cac_loadout_edit_select_primary")
			MenuHidesFreeCursor(f1_local1, controller)
			CoD.BaseUtility.DisableNavigation(f1_local1)
		elseif IsSelfInState(self, "DefaultState") then
			MenuUnhideFreeCursor(f1_local1, controller)
			CoD.BaseUtility.EnableNavigation(f1_local1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "StartMenu_Main.clear_transition", function(model)
		local f13_local0 = self
		CoD.StartMenuUtility.HideClassSelectSlideout(f1_local1, f1_arg0)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "engineLoadoutSelect", function(model)
		local f14_local0 = self
		if IsPC() then
			CoD.StartMenuUtility.HideClassSelectSlideout(f1_local1, f1_arg0)
		end
	end)
	ChooseClassSlideOut.id = "ChooseClassSlideOut"
	if CoD.isPC then
		MouseFocusClose.id = "MouseFocusClose"
	end
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local7 = self
	SetProperty(self, "disableInputLock", true)
	f1_local7 = FullBackground
	if IsPC() then
		SizeToWidthOfScreen(f1_local7, f1_arg0)
	elseif IsSplitscreenAndInGame(f1_arg0) then
		SizeToWidthOfScreen(f1_local7, f1_arg0)
	end
	f1_local7 = FooterContainerFrontendRight
	if not IsPC() then
		SizeToSafeArea(f1_local7, f1_arg0)
	end
	return self
end
CoD.ClassSelectSlideoutPopup.__resetProperties = function(f15_arg0)
	f15_arg0.FullBackground:completeAnimation()
	f15_arg0.MouseFocusClose:completeAnimation()
	f15_arg0.ChooseClassSlideOut:completeAnimation()
	f15_arg0.FooterContainerFrontendRight:completeAnimation()
	f15_arg0.FullBackground:setAlpha(0.25)
	f15_arg0.MouseFocusClose:setAlpha(0)
	f15_arg0.ChooseClassSlideOut:setTopBottom(1, 1, 0, 600)
	f15_arg0.ChooseClassSlideOut:setAlpha(1)
	f15_arg0.FooterContainerFrontendRight:setAlpha(0)
end
CoD.ClassSelectSlideoutPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.FullBackground:completeAnimation()
			f16_arg0.FullBackground:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.FullBackground)
			f16_arg0.ChooseClassSlideOut:completeAnimation()
			f16_arg0.ChooseClassSlideOut:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ChooseClassSlideOut)
			f16_arg0.MouseFocusClose:completeAnimation()
			f16_arg0.MouseFocusClose:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.MouseFocusClose)
		end,
		Open = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			local f17_local0 = function(f18_arg0)
				f17_arg0.FullBackground:beginAnimation(200)
				f17_arg0.FullBackground:setAlpha(0.8)
				f17_arg0.FullBackground:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FullBackground:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.FullBackground:completeAnimation()
			f17_arg0.FullBackground:setAlpha(0)
			f17_local0(f17_arg0.FullBackground)
			local f17_local1 = function(f19_arg0)
				f17_arg0.ChooseClassSlideOut:beginAnimation(200)
				f17_arg0.ChooseClassSlideOut:setTopBottom(1, 1, -600, 0)
				f17_arg0.ChooseClassSlideOut:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ChooseClassSlideOut:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ChooseClassSlideOut:completeAnimation()
			f17_arg0.ChooseClassSlideOut:setTopBottom(1, 1, 0, 600)
			f17_local1(f17_arg0.ChooseClassSlideOut)
			local f17_local2 = function(f20_arg0)
				f17_arg0.MouseFocusClose:beginAnimation(200)
				f17_arg0.MouseFocusClose:setAlpha(1)
				f17_arg0.MouseFocusClose:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.MouseFocusClose:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.MouseFocusClose:completeAnimation()
			f17_arg0.MouseFocusClose:setAlpha(0)
			f17_local2(f17_arg0.MouseFocusClose)
			local f17_local3 = function(f21_arg0)
				f17_arg0.FooterContainerFrontendRight:beginAnimation(200)
				f17_arg0.FooterContainerFrontendRight:setAlpha(1)
				f17_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.FooterContainerFrontendRight:completeAnimation()
			f17_arg0.FooterContainerFrontendRight:setAlpha(0)
			f17_local3(f17_arg0.FooterContainerFrontendRight)
		end,
	},
	Open = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.FullBackground:completeAnimation()
			f22_arg0.FullBackground:setAlpha(0.8)
			f22_arg0.clipFinished(f22_arg0.FullBackground)
			f22_arg0.ChooseClassSlideOut:completeAnimation()
			f22_arg0.ChooseClassSlideOut:setTopBottom(1, 1, -600, 0)
			f22_arg0.clipFinished(f22_arg0.ChooseClassSlideOut)
			f22_arg0.MouseFocusClose:completeAnimation()
			f22_arg0.MouseFocusClose:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.MouseFocusClose)
			f22_arg0.FooterContainerFrontendRight:completeAnimation()
			f22_arg0.FooterContainerFrontendRight:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.FooterContainerFrontendRight)
		end,
		DefaultState = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.FullBackground:beginAnimation(200)
				f23_arg0.FullBackground:setAlpha(0)
				f23_arg0.FullBackground:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.FullBackground:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.FullBackground:completeAnimation()
			f23_arg0.FullBackground:setAlpha(0.8)
			f23_local0(f23_arg0.FullBackground)
		end,
	},
}
CoD.ClassSelectSlideoutPopup.__onClose = function(f25_arg0)
	f25_arg0.FullBackground:close()
	f25_arg0.ChooseClassSlideOut:close()
	f25_arg0.MouseFocusClose:close()
	f25_arg0.FooterContainerFrontendRight:close()
end
