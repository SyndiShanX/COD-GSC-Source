CoD.AnimationLoading2 = InheritFrom(LUI.UIElement)
CoD.AnimationLoading2.__defaultWidth = 216
CoD.AnimationLoading2.__defaultHeight = 216
CoD.AnimationLoading2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AnimationLoading2)
	self.id = "AnimationLoading2"
	self.soundSet = "ChooseDecal"
	local Image0 = LUI.UIImage.new(0, 0, 0, 216, 0, 0, 0, 216)
	Image0:setImage(RegisterImage(@"t7_menu_loadingspinner_flipbook"))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	Image0:setShaderVector(0, 28, 0, 0, 0)
	Image0:setShaderVector(1, 22, 0, 0, 0)
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
