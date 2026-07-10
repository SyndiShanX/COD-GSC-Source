CoD.WZAAR_Challenges_NearCompletion_CroppedImage = InheritFrom(LUI.UIElement)
CoD.WZAAR_Challenges_NearCompletion_CroppedImage.__defaultWidth = 345
CoD.WZAAR_Challenges_NearCompletion_CroppedImage.__defaultHeight = 56
CoD.WZAAR_Challenges_NearCompletion_CroppedImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_Challenges_NearCompletion_CroppedImage)
	self.id = "WZAAR_Challenges_NearCompletion_CroppedImage"
	self.soundSet = "ChooseDecal"
	local Image = LUI.UIImage.new(0.5, 0.5, -172.5, 172.5, 0.5, 0.5, -28, 28)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Image:setShaderVector(0, 0, 0.5, 0, 0)
	Image:setShaderVector(1, 1, 1, 0, 0)
	Image:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
