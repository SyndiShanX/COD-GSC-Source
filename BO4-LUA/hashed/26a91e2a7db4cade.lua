CoD.Hud_ZM_Trial_RoundInfoText = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_Trial_RoundInfoText.__defaultWidth = 600
CoD.Hud_ZM_Trial_RoundInfoText.__defaultHeight = 61
CoD.Hud_ZM_Trial_RoundInfoText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_Trial_RoundInfoText)
	self.id = "Hud_ZM_Trial_RoundInfoText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RoundTitleText = LUI.UIText.new(0, 0, 0, 600, 0, 0, 0, 33)
	RoundTitleText:setRGB(0.96, 0.66, 0)
	RoundTitleText:setTTF("skorzhen")
	RoundTitleText:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	RoundTitleText:setShaderVector(0, 0.02, 0, 0, 0)
	RoundTitleText:setShaderVector(1, 0.04, 0, 0, 0)
	RoundTitleText:setShaderVector(2, 0, 0, 0, 1)
	RoundTitleText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RoundTitleText:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.roundTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RoundTitleText:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(RoundTitleText)
	self.RoundTitleText = RoundTitleText
	local Divider = LUI.UIImage.new(0, 0, 0, 220, 0, 0, 32, 34)
	Divider:setRGB(0.96, 0.66, 0)
	self:addElement(Divider)
	self.Divider = Divider
	local RoundDescriptionText = LUI.UIText.new(0, 0, 0, 235, 0, 0, 43, 61)
	RoundDescriptionText:setTTF("dinnext_regular")
	RoundDescriptionText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RoundDescriptionText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RoundDescriptionText:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.roundDescription", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RoundDescriptionText:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(RoundDescriptionText)
	self.RoundDescriptionText = RoundDescriptionText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_Trial_RoundInfoText.__resetProperties = function(f4_arg0)
	f4_arg0.Divider:completeAnimation()
	f4_arg0.Divider:setTopBottom(0, 0, 32, 34)
end
CoD.Hud_ZM_Trial_RoundInfoText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Divider:completeAnimation()
			f5_arg0.Divider:setTopBottom(0, 0, 35, 37)
			f5_arg0.clipFinished(f5_arg0.Divider)
		end,
	},
}
CoD.Hud_ZM_Trial_RoundInfoText.__onClose = function(f6_arg0)
	f6_arg0.RoundTitleText:close()
	f6_arg0.RoundDescriptionText:close()
end
