CoD.PC_Korea_Event_Week_WeekProgress_Title = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Week_WeekProgress_Title.__defaultWidth = 705
CoD.PC_Korea_Event_Week_WeekProgress_Title.__defaultHeight = 97
CoD.PC_Korea_Event_Week_WeekProgress_Title.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_Week_WeekProgress_Title)
	self.id = "PC_Korea_Event_Week_WeekProgress_Title"
	self.soundSet = "default"
	local WeekTitleImage = LUI.UIImage.new(0.5, 0.5, -350, 350, 0.5, 0.5, -44, 48)
	WeekTitleImage:setImage(RegisterImage(0x69B4E11F86D3E2))
	self:addElement(WeekTitleImage)
	self.WeekTitleImage = WeekTitleImage
	local WeekTitleHatching = LUI.UIImage.new(0.5, 0.5, -350, 350, 0.5, 0.5, 40, 48)
	WeekTitleHatching:setImage(RegisterImage(0xA9236D0B7D5254E))
	self:addElement(WeekTitleHatching)
	self.WeekTitleHatching = WeekTitleHatching
	local DescriptionLineBorder = LUI.UIImage.new(0.5, 0.5, -350, 350, 0.5, 0.5, -48.5, -29.5)
	DescriptionLineBorder:setImage(RegisterImage(0xC752149A1FA1AAE))
	DescriptionLineBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	DescriptionLineBorder:setShaderVector(0, 0, 0, 0, 0)
	DescriptionLineBorder:setupNineSliceShader(6, 6)
	self:addElement(DescriptionLineBorder)
	self.DescriptionLineBorder = DescriptionLineBorder
	local CornerPips2 = LUI.UIImage.new(0.5, 0.5, -352.5, -347.5, 0.5, 0.5, -46.5, -41.5)
	CornerPips2:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerPips2)
	self.CornerPips2 = CornerPips2
	local CornerPips = LUI.UIImage.new(0.5, 0.5, 347.5, 352.5, 0.5, 0.5, -46.5, -41.5)
	CornerPips:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerPips)
	self.CornerPips = CornerPips
	local WeekTitle = LUI.UIText.new(0.5, 0.5, -323, 323, 0.5, 0.5, -15, 15)
	WeekTitle:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	WeekTitle:setText(Engine[0xF9F1239CFD921FE](0x3D50F4DBD8D908B))
	WeekTitle:setTTF("ttmussels_demibold")
	WeekTitle:setLetterSpacing(3)
	WeekTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WeekTitle:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(WeekTitle)
	self.WeekTitle = WeekTitle
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
