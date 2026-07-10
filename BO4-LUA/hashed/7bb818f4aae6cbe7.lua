CoD.AbilityCallout_Internal = InheritFrom(LUI.UIElement)
CoD.AbilityCallout_Internal.__defaultWidth = 300
CoD.AbilityCallout_Internal.__defaultHeight = 75
CoD.AbilityCallout_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AbilityCallout_Internal)
	self.id = "AbilityCallout_Internal"
	self.soundSet = "default"
	local Background = LUI.UIImage.new(0, 0, 0, 300, 0, 0, 0, 75)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.75)
	self:addElement(Background)
	self.Background = Background
	local AbilityName = LUI.UIText.new(0, 0, 50, 296, 0, 0, 4.5, 37.5)
	AbilityName:setTTF("default")
	AbilityName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AbilityName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	AbilityName:linkToElementModel(self, "abilityName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AbilityName:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(AbilityName)
	self.AbilityName = AbilityName
	local CalloutIcon = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 12.5, 62.5)
	CalloutIcon:linkToElementModel(self, "abilityIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CalloutIcon:setImage(CoD.BaseUtility.AlreadyRegistered(f3_local0))
		end
	end)
	self:addElement(CalloutIcon)
	self.CalloutIcon = CalloutIcon
	local NameAndTag = LUI.UIText.new(0, 0, 50, 296, 0, 0, 38, 71)
	NameAndTag:setRGB(0.7, 0.7, 0.7)
	NameAndTag:setTTF("default")
	NameAndTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NameAndTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	NameAndTag:linkToElementModel(self, "clientNum", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NameAndTag:setText(GetClientNameAndClanTag(f1_arg1, f4_local0))
		end
	end)
	self:addElement(NameAndTag)
	self.NameAndTag = NameAndTag
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AbilityCallout_Internal.__onClose = function(f5_arg0)
	f5_arg0.AbilityName:close()
	f5_arg0.CalloutIcon:close()
	f5_arg0.NameAndTag:close()
end
