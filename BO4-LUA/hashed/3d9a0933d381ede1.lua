CoD.ZM_Title_Fog = InheritFrom(LUI.UIElement)
CoD.ZM_Title_Fog.__defaultWidth = 512
CoD.ZM_Title_Fog.__defaultHeight = 512
CoD.ZM_Title_Fog.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZM_Title_Fog)
	self.id = "ZM_Title_Fog"
	self.soundSet = "none"
	local Fog1 = LUI.UIImage.new(0, 0, 0, 512, 0, 0, 0, 512)
	Fog1:setImage(RegisterImage(@"uie_fxt_fog_slow_md_anim"))
	Fog1:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	Fog1:setShaderVector(0, 8, 8, 0, 0)
	Fog1:setShaderVector(1, 32, 0, 0, 0)
	self:addElement(Fog1)
	self.Fog1 = Fog1
	local Fog2 = LUI.UIImage.new(0, 0, 0, 512, 0, 0, 0, 512)
	Fog2:setZRot(180)
	Fog2:setImage(RegisterImage(@"uie_fxt_fog_slow_md_anim"))
	Fog2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	Fog2:setShaderVector(0, 8, 8, 0, 0)
	Fog2:setShaderVector(1, 14, 0, 0, 0)
	self:addElement(Fog2)
	self.Fog2 = Fog2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
