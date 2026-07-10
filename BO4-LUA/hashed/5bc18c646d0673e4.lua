CoD.WZAARMeritBreakdownLarge = InheritFrom(LUI.UIElement)
CoD.WZAARMeritBreakdownLarge.__defaultWidth = 306
CoD.WZAARMeritBreakdownLarge.__defaultHeight = 258
CoD.WZAARMeritBreakdownLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAARMeritBreakdownLarge)
	self.id = "WZAARMeritBreakdownLarge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Value = LUI.UIText.new(0.5, 0.5, -146, 146, 0, 0, 141, 240)
	Value:setRGB(0.97, 0.8, 0.11)
	Value:setTTF("ttmussels_demibold")
	Value:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Value:setShaderVector(0, 0.4, 0, 0, 0)
	Value:setShaderVector(1, 0, 0, 0, 0)
	Value:setShaderVector(2, 1, 0.2, 0, 0.5)
	Value:setLetterSpacing(2)
	Value:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Value:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Value:linkToElementModel(self, "value", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Value:setText(f2_local0)
		end
	end)
	self:addElement(Value)
	self.Value = Value
	local Label = LUI.UIText.new(0.5, 0.5, -146, 146, 0, 0, 62, 92)
	Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Label:setTTF("ttmussels_regular")
	Label:setLetterSpacing(1)
	Label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Label:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	Label:linkToElementModel(self, "label", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Label:setText(f3_local0)
		end
	end)
	self:addElement(Label)
	self.Label = Label
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAARMeritBreakdownLarge.__resetProperties = function(f4_arg0)
	f4_arg0.Label:completeAnimation()
	f4_arg0.Value:completeAnimation()
	f4_arg0.Label:setAlpha(1)
	f4_arg0.Value:setAlpha(1)
end
CoD.WZAARMeritBreakdownLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Value:completeAnimation()
			f5_arg0.Value:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Value)
			f5_arg0.Label:completeAnimation()
			f5_arg0.Label:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Label)
		end,
		Show = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Value:beginAnimation(200)
				f6_arg0.Value:setAlpha(1)
				f6_arg0.Value:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Value:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Value:completeAnimation()
			f6_arg0.Value:setAlpha(0)
			f6_local0(f6_arg0.Value)
			local f6_local1 = function(f8_arg0)
				f6_arg0.Label:beginAnimation(200)
				f6_arg0.Label:setAlpha(1)
				f6_arg0.Label:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Label:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Label:completeAnimation()
			f6_arg0.Label:setAlpha(0)
			f6_local1(f6_arg0.Label)
		end,
	},
}
CoD.WZAARMeritBreakdownLarge.__onClose = function(f9_arg0)
	f9_arg0.Value:close()
	f9_arg0.Label:close()
end
