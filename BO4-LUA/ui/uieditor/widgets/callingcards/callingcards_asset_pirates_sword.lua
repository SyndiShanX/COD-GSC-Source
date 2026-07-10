CoD.CallingCards_Asset_Pirates_sword = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_Pirates_sword.__defaultWidth = 10
CoD.CallingCards_Asset_Pirates_sword.__defaultHeight = 10
CoD.CallingCards_Asset_Pirates_sword.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_Pirates_sword)
	self.id = "CallingCards_Asset_Pirates_sword"
	self.soundSet = "default"
	local sword = LUI.UIImage.new(0, 0, -323, 21, 0, 0, -25, 79)
	sword:setImage(RegisterImage(@"uie_ui_icon_callingcards_pirates_sword"))
	self:addElement(sword)
	self.sword = sword
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
