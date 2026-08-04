require("ui/uieditor/widgets/lobby/common/fe_titlenumbrdr")
CoD.CraftActionSliderWidget = InheritFrom(LUI.UIElement)
CoD.CraftActionSliderWidget.__defaultWidth = 315
CoD.CraftActionSliderWidget.__defaultHeight = 60
CoD.CraftActionSliderWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CraftActionSliderWidget)
	self.id = "CraftActionSliderWidget"
	self.soundSet = "SelectColor"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -2, 2)
	Frame:setRGB(0.2, 0.2, 0.2)
	Frame:setAlpha(0.5)
	Frame:setImage(RegisterImage("uie_ui_menu_store_common_frame"))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local actionName = LUI.UIText.new(0, 1, 10, -10, 0, 0, 7, 29)
	actionName:setRGB(0.92, 0.92, 0.92)
	actionName:setTTF("ttmussels_regular")
	actionName:setLetterSpacing(2)
	actionName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	actionName:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(actionName)
	self.actionName = actionName
	local sliderBack = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 0, 6, 309, 0, 0, 35, 60)
	sliderBack:setAlpha(0)
	self:addElement(sliderBack)
	self.sliderBack = sliderBack
	local dividerH03 = LUI.UIImage.new(0, 0, 0, 315, 0, 0, 31.5, 36.5)
	dividerH03:setAlpha(0.1)
	dividerH03:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	dividerH03:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	dividerH03:setShaderVector(0, 0, 0, 0, 0)
	dividerH03:setupNineSliceShader(8, 4)
	self:addElement(dividerH03)
	self.dividerH03 = dividerH03
	local dividerH = LUI.UIImage.new(0, 0, 0, 315, 0, 0, 58.5, 63.5)
	dividerH:setAlpha(0.1)
	dividerH:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	dividerH:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	dividerH:setShaderVector(0, 0, 0, 0, 0)
	dividerH:setupNineSliceShader(8, 4)
	self:addElement(dividerH)
	self.dividerH = dividerH
	local back = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 36.5, 56.5)
	back:setRGB(0.26, 0.26, 0.23)
	self:addElement(back)
	self.back = back
	local sliderFill = LUI.UIImage.new(0, 0, 0, 183, 0, 0, 36.5, 56.5)
	sliderFill:setRGB(0.26, 0.26, 0.23)
	self:addElement(sliderFill)
	self.sliderFill = sliderFill
	local sliderBar = LUI.UIImage.new(0, 0, 171, 183, 0, 0, 33, 60)
	sliderBar:setRGB(0.44, 0.44, 0.35)
	self:addElement(sliderBar)
	self.sliderBar = sliderBar
	self.actionName:linkToElementModel(self, "actionName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			actionName:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CraftActionSliderWidget.__resetProperties = function(f5_arg0)
	f5_arg0.sliderFill:completeAnimation()
	f5_arg0.sliderBar:completeAnimation()
	f5_arg0.back:completeAnimation()
	f5_arg0.actionName:completeAnimation()
	f5_arg0.sliderFill:setRGB(0.26, 0.26, 0.23)
	f5_arg0.sliderFill:setAlpha(1)
	f5_arg0.sliderBar:setRGB(0.44, 0.44, 0.35)
	f5_arg0.sliderBar:setAlpha(1)
	f5_arg0.back:setRGB(0.26, 0.26, 0.23)
	f5_arg0.actionName:setAlpha(1)
end
CoD.CraftActionSliderWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.back:completeAnimation()
			f7_arg0.back:setRGB(0.59, 0.58, 0.44)
			f7_arg0.clipFinished(f7_arg0.back)
			f7_arg0.sliderFill:completeAnimation()
			f7_arg0.sliderFill:setRGB(0.59, 0.58, 0.44)
			f7_arg0.clipFinished(f7_arg0.sliderFill)
			f7_arg0.sliderBar:completeAnimation()
			f7_arg0.sliderBar:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f7_arg0.clipFinished(f7_arg0.sliderBar)
		end,
		GainFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			local f8_local0 = function(f9_arg0)
				f8_arg0.back:beginAnimation(200)
				f8_arg0.back:setRGB(0.59, 0.58, 0.44)
				f8_arg0.back:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.back:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.back:completeAnimation()
			f8_arg0.back:setRGB(0.26, 0.26, 0.23)
			f8_local0(f8_arg0.back)
			local f8_local1 = function(f10_arg0)
				f8_arg0.sliderFill:beginAnimation(200)
				f8_arg0.sliderFill:setRGB(0.59, 0.58, 0.44)
				f8_arg0.sliderFill:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.sliderFill:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.sliderFill:completeAnimation()
			f8_arg0.sliderFill:setRGB(0.26, 0.26, 0.23)
			f8_local1(f8_arg0.sliderFill)
			local f8_local2 = function(f11_arg0)
				f8_arg0.sliderBar:beginAnimation(200)
				f8_arg0.sliderBar:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f8_arg0.sliderBar:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.sliderBar:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.sliderBar:completeAnimation()
			f8_arg0.sliderBar:setRGB(0.44, 0.44, 0.35)
			f8_local2(f8_arg0.sliderBar)
		end,
		LoseFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.back:beginAnimation(200)
				f12_arg0.back:setRGB(0.26, 0.26, 0.23)
				f12_arg0.back:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.back:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.back:completeAnimation()
			f12_arg0.back:setRGB(0.59, 0.58, 0.44)
			f12_local0(f12_arg0.back)
			local f12_local1 = function(f14_arg0)
				f12_arg0.sliderFill:beginAnimation(200)
				f12_arg0.sliderFill:setRGB(0.26, 0.26, 0.23)
				f12_arg0.sliderFill:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.sliderFill:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.sliderFill:completeAnimation()
			f12_arg0.sliderFill:setRGB(0.59, 0.58, 0.44)
			f12_local1(f12_arg0.sliderFill)
			local f12_local2 = function(f15_arg0)
				f12_arg0.sliderBar:beginAnimation(200)
				f12_arg0.sliderBar:setRGB(0.44, 0.44, 0.35)
				f12_arg0.sliderBar:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.sliderBar:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.sliderBar:completeAnimation()
			f12_arg0.sliderBar:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f12_local2(f12_arg0.sliderBar)
		end,
	},
	Disabled = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.actionName:completeAnimation()
			f16_arg0.actionName:setAlpha(0.25)
			f16_arg0.clipFinished(f16_arg0.actionName)
			f16_arg0.sliderFill:completeAnimation()
			f16_arg0.sliderFill:setAlpha(0.25)
			f16_arg0.clipFinished(f16_arg0.sliderFill)
			f16_arg0.sliderBar:completeAnimation()
			f16_arg0.sliderBar:setAlpha(0.25)
			f16_arg0.clipFinished(f16_arg0.sliderBar)
		end,
	},
}
CoD.CraftActionSliderWidget.__onClose = function(f17_arg0)
	f17_arg0.actionName:close()
	f17_arg0.sliderBack:close()
end
