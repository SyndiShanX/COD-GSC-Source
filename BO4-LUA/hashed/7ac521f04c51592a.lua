CoD.ChallengeCoin = InheritFrom(LUI.UIElement)
CoD.ChallengeCoin.__defaultWidth = 200
CoD.ChallengeCoin.__defaultHeight = 200
CoD.ChallengeCoin.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengeCoin)
	self.id = "ChallengeCoin"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChallengeCoinImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ChallengeCoinImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x98A2728B4675FB5))
	ChallengeCoinImage:setShaderVector(0, 0, 0, 0, 0)
	ChallengeCoinImage:setShaderVector(1, -46.81, 0, 0, 0)
	ChallengeCoinImage:subscribeToGlobalModel(f1_arg1, "GameScore", "challengeCoinImage", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ChallengeCoinImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ChallengeCoinImage)
	self.ChallengeCoinImage = ChallengeCoinImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengeCoin.__resetProperties = function(f3_arg0)
	f3_arg0.ChallengeCoinImage:completeAnimation()
	f3_arg0.ChallengeCoinImage:setAlpha(1)
	f3_arg0.ChallengeCoinImage:setShaderVector(0, 0, 0, 0, 0)
	f3_arg0.ChallengeCoinImage:setShaderVector(1, -46.81, 0, 0, 0)
end
CoD.ChallengeCoin.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Glint = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.ChallengeCoinImage:beginAnimation(1590, Enum[0xF50FFF429AB1890][0xC91E32008D731D0] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f5_arg0.ChallengeCoinImage:setShaderVector(0, 1, 0, 0, 0)
				f5_arg0.ChallengeCoinImage:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ChallengeCoinImage:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.ChallengeCoinImage:completeAnimation()
			f5_arg0.ChallengeCoinImage:setShaderVector(0, 0, 0, 0, 0)
			f5_arg0.ChallengeCoinImage:setShaderVector(1, -46.81, 0, 0, 0)
			f5_local0(f5_arg0.ChallengeCoinImage)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ChallengeCoinImage:completeAnimation()
			f7_arg0.ChallengeCoinImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ChallengeCoinImage)
		end,
	},
}
CoD.ChallengeCoin.__onClose = function(f8_arg0)
	f8_arg0.ChallengeCoinImage:close()
end
