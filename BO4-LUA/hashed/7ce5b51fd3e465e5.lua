CoD.ui_icon_callingcards_fairytales_flame3 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_fairytales_flame3.__defaultWidth = 20
CoD.ui_icon_callingcards_fairytales_flame3.__defaultHeight = 20
CoD.ui_icon_callingcards_fairytales_flame3.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_fairytales_flame3)
	self.id = "ui_icon_callingcards_fairytales_flame3"
	self.soundSet = "default"
	local fire3 = LUI.UIImage.new(0, 0, -220, 20, 0, 0, -120, 56)
	fire3:setImage(RegisterImage(0x45BC54F122A1AD3))
	fire3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(fire3)
	self.fire3 = fire3
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
