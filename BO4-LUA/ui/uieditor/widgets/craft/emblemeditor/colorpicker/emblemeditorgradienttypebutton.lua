require("x64:f173308619268e8")
CoD.EmblemEditorGradientTypeButton = InheritFrom(LUI.UIElement)
CoD.EmblemEditorGradientTypeButton.__defaultWidth = 807
CoD.EmblemEditorGradientTypeButton.__defaultHeight = 80
CoD.EmblemEditorGradientTypeButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorGradientTypeButton)
	self.id = "EmblemEditorGradientTypeButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ThicknessValue = LUI.UIText.new(0, 0, 757, 807, 0, 0, 40, 65)
	ThicknessValue:setRGB(0.92, 0.92, 0.92)
	ThicknessValue:setTTF("dinnext_regular")
	ThicknessValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	ThicknessValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ThicknessValue:subscribeToGlobalModel(f1_arg1, "EmblemSelectedLayerProperties", "gradient_thickness", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ThicknessValue:setText(f2_local0)
		end
	end)
	self:addElement(ThicknessValue)
	self.ThicknessValue = ThicknessValue
	local ThicknessSlider = CoD.EmblemEditorGradientSliderBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -261.5, 350.5, 0, 0, 40, 60)
	ThicknessSlider:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.CraftUtility.EmblemGradient_ColorGradientSliderGainFocus(self, element, f1_arg1)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_right"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ThicknessSlider, f1_arg1, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemGradient_UpdateThicknessByStep(self, element, -0.01, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(ThicknessSlider, f1_arg1, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemGradient_UpdateThicknessByStep(self, element, 0.01, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(ThicknessSlider)
	self.ThicknessSlider = ThicknessSlider
	local ThicknessText = LUI.UIText.new(0, 0, 0, 116, 0, 0, 40, 60)
	ThicknessText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_21960EFEF4BF9116"))
	ThicknessText:setTTF("default")
	ThicknessText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ThicknessText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ThicknessText)
	self.ThicknessText = ThicknessText
	local HardnessValue = LUI.UIText.new(0, 0, 757, 807, 0, 0, 3, 28)
	HardnessValue:setRGB(0.92, 0.92, 0.92)
	HardnessValue:setTTF("dinnext_regular")
	HardnessValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	HardnessValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	HardnessValue:subscribeToGlobalModel(f1_arg1, "EmblemSelectedLayerProperties", "gradient_fill", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			HardnessValue:setText(f8_local0)
		end
	end)
	self:addElement(HardnessValue)
	self.HardnessValue = HardnessValue
	local HardnessSlider = CoD.EmblemEditorGradientSliderBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -261.5, 350.5, 0, 0, 3, 23)
	HardnessSlider:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.CraftUtility.EmblemGradient_ColorGradientSliderGainFocus(self, element, f1_arg1)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_left"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_right"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(HardnessSlider, f1_arg1, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemGradient_UpdateGradientFillByStep(self, element, -0.01, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_left"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(HardnessSlider, f1_arg1, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemGradient_UpdateGradientFillByStep(self, element, 0.01, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_right"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(HardnessSlider)
	self.HardnessSlider = HardnessSlider
	local HardnessText = LUI.UIText.new(0, 0, 0, 116, 0, 0, 3, 23)
	HardnessText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_373519BA1E3232E"))
	HardnessText:setTTF("default")
	HardnessText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HardnessText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(HardnessText)
	self.HardnessText = HardnessText
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		CoD.CraftUtility.EmblemGradient_UpdateSliders(controller, f1_arg0)
	end)
	ThicknessSlider.id = "ThicknessSlider"
	HardnessSlider.id = "HardnessSlider"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.CraftUtility.EmblemGradient_UpdateGradientFillByStep(self, ThicknessSlider, 0, f1_arg1)
	CoD.CraftUtility.EmblemGradient_UpdateGradientFillByStep(self, HardnessSlider, 0, f1_arg1)
	return self
end
CoD.EmblemEditorGradientTypeButton.__resetProperties = function(f15_arg0)
	f15_arg0.HardnessText:completeAnimation()
	f15_arg0.HardnessSlider:completeAnimation()
	f15_arg0.HardnessValue:completeAnimation()
	f15_arg0.ThicknessText:completeAnimation()
	f15_arg0.ThicknessSlider:completeAnimation()
	f15_arg0.ThicknessValue:completeAnimation()
	f15_arg0.HardnessText:setAlpha(1)
	f15_arg0.HardnessSlider:setLeftRight(0.5, 0.5, -261.5, 350.5)
	f15_arg0.HardnessSlider:setTopBottom(0, 0, 3, 23)
	f15_arg0.HardnessSlider:setAlpha(1)
	f15_arg0.HardnessValue:setTopBottom(0, 0, 3, 28)
	f15_arg0.HardnessValue:setAlpha(1)
	f15_arg0.ThicknessText:setAlpha(1)
	f15_arg0.ThicknessSlider:setAlpha(1)
	f15_arg0.ThicknessValue:setAlpha(1)
end
CoD.EmblemEditorGradientTypeButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(6)
			f16_arg0.ThicknessValue:completeAnimation()
			f16_arg0.ThicknessValue:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ThicknessValue)
			f16_arg0.ThicknessSlider:completeAnimation()
			f16_arg0.ThicknessSlider:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ThicknessSlider)
			f16_arg0.ThicknessText:completeAnimation()
			f16_arg0.ThicknessText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ThicknessText)
			f16_arg0.HardnessValue:completeAnimation()
			f16_arg0.HardnessValue:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.HardnessValue)
			f16_arg0.HardnessSlider:completeAnimation()
			f16_arg0.HardnessSlider:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.HardnessSlider)
			f16_arg0.HardnessText:completeAnimation()
			f16_arg0.HardnessText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.HardnessText)
		end,
	},
	SingleSliderState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(6)
			f17_arg0.ThicknessValue:completeAnimation()
			f17_arg0.ThicknessValue:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ThicknessValue)
			f17_arg0.ThicknessSlider:completeAnimation()
			f17_arg0.ThicknessSlider:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ThicknessSlider)
			f17_arg0.ThicknessText:completeAnimation()
			f17_arg0.ThicknessText:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ThicknessText)
			f17_arg0.HardnessValue:completeAnimation()
			f17_arg0.HardnessValue:setTopBottom(0, 0, 19, 44)
			f17_arg0.clipFinished(f17_arg0.HardnessValue)
			f17_arg0.HardnessSlider:completeAnimation()
			f17_arg0.HardnessSlider:setLeftRight(0.5, 0.5, -403.5, 338.5)
			f17_arg0.HardnessSlider:setTopBottom(0, 0, 21, 41)
			f17_arg0.clipFinished(f17_arg0.HardnessSlider)
			f17_arg0.HardnessText:completeAnimation()
			f17_arg0.HardnessText:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.HardnessText)
		end,
	},
	KM = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(6)
			f18_arg0.ThicknessValue:completeAnimation()
			f18_arg0.ThicknessValue:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ThicknessValue)
			f18_arg0.ThicknessSlider:completeAnimation()
			f18_arg0.ThicknessSlider:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ThicknessSlider)
			f18_arg0.ThicknessText:completeAnimation()
			f18_arg0.ThicknessText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ThicknessText)
			f18_arg0.HardnessValue:completeAnimation()
			f18_arg0.HardnessValue:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.HardnessValue)
			f18_arg0.HardnessSlider:completeAnimation()
			f18_arg0.HardnessSlider:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.HardnessSlider)
			f18_arg0.HardnessText:completeAnimation()
			f18_arg0.HardnessText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.HardnessText)
		end,
	},
	ContourState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.EmblemEditorGradientTypeButton.__onClose = function(f20_arg0)
	f20_arg0.ThicknessValue:close()
	f20_arg0.ThicknessSlider:close()
	f20_arg0.HardnessValue:close()
	f20_arg0.HardnessSlider:close()
end
