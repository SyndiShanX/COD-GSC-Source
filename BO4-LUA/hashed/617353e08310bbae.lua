CoD.ReservesSpecialContractProgressBar = InheritFrom(LUI.UIElement)
CoD.ReservesSpecialContractProgressBar.__defaultWidth = 344
CoD.ReservesSpecialContractProgressBar.__defaultHeight = 18
CoD.ReservesSpecialContractProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesSpecialContractProgressBar)
	self.id = "ReservesSpecialContractProgressBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Box = LUI.UIImage.new(0, 1, 10, -66, 0, 0.5, 3.5, 3.5)
	Box:setRGB(0.07, 0.07, 0.07)
	self:addElement(Box)
	self.Box = Box
	local ProgressBarBacking = LUI.UIImage.new(0, 1, 11, -67, 0, 0.33, 5, 5)
	ProgressBarBacking:setRGB(0.28, 0.28, 0.28)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local Progress = LUI.UIImage.new(0, 1, 11, -67, -0.08, 0.42, 5, 5)
	Progress:setRGB(1, 0.73, 0)
	Progress:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	Progress:setShaderVector(0, 1, 0, 0, 0)
	Progress:setShaderVector(1, 0, 0, 0, 0)
	Progress:setShaderVector(2, 1, 0, 0, 0)
	Progress:setShaderVector(3, 0, 0, 0, 0)
	Progress:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Progress)
	self.Progress = Progress
	local ProgressGlow = LUI.UIImage.new(0, 1, 11, -67, -0.13, 0.47, 5, 5)
	ProgressGlow:setRGB(1, 0.73, 0)
	ProgressGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	ProgressGlow:setShaderVector(0, 1, 0, 0, 0)
	ProgressGlow:setShaderVector(1, 0, 0, 0, 0)
	ProgressGlow:setShaderVector(2, 1, 0, 0, 0)
	ProgressGlow:setShaderVector(3, 0, 0, 0, 0)
	ProgressGlow:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ProgressGlow)
	self.ProgressGlow = ProgressGlow
	local TiledShaderImage = LUI.UIImage.new(0, 1, 10, -66, 0.28, 0.61, 1, 1)
	TiledShaderImage:setRGB(0, 0, 0)
	TiledShaderImage:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local ProgressFraction = LUI.UIText.new(1, 1, -58, 0, 0, 0, 0, 18)
	ProgressFraction:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ProgressFraction:setText("")
	ProgressFraction:setTTF("ttmussels_demibold")
	ProgressFraction:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ProgressFraction:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(ProgressFraction)
	self.ProgressFraction = ProgressFraction
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesSpecialContractProgressBar.__resetProperties = function(f2_arg0)
	f2_arg0.Progress:completeAnimation()
	f2_arg0.ProgressFraction:completeAnimation()
	f2_arg0.TiledShaderImage:completeAnimation()
	f2_arg0.Box:completeAnimation()
	f2_arg0.ProgressBarBacking:completeAnimation()
	f2_arg0.Progress:setRGB(1, 0.73, 0)
	f2_arg0.Progress:setAlpha(1)
	f2_arg0.ProgressFraction:setAlpha(1)
	f2_arg0.TiledShaderImage:setAlpha(1)
	f2_arg0.Box:setAlpha(1)
	f2_arg0.ProgressBarBacking:setAlpha(1)
end
CoD.ReservesSpecialContractProgressBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Complete = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Progress:completeAnimation()
			f4_arg0.Progress:setRGB(0.04, 0.83, 0.28)
			f4_arg0.clipFinished(f4_arg0.Progress)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			f5_arg0.Box:completeAnimation()
			f5_arg0.Box:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Box)
			f5_arg0.ProgressBarBacking:completeAnimation()
			f5_arg0.ProgressBarBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ProgressBarBacking)
			f5_arg0.Progress:completeAnimation()
			f5_arg0.Progress:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Progress)
			f5_arg0.TiledShaderImage:completeAnimation()
			f5_arg0.TiledShaderImage:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TiledShaderImage)
			f5_arg0.ProgressFraction:completeAnimation()
			f5_arg0.ProgressFraction:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ProgressFraction)
		end,
	},
}
