CoD.FinalKillcamPlayerInfo = InheritFrom(LUI.UIElement)
CoD.FinalKillcamPlayerInfo.__defaultWidth = 1920
CoD.FinalKillcamPlayerInfo.__defaultHeight = 155
CoD.FinalKillcamPlayerInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FinalKillcamPlayerInfo)
	self.id = "FinalKillcamPlayerInfo"
	self.soundSet = "default"
	local blurbackplate = LUI.UIImage.new(-0.05, 1.05, 0, 0, 0, 0, 0, 155)
	blurbackplate:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blurbackplate:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blurbackplate)
	self.blurbackplate = blurbackplate
	local blackplate = LUI.UIImage.new(-0.05, 1.05, 0, 0, 0, 0, 0, 155)
	blackplate:setRGB(0, 0, 0)
	blackplate:setAlpha(0.97)
	self:addElement(blackplate)
	self.blackplate = blackplate
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
