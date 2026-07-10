require("x64:3e426332d66c91e")
require("x64:f78acfcbc465bba")
CoD.codcaster_color_element = InheritFrom(LUI.UIElement)
CoD.codcaster_color_element.__defaultWidth = 75
CoD.codcaster_color_element.__defaultHeight = 75
CoD.codcaster_color_element.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcaster_color_element)
	self.id = "codcaster_color_element"
	self.soundSet = "SelectColor_ColorSwatchPicker"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backgroundBlurDisabled = LUI.UIImage.new(0.21, 0.79, 0, 0, 0, 0, 28, 84)
	backgroundBlurDisabled:setRGB(0, 0, 0)
	backgroundBlurDisabled:setAlpha(0)
	backgroundBlurDisabled:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	backgroundBlurDisabled:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backgroundBlurDisabled)
	self.backgroundBlurDisabled = backgroundBlurDisabled
	local ButtonDisabled = LUI.UIImage.new(0.5, 0.5, -45, 45, 0.5, 0.5, -31, 31)
	ButtonDisabled:setAlpha(0)
	ButtonDisabled:setImage(RegisterImage(0x66C228F469B9CE3))
	self:addElement(ButtonDisabled)
	self.ButtonDisabled = ButtonDisabled
	local FocusGlow = LUI.UIImage.new(0, 1, -49, 49, 0, 1, -51, 51)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(0xB8F10D49D85E9C4))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(100, 100)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local colorElement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	colorElement:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			colorElement:setRGB(f2_local0)
		end
	end)
	self:addElement(colorElement)
	self.colorElement = colorElement
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	self:addElement(Lines)
	self.Lines = Lines
	local FocusBorder = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -3, 3)
	FocusBorder:setRGB(0.96, 0.94, 0.78)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -10, 10, 0, 1, -10, 10)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local BGGlow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGGlow:setAlpha(0)
	BGGlow:setImage(RegisterImage(0xC270E906CDA1B2E))
	BGGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BGGlow)
	self.BGGlow = BGGlow
	local BGDotPatternLarge = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGDotPatternLarge:setAlpha(0.02)
	BGDotPatternLarge:setImage(RegisterImage(0xFC21A8215EA012B))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -38, 6, 0, 0, -6, 38)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(0x9A8B26C9B001758))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -38, 6, 0, 0, -6, 38)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(0x7AF532D84DE505A))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	self:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected")
			end,
		},
	})
	self:linkToElementModel(self, "selected", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.codcaster_color_element.__resetProperties = function(f5_arg0)
	f5_arg0.FocusBorder:completeAnimation()
	f5_arg0.FocusBrackets:completeAnimation()
	f5_arg0.FocusGlow:completeAnimation()
	f5_arg0.EquippedMarkerTick:completeAnimation()
	f5_arg0.EquippedMarkerBG:completeAnimation()
	f5_arg0.FocusBorder:setAlpha(0)
	f5_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
	f5_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
	f5_arg0.FocusBrackets:setAlpha(0)
	f5_arg0.FocusGlow:setLeftRight(0, 1, -49, 49)
	f5_arg0.FocusGlow:setTopBottom(0, 1, -51, 51)
	f5_arg0.FocusGlow:setAlpha(0)
	f5_arg0.EquippedMarkerTick:setAlpha(0)
	f5_arg0.EquippedMarkerBG:setAlpha(0)
end
CoD.codcaster_color_element.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.FocusGlow:completeAnimation()
			f7_arg0.FocusGlow:setLeftRight(0, 1, -36, 36)
			f7_arg0.FocusGlow:setTopBottom(0, 1, -35, 35)
			f7_arg0.FocusGlow:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.FocusGlow)
			f7_arg0.FocusBorder:completeAnimation()
			f7_arg0.FocusBorder:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.FocusBorder)
			f7_arg0.FocusBrackets:completeAnimation()
			f7_arg0.FocusBrackets:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.FocusBrackets)
		end,
		GainFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			local f8_local0 = function(f9_arg0)
				f8_arg0.FocusGlow:beginAnimation(200)
				f8_arg0.FocusGlow:setAlpha(1)
				f8_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FocusGlow:completeAnimation()
			f8_arg0.FocusGlow:setLeftRight(0, 1, -36, 36)
			f8_arg0.FocusGlow:setTopBottom(0, 1, -35, 35)
			f8_arg0.FocusGlow:setAlpha(0)
			f8_local0(f8_arg0.FocusGlow)
			local f8_local1 = function(f10_arg0)
				f8_arg0.FocusBorder:beginAnimation(200)
				f8_arg0.FocusBorder:setAlpha(1)
				f8_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FocusBorder:completeAnimation()
			f8_arg0.FocusBorder:setAlpha(0)
			f8_local1(f8_arg0.FocusBorder)
			local f8_local2 = function(f11_arg0)
				f8_arg0.FocusBrackets:beginAnimation(200)
				f8_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
				f8_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
				f8_arg0.FocusBrackets:setAlpha(1)
				f8_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FocusBrackets:completeAnimation()
			f8_arg0.FocusBrackets:setLeftRight(0, 1, -20, 20)
			f8_arg0.FocusBrackets:setTopBottom(0, 1, -20, 20)
			f8_arg0.FocusBrackets:setAlpha(0)
			f8_local2(f8_arg0.FocusBrackets)
		end,
		LoseFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.FocusGlow:beginAnimation(100)
				f12_arg0.FocusGlow:setAlpha(0)
				f12_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FocusGlow:completeAnimation()
			f12_arg0.FocusGlow:setLeftRight(0, 1, -36, 36)
			f12_arg0.FocusGlow:setTopBottom(0, 1, -35, 35)
			f12_arg0.FocusGlow:setAlpha(1)
			f12_local0(f12_arg0.FocusGlow)
			local f12_local1 = function(f14_arg0)
				f12_arg0.FocusBorder:beginAnimation(100)
				f12_arg0.FocusBorder:setAlpha(0)
				f12_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FocusBorder:completeAnimation()
			f12_arg0.FocusBorder:setAlpha(1)
			f12_local1(f12_arg0.FocusBorder)
			local f12_local2 = function(f15_arg0)
				f12_arg0.FocusBrackets:beginAnimation(100)
				f12_arg0.FocusBrackets:setLeftRight(0, 1, -20, 20)
				f12_arg0.FocusBrackets:setTopBottom(0, 1, -20, 20)
				f12_arg0.FocusBrackets:setAlpha(0)
				f12_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FocusBrackets:completeAnimation()
			f12_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f12_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f12_arg0.FocusBrackets:setAlpha(1)
			f12_local2(f12_arg0.FocusBrackets)
		end,
	},
	Selected = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.EquippedMarkerTick:completeAnimation()
			f16_arg0.EquippedMarkerTick:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.EquippedMarkerTick)
			f16_arg0.EquippedMarkerBG:completeAnimation()
			f16_arg0.EquippedMarkerBG:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.EquippedMarkerBG)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.FocusBorder:completeAnimation()
			f17_arg0.FocusBorder:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusBorder)
			f17_arg0.FocusBrackets:completeAnimation()
			f17_arg0.FocusBrackets:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusBrackets)
			f17_arg0.EquippedMarkerTick:completeAnimation()
			f17_arg0.EquippedMarkerTick:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.EquippedMarkerTick)
			f17_arg0.EquippedMarkerBG:completeAnimation()
			f17_arg0.EquippedMarkerBG:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.EquippedMarkerBG)
		end,
	},
}
CoD.codcaster_color_element.__onClose = function(f18_arg0)
	f18_arg0.colorElement:close()
	f18_arg0.Lines:close()
	f18_arg0.FocusBrackets:close()
end
