CoD.PrematchCountdown_NumbersInternal = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_NumbersInternal.__defaultWidth = 240
CoD.PrematchCountdown_NumbersInternal.__defaultHeight = 105
CoD.PrematchCountdown_NumbersInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown_NumbersInternal)
	self.id = "PrematchCountdown_NumbersInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Numbers = LUI.UIText.new(0.5, 0.5, -120, 120, 0, 0, -6, 123)
	Numbers:setText("")
	Numbers:setTTF("ttmussels_demibold")
	Numbers:setMaterial(LUI.UIImage.GetCachedMaterial(0x6250C6FCAC36BD4))
	Numbers:setShaderVector(0, 0.14, 0, 0, 0)
	Numbers:setShaderVector(1, 0, 0, 0, 0.3)
	Numbers:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Numbers:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Numbers)
	self.Numbers = Numbers
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PrematchCountdown_NumbersInternal.__resetProperties = function(f2_arg0)
	f2_arg0.Numbers:completeAnimation()
	f2_arg0.Numbers:setAlpha(1)
end
CoD.PrematchCountdown_NumbersInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Start = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.Numbers:beginAnimation(260)
				f4_arg0.Numbers:setAlpha(1)
				f4_arg0.Numbers:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Numbers:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.Numbers:completeAnimation()
			f4_arg0.Numbers:setAlpha(0)
			f4_local0(f4_arg0.Numbers)
		end,
	},
}
