require("x64:83beb065da2b240")
require("x64:a0fe8345b41542f")
CoD.CharacterSelection_CharacterInfo = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_CharacterInfo.__defaultWidth = 500
CoD.CharacterSelection_CharacterInfo.__defaultHeight = 160
CoD.CharacterSelection_CharacterInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.CharacterSelection_CharacterInfo)
	self.id = "CharacterSelection_CharacterInfo"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CharacterFullName = LUI.UIText.new(0, 0, 0, 393, 0, 0, 0, 40)
	CharacterFullName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CharacterFullName:setText("")
	CharacterFullName:setTTF("notosans_regular")
	CharacterFullName:setLetterSpacing(10)
	CharacterFullName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(CharacterFullName)
	self.CharacterFullName = CharacterFullName
	local CommonSocialArrow = CoD.CharacterSelection_CharacterInfoSeparator.new(f1_arg0, f1_arg1, 0, 0, -27, 400, 0, 0, 40, 52)
	self:addElement(CommonSocialArrow)
	self.CommonSocialArrow = CommonSocialArrow
	local availabilityText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 52, 80)
	availabilityText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	availabilityText:setText("")
	availabilityText:setTTF("ttmussels_regular")
	availabilityText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	availabilityText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(availabilityText)
	self.availabilityText = availabilityText
	local FeaturedGamesList = CoD.CharacterSelection_FeaturedGamesList.new(f1_arg0, f1_arg1, 0, 0, 0, 320, 0, 0, 80, 144)
	FeaturedGamesList:linkToElementModel(self, nil, false, function(model)
		FeaturedGamesList:setModel(model, f1_arg1)
	end)
	self:addElement(FeaturedGamesList)
	self.FeaturedGamesList = FeaturedGamesList
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "AnimState",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CharacterSelection_CharacterInfo.__resetProperties = function(f5_arg0)
	f5_arg0.CharacterFullName:completeAnimation()
	f5_arg0.FeaturedGamesList:completeAnimation()
	f5_arg0.availabilityText:completeAnimation()
	f5_arg0.CommonSocialArrow:completeAnimation()
	f5_arg0.CharacterFullName:setAlpha(1)
	f5_arg0.FeaturedGamesList:setAlpha(1)
	f5_arg0.availabilityText:setAlpha(1)
	f5_arg0.CommonSocialArrow:setAlpha(1)
end
CoD.CharacterSelection_CharacterInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.CharacterFullName:completeAnimation()
			f6_arg0.CharacterFullName:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CharacterFullName)
			f6_arg0.CommonSocialArrow:completeAnimation()
			f6_arg0.CommonSocialArrow:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CommonSocialArrow)
			f6_arg0.availabilityText:completeAnimation()
			f6_arg0.availabilityText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.availabilityText)
			f6_arg0.FeaturedGamesList:completeAnimation()
			f6_arg0.FeaturedGamesList:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FeaturedGamesList)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	AnimState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(300)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.CharacterFullName:beginAnimation(500)
				f8_arg0.CharacterFullName:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CharacterFullName:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.CharacterFullName:completeAnimation()
			f8_arg0.CharacterFullName:setAlpha(0)
			f8_local0(f8_arg0.CharacterFullName)
			local f8_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(300)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.availabilityText:beginAnimation(500)
				f8_arg0.availabilityText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.availabilityText:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f8_arg0.availabilityText:completeAnimation()
			f8_arg0.availabilityText:setAlpha(0)
			f8_local1(f8_arg0.availabilityText)
			local f8_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_in"])
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.FeaturedGamesList:beginAnimation(500)
				f8_arg0.FeaturedGamesList:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FeaturedGamesList:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f8_arg0.FeaturedGamesList:completeAnimation()
			f8_arg0.FeaturedGamesList:setAlpha(0)
			f8_local2(f8_arg0.FeaturedGamesList)
		end,
	},
}
CoD.CharacterSelection_CharacterInfo.__onClose = function(f15_arg0)
	f15_arg0.CommonSocialArrow:close()
	f15_arg0.FeaturedGamesList:close()
end
