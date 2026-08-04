CoD.PC_StartMenu_OptionsTabs_Background = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_OptionsTabs_Background.__defaultWidth = 1920
CoD.PC_StartMenu_OptionsTabs_Background.__defaultHeight = 38
CoD.PC_StartMenu_OptionsTabs_Background.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_OptionsTabs_Background)
	self.id = "PC_StartMenu_OptionsTabs_Background"
	self.soundSet = "default"
	local TabBackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 37)
	TabBackingTint:setRGB(0.13, 0.13, 0.13)
	TabBackingTint:setAlpha(0.25)
	self:addElement(TabBackingTint)
	self.TabBackingTint = TabBackingTint
	local TabBottomLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 34, 38)
	TabBottomLine:setAlpha(0.08)
	TabBottomLine:setImage(RegisterImage("uie_ui_menu_common_tab_line_bottom"))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	local TabBackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 37)
	TabBackingBlur:setAlpha(0)
	TabBackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	TabBackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(TabBackingBlur)
	self.TabBackingBlur = TabBackingBlur
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
