CoD.SpecialDealTimer = InheritFrom(LUI.UIElement)
CoD.SpecialDealTimer.__defaultWidth = 388
CoD.SpecialDealTimer.__defaultHeight = 23
CoD.SpecialDealTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialDealTimer)
	self.id = "SpecialDealTimer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 0, 0, 388, 0, 0, 0, 23)
	TextBox:setRGB(0, 0, 0)
	TextBox:setTTF("dinnext_regular")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	TextBox:setShaderVector(0, 0, 0, 0, 0)
	TextBox:setShaderVector(1, 0, 0, 0, 0)
	TextBox:setShaderVector(2, 1, 1, 1, 0)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	TextBox:setBackingType(3)
	TextBox:setBackingXPadding(6)
	TextBox:setBackingYPadding(8)
	TextBox:setBackingImage(RegisterImage(@"hash_1714F15AF25A104F"))
	TextBox:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	TextBox:setBackingShaderVector(0, 0, 0, 0, 0)
	TextBox:setupBackingNineSliceShader(200, 20)
	TextBox:subscribeToGlobalModel(f1_arg1, "AutoEvents", "loot_special_deal_timer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(f2_local0)
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "ShowTimer",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("ui_specialDealShowTimer")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialDealTimer.__resetProperties = function(f4_arg0)
	f4_arg0.TextBox:completeAnimation()
	f4_arg0.TextBox:setAlpha(1)
end
CoD.SpecialDealTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.TextBox:completeAnimation()
			f5_arg0.TextBox:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TextBox)
		end,
	},
	ShowTimer = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.TextBox:completeAnimation()
			f6_arg0.TextBox:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TextBox)
		end,
	},
}
CoD.SpecialDealTimer.__onClose = function(f7_arg0)
	f7_arg0.TextBox:close()
end
