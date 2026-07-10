require("x64:100e5d2a5970b5e")
require("x64:29187ea00d726c3")
CoD.PC_AchievementDetailedView_Desc = InheritFrom(LUI.UIElement)
CoD.PC_AchievementDetailedView_Desc.__defaultWidth = 600
CoD.PC_AchievementDetailedView_Desc.__defaultHeight = 129
CoD.PC_AchievementDetailedView_Desc.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.PC_AchievementDetailedView_Desc)
	self.id = "PC_AchievementDetailedView_Desc"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DescriptionBG = CoD.PC_AchievementDetailedView_Desc_BG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(DescriptionBG)
	self.DescriptionBG = DescriptionBG
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 15)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local Name = LUI.UIText.new(0, 1, 25, -25, 0, 0, 25, 50)
	Name:setRGB(0.7, 0.67, 0.62)
	Name:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(4)
	Name:setLineSpacing(3)
	Name:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Name)
	self.Name = Name
	local Separator = LUI.UIImage.new(0, 1, 20, -20, 0, 0, 60, 61)
	Separator:setAlpha(0.01)
	self:addElement(Separator)
	self.Separator = Separator
	local Description = LUI.UIText.new(0, 1, 25, -25, 0, 0, 71, 89)
	Description:setRGB(0.49, 0.47, 0.45)
	Description:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(1)
	Description:setLineSpacing(3)
	Description:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, -0.01, 0.99, 0, 0, 0, 0, 99, 111)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_AchievementDetailedView_Desc.__onClose = function(f2_arg0)
	f2_arg0.DescriptionBG:close()
	f2_arg0.VerticalListSpacer:close()
	f2_arg0.VerticalListSpacer2:close()
end
