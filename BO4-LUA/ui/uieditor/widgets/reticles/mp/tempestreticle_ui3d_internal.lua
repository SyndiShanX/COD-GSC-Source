CoD.TempestReticle_UI3D_Internal = InheritFrom(LUI.UIElement)
CoD.TempestReticle_UI3D_Internal.__defaultWidth = 450
CoD.TempestReticle_UI3D_Internal.__defaultHeight = 300
CoD.TempestReticle_UI3D_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TempestReticle_UI3D_Internal)
	self.id = "TempestReticle_UI3D_Internal"
	self.soundSet = "default"
	local leftHash = LUI.UIImage.new(0, 0, 0, 75, 0.5, 0.5, -17, -15)
	self:addElement(leftHash)
	self.leftHash = leftHash
	local rightHash = LUI.UIImage.new(1, 1, -75, 0, 0.5, 0.5, -17, -15)
	self:addElement(rightHash)
	self.rightHash = rightHash
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
