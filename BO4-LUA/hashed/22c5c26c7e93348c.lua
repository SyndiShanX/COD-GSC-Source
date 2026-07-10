require("x64:e8e4ca11e9bec8b")
require("x64:ec94048bad1fbac")
CoD.CharacterSelection_CharacterInfoSeparator = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_CharacterInfoSeparator.__defaultWidth = 427
CoD.CharacterSelection_CharacterInfoSeparator.__defaultHeight = 12
CoD.CharacterSelection_CharacterInfoSeparator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CharacterSelection_CharacterInfoSeparator)
	self.id = "CharacterSelection_CharacterInfoSeparator"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorDividerWithGradient = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0.5, 0.5, -186.5, 213.5, 0, 0, 5.5, 6.5)
	DirectorDividerWithGradient:setRGB(0.39, 0.39, 0.39)
	self:addElement(DirectorDividerWithGradient)
	self.DirectorDividerWithGradient = DirectorDividerWithGradient
	local CommonSocialArrow = CoD.CommonSocialArrow.new(f1_arg0, f1_arg1, 0, 0, 0, 24, 0, 0, 0, 12)
	CommonSocialArrow:setAlpha(0.5)
	CommonSocialArrow:setZRot(180)
	self:addElement(CommonSocialArrow)
	self.CommonSocialArrow = CommonSocialArrow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CharacterSelection_CharacterInfoSeparator.__resetProperties = function(f2_arg0)
	f2_arg0.CommonSocialArrow:completeAnimation()
	f2_arg0.DirectorDividerWithGradient:completeAnimation()
	f2_arg0.CommonSocialArrow:setAlpha(0.5)
	f2_arg0.DirectorDividerWithGradient:setLeftRight(0.5, 0.5, -186.5, 213.5)
	f2_arg0.DirectorDividerWithGradient:setAlpha(1)
end
CoD.CharacterSelection_CharacterInfoSeparator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Reveal = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f6_arg0:setLeftRight(0.5, 0.5, -186.5, 213.5)
					f6_arg0:setAlpha(1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.DirectorDividerWithGradient:beginAnimation(200)
				f4_arg0.DirectorDividerWithGradient:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.DirectorDividerWithGradient:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.DirectorDividerWithGradient:completeAnimation()
			f4_arg0.DirectorDividerWithGradient:setLeftRight(0.5, 0.5, -186.5, -186.5)
			f4_arg0.DirectorDividerWithGradient:setAlpha(0)
			f4_local0(f4_arg0.DirectorDividerWithGradient)
			local f4_local1 = function(f7_arg0)
				f4_arg0.CommonSocialArrow:beginAnimation(200)
				f4_arg0.CommonSocialArrow:setAlpha(0.25)
				f4_arg0.CommonSocialArrow:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.CommonSocialArrow:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.CommonSocialArrow:completeAnimation()
			f4_arg0.CommonSocialArrow:setAlpha(0)
			f4_local1(f4_arg0.CommonSocialArrow)
		end,
	},
}
CoD.CharacterSelection_CharacterInfoSeparator.__onClose = function(f8_arg0)
	f8_arg0.DirectorDividerWithGradient:close()
	f8_arg0.CommonSocialArrow:close()
end
