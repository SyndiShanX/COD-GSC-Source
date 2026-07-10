CoD.ContractProgressBar = InheritFrom(LUI.UIElement)
CoD.ContractProgressBar.__defaultWidth = 344
CoD.ContractProgressBar.__defaultHeight = 18
CoD.ContractProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractProgressBar)
	self.id = "ContractProgressBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Box = LUI.UIImage.new(0, 0.79, 60, 60, 0, 0.5, 3.5, 3.5)
	Box:setRGB(0.07, 0.07, 0.07)
	self:addElement(Box)
	self.Box = Box
	local ProgressBarBacking = LUI.UIImage.new(0, 0.78, 61, 61, 0, 0.33, 5, 5)
	ProgressBarBacking:setRGB(0.28, 0.28, 0.28)
	ProgressBarBacking:setImage(RegisterImage(0x1B69BB6285C5BBB))
	ProgressBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x31E7B3C72564429))
	ProgressBarBacking:setShaderVector(0, 0, 0, 0.55, 0.13)
	ProgressBarBacking:setShaderVector(2, 0, 1, 0, 1)
	ProgressBarBacking:setupNineSliceShader(25, 4)
	ProgressBarBacking:linkToElementModel(self, "totalRewardCount", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProgressBarBacking:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local ProgressBar = LUI.UIImage.new(0, 0.78, 61, 61, 0, 0.33, 5, 5)
	ProgressBar:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ProgressBar:setImage(RegisterImage(0x1B69BB6285C5BBB))
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x31E7B3C72564429))
	ProgressBar:setShaderVector(0, 0, 0, 0.55, 0.13)
	ProgressBar:setupNineSliceShader(25, 4)
	ProgressBar:linkToElementModel(self, "totalRewardCount", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	ProgressBar.__Wipe_X_Start_X_End_Y_Start_Y_End = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			ProgressBar:setShaderVector(2, CoD.ContractUtility.GetContractProgessBarWipe(self:getModel(), f1_arg1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end
	ProgressBar:linkToElementModel(self, "earnedRewardCount", true, ProgressBar.__Wipe_X_Start_X_End_Y_Start_Y_End)
	ProgressBar.__Wipe_X_Start_X_End_Y_Start_Y_End_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.earnedRewardCount
		end
		if f5_local0 then
			ProgressBar.__Wipe_X_Start_X_End_Y_Start_Y_End(f5_local0)
		end
	end
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local TiledShaderImage = LUI.UIImage.new(0.18, 0.97, -3, -3, 0.28, 0.61, 1, 1)
	TiledShaderImage:setRGB(0, 0, 0)
	TiledShaderImage:setImage(RegisterImage(0x4B6FFA90272070E))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local ProgressFraction = LUI.UIText.new(0, 0, 0, 58, 0, 0, 0, 18)
	ProgressFraction:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ProgressFraction:setTTF("ttmussels_regular")
	ProgressFraction:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ProgressFraction:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ProgressFraction:linkToElementModel(self, "rewardFractionString", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ProgressFraction:setText(f6_local0)
		end
	end)
	self:addElement(ProgressFraction)
	self.ProgressFraction = ProgressFraction
	ProgressBar:linkToElementModel(self, "totalRewardCount", true, ProgressBar.__Wipe_X_Start_X_End_Y_Start_Y_End_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractProgressBar.__resetProperties = function(f7_arg0)
	f7_arg0.ProgressFraction:completeAnimation()
	f7_arg0.TiledShaderImage:completeAnimation()
	f7_arg0.ProgressBar:completeAnimation()
	f7_arg0.ProgressBarBacking:completeAnimation()
	f7_arg0.Box:completeAnimation()
	f7_arg0.ProgressFraction:setAlpha(1)
	f7_arg0.TiledShaderImage:setAlpha(1)
	f7_arg0.ProgressBar:setAlpha(1)
	f7_arg0.ProgressBarBacking:setAlpha(1)
	f7_arg0.Box:setAlpha(1)
end
CoD.ContractProgressBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.Box:completeAnimation()
			f9_arg0.Box:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Box)
			f9_arg0.ProgressBarBacking:completeAnimation()
			f9_arg0.ProgressBarBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ProgressBarBacking)
			f9_arg0.ProgressBar:completeAnimation()
			f9_arg0.ProgressBar:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ProgressBar)
			f9_arg0.TiledShaderImage:completeAnimation()
			f9_arg0.TiledShaderImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TiledShaderImage)
			f9_arg0.ProgressFraction:completeAnimation()
			f9_arg0.ProgressFraction:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ProgressFraction)
		end,
	},
	HideProgress = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ProgressFraction:completeAnimation()
			f10_arg0.ProgressFraction:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ProgressFraction)
		end,
	},
}
CoD.ContractProgressBar.__onClose = function(f11_arg0)
	f11_arg0.ProgressBarBacking:close()
	f11_arg0.ProgressBar:close()
	f11_arg0.ProgressFraction:close()
end
