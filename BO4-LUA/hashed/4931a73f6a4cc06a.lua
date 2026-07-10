require("x64:6ec1f13cff1c856")
require("x64:a2599421197984c")
require("x64:ffe7666991d2a86")
require("x64:5677da2fba4b1c9")
CoD.Hud_ZM_Trial_Objective = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_Trial_Objective.__defaultWidth = 1895
CoD.Hud_ZM_Trial_Objective.__defaultHeight = 230
CoD.Hud_ZM_Trial_Objective.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_Trial_Objective)
	self.id = "Hud_ZM_Trial_Objective"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RoundDescriptionWidget = CoD.Hud_ZM_Trial_RoundInfoText.new(f1_arg0, f1_arg1, 0, 0, 40, 640, 0, 0, 96, 157)
	self:addElement(RoundDescriptionWidget)
	self.RoundDescriptionWidget = RoundDescriptionWidget
	local ZmRnd = CoD.ZmRnd.new(f1_arg0, f1_arg1, 0, 0, -53, 283, 0, 0, -124, 176)
	ZmRnd:setScale(0.6, 0.6)
	ZmRnd:subscribeToGlobalModel(f1_arg1, "GameScore", nil, function(model)
		ZmRnd:setModel(model, f1_arg1)
	end)
	ZmRnd:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ZMHudGlobal.trials.infoHidden", function(model)
		SetElementState(self, ZmRnd, f1_arg1, "DefaultState")
		UpdateElementState(self, "ZmRnd", f1_arg1)
	end)
	self:addElement(ZmRnd)
	self.ZmRnd = ZmRnd
	local ObjectiveScratchOut = CoD.Hud_ZM_Perks_Disabled_Container.new(f1_arg0, f1_arg1, 0, 0, 15, 365, 0, 0, 59, 194)
	ObjectiveScratchOut:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.roundSuccess", 1)
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f5_local0
				if not CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden") then
					f5_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
					if f5_local0 then
						f5_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.roundSuccess", 1)
					end
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
	})
	local f1_local4 = ObjectiveScratchOut
	local ZMTitleFog = ObjectiveScratchOut.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	ZMTitleFog(f1_local4, f1_local6["ZMHudGlobal.trials.roundSuccess"], function(f6_arg0)
		f1_arg0:updateElementState(ObjectiveScratchOut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "ZMHudGlobal.trials.roundSuccess",
		})
	end, false)
	f1_local4 = ObjectiveScratchOut
	ZMTitleFog = ObjectiveScratchOut.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	ZMTitleFog(f1_local4, f1_local6["ZMHudGlobal.trials.infoHidden"], function(f7_arg0)
		f1_arg0:updateElementState(ObjectiveScratchOut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "ZMHudGlobal.trials.infoHidden",
		})
	end, false)
	self:addElement(ObjectiveScratchOut)
	self.ObjectiveScratchOut = ObjectiveScratchOut
	ZMTitleFog = CoD.ZM_Title_Fog.new(f1_arg0, f1_arg1, 0, 0, -100, 412, 0, 0, -141, 371)
	ZMTitleFog:setAlpha(0)
	ZMTitleFog:setScale(1, 0.6)
	self:addElement(ZMTitleFog)
	self.ZMTitleFog = ZMTitleFog
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden")
			end,
		},
		{
			stateName = "ShowHudDeactivatedTrial",
			condition = function(menu, element, event)
				local f9_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]) and not CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden") then
					f9_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
					if f9_local0 then
						f9_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1)
					end
				else
					f9_local0 = false
				end
				return f9_local0
			end,
		},
		{
			stateName = "RoundSuccess",
			condition = function(menu, element, event)
				local f10_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]) and not CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden") then
					f10_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
					if f10_local0 then
						f10_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.roundSuccess", 1)
					end
				else
					f10_local0 = false
				end
				return f10_local0
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f11_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]) and not CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden") then
					f11_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
				else
					f11_local0 = false
				end
				return f11_local0
			end,
		},
	})
	f1_local6 = self
	f1_local4 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local6, f1_local7["ZMHudGlobal.trials.infoHidden"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "ZMHudGlobal.trials.infoHidden",
		})
	end, false)
	f1_local6 = self
	f1_local4 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local6, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local6 = self
	f1_local4 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local6, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local6 = self
	f1_local4 = self.subscribeToModel
	f1_local7 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local6, f1_local7["ZMHudGlobal.trials.hudDeactivated"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "ZMHudGlobal.trials.hudDeactivated",
		})
	end, false)
	f1_local6 = self
	f1_local4 = self.subscribeToModel
	f1_local7 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local6, f1_local7["ZMHudGlobal.trials.roundSuccess"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "ZMHudGlobal.trials.roundSuccess",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_Trial_Objective.__resetProperties = function(f17_arg0)
	f17_arg0.RoundDescriptionWidget:completeAnimation()
	f17_arg0.ZmRnd:completeAnimation()
	f17_arg0.ObjectiveScratchOut:completeAnimation()
	f17_arg0.RoundDescriptionWidget:setAlpha(1)
	f17_arg0.ZmRnd:setAlpha(1)
	f17_arg0.ObjectiveScratchOut:setAlpha(1)
end
CoD.Hud_ZM_Trial_Objective.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.RoundDescriptionWidget:completeAnimation()
			f18_arg0.RoundDescriptionWidget:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.RoundDescriptionWidget)
			f18_arg0.ZmRnd:completeAnimation()
			f18_arg0.ZmRnd:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ZmRnd)
			f18_arg0.ObjectiveScratchOut:completeAnimation()
			f18_arg0.ObjectiveScratchOut:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ObjectiveScratchOut)
		end,
	},
	Hidden = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.RoundDescriptionWidget:completeAnimation()
			f19_arg0.RoundDescriptionWidget:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.RoundDescriptionWidget)
			f19_arg0.ZmRnd:completeAnimation()
			f19_arg0.ZmRnd:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ZmRnd)
			f19_arg0.ObjectiveScratchOut:completeAnimation()
			f19_arg0.ObjectiveScratchOut:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ObjectiveScratchOut)
		end,
		Show = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(1300)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.RoundDescriptionWidget:beginAnimation(650)
				f20_arg0.RoundDescriptionWidget:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.RoundDescriptionWidget:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.RoundDescriptionWidget:completeAnimation()
			f20_arg0.RoundDescriptionWidget:setAlpha(0)
			f20_local0(f20_arg0.RoundDescriptionWidget)
			local f20_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(1300)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.ZmRnd:beginAnimation(650)
				f20_arg0.ZmRnd:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ZmRnd:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f20_arg0.ZmRnd:completeAnimation()
			f20_arg0.ZmRnd:setAlpha(0)
			f20_local1(f20_arg0.ZmRnd)
		end,
	},
	ShowHudDeactivatedTrial = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.RoundDescriptionWidget:completeAnimation()
			f25_arg0.RoundDescriptionWidget:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RoundDescriptionWidget)
			f25_arg0.ZmRnd:completeAnimation()
			f25_arg0.ZmRnd:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ZmRnd)
			f25_arg0.ObjectiveScratchOut:completeAnimation()
			f25_arg0.ObjectiveScratchOut:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ObjectiveScratchOut)
		end,
	},
	RoundSuccess = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.RoundDescriptionWidget:completeAnimation()
			f26_arg0.RoundDescriptionWidget:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.RoundDescriptionWidget)
			f26_arg0.ZmRnd:completeAnimation()
			f26_arg0.ZmRnd:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ZmRnd)
			f26_arg0.ObjectiveScratchOut:completeAnimation()
			f26_arg0.ObjectiveScratchOut:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ObjectiveScratchOut)
		end,
	},
	Show = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.RoundDescriptionWidget:completeAnimation()
			f27_arg0.RoundDescriptionWidget:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.RoundDescriptionWidget)
			f27_arg0.ZmRnd:completeAnimation()
			f27_arg0.ZmRnd:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.ZmRnd)
			f27_arg0.ObjectiveScratchOut:completeAnimation()
			f27_arg0.ObjectiveScratchOut:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ObjectiveScratchOut)
		end,
		RoundSuccess = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(1000)
					f30_arg0:setAlpha(0)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.RoundDescriptionWidget:beginAnimation(2000)
				f28_arg0.RoundDescriptionWidget:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.RoundDescriptionWidget:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.RoundDescriptionWidget:completeAnimation()
			f28_arg0.RoundDescriptionWidget:setAlpha(1)
			f28_local0(f28_arg0.RoundDescriptionWidget)
			local f28_local1 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(1000)
					f32_arg0:setAlpha(0)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.ZmRnd:beginAnimation(2000)
				f28_arg0.ZmRnd:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ZmRnd:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f28_arg0.ZmRnd:completeAnimation()
			f28_arg0.ZmRnd:setAlpha(1)
			f28_local1(f28_arg0.ZmRnd)
			local f28_local2 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(1000)
					f34_arg0:setAlpha(0)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.ObjectiveScratchOut:beginAnimation(2000)
				f28_arg0.ObjectiveScratchOut:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ObjectiveScratchOut:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f28_arg0.ObjectiveScratchOut:completeAnimation()
			f28_arg0.ObjectiveScratchOut:setAlpha(1)
			f28_local2(f28_arg0.ObjectiveScratchOut)
		end,
	},
}
CoD.Hud_ZM_Trial_Objective.__onClose = function(f35_arg0)
	f35_arg0.RoundDescriptionWidget:close()
	f35_arg0.ZmRnd:close()
	f35_arg0.ObjectiveScratchOut:close()
	f35_arg0.ZMTitleFog:close()
end
