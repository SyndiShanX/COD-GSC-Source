CoD.vhud_CenterCircleHorizon = InheritFrom(LUI.UIElement)
CoD.vhud_CenterCircleHorizon.__defaultWidth = 133
CoD.vhud_CenterCircleHorizon.__defaultHeight = 133
CoD.vhud_CenterCircleHorizon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_CenterCircleHorizon)
	self.id = "vhud_CenterCircleHorizon"
	self.soundSet = "default"
	local CenterCircleHorizon = LUI.UIImage.new(0.5, 0.5, -58, 58, 0.5, 0.5, -40, 40)
	CenterCircleHorizon:setAlpha(0.1)
	CenterCircleHorizon:setZoom(7)
	CenterCircleHorizon:setImage(RegisterImage(0x999492673C51C27))
	CenterCircleHorizon:setMaterial(LUI.UIImage.GetCachedMaterial(0x5956C6C1FD41D3C))
	CenterCircleHorizon:setShaderVector(0, 0.2, 1, 0, 0)
	CenterCircleHorizon:setShaderVector(1, 0, 0, 0, 0)
	CenterCircleHorizon:setShaderVector(2, 0, 0, 0, 0)
	CenterCircleHorizon:setShaderVector(3, 0, 0, 0, 0)
	CenterCircleHorizon:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(CenterCircleHorizon)
	self.CenterCircleHorizon = CenterCircleHorizon
	local CenterCircleHorizon0 = LUI.UIImage.new(0.5, 0.5, -58, 58, 0.5, 0.5, -40, 40)
	CenterCircleHorizon0:setImage(RegisterImage(0x999492673C51C27))
	CenterCircleHorizon0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(CenterCircleHorizon0)
	self.CenterCircleHorizon0 = CenterCircleHorizon0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
