CoD.ChargerShot_ActiveLock = InheritFrom(LUI.UIElement)
CoD.ChargerShot_ActiveLock.__defaultWidth = 384
CoD.ChargerShot_ActiveLock.__defaultHeight = 384
CoD.ChargerShot_ActiveLock.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargerShot_ActiveLock)
	self.id = "ChargerShot_ActiveLock"
	self.soundSet = "ChooseDecal"
	local Image0 = LUI.UIImage.new(0, 1, 1, -1, 0, 1, 0, 0)
	Image0:setImage(RegisterImage(0x5369907439E6D6A))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
