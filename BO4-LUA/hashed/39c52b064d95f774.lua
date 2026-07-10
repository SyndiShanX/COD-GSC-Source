require("x64:e8e4ca11e9bec8b")
require("x64:ec94048bad1fbac")
CoD.AARMissionReward_CharacterName = InheritFrom(LUI.UIElement)
CoD.AARMissionReward_CharacterName.__defaultWidth = 653
CoD.AARMissionReward_CharacterName.__defaultHeight = 114
CoD.AARMissionReward_CharacterName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARMissionReward_CharacterName)
	self.id = "AARMissionReward_CharacterName"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UnlockCondition = LUI.UIText.new(0, 0, 27, 653, 0, 0, 80, 116)
	UnlockCondition:setRGB(0.63, 0.77, 0.89)
	UnlockCondition:setAlpha(0.5)
	UnlockCondition:setTTF("ttmussels_regular")
	UnlockCondition:setLetterSpacing(2)
	UnlockCondition:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	UnlockCondition:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	UnlockCondition:linkToElementModel(self, "unlockDesc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			UnlockCondition:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(UnlockCondition)
	self.UnlockCondition = UnlockCondition
	local CharacterName = LUI.UIText.new(0, 0, 23, 653, 0, 0, -6, 69)
	CharacterName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	CharacterName:setAlpha(0.5)
	CharacterName:setTTF("ttmussels_demibold")
	CharacterName:setLetterSpacing(8)
	CharacterName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CharacterName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	CharacterName:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CharacterName:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(CharacterName)
	self.CharacterName = CharacterName
	local CommonSocialArrow = CoD.CommonSocialArrow.new(f1_arg0, f1_arg1, 0, 0, -7, 17, 0, 0, 64, 76)
	CommonSocialArrow:setAlpha(0.5)
	CommonSocialArrow:setZRot(180)
	self:addElement(CommonSocialArrow)
	self.CommonSocialArrow = CommonSocialArrow
	local DirectorDividerWithGradient = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0.5, 0.5, -303.5, 300.5, 0, 0, 70, 71)
	DirectorDividerWithGradient:setRGB(0.39, 0.39, 0.39)
	self:addElement(DirectorDividerWithGradient)
	self.DirectorDividerWithGradient = DirectorDividerWithGradient
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARMissionReward_CharacterName.__resetProperties = function(f4_arg0)
	f4_arg0.DirectorDividerWithGradient:completeAnimation()
	f4_arg0.CommonSocialArrow:completeAnimation()
	f4_arg0.UnlockCondition:completeAnimation()
	f4_arg0.CharacterName:completeAnimation()
	f4_arg0.DirectorDividerWithGradient:setLeftRight(0.5, 0.5, -303.5, 300.5)
	f4_arg0.CommonSocialArrow:setAlpha(0.5)
	f4_arg0.UnlockCondition:setAlpha(0.5)
	f4_arg0.CharacterName:setAlpha(0.5)
end
CoD.AARMissionReward_CharacterName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(300)
					f7_arg0:setAlpha(0.5)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.UnlockCondition:beginAnimation(500)
				f5_arg0.UnlockCondition:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.UnlockCondition:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.UnlockCondition:completeAnimation()
			f5_arg0.UnlockCondition:setAlpha(0)
			f5_local0(f5_arg0.UnlockCondition)
			local f5_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(199)
					f9_arg0:setAlpha(0.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.CharacterName:beginAnimation(500)
				f5_arg0.CharacterName:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CharacterName:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f5_arg0.CharacterName:completeAnimation()
			f5_arg0.CharacterName:setAlpha(0)
			f5_local1(f5_arg0.CharacterName)
			local f5_local2 = function(f10_arg0)
				f5_arg0.CommonSocialArrow:beginAnimation(200)
				f5_arg0.CommonSocialArrow:setAlpha(0.5)
				f5_arg0.CommonSocialArrow:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CommonSocialArrow:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.CommonSocialArrow:completeAnimation()
			f5_arg0.CommonSocialArrow:setAlpha(0)
			f5_local2(f5_arg0.CommonSocialArrow)
			local f5_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(300)
					f12_arg0:setLeftRight(0.5, 0.5, -299.5, 300.5)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.DirectorDividerWithGradient:beginAnimation(200)
				f5_arg0.DirectorDividerWithGradient:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.DirectorDividerWithGradient:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f5_arg0.DirectorDividerWithGradient:completeAnimation()
			f5_arg0.DirectorDividerWithGradient:setLeftRight(0.5, 0.5, -299.5, -299.5)
			f5_local3(f5_arg0.DirectorDividerWithGradient)
		end,
	},
}
CoD.AARMissionReward_CharacterName.__onClose = function(f13_arg0)
	f13_arg0.UnlockCondition:close()
	f13_arg0.CharacterName:close()
	f13_arg0.CommonSocialArrow:close()
	f13_arg0.DirectorDividerWithGradient:close()
end
