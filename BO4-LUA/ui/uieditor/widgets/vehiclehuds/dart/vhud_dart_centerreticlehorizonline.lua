CoD.vhud_dart_CenterReticleHorizonLine = InheritFrom(LUI.UIElement)
CoD.vhud_dart_CenterReticleHorizonLine.__defaultWidth = 687
CoD.vhud_dart_CenterReticleHorizonLine.__defaultHeight = 313
CoD.vhud_dart_CenterReticleHorizonLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_dart_CenterReticleHorizonLine)
	self.id = "vhud_dart_CenterReticleHorizonLine"
	self.soundSet = "default"
	local CenterReticle = LUI.UIImage.new(0.5, 0.5, -334, 334, 0.5, 0.5, -4, 4)
	CenterReticle:setImage(RegisterImage(@"uie_ui_hud_vehicle_dart_horizontal_line"))
	CenterReticle:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration"))
	CenterReticle:setShaderVector(0, 0.2, 1, 0, 0)
	CenterReticle:setShaderVector(1, 0, 0, 0, 0)
	CenterReticle:setShaderVector(2, 0, 0, 0, 0)
	CenterReticle:setShaderVector(3, 0, 0, 0, 0)
	CenterReticle:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(CenterReticle)
	self.CenterReticle = CenterReticle
	local CenterReticle0 = LUI.UIImage.new(0.5, 0.5, -334, 334, 0.5, 0.5, -4, 4)
	CenterReticle0:setAlpha(0.08)
	CenterReticle0:setZoom(-40)
	CenterReticle0:setImage(RegisterImage(@"uie_ui_hud_vehicle_dart_horizontal_line"))
	CenterReticle0:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration"))
	CenterReticle0:setShaderVector(0, 0.2, 1, 0, 0)
	CenterReticle0:setShaderVector(1, 0, 0, 0, 0)
	CenterReticle0:setShaderVector(2, 0, 0, 0, 0)
	CenterReticle0:setShaderVector(3, 0, 0, 0, 0)
	CenterReticle0:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(CenterReticle0)
	self.CenterReticle0 = CenterReticle0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
