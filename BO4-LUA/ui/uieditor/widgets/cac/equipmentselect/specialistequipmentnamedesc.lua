require("x64:ec94048bad1fbac")
CoD.SpecialistEquipmentNameDesc = InheritFrom(LUI.UIElement)
CoD.SpecialistEquipmentNameDesc.__defaultWidth = 500
CoD.SpecialistEquipmentNameDesc.__defaultHeight = 107
CoD.SpecialistEquipmentNameDesc.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistEquipmentNameDesc)
	self.id = "SpecialistEquipmentNameDesc"
	self.soundSet = "default"
	local Name = LUI.UIText.new(0, 0, 0, 500, 0, 0, 44.5, 76.5)
	Name:setRGB(0.92, 0.92, 0.92)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(14)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	Name:linkToElementModel(self, "displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Description = LUI.UIText.new(0, 0, 2, 474, 0, 0, 88.5, 106.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Description:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Description:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local Divider = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0, 0, 1, 401, 0, 0, 81, 82)
	Divider:setAlpha(0.25)
	self:addElement(Divider)
	self.Divider = Divider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistEquipmentNameDesc.__onClose = function(f4_arg0)
	f4_arg0.Name:close()
	f4_arg0.Description:close()
	f4_arg0.Divider:close()
end
