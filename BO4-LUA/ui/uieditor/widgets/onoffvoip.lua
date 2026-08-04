CoD.OnOffVoip = InheritFrom(LUI.UIElement)
CoD.OnOffVoip.__defaultWidth = 72
CoD.OnOffVoip.__defaultHeight = 25
CoD.OnOffVoip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OnOffVoip)
	self.id = "OnOffVoip"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VoipWaves = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	VoipWaves:setRGB(0.86, 0.86, 0.87)
	VoipWaves:setAlpha(0.8)
	VoipWaves:setMaterial(LUI.UIImage.GetCachedMaterial(0xBCFA52E406081F2))
	VoipWaves:setShaderVector(0, 1, 0, 0, 0)
	VoipWaves:setShaderVector(1, 0.5, 0.1, 0.2, 16)
	VoipWaves:setShaderVector(2, CoD.BaseUtility.RandomVectorXRange(0, 100, 50, 0, 0, 0))
	self:addElement(VoipWaves)
	self.VoipWaves = VoipWaves
	local TopBlueBarRight = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 0, 2)
	TopBlueBarRight:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(TopBlueBarRight)
	self.TopBlueBarRight = TopBlueBarRight
	local Muted = nil
	Muted = LUI.UIImage.new(0.5, 0.5, -8, 8, 0.5, 0.5, -4.5, 11.5)
	Muted:setAlpha(0)
	Muted:setZRot(-90)
	Muted:setImage(RegisterImage("voice_off"))
	self:addElement(Muted)
	self.Muted = Muted
	self:mergeStateConditions({
		{
			stateName = "NoMic",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue(element, f1_arg1, "voipStatus", Enum[@"hash_6B5FD9E48749F3BC"][0x76A19049F82B1E3], Enum[@"hash_6B5FD9E48749F3BC"][0xCE9DDBD0F71A141])
			end,
		},
		{
			stateName = "Muted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue(element, f1_arg1, "voipStatus", Enum[@"hash_6B5FD9E48749F3BC"][0xF1919C255E8BA7B], Enum[@"hash_6B5FD9E48749F3BC"][0xE73F181672DFE2F])
			end,
		},
		{
			stateName = "PlatformPartyMuted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "voipStatus", Enum[@"hash_6B5FD9E48749F3BC"][0x9A6D77555AAD3A1])
			end,
		},
	})
	self:linkToElementModel(self, "voipStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "voipStatus",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.DirectorUtility.ModifyAmplitudeBasedOnVoipStatus(self, VoipWaves, 600, 100)
	return self
end
CoD.OnOffVoip.__resetProperties = function(f6_arg0)
	f6_arg0.TopBlueBarRight:completeAnimation()
	f6_arg0.VoipWaves:completeAnimation()
	f6_arg0.Muted:completeAnimation()
	f6_arg0.TopBlueBarRight:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f6_arg0.TopBlueBarRight:setAlpha(1)
	f6_arg0.VoipWaves:setAlpha(0.8)
	f6_arg0.Muted:setAlpha(0)
end
CoD.OnOffVoip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	NoMic = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.VoipWaves:completeAnimation()
			f8_arg0.VoipWaves:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.VoipWaves)
			f8_arg0.TopBlueBarRight:completeAnimation()
			f8_arg0.TopBlueBarRight:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TopBlueBarRight)
		end,
	},
	Muted = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.VoipWaves:completeAnimation()
			f9_arg0.VoipWaves:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.VoipWaves)
			f9_arg0.TopBlueBarRight:completeAnimation()
			f9_arg0.TopBlueBarRight:setRGB(0.53, 0.11, 0.14)
			f9_arg0.clipFinished(f9_arg0.TopBlueBarRight)
			f9_arg0.Muted:completeAnimation()
			f9_arg0.Muted:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Muted)
		end,
	},
	PlatformPartyMuted = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.VoipWaves:completeAnimation()
			f10_arg0.VoipWaves:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VoipWaves)
			f10_arg0.TopBlueBarRight:completeAnimation()
			f10_arg0.TopBlueBarRight:setRGB(0.53, 0.11, 0.13)
			f10_arg0.clipFinished(f10_arg0.TopBlueBarRight)
			f10_arg0.Muted:completeAnimation()
			f10_arg0.Muted:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Muted)
		end,
	},
}
CoD.OnOffVoip.__onClose = function(f11_arg0)
	f11_arg0.VoipWaves:close()
end
