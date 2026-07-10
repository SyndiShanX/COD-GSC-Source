CoD.CharacterSelection_PrestigeInfo = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_PrestigeInfo.__defaultWidth = 74
CoD.CharacterSelection_PrestigeInfo.__defaultHeight = 74
CoD.CharacterSelection_PrestigeInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CharacterSelection_PrestigeInfo)
	self.id = "CharacterSelection_PrestigeInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PrestigeIcon = LUI.UIImage.new(0, 0, 0, 74, 0, 0, 0, 74)
	PrestigeIcon:subscribeToGlobalModel(f1_arg1, "PrestigeStats", "icon", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PrestigeIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PrestigeIcon)
	self.PrestigeIcon = PrestigeIcon
	local PrestigeText = LUI.UIText.new(0, 0, 74, 536, 0, 0, 18.5, 55.5)
	PrestigeText:setTTF("ttmussels_regular")
	PrestigeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PrestigeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PrestigeText:subscribeToGlobalModel(f1_arg1, "PrestigeStats", "plevel", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PrestigeText:setText(GetPrestigeTitleForPLevelAndMode("wz", f3_local0))
		end
	end)
	self:addElement(PrestigeText)
	self.PrestigeText = PrestigeText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CharacterSelection_PrestigeInfo.__resetProperties = function(f4_arg0)
	f4_arg0.PrestigeText:completeAnimation()
	f4_arg0.PrestigeIcon:completeAnimation()
	f4_arg0.PrestigeText:setAlpha(1)
	f4_arg0.PrestigeIcon:setAlpha(1)
end
CoD.CharacterSelection_PrestigeInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.PrestigeIcon:completeAnimation()
			f5_arg0.PrestigeIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PrestigeIcon)
			f5_arg0.PrestigeText:completeAnimation()
			f5_arg0.PrestigeText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PrestigeText)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.PrestigeIcon:completeAnimation()
			f6_arg0.PrestigeIcon:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.PrestigeIcon)
			f6_arg0.PrestigeText:completeAnimation()
			f6_arg0.PrestigeText:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.PrestigeText)
		end,
	},
}
CoD.CharacterSelection_PrestigeInfo.__onClose = function(f7_arg0)
	f7_arg0.PrestigeIcon:close()
	f7_arg0.PrestigeText:close()
end
