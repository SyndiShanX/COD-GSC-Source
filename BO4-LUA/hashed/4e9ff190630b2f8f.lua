CoD.ArchivesVoDDescription = InheritFrom(LUI.UIElement)
CoD.ArchivesVoDDescription.__defaultWidth = 510
CoD.ArchivesVoDDescription.__defaultHeight = 60
CoD.ArchivesVoDDescription.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.ArchivesVoDDescription)
	self.id = "ArchivesVoDDescription"
	self.soundSet = "none"
	local Title = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 36)
	Title:setRGB(0.92, 0.89, 0.72)
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Title:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Desc = LUI.UIText.new(0, 1, 0, 0, 0, 0, 46, 70)
	Desc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Desc:setTTF("ttmussels_regular")
	Desc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Desc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Desc:linkToElementModel(self, "desc", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Desc:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArchivesVoDDescription.__onClose = function(f4_arg0)
	f4_arg0.Title:close()
	f4_arg0.Desc:close()
end
