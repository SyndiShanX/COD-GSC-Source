CoD.PositionDraft_FocusedCharacterName = InheritFrom(LUI.UIElement)
CoD.PositionDraft_FocusedCharacterName.__defaultWidth = 678
CoD.PositionDraft_FocusedCharacterName.__defaultHeight = 63
CoD.PositionDraft_FocusedCharacterName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_FocusedCharacterName)
	self.id = "PositionDraft_FocusedCharacterName"
	self.soundSet = "default"
	local SpecialistName = LUI.UIText.new(0, 0, 10, 688, 0, 0, 22, 78)
	SpecialistName:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	SpecialistName:setZoom(10)
	SpecialistName:setTTF("ttmussels_regular")
	SpecialistName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	SpecialistName:setShaderVector(0, 0.3, 0, 0, 0)
	SpecialistName:setShaderVector(1, 0, 0, 0, 0)
	SpecialistName:setShaderVector(2, 0.8, 0.1, 0, 0.5)
	SpecialistName:setLetterSpacing(10)
	SpecialistName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SpecialistName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SpecialistName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpecialistName:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local JobTitle = LUI.UIText.new(0, 0, 14, 692, 0, 0, 4, 24)
	JobTitle:setRGB(0.97, 0.93, 0.56)
	JobTitle:setZoom(10)
	JobTitle:setTTF("ttmussels_regular")
	JobTitle:setLetterSpacing(10)
	JobTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	JobTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	JobTitle:linkToElementModel(self, "jobTitle", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			JobTitle:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(JobTitle)
	self.JobTitle = JobTitle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_FocusedCharacterName.__onClose = function(f4_arg0)
	f4_arg0.SpecialistName:close()
	f4_arg0.JobTitle:close()
end
