CoD.PC_StartMenu_Options_Controls_DescriptionImage = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_DescriptionImage.__defaultWidth = 675
CoD.PC_StartMenu_Options_Controls_DescriptionImage.__defaultHeight = 380
CoD.PC_StartMenu_Options_Controls_DescriptionImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_DescriptionImage)
	self.id = "PC_StartMenu_Options_Controls_DescriptionImage"
	self.soundSet = "default"
	local PlaceHolderImage = LUI.UIImage.new(0, 0, 0, 675, 0, 0, 0, 380)
	PlaceHolderImage:setImage(RegisterImage("img_t7_menu_mp_preview_ethiopia"))
	self:addElement(PlaceHolderImage)
	self.PlaceHolderImage = PlaceHolderImage
	local TopBorderLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	TopBorderLine:setRGB(0.38, 0.36, 0.33)
	self:addElement(TopBorderLine)
	self.TopBorderLine = TopBorderLine
	local LeftBorderLine = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 5)
	LeftBorderLine:setRGB(0.38, 0.36, 0.33)
	self:addElement(LeftBorderLine)
	self.LeftBorderLine = LeftBorderLine
	local RightBorderLine = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 5)
	RightBorderLine:setRGB(0.38, 0.36, 0.33)
	self:addElement(RightBorderLine)
	self.RightBorderLine = RightBorderLine
	local BottomBorderLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 0)
	BottomBorderLine:setRGB(0.38, 0.36, 0.33)
	self:addElement(BottomBorderLine)
	self.BottomBorderLine = BottomBorderLine
	local WIP = LUI.UIText.new(0.18, 0.18, -11, 489, 0.5, 0.5, -37.5, 37.5)
	WIP:setAlpha(0)
	WIP:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_313222972922C54"))
	WIP:setTTF("ttmussels_demibold")
	WIP:setLetterSpacing(10)
	WIP:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	WIP:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(WIP)
	self.WIP = WIP
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
