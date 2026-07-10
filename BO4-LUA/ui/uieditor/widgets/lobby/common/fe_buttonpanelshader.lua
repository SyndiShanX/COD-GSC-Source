CoD.FE_ButtonPanelShader = InheritFrom(LUI.UIElement)
CoD.FE_ButtonPanelShader.__defaultWidth = 123
CoD.FE_ButtonPanelShader.__defaultHeight = 30
CoD.FE_ButtonPanelShader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_ButtonPanelShader)
	self.id = "FE_ButtonPanelShader"
	self.soundSet = "default"
	local Full = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -3, 3)
	Full:setImage(RegisterImage(0xA03CE50BF6A7EC9))
	Full:setMaterial(LUI.UIImage.GetCachedMaterial(0x2B96FF998623B68))
	Full:setShaderVector(0, 0, 0, 0, 0)
	Full:setShaderVector(1, 3, 3, 0, 0)
	Full:setupNineSliceShader(12, 12)
	self:addElement(Full)
	self.Full = Full
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
