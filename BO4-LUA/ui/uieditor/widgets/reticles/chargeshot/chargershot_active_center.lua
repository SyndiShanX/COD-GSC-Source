CoD.ChargerShot_Active_Center = InheritFrom(LUI.UIElement)
CoD.ChargerShot_Active_Center.__defaultWidth = 108
CoD.ChargerShot_Active_Center.__defaultHeight = 108
CoD.ChargerShot_Active_Center.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargerShot_Active_Center)
	self.id = "ChargerShot_Active_Center"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setImage(RegisterImage(0x95D78ACBAA9028C))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
