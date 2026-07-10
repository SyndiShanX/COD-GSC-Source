require("x64:ec94048bad1fbac")
CoD.ZMSpecialWeapon_StageDescriptionInternal = InheritFrom(LUI.UIElement)
CoD.ZMSpecialWeapon_StageDescriptionInternal.__defaultWidth = 600
CoD.ZMSpecialWeapon_StageDescriptionInternal.__defaultHeight = 63
CoD.ZMSpecialWeapon_StageDescriptionInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMSpecialWeapon_StageDescriptionInternal)
	self.id = "ZMSpecialWeapon_StageDescriptionInternal"
	self.soundSet = "default"
	local Name = LUI.UIText.new(0, 0, -401, 600, 0, 0, 0, 32)
	Name:setRGB(0.92, 0.89, 0.72)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(14)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Name:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	Name:linkToElementModel(self, "itemName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Description = LUI.UIText.new(0, 0, -108, 600, 0, 0, 45, 63)
	Description:setRGB(0.8, 0.79, 0.78)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Description:setText(f3_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local Divider = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0, 0, 200, 600, 0, 0, 36.5, 37.5)
	Divider:setAlpha(0.25)
	Divider:setZRot(180)
	self:addElement(Divider)
	self.Divider = Divider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMSpecialWeapon_StageDescriptionInternal.__onClose = function(f4_arg0)
	f4_arg0.Name:close()
	f4_arg0.Description:close()
	f4_arg0.Divider:close()
end
