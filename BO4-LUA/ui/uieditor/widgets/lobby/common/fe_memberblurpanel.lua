CoD.FE_MemberBlurPanel = InheritFrom(LUI.UIElement)
CoD.FE_MemberBlurPanel.__defaultWidth = 1476
CoD.FE_MemberBlurPanel.__defaultHeight = 162
CoD.FE_MemberBlurPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_MemberBlurPanel)
	self.id = "FE_MemberBlurPanel"
	self.soundSet = "default"
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setImage(RegisterImage(0x22D09C73662150D))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x92677F19E79D991))
	Image0:setShaderVector(0, 0, 20, 0, 0)
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
