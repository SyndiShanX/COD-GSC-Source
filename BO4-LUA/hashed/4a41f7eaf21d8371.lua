require("x64:90b88e935956c1d")
CoD.AARTierRewardItemCommon = InheritFrom(LUI.UIElement)
CoD.AARTierRewardItemCommon.__defaultWidth = 105
CoD.AARTierRewardItemCommon.__defaultHeight = 136
CoD.AARTierRewardItemCommon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardItemCommon)
	self.id = "AARTierRewardItemCommon"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.85)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BGBrighten = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBrighten:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
	BGBrighten:setAlpha(0.05)
	BGBrighten:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BGBrighten)
	self.BGBrighten = BGBrighten
	local RadialGlow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RadialGlow:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
	RadialGlow:setAlpha(0.02)
	RadialGlow:setImage(RegisterImage(0x74F13AE9F5148FE))
	self:addElement(RadialGlow)
	self.RadialGlow = RadialGlow
	local Darken = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Darken:setRGB(0, 0, 0)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local RewardImage = CoD.AARTierRewardItemImage.new(f1_arg0, f1_arg1, 0, 1, 1, -1, 0, 1, 1, -1)
	RewardImage:linkToElementModel(self, nil, false, function(model)
		RewardImage:setModel(model, f1_arg1)
	end)
	self:addElement(RewardImage)
	self.RewardImage = RewardImage
	local LockBacker = LUI.UIImage.new(1, 1, -52, 0, 1, 1, -52, 0)
	LockBacker:setRGB(0, 0, 0)
	LockBacker:setAlpha(0)
	LockBacker:setImage(RegisterImage(0xB6B0FDFB6B66AF9))
	self:addElement(LockBacker)
	self.LockBacker = LockBacker
	local LockIcon = LUI.UIImage.new(1, 1, -52, 0, 1, 1, -52, 0)
	LockIcon:setAlpha(0)
	LockIcon:setImage(RegisterImage(0x410BF8B0F9878A4))
	LockIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	LockIcon:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(LockIcon)
	self.LockIcon = LockIcon
	local CommonFrame01 = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	CommonFrame01:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
	CommonFrame01:setImage(RegisterImage(0xCA6E5C175806396))
	CommonFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	CommonFrame01:setShaderVector(0, 0, 0, 0, 0)
	CommonFrame01:setupNineSliceShader(8, 8)
	self:addElement(CommonFrame01)
	self.CommonFrame01 = CommonFrame01
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "primaryImage")
			end,
		},
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "unlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	self:linkToElementModel(self, "primaryImage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "primaryImage",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardItemCommon.__resetProperties = function(f8_arg0)
	f8_arg0.CommonFrame01:completeAnimation()
	f8_arg0.Darken:completeAnimation()
	f8_arg0.LockBacker:completeAnimation()
	f8_arg0.LockIcon:completeAnimation()
	f8_arg0.RewardImage:completeAnimation()
	f8_arg0.NoiseTiledBacking:completeAnimation()
	f8_arg0.RadialGlow:completeAnimation()
	f8_arg0.BGBrighten:completeAnimation()
	f8_arg0.CommonFrame01:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
	f8_arg0.CommonFrame01:setAlpha(1)
	f8_arg0.Darken:setAlpha(0)
	f8_arg0.LockBacker:setAlpha(0)
	f8_arg0.LockIcon:setAlpha(0)
	f8_arg0.RewardImage:setRGB(1, 1, 1)
	f8_arg0.NoiseTiledBacking:setRGB(1, 1, 1)
	f8_arg0.NoiseTiledBacking:setAlpha(0.85)
	f8_arg0.RadialGlow:setAlpha(0.02)
	f8_arg0.BGBrighten:setAlpha(0.05)
end
CoD.AARTierRewardItemCommon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.CommonFrame01:completeAnimation()
			f9_arg0.CommonFrame01:setRGB(0.49, 0.49, 0.49)
			f9_arg0.clipFinished(f9_arg0.CommonFrame01)
		end,
	},
	Locked = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.Darken:completeAnimation()
			f10_arg0.Darken:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Darken)
			f10_arg0.RewardImage:completeAnimation()
			f10_arg0.RewardImage:setRGB(0.39, 0.38, 0.34)
			f10_arg0.clipFinished(f10_arg0.RewardImage)
			f10_arg0.LockBacker:completeAnimation()
			f10_arg0.LockBacker:setAlpha(0.5)
			f10_arg0.clipFinished(f10_arg0.LockBacker)
			f10_arg0.LockIcon:completeAnimation()
			f10_arg0.LockIcon:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.LockIcon)
			f10_arg0.CommonFrame01:completeAnimation()
			f10_arg0.CommonFrame01:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
			f10_arg0.clipFinished(f10_arg0.CommonFrame01)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Darken:beginAnimation(200)
				f11_arg0.Darken:setAlpha(0)
				f11_arg0.Darken:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Darken:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Darken:completeAnimation()
			f11_arg0.Darken:setAlpha(0.4)
			f11_local0(f11_arg0.Darken)
			local f11_local1 = function(f13_arg0)
				f11_arg0.CommonFrame01:beginAnimation(200)
				f11_arg0.CommonFrame01:setRGB(ColorSet.BlackMarketCommonBright.r, ColorSet.BlackMarketCommonBright.g, ColorSet.BlackMarketCommonBright.b)
				f11_arg0.CommonFrame01:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.CommonFrame01:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.CommonFrame01:completeAnimation()
			f11_arg0.CommonFrame01:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
			f11_local1(f11_arg0.CommonFrame01)
		end,
	},
	Empty = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setRGB(0.52, 0.52, 0.52)
			f14_arg0.NoiseTiledBacking:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBacking)
			f14_arg0.BGBrighten:completeAnimation()
			f14_arg0.BGBrighten:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BGBrighten)
			f14_arg0.RadialGlow:completeAnimation()
			f14_arg0.RadialGlow:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.RadialGlow)
			f14_arg0.CommonFrame01:completeAnimation()
			f14_arg0.CommonFrame01:setRGB(0.31, 0.31, 0.34)
			f14_arg0.CommonFrame01:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CommonFrame01)
		end,
	},
	Earned = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.Darken:completeAnimation()
			f15_arg0.Darken:setAlpha(0.2)
			f15_arg0.clipFinished(f15_arg0.Darken)
			f15_arg0.CommonFrame01:completeAnimation()
			f15_arg0.CommonFrame01:setRGB(0.26, 0.26, 0.26)
			f15_arg0.clipFinished(f15_arg0.CommonFrame01)
		end,
	},
}
CoD.AARTierRewardItemCommon.__onClose = function(f16_arg0)
	f16_arg0.RewardImage:close()
end
