require("x64:e95c1a1a693ac70")
CoD.TitleTextWidget = InheritFrom(LUI.UIElement)
CoD.TitleTextWidget.__defaultWidth = 600
CoD.TitleTextWidget.__defaultHeight = 51
CoD.TitleTextWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TitleTextWidget)
	self.id = "TitleTextWidget"
	self.soundSet = "CAC_EditLoadout"
	local titleGlow = CoD.cac_ItemTitleGlow.new(f1_arg0, f1_arg1, 0, 1, -3, 5, 0, 1, -4, 4)
	titleGlow:setRGB(0.9, 0.9, 0.9)
	self:addElement(titleGlow)
	self.titleGlow = titleGlow
	local itemName = LUI.UIText.new(0, 0, 4, 109, 0.5, 0.5, -22, 26)
	itemName:setRGB(0, 0, 0)
	itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	itemName:setTTF("ttmussels_demibold")
	itemName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	itemName:setShaderVector(0, 0.06, 0, 0, 0)
	itemName:setShaderVector(1, 0.02, 0, 0, 0)
	itemName:setShaderVector(2, 1, 0, 0, 0)
	itemName:setLetterSpacing(0.6)
	itemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(itemName, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 5)
	end)
	self:addElement(itemName)
	self.itemName = itemName
	local Glow = LUI.UIImage.new(0, 1, -80, 74, 0.5, 0.5, -45, 65)
	Glow:setAlpha(0.14)
	Glow:setImage(RegisterImage(@"uie_t7_menu_cac_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TitleTextWidget.__onClose = function(f3_arg0)
	f3_arg0.titleGlow:close()
end
