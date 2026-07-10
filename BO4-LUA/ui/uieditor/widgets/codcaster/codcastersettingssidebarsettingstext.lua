CoD.CodCasterSettingsSideBarSettingsText = InheritFrom(LUI.UIElement)
CoD.CodCasterSettingsSideBarSettingsText.__defaultWidth = 700
CoD.CodCasterSettingsSideBarSettingsText.__defaultHeight = 60
CoD.CodCasterSettingsSideBarSettingsText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterSettingsSideBarSettingsText)
	self.id = "CodCasterSettingsSideBarSettingsText"
	self.soundSet = "default"
	local OptionTitle = LUI.UIText.new(0, 0, 0, 700, 0, 0, 0, 30)
	OptionTitle:setRGB(0.63, 0.57, 0.2)
	OptionTitle:setTTF("ttmussels_regular")
	OptionTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionTitle:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	OptionTitle:subscribeToGlobalModel(f1_arg1, "CurrentOptionInfo", "name", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			OptionTitle:setText(ConvertToUpperString(f2_local0))
		end
	end)
	self:addElement(OptionTitle)
	self.OptionTitle = OptionTitle
	local OptionDesc = LUI.UIText.new(0, 0, 0, 700, 0, 0, 39, 60)
	OptionDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OptionDesc:setTTF("dinnext_regular")
	OptionDesc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionDesc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	OptionDesc:subscribeToGlobalModel(f1_arg1, "CurrentOptionInfo", "hintText", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			OptionDesc:setText(f3_local0)
		end
	end)
	self:addElement(OptionDesc)
	self.OptionDesc = OptionDesc
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterSettingsSideBarSettingsText.__onClose = function(f4_arg0)
	f4_arg0.OptionTitle:close()
	f4_arg0.OptionDesc:close()
end
