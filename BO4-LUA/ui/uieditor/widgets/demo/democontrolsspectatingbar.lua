require("x64:a969a8392712433")
CoD.DemoControlsSpectatingBar = InheritFrom(LUI.UIElement)
CoD.DemoControlsSpectatingBar.__defaultWidth = 290
CoD.DemoControlsSpectatingBar.__defaultHeight = 30
CoD.DemoControlsSpectatingBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoControlsSpectatingBar)
	self.id = "DemoControlsSpectatingBar"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	self.leftButton = LUI.UIElement.createFake()
	local PlayerName = LUI.UIText.new(0, 1, 34, -34, 0.5, 0.5, -10, 10)
	PlayerName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PlayerName:setTTF("notosans_bold")
	PlayerName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	PlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayerName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	PlayerName:subscribeToGlobalModel(f1_arg1, "Demo", "clientNum", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerName:setText(GetClientNameAndClanTag(f1_arg1, f2_local0))
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local f1_local3 = nil
	self.rightButton = LUI.UIElement.createFake()
	local LeftArrow = nil
	LeftArrow = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0, 0, 0, 67, 0, 0, -7.5, 37.5)
	LeftArrow.KeyMouseImage:setYRot(180)
	LeftArrow.KeyMouseImage:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	LeftArrow:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LeftArrow.ControllerImage:setImage(RegisterImage(f3_local0))
		end
	end)
	LeftArrow:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if IsGamepad(f1_arg1) then
			HideWidget(element)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	LeftArrow:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeftArrow, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		CoD.DemoUtility.LeftBumperAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	local RightArrow = nil
	RightArrow = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0, 0, 223, 290, 0, 0, -7.5, 37.5)
	RightArrow.KeyMouseImage:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	RightArrow:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			RightArrow.ControllerImage:setImage(RegisterImage(f8_local0))
		end
	end)
	RightArrow:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		if IsGamepad(f1_arg1) then
			HideWidget(element)
		end
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	RightArrow:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightArrow, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		CoD.DemoUtility.RightBumperAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	self:mergeStateConditions({
		{
			stateName = "WithButtonPromptsKBM",
			condition = function(menu, element, event)
				local f13_local0
				if not IsDemoClipPlaying() and not CoD.HUDUtility.IsGameTypeEqualToString("fr") and not IsFreeCameraLockedOnEntity(f1_arg1) then
					f13_local0 = IsMouseOrKeyboard(f1_arg1)
					if f13_local0 then
						f13_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("demo.isDefaultCameraMode")
					end
				else
					f13_local0 = false
				end
				return f13_local0
			end,
		},
		{
			stateName = "WithButtonPrompts",
			condition = function(menu, element, event)
				local f14_local0
				if not IsDemoClipPlaying() and not CoD.HUDUtility.IsGameTypeEqualToString("fr") and not IsFreeCameraLockedOnEntity(f1_arg1) then
					f14_local0 = IsGamepad(f1_arg1)
				else
					f14_local0 = false
				end
				return f14_local0
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["demo.isFreeCameraLockedOnEntity"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "demo.isFreeCameraLockedOnEntity",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f16_arg1)
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["demo.isDefaultCameraMode"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "demo.isDefaultCameraMode",
		})
	end, false)
	if CoD.isPC then
		LeftArrow.id = "LeftArrow"
	end
	if CoD.isPC then
		RightArrow.id = "RightArrow"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.DemoUtility.AddSubscriptionsToUpdatePlayerNameTextfield(self.PlayerName, f1_arg1)
	DisableKeyboardNavigationByElement(LeftArrow)
	DisableKeyboardNavigationByElement(RightArrow)
	return self
end
CoD.DemoControlsSpectatingBar.__resetProperties = function(f19_arg0)
	f19_arg0.leftButton:completeAnimation()
	f19_arg0.rightButton:completeAnimation()
	f19_arg0.LeftArrow:completeAnimation()
	f19_arg0.RightArrow:completeAnimation()
	f19_arg0.leftButton:setAlpha(1)
	f19_arg0.rightButton:setAlpha(1)
	f19_arg0.LeftArrow:setAlpha(1)
	f19_arg0.RightArrow:setAlpha(1)
end
CoD.DemoControlsSpectatingBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.leftButton:completeAnimation()
			f20_arg0.leftButton:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.leftButton)
			f20_arg0.rightButton:completeAnimation()
			f20_arg0.rightButton:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.rightButton)
			f20_arg0.LeftArrow:completeAnimation()
			f20_arg0.LeftArrow:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.LeftArrow)
			f20_arg0.RightArrow:completeAnimation()
			f20_arg0.RightArrow:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.RightArrow)
		end,
	},
	WithButtonPromptsKBM = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.leftButton:completeAnimation()
			f21_arg0.leftButton:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.leftButton)
			f21_arg0.rightButton:completeAnimation()
			f21_arg0.rightButton:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.rightButton)
			f21_arg0.LeftArrow:completeAnimation()
			f21_arg0.LeftArrow:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.LeftArrow)
			f21_arg0.RightArrow:completeAnimation()
			f21_arg0.RightArrow:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.RightArrow)
		end,
	},
	WithButtonPrompts = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.leftButton:completeAnimation()
			f22_arg0.leftButton:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.leftButton)
			f22_arg0.rightButton:completeAnimation()
			f22_arg0.rightButton:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.rightButton)
			f22_arg0.LeftArrow:completeAnimation()
			f22_arg0.LeftArrow:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.LeftArrow)
			f22_arg0.RightArrow:completeAnimation()
			f22_arg0.RightArrow:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.RightArrow)
		end,
	},
}
CoD.DemoControlsSpectatingBar.__onClose = function(f23_arg0)
	f23_arg0.leftButton:close()
	f23_arg0.PlayerName:close()
	f23_arg0.rightButton:close()
	f23_arg0.LeftArrow:close()
	f23_arg0.RightArrow:close()
end
