CoD.Toast_ItemTitleGlow = InheritFrom(LUI.UIElement)
CoD.Toast_ItemTitleGlow.__defaultWidth = 144
CoD.Toast_ItemTitleGlow.__defaultHeight = 60
CoD.Toast_ItemTitleGlow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Toast_ItemTitleGlow)
	self.id = "Toast_ItemTitleGlow"
	self.soundSet = "default"
	local Image1 = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 12)
	Image1:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowul"))
	Image1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image1)
	self.Image1 = Image1
	local Image2 = LUI.UIImage.new(0, 1, 12, -12, 0, 0, 0, 12)
	Image2:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowum"))
	Image2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(1, 1, -12, 0, 0, 0, 0, 12)
	Image3:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowur"))
	Image3:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image3)
	self.Image3 = Image3
	local Image4 = LUI.UIImage.new(0, 0, 0, 12, 0, 1, 12, -12)
	Image4:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowml"))
	Image4:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image4)
	self.Image4 = Image4
	local Image5 = LUI.UIImage.new(0, 1, 12, -12, 0, 1, 12, -12)
	Image5:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowmm"))
	Image5:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image5)
	self.Image5 = Image5
	local Image6 = LUI.UIImage.new(1, 1, -12, 0, 0, 1, 12, -12)
	Image6:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowmr"))
	Image6:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image6)
	self.Image6 = Image6
	local Image7 = LUI.UIImage.new(0, 0, 0, 12, 1, 1, -12, 0)
	Image7:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowll"))
	Image7:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image7)
	self.Image7 = Image7
	local Image8 = LUI.UIImage.new(0, 1, 12, -12, 1, 1, -12, 0)
	Image8:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowlm"))
	Image8:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image8)
	self.Image8 = Image8
	local Image9 = LUI.UIImage.new(1, 1, -12, 0, 1, 1, -12, 0)
	Image9:setImage(RegisterImage(@"uie_t7_menu_cac_itemtitleglowlr"))
	Image9:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image9)
	self.Image9 = Image9
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
