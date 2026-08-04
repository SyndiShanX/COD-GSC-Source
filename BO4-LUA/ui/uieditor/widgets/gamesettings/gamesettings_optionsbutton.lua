require("ui/uieditor/widgets/commonbuttonoutline")
require("ui/uieditor/widgets/store/storecommontextbacking")
CoD.GameSettings_OptionsButton = InheritFrom(LUI.UIElement)
CoD.GameSettings_OptionsButton.__defaultWidth = 760
CoD.GameSettings_OptionsButton.__defaultHeight = 60
CoD.GameSettings_OptionsButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_OptionsButton)
	self.id = "GameSettings_OptionsButton"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseBacking:setAlpha(0.5)
	NoiseBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseBacking)
	self.NoiseBacking = NoiseBacking
	local DotsBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	DotsBacking:setAlpha(0.4)
	DotsBacking.TiledShaderImage:setupNineSliceShader(42, 42)
	self:addElement(DotsBacking)
	self.DotsBacking = DotsBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local Icon = LUI.UIImage.new(0, 0, 10, 42, 0, 0, 11, 43)
	Icon:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Icon:setAlpha(0)
	Icon:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local OptionText = LUI.UIText.new(0.03, 0.97, 0, 0, 0.31, 0.69, 0, 0)
	OptionText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OptionText:setTTF("ttmussels_regular")
	OptionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	OptionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	OptionText:linkToElementModel(self, "displayText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			OptionText:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(OptionText)
	self.OptionText = OptionText
	local Frame = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame.FocusGlow:setScale(1, 0.9)
	self:addElement(Frame)
	self.Frame = Frame
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	Frame.id = "Frame"
	self.__defaultFocus = Frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_OptionsButton.__resetProperties = function(f6_arg0)
	f6_arg0.Frame:completeAnimation()
	f6_arg0.OptionText:completeAnimation()
	f6_arg0.Icon:completeAnimation()
	f6_arg0.SelectorOverlay:completeAnimation()
	f6_arg0.DotsBacking:completeAnimation()
	f6_arg0.NoiseBacking:completeAnimation()
	f6_arg0.Backing:completeAnimation()
	f6_arg0.Frame:setScale(1, 1)
	f6_arg0.OptionText:setAlpha(1)
	f6_arg0.OptionText:setScale(1, 1)
	f6_arg0.Icon:setAlpha(0)
	f6_arg0.Icon:setScale(1, 1)
	f6_arg0.SelectorOverlay:setAlpha(0.01)
	f6_arg0.SelectorOverlay:setScale(1, 1)
	f6_arg0.DotsBacking:setScale(1, 1)
	f6_arg0.NoiseBacking:setScale(1, 1)
	f6_arg0.Backing:setScale(1, 1)
end
CoD.GameSettings_OptionsButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(7)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.Backing)
			f8_arg0.NoiseBacking:completeAnimation()
			f8_arg0.NoiseBacking:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.NoiseBacking)
			f8_arg0.DotsBacking:completeAnimation()
			f8_arg0.DotsBacking:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.DotsBacking)
			f8_arg0.SelectorOverlay:completeAnimation()
			f8_arg0.SelectorOverlay:setAlpha(0.04)
			f8_arg0.SelectorOverlay:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.SelectorOverlay)
			f8_arg0.Icon:completeAnimation()
			f8_arg0.Icon:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.Icon)
			f8_arg0.OptionText:completeAnimation()
			f8_arg0.OptionText:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.OptionText)
			f8_arg0.Frame:completeAnimation()
			f8_arg0.Frame:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.Frame)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(7)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Backing:beginAnimation(200)
				f9_arg0.Backing:setScale(1.05, 1.05)
				f9_arg0.Backing:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Backing:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Backing:completeAnimation()
			f9_arg0.Backing:setScale(1, 1)
			f9_local0(f9_arg0.Backing)
			local f9_local1 = function(f11_arg0)
				f9_arg0.NoiseBacking:beginAnimation(200)
				f9_arg0.NoiseBacking:setScale(1.05, 1.05)
				f9_arg0.NoiseBacking:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.NoiseBacking:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.NoiseBacking:completeAnimation()
			f9_arg0.NoiseBacking:setScale(1, 1)
			f9_local1(f9_arg0.NoiseBacking)
			local f9_local2 = function(f12_arg0)
				f9_arg0.DotsBacking:beginAnimation(200)
				f9_arg0.DotsBacking:setScale(1.05, 1.05)
				f9_arg0.DotsBacking:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DotsBacking:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.DotsBacking:completeAnimation()
			f9_arg0.DotsBacking:setScale(1, 1)
			f9_local2(f9_arg0.DotsBacking)
			local f9_local3 = function(f13_arg0)
				f9_arg0.SelectorOverlay:beginAnimation(200)
				f9_arg0.SelectorOverlay:setAlpha(0.04)
				f9_arg0.SelectorOverlay:setScale(1.05, 1.05)
				f9_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SelectorOverlay:completeAnimation()
			f9_arg0.SelectorOverlay:setAlpha(0.01)
			f9_arg0.SelectorOverlay:setScale(1, 1)
			f9_local3(f9_arg0.SelectorOverlay)
			local f9_local4 = function(f14_arg0)
				f9_arg0.Icon:beginAnimation(200)
				f9_arg0.Icon:setScale(1.05, 1.05)
				f9_arg0.Icon:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Icon:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Icon:completeAnimation()
			f9_arg0.Icon:setScale(1, 1)
			f9_local4(f9_arg0.Icon)
			local f9_local5 = function(f15_arg0)
				f9_arg0.OptionText:beginAnimation(200)
				f9_arg0.OptionText:setScale(1.05, 1.05)
				f9_arg0.OptionText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.OptionText:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.OptionText:completeAnimation()
			f9_arg0.OptionText:setScale(1, 1)
			f9_local5(f9_arg0.OptionText)
			local f9_local6 = function(f16_arg0)
				f9_arg0.Frame:beginAnimation(200)
				f9_arg0.Frame:setScale(1.05, 1.05)
				f9_arg0.Frame:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Frame:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Frame:completeAnimation()
			f9_arg0.Frame:setScale(1, 1)
			f9_local6(f9_arg0.Frame)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(7)
			local f17_local0 = function(f18_arg0)
				f17_arg0.Backing:beginAnimation(200)
				f17_arg0.Backing:setScale(1, 1)
				f17_arg0.Backing:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Backing:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Backing:completeAnimation()
			f17_arg0.Backing:setScale(1.05, 1.05)
			f17_local0(f17_arg0.Backing)
			local f17_local1 = function(f19_arg0)
				f17_arg0.NoiseBacking:beginAnimation(200)
				f17_arg0.NoiseBacking:setScale(1, 1)
				f17_arg0.NoiseBacking:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.NoiseBacking:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.NoiseBacking:completeAnimation()
			f17_arg0.NoiseBacking:setScale(1.05, 1.05)
			f17_local1(f17_arg0.NoiseBacking)
			local f17_local2 = function(f20_arg0)
				f17_arg0.DotsBacking:beginAnimation(200)
				f17_arg0.DotsBacking:setScale(1, 1)
				f17_arg0.DotsBacking:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DotsBacking:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.DotsBacking:completeAnimation()
			f17_arg0.DotsBacking:setScale(1.05, 1.05)
			f17_local2(f17_arg0.DotsBacking)
			local f17_local3 = function(f21_arg0)
				f17_arg0.SelectorOverlay:beginAnimation(200)
				f17_arg0.SelectorOverlay:setAlpha(0.01)
				f17_arg0.SelectorOverlay:setScale(1, 1)
				f17_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.SelectorOverlay:completeAnimation()
			f17_arg0.SelectorOverlay:setAlpha(0.04)
			f17_arg0.SelectorOverlay:setScale(1.05, 1.05)
			f17_local3(f17_arg0.SelectorOverlay)
			local f17_local4 = function(f22_arg0)
				f17_arg0.Icon:beginAnimation(200)
				f17_arg0.Icon:setScale(1, 1)
				f17_arg0.Icon:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Icon:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Icon:completeAnimation()
			f17_arg0.Icon:setScale(1.05, 1.05)
			f17_local4(f17_arg0.Icon)
			local f17_local5 = function(f23_arg0)
				f17_arg0.OptionText:beginAnimation(200)
				f17_arg0.OptionText:setScale(1, 1)
				f17_arg0.OptionText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.OptionText:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.OptionText:completeAnimation()
			f17_arg0.OptionText:setScale(1.05, 1.05)
			f17_local5(f17_arg0.OptionText)
			local f17_local6 = function(f24_arg0)
				f17_arg0.Frame:beginAnimation(200)
				f17_arg0.Frame:setScale(1, 1)
				f17_arg0.Frame:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Frame:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Frame:completeAnimation()
			f17_arg0.Frame:setScale(1.05, 1.05)
			f17_local6(f17_arg0.Frame)
		end,
	},
	Disabled = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.OptionText:completeAnimation()
			f25_arg0.OptionText:setAlpha(0.4)
			f25_arg0.clipFinished(f25_arg0.OptionText)
		end,
		ChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.Icon:completeAnimation()
			f26_arg0.Icon:setAlpha(0.4)
			f26_arg0.clipFinished(f26_arg0.Icon)
			f26_arg0.OptionText:completeAnimation()
			f26_arg0.OptionText:setAlpha(0.4)
			f26_arg0.clipFinished(f26_arg0.OptionText)
		end,
	},
}
CoD.GameSettings_OptionsButton.__onClose = function(f27_arg0)
	f27_arg0.DotsBacking:close()
	f27_arg0.Icon:close()
	f27_arg0.OptionText:close()
	f27_arg0.Frame:close()
end
