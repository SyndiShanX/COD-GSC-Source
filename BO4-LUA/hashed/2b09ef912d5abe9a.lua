CoD.ZMInvStageImage = InheritFrom(LUI.UIElement)
CoD.ZMInvStageImage.__defaultWidth = 128
CoD.ZMInvStageImage.__defaultHeight = 128
CoD.ZMInvStageImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvStageImage)
	self.id = "ZMInvStageImage"
	self.soundSet = "default"
	local Stage1Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Stage1Image:setImage(RegisterImage(0x604E717CD284868))
	Stage1Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6E9593DF28749F2))
	Stage1Image:setShaderVector(0, 1, 1, 0, 0)
	Stage1Image:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(Stage1Image)
	self.Stage1Image = Stage1Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
