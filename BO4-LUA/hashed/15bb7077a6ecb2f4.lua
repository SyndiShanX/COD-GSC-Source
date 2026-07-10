CoD.Hud_ZM_Trial_Completed = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_Trial_Completed.__defaultWidth = 1920
CoD.Hud_ZM_Trial_Completed.__defaultHeight = 300
CoD.Hud_ZM_Trial_Completed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_Trial_Completed)
	self.id = "Hud_ZM_Trial_Completed"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TrialCompletedText = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 47, 137)
	TrialCompletedText:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	TrialCompletedText:setText(LocalizeToUpperString(0x400A284ADF5EAC0))
	TrialCompletedText:setTTF("skorzhen")
	TrialCompletedText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TrialCompletedText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TrialCompletedText)
	self.TrialCompletedText = TrialCompletedText
	local DescriptionDivider = LUI.UIImage.new(0, 0, 672, 1248, 0, 0, 135, 137)
	DescriptionDivider:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	self:addElement(DescriptionDivider)
	self.DescriptionDivider = DescriptionDivider
	local CornerL = LUI.UIImage.new(0, 0, 664.5, 679.5, 0, 0, 128.5, 143.5)
	CornerL:setImage(RegisterImage(0x1EC82771A88A0E6))
	self:addElement(CornerL)
	self.CornerL = CornerL
	local CornerR = LUI.UIImage.new(0, 0, 1246, 1261, 0, 0, 128.5, 143.5)
	CornerR:setImage(RegisterImage(0x1EC82771A88A0E6))
	self:addElement(CornerR)
	self.CornerR = CornerR
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 2) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.showScoreboard", 1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["ZMHudGlobal.trials.gameState"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "ZMHudGlobal.trials.gameState",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["ZMHudGlobal.trials.showScoreboard"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ZMHudGlobal.trials.showScoreboard",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_Trial_Completed.__resetProperties = function(f5_arg0)
	f5_arg0.DescriptionDivider:completeAnimation()
	f5_arg0.TrialCompletedText:completeAnimation()
	f5_arg0.CornerL:completeAnimation()
	f5_arg0.CornerR:completeAnimation()
	f5_arg0.DescriptionDivider:setAlpha(1)
	f5_arg0.TrialCompletedText:setAlpha(1)
	f5_arg0.CornerL:setAlpha(1)
	f5_arg0.CornerR:setAlpha(1)
end
CoD.Hud_ZM_Trial_Completed.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.TrialCompletedText:completeAnimation()
			f6_arg0.TrialCompletedText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TrialCompletedText)
			f6_arg0.DescriptionDivider:completeAnimation()
			f6_arg0.DescriptionDivider:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.DescriptionDivider)
			f6_arg0.CornerL:completeAnimation()
			f6_arg0.CornerL:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CornerL)
			f6_arg0.CornerR:completeAnimation()
			f6_arg0.CornerR:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CornerR)
		end,
	},
	Show = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			local f7_local0 = function(f8_arg0)
				f7_arg0.TrialCompletedText:beginAnimation(200)
				f7_arg0.TrialCompletedText:setAlpha(1)
				f7_arg0.TrialCompletedText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.TrialCompletedText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.TrialCompletedText:completeAnimation()
			f7_arg0.TrialCompletedText:setAlpha(0)
			f7_local0(f7_arg0.TrialCompletedText)
			local f7_local1 = function(f9_arg0)
				f7_arg0.DescriptionDivider:beginAnimation(200)
				f7_arg0.DescriptionDivider:setAlpha(1)
				f7_arg0.DescriptionDivider:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.DescriptionDivider:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.DescriptionDivider:completeAnimation()
			f7_arg0.DescriptionDivider:setAlpha(0)
			f7_local1(f7_arg0.DescriptionDivider)
			local f7_local2 = function(f10_arg0)
				f7_arg0.CornerL:beginAnimation(200)
				f7_arg0.CornerL:setAlpha(1)
				f7_arg0.CornerL:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.CornerL:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.CornerL:completeAnimation()
			f7_arg0.CornerL:setAlpha(0)
			f7_local2(f7_arg0.CornerL)
			local f7_local3 = function(f11_arg0)
				f7_arg0.CornerR:beginAnimation(200)
				f7_arg0.CornerR:setAlpha(1)
				f7_arg0.CornerR:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.CornerR:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.CornerR:completeAnimation()
			f7_arg0.CornerR:setAlpha(0)
			f7_local3(f7_arg0.CornerR)
		end,
	},
}
