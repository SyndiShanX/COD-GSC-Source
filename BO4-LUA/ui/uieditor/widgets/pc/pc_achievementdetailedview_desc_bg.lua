require("ui/uieditor/widgets/lobby/common/fe_titlenumbrdr")
CoD.PC_AchievementDetailedView_Desc_BG = InheritFrom(LUI.UIElement)
CoD.PC_AchievementDetailedView_Desc_BG.__defaultWidth = 600
CoD.PC_AchievementDetailedView_Desc_BG.__defaultHeight = 129
CoD.PC_AchievementDetailedView_Desc_BG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_AchievementDetailedView_Desc_BG)
	self.id = "PC_AchievementDetailedView_Desc_BG"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DescriptionBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DescriptionBG:setRGB(0.09, 0.09, 0.09)
	self:addElement(DescriptionBG)
	self.DescriptionBG = DescriptionBG
	local DescriptionOutline = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DescriptionOutline:setAlpha(0.2)
	self:addElement(DescriptionOutline)
	self.DescriptionOutline = DescriptionOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_AchievementDetailedView_Desc_BG.__onClose = function(f2_arg0)
	f2_arg0.DescriptionOutline:close()
end
