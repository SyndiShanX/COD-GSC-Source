require("x64:b1e6659f5c94f4d")
CoD.WZAAR_ChallengeContainer = InheritFrom(LUI.UIElement)
CoD.WZAAR_ChallengeContainer.__defaultWidth = 540
CoD.WZAAR_ChallengeContainer.__defaultHeight = 622
CoD.WZAAR_ChallengeContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_ChallengeContainer)
	self.id = "WZAAR_ChallengeContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Title = CoD.WZ_AARChallengeContainerInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, -3, 625)
	self:addElement(Title)
	self.Title = Title
	local Sound = LUI.UIElement.new(0, 0, 741, 773, 0, 0, 255, 287)
	self:addElement(Sound)
	self.Sound = Sound
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.warzone.wzAAR.challengeProgEarned")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.warzone.wzAAR.challengeProgEarned"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.warzone.wzAAR.challengeProgEarned",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsSelfInState(self, "Hidden") then
			HideWidget(element)
		elseif IsSelfInState(self, "DefaultState") then
			ShowWidget(element)
		end
	end)
	Title.id = "Title"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR_ChallengeContainer.__resetProperties = function(f5_arg0)
	f5_arg0.Title:completeAnimation()
	f5_arg0.Sound:completeAnimation()
	f5_arg0.Title:setAlpha(1)
	f5_arg0.Title:setScale(1, 1)
	f5_arg0.Sound:setPlaySoundDirect(false)
end
CoD.WZAAR_ChallengeContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
					f8_arg0:setAlpha(1)
					f8_arg0:setScale(1, 1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.Title:beginAnimation(800)
				f6_arg0.Title:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Title:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.Title:completeAnimation()
			f6_arg0.Title:setAlpha(0)
			f6_arg0.Title:setScale(1.4, 1.4)
			f6_local0(f6_arg0.Title)
			f6_arg0.Sound:beginAnimation(800)
			f6_arg0.Sound:setPlaySoundDirect(true)
			f6_arg0.Sound:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
			f6_arg0.Sound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_wz_aar_box", f6_arg1)
				f6_arg0.clipFinished(element, event)
			end)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Title:completeAnimation()
			f10_arg0.Title:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Title)
		end,
	},
}
CoD.WZAAR_ChallengeContainer.__onClose = function(f11_arg0)
	f11_arg0.Title:close()
end
