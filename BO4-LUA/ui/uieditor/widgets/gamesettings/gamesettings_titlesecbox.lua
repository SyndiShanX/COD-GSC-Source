require("x64:e95c1a1a693ac70")
require("x64:6d874b1ace30c05")
CoD.GameSettings_titlesecbox = InheritFrom(LUI.UIElement)
CoD.GameSettings_titlesecbox.__defaultWidth = 528
CoD.GameSettings_titlesecbox.__defaultHeight = 45
CoD.GameSettings_titlesecbox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_titlesecbox)
	self.id = "GameSettings_titlesecbox"
	self.soundSet = "default"
	local GameSettingstextboxBG = CoD.GameSettings_textboxBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(GameSettingstextboxBG)
	self.GameSettingstextboxBG = GameSettingstextboxBG
	local TitleGlow1 = CoD.cac_ItemTitleGlow.new(f1_arg0, f1_arg1, 0, 1, -4, 4, 0, 1, -4, 4)
	TitleGlow1:setRGB(0, 0, 0)
	TitleGlow1:setAlpha(0.95)
	self:addElement(TitleGlow1)
	self.TitleGlow1 = TitleGlow1
	local Glow = LUI.UIImage.new(0, 1, -81, 73, 0.5, 0.5, -45, 65)
	Glow:setRGB(0, 0, 0)
	Glow:setAlpha(0.5)
	Glow:setImage(RegisterImage(@"uie_t7_menu_cac_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local Textbox = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -16.5, 16.5)
	Textbox:setRGB(0.96, 0.93, 0.84)
	Textbox:setText(LocalizeIntoString(@"hash_0", "Care Package"))
	Textbox:setTTF("ttmussels_regular")
	Textbox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	Textbox:setShaderVector(0, 0.06, 0, 0, 0)
	Textbox:setShaderVector(1, 0.02, 0, 0, 0)
	Textbox:setShaderVector(2, 1, 0, 0, 0)
	Textbox:setLetterSpacing(6)
	Textbox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Textbox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(Textbox, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 2)
	end)
	self:addElement(Textbox)
	self.Textbox = Textbox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_titlesecbox.__onClose = function(f3_arg0)
	f3_arg0.GameSettingstextboxBG:close()
	f3_arg0.TitleGlow1:close()
end
