CoD.WZAAR_MeritBreakdownLine = InheritFrom(LUI.UIElement)
CoD.WZAAR_MeritBreakdownLine.__defaultWidth = 360
CoD.WZAAR_MeritBreakdownLine.__defaultHeight = 30
CoD.WZAAR_MeritBreakdownLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_MeritBreakdownLine)
	self.id = "WZAAR_MeritBreakdownLine"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Value = LUI.UIText.new(1, 1, -112, 0, -0, 1, 0, 0)
	Value:setRGB(0.97, 0.8, 0.11)
	Value:setTTF("ttmussels_demibold")
	Value:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Value:setShaderVector(0, 0.4, 0, 0, 0)
	Value:setShaderVector(1, 0, 0, 0, 0)
	Value:setShaderVector(2, 1, 0.2, 0, 0.5)
	Value:setLetterSpacing(2)
	Value:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Value:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	Value:linkToElementModel(self, "value", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Value:setText(f2_local0)
		end
	end)
	self:addElement(Value)
	self.Value = Value
	local Label = LUI.UIText.new(0, 0.68, 0, 0, 0.14, 0.86, 0, 0)
	Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Label:setTTF("ttmussels_regular")
	Label:setLetterSpacing(2)
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Label:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	Label:linkToElementModel(self, "label", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Label:setText(LocalizeToUpperString(f3_local0))
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
CoD.WZAAR_MeritBreakdownLine.__resetProperties = function(f4_arg0)
	f4_arg0.Label:completeAnimation()
	f4_arg0.Value:completeAnimation()
	f4_arg0.Label:setAlpha(1)
	f4_arg0.Value:setAlpha(1)
end
CoD.WZAAR_MeritBreakdownLine.__clipsPerState = {
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
CoD.WZAAR_MeritBreakdownLine.__onClose = function(f9_arg0)
	f9_arg0.Value:close()
	f9_arg0.Label:close()
end
