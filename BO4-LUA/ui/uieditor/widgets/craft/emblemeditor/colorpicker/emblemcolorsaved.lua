CoD.EmblemColorSaved = InheritFrom(LUI.UIElement)
CoD.EmblemColorSaved.__defaultWidth = 54
CoD.EmblemColorSaved.__defaultHeight = 180
CoD.EmblemColorSaved.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemColorSaved)
	self.id = "EmblemColorSaved"
	self.soundSet = "SelectColor_ColorSwatchPicker"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	background:setAlpha(0)
	self:addElement(background)
	self.background = background
	local colorElement = LUI.UIImage.new(0.5, 0.5, -27, 27, 0.5, 0.5, -90, 90)
	colorElement:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			colorElement:setRGB(f2_local0)
		end
	end)
	self:addElement(colorElement)
	self.colorElement = colorElement
	local FrontendFrameSelected = LUI.UIImage.new(0.5, 0.5, -34.5, 34.5, 0.5, 0.5, -98, 98)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(0xCB07CCC28498CB2))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(14, 14)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["Emblem.EmblemProperties.isGradientMode"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["Emblem.EmblemProperties.colorMode"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) and IsGamepad(controller) then
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.CraftUtility.EmblemGradient_BackFromColorPicker(self, element, menu, controller)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.CraftUtility.EmblemGradient_ShowSwatchContainer(self, element, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemColorSaved.__resetProperties = function(f9_arg0)
	f9_arg0.background:completeAnimation()
	f9_arg0.FrontendFrameSelected:completeAnimation()
	f9_arg0.colorElement:completeAnimation()
	f9_arg0.background:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	f9_arg0.background:setAlpha(0)
	f9_arg0.FrontendFrameSelected:setLeftRight(0.5, 0.5, -34.5, 34.5)
	f9_arg0.FrontendFrameSelected:setTopBottom(0.5, 0.5, -98, 98)
	f9_arg0.FrontendFrameSelected:setAlpha(0)
	f9_arg0.colorElement:setLeftRight(0.5, 0.5, -27, 27)
	f9_arg0.colorElement:setTopBottom(0.5, 0.5, -90, 90)
end
CoD.EmblemColorSaved.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.background:completeAnimation()
			f10_arg0.background:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.background)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.colorElement:completeAnimation()
			f11_arg0.colorElement:setLeftRight(0.5, 0.5, -28.5, 28.5)
			f11_arg0.colorElement:setTopBottom(0.5, 0.5, -91.5, 91.5)
			f11_arg0.clipFinished(f11_arg0.colorElement)
			f11_arg0.FrontendFrameSelected:completeAnimation()
			f11_arg0.FrontendFrameSelected:setLeftRight(0.5, 0.5, -36, 36)
			f11_arg0.FrontendFrameSelected:setTopBottom(0.5, 0.5, -99.5, 99.5)
			f11_arg0.FrontendFrameSelected:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FrontendFrameSelected)
		end,
		Over = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								f17_arg0:beginAnimation(30, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
								f17_arg0:setAlpha(1)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
							end
							f16_arg0:beginAnimation(20)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(20)
						f15_arg0:setAlpha(0.35)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(20)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f12_arg0.background:beginAnimation(20, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f12_arg0.background:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.background:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.background:completeAnimation()
			f12_arg0.background:setRGB(1, 1, 1)
			f12_arg0.background:setAlpha(0.65)
			f12_local0(f12_arg0.background)
		end,
		GainFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				f18_arg0.colorElement:beginAnimation(200)
				f18_arg0.colorElement:setLeftRight(0.5, 0.5, -28.5, 28.5)
				f18_arg0.colorElement:setTopBottom(0.5, 0.5, -91.5, 91.5)
				f18_arg0.colorElement:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.colorElement:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.colorElement:completeAnimation()
			f18_arg0.colorElement:setLeftRight(0.5, 0.5, -27, 27)
			f18_arg0.colorElement:setTopBottom(0.5, 0.5, -90, 90)
			f18_local0(f18_arg0.colorElement)
			local f18_local1 = function(f20_arg0)
				f18_arg0.FrontendFrameSelected:beginAnimation(200)
				f18_arg0.FrontendFrameSelected:setLeftRight(0.5, 0.5, -36, 36)
				f18_arg0.FrontendFrameSelected:setTopBottom(0.5, 0.5, -99.5, 99.5)
				f18_arg0.FrontendFrameSelected:setAlpha(1)
				f18_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrontendFrameSelected:completeAnimation()
			f18_arg0.FrontendFrameSelected:setLeftRight(0.5, 0.5, -34.5, 34.5)
			f18_arg0.FrontendFrameSelected:setTopBottom(0.5, 0.5, -98, 98)
			f18_arg0.FrontendFrameSelected:setAlpha(0)
			f18_local1(f18_arg0.FrontendFrameSelected)
		end,
		LoseFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.colorElement:beginAnimation(100)
				f21_arg0.colorElement:setLeftRight(0.5, 0.5, -27, 27)
				f21_arg0.colorElement:setTopBottom(0.5, 0.5, -90, 90)
				f21_arg0.colorElement:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.colorElement:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.colorElement:completeAnimation()
			f21_arg0.colorElement:setLeftRight(0.5, 0.5, -28.5, 28.5)
			f21_arg0.colorElement:setTopBottom(0.5, 0.5, -91.5, 91.5)
			f21_local0(f21_arg0.colorElement)
			local f21_local1 = function(f23_arg0)
				f21_arg0.FrontendFrameSelected:beginAnimation(100)
				f21_arg0.FrontendFrameSelected:setLeftRight(0.5, 0.5, -34.5, 34.5)
				f21_arg0.FrontendFrameSelected:setTopBottom(0.5, 0.5, -98, 98)
				f21_arg0.FrontendFrameSelected:setAlpha(0)
				f21_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.FrontendFrameSelected:completeAnimation()
			f21_arg0.FrontendFrameSelected:setLeftRight(0.5, 0.5, -36, 36)
			f21_arg0.FrontendFrameSelected:setTopBottom(0.5, 0.5, -99.5, 99.5)
			f21_arg0.FrontendFrameSelected:setAlpha(1)
			f21_local1(f21_arg0.FrontendFrameSelected)
		end,
	},
}
CoD.EmblemColorSaved.__onClose = function(f24_arg0)
	f24_arg0.colorElement:close()
end
