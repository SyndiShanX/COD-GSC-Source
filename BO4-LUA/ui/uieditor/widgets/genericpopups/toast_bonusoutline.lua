require("ui/uieditor/widgets/genericpopups/gp_framebackgroundt")
require("ui/uieditor/widgets/genericpopups/toast_itemtitleglow")
CoD.Toast_BonusOutline = InheritFrom(LUI.UIElement)
CoD.Toast_BonusOutline.__defaultWidth = 456
CoD.Toast_BonusOutline.__defaultHeight = 120
CoD.Toast_BonusOutline.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Toast_BonusOutline)
	self.id = "Toast_BonusOutline"
	self.soundSet = "default"
	local ToastItemTitleGlow = CoD.Toast_ItemTitleGlow.new(f1_arg0, f1_arg1, 0.5, 0.5, -61, 56, 1, 1, -35, 3)
	self:addElement(ToastItemTitleGlow)
	self.ToastItemTitleGlow = ToastItemTitleGlow
	local Bonus = LUI.UIText.new(0.5, 0.5, -113, 107, 1, 1, -25, 0)
	Bonus:setRGB(0, 0, 0)
	Bonus:setText(Engine[@"hash_4F9F1239CFD921FE"]("mpui/bonus_caps"))
	Bonus:setTTF("dinnext_regular")
	Bonus:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	Bonus:setShaderVector(0, 0.06, 0, 0, 0)
	Bonus:setShaderVector(1, 0.02, 0, 0, 0)
	Bonus:setShaderVector(2, 1, 0, 0, 0)
	Bonus:setLetterSpacing(1)
	Bonus:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Bonus:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(Bonus)
	self.Bonus = Bonus
	local FrameBackground = CoD.GP_FrameBackgroundt.new(f1_arg0, f1_arg1, 0, 1, -45, 43, 0, 1, 0, -24)
	self:addElement(FrameBackground)
	self.FrameBackground = FrameBackground
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Toast_BonusOutline.__onClose = function(f2_arg0)
	f2_arg0.ToastItemTitleGlow:close()
	f2_arg0.FrameBackground:close()
end
