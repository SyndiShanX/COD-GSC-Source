require("x64:e4461faa9bc15")
CoD.Laboratory_SafeAreaContainer_Mixagain = InheritFrom(LUI.UIElement)
CoD.Laboratory_SafeAreaContainer_Mixagain.__defaultWidth = 1920
CoD.Laboratory_SafeAreaContainer_Mixagain.__defaultHeight = 1080
CoD.Laboratory_SafeAreaContainer_Mixagain.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Laboratory_SafeAreaContainer_Mixagain)
	self.id = "Laboratory_SafeAreaContainer_Mixagain"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MixAgain = CoD.LaboratoryMixAgain.new(f1_arg0, f1_arg1, 0, 0, 0, 280, 0, 1, 0, 0)
	MixAgain:setAlpha(0)
	MixAgain:linkToElementModel(self, nil, false, function(model)
		MixAgain:setModel(model, f1_arg1)
	end)
	self:addElement(MixAgain)
	self.MixAgain = MixAgain
	self:mergeStateConditions({
		{
			stateName = "AnimStateMixAgain",
			condition = function(menu, element, event)
				return CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN)
			end,
		},
		{
			stateName = "AnimStateMixAgainToNotPlaying",
			condition = function(menu, element, event)
				return CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN_TO_NOT_PLAYING)
			end,
		},
		{
			stateName = "AnimStatePlaying",
			condition = function(menu, element, event)
				return not CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["Laboratory.animState"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "Laboratory.animState",
		})
	end, false)
	MixAgain.id = "MixAgain"
	self.__defaultFocus = MixAgain
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Laboratory_SafeAreaContainer_Mixagain.__resetProperties = function(f7_arg0)
	f7_arg0.MixAgain:completeAnimation()
	f7_arg0.MixAgain:setLeftRight(0, 0, 0, 280)
	f7_arg0.MixAgain:setAlpha(0)
end
CoD.Laboratory_SafeAreaContainer_Mixagain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	AnimStateMixAgain = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.MixAgain:completeAnimation()
			f9_arg0.MixAgain:setLeftRight(0.5, 0.5, -960, -680)
			f9_arg0.MixAgain:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.MixAgain)
		end,
		AnimStatePlaying = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.MixAgain:beginAnimation(350)
				f10_arg0.MixAgain:setLeftRight(0, 0, -280, 0)
				f10_arg0.MixAgain:setAlpha(0)
				f10_arg0.MixAgain:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.MixAgain:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.MixAgain:completeAnimation()
			f10_arg0.MixAgain:setLeftRight(0.5, 0.5, -960, -680)
			f10_arg0.MixAgain:setAlpha(1)
			f10_local0(f10_arg0.MixAgain)
		end,
		AnimStateMixAgainToNotPlaying = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.MixAgain:beginAnimation(350)
				f12_arg0.MixAgain:setLeftRight(0, 0, -280, 0)
				f12_arg0.MixAgain:setAlpha(0)
				f12_arg0.MixAgain:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.MixAgain:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.MixAgain:completeAnimation()
			f12_arg0.MixAgain:setLeftRight(0.5, 0.5, -960, -680)
			f12_arg0.MixAgain:setAlpha(1)
			f12_local0(f12_arg0.MixAgain)
		end,
	},
	AnimStateMixAgainToNotPlaying = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.MixAgain:completeAnimation()
			f14_arg0.MixAgain:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.MixAgain)
		end,
	},
	AnimStatePlaying = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.MixAgain:completeAnimation()
			f15_arg0.MixAgain:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.MixAgain)
		end,
		AnimStateMixAgain = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.MixAgain:beginAnimation(350)
				f16_arg0.MixAgain:setLeftRight(0.5, 0.5, -960, -680)
				f16_arg0.MixAgain:setAlpha(1)
				f16_arg0.MixAgain:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.MixAgain:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.MixAgain:completeAnimation()
			f16_arg0.MixAgain:setLeftRight(0, 0, -280, 0)
			f16_arg0.MixAgain:setAlpha(0)
			f16_local0(f16_arg0.MixAgain)
		end,
	},
}
CoD.Laboratory_SafeAreaContainer_Mixagain.__onClose = function(f18_arg0)
	f18_arg0.MixAgain:close()
end
