require("x64:e6df4068375d284")
require("x64:37ed89902d7e13c")
CoD.StartMenu_QuitButton = InheritFrom(LUI.UIElement)
CoD.StartMenu_QuitButton.__defaultWidth = 240
CoD.StartMenu_QuitButton.__defaultHeight = 75
CoD.StartMenu_QuitButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_QuitButton)
	self.id = "StartMenu_QuitButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorGenericButton = CoD.DirectorGenericButton.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 0, 92)
	DirectorGenericButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x0))
	DirectorGenericButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x0))
	self:addElement(DirectorGenericButton)
	self.DirectorGenericButton = DirectorGenericButton
	local HoldButtonFill = CoD.StartMenu_QuitButtonFill.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 0, 91)
	HoldButtonFill:mergeStateConditions({
		{
			stateName = "Playing",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "buttonBit->progress", 0) then
					f2_local0 = CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "DirectorGenericButton")
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	HoldButtonFill:linkToElementModel(HoldButtonFill, "buttonBit", true, function(model)
		if HoldButtonFill["__stateValidation_buttonBit->progress"] then
			HoldButtonFill:removeSubscription(HoldButtonFill["__stateValidation_buttonBit->progress"])
			HoldButtonFill["__stateValidation_buttonBit->progress"] = nil
		end
		if model then
			local f3_local0 = model:get()
			local f3_local1 = model:get()
			model = f3_local0 and f3_local1.progress
		end
		if model then
			HoldButtonFill["__stateValidation_buttonBit->progress"] = HoldButtonFill:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(HoldButtonFill, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "buttonBit->progress",
				})
			end)
		end
	end)
	HoldButtonFill:appendEventHandler("record_curr_focused_elem_id", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(HoldButtonFill, f5_arg1)
	end)
	HoldButtonFill:setAlpha(0)
	HoldButtonFill:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xba_pscross"], false, function(model)
		HoldButtonFill:setModel(model, f1_arg1)
	end)
	self:addElement(HoldButtonFill)
	self.HoldButtonFill = HoldButtonFill
	local TextBox = LUI.UIText.new(0, 0, 0, 250, 0, 0, 34, 58)
	TextBox:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TextBox:setText(LocalizeToUpperString(@"menu/quit_game"))
	TextBox:setTTF("ttmussels_demibold")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	TextBox:setShaderVector(0, 0, 0, 0, 0)
	TextBox:setShaderVector(1, 0, 0, 0, 0)
	TextBox:setShaderVector(2, 1, 0, 0, 0)
	TextBox:setLetterSpacing(3)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "EndGame",
			condition = function(menu, element, event)
				local f7_local0 = IsLobbyHost()
				if f7_local0 then
					if not IsOnlineGame() and not InFrontend() and not IsDemoPlaying() then
						f7_local0 = IsGamepad(f1_arg1)
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
	})
	self:appendEventHandler("on_session_start", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f8_arg1)
	end)
	self:appendEventHandler("on_session_end", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	self:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f10_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	DirectorGenericButton.id = "DirectorGenericButton"
	self.__defaultFocus = DirectorGenericButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_QuitButton.__resetProperties = function(f12_arg0)
	f12_arg0.HoldButtonFill:completeAnimation()
	f12_arg0.TextBox:completeAnimation()
	f12_arg0.HoldButtonFill:setAlpha(0)
	f12_arg0.TextBox:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f12_arg0.TextBox:setShaderVector(0, 0, 0, 0, 0)
	f12_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
	f12_arg0.TextBox:setShaderVector(2, 1, 0, 0, 0)
end
CoD.StartMenu_QuitButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.DirectorGenericButton:completeAnimation()
			f13_arg0.clipFinished(f13_arg0.DirectorGenericButton)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.DirectorGenericButton:completeAnimation()
			f14_arg0.clipFinished(f14_arg0.DirectorGenericButton)
			f14_arg0.HoldButtonFill:completeAnimation()
			f14_arg0.HoldButtonFill:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.HoldButtonFill)
			f14_arg0.TextBox:completeAnimation()
			f14_arg0.TextBox:setRGB(0, 0, 0)
			f14_arg0.clipFinished(f14_arg0.TextBox)
		end,
	},
	EndGame = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.DirectorGenericButton:completeAnimation()
			f15_arg0.clipFinished(f15_arg0.DirectorGenericButton)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.DirectorGenericButton:completeAnimation()
			f16_arg0.clipFinished(f16_arg0.DirectorGenericButton)
			f16_arg0.HoldButtonFill:completeAnimation()
			f16_arg0.HoldButtonFill:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.HoldButtonFill)
			f16_arg0.TextBox:completeAnimation()
			f16_arg0.TextBox:setRGB(0, 0, 0)
			f16_arg0.TextBox:setShaderVector(0, 0.1, 0, 0, 0)
			f16_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
			f16_arg0.TextBox:setShaderVector(2, 1, 0, 0, 0)
			f16_arg0.clipFinished(f16_arg0.TextBox)
		end,
	},
}
CoD.StartMenu_QuitButton.__onClose = function(f17_arg0)
	f17_arg0.DirectorGenericButton:close()
	f17_arg0.HoldButtonFill:close()
end
