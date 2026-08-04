CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionImage = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionImage.__defaultWidth = 673
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionImage.__defaultHeight = 329
CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionImage)
	self.id = "StartMenu_Options_PC_GraphicsOptions_DescriptionImage"
	self.soundSet = "default"
	local PlaceHolderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PlaceHolderImage:setImage(RegisterImage("img_t7_menu_mp_preview_biodome"))
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
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
