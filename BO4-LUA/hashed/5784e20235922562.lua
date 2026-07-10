CoD.ui_icon_callingcards_fairytales_flame2 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_fairytales_flame2.__defaultWidth = 20
CoD.ui_icon_callingcards_fairytales_flame2.__defaultHeight = 20
CoD.ui_icon_callingcards_fairytales_flame2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_fairytales_flame2)
	self.id = "ui_icon_callingcards_fairytales_flame2"
	self.soundSet = "default"
	local fire2 = LUI.UIImage.new(0, 0, -210, 30, 0, 0, -132, 44)
	fire2:setImage(RegisterImage(0x45BC44F122A1920))
	fire2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(fire2)
	self.fire2 = fire2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
