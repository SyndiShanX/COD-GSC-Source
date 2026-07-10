require("x64:8c66c9b1178245f")
require("x64:da90e0b8527aec8")
require("x64:472f3d8b96b551a")
require("x64:b40a50c0581f80a")
require("x64:2a518d2492c1197")
require("x64:e52957b45821d12")
CoD.Hud_ZM_TrialsContainer = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_TrialsContainer.__defaultWidth = 1920
CoD.Hud_ZM_TrialsContainer.__defaultHeight = 1080
CoD.Hud_ZM_TrialsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_TrialsContainer)
	self.id = "Hud_ZM_TrialsContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HudZMTrialCompleted = CoD.Hud_ZM_Trial_Completed.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -284, 16)
	self:addElement(HudZMTrialCompleted)
	self.HudZMTrialCompleted = HudZMTrialCompleted
	local TrialRoundFailed = CoD.HUD_ZM_Trial_Round_Failed.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -360, -60)
	self:addElement(TrialRoundFailed)
	self.TrialRoundFailed = TrialRoundFailed
	local TrialStrikes = CoD.Hud_ZM_Trial_Strikes.new(f1_arg0, f1_arg1, 1, 1, -267.5, -43.5, 0, 0, 83, 163)
	self:addElement(TrialStrikes)
	self.TrialStrikes = TrialStrikes
	local HudZMTrialMedal = CoD.Hud_ZM_Trial_Medal.new(f1_arg0, f1_arg1, 0.5, 0.5, -384, 384, 0.5, 0.5, -134, 134)
	self:addElement(HudZMTrialMedal)
	self.HudZMTrialMedal = HudZMTrialMedal
	local HudZMTrialObjective = CoD.Hud_ZM_Trial_Objective.new(f1_arg0, f1_arg1, 0, 0, 0, 1895, 0, 0, 73, 303)
	self:addElement(HudZMTrialObjective)
	self.HudZMTrialObjective = HudZMTrialObjective
	local HudZMTimer = CoD.Hud_ZM_Timer.new(f1_arg0, f1_arg1, 1, 1, -255.5, -55.5, 0, 0, 33, 75)
	HudZMTimer:setRGB(0.96, 0.66, 0)
	self:addElement(HudZMTimer)
	self.HudZMTimer = HudZMTimer
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				local f2_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
					if f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						if not f2_local0 then
							f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
							if not f2_local0 then
								f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
								if not f2_local0 then
									f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
									if not f2_local0 then
										f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
										if not f2_local0 then
											f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
										end
									end
								end
							end
						end
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Trials_HUDDeactivated",
			condition = function(menu, element, event)
				local f3_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1)
					if f3_local0 then
						f3_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden")
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.playerSpawned"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["ZMHudGlobal.trials.hudDeactivated"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "ZMHudGlobal.trials.hudDeactivated",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["ZMHudGlobal.trials.infoHidden"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "ZMHudGlobal.trials.infoHidden",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_TrialsContainer.__resetProperties = function(f13_arg0)
	f13_arg0.TrialStrikes:completeAnimation()
	f13_arg0.HudZMTimer:completeAnimation()
	f13_arg0.HudZMTrialObjective:completeAnimation()
	f13_arg0.TrialStrikes:setAlpha(1)
	f13_arg0.HudZMTimer:setAlpha(1)
	f13_arg0.HudZMTrialObjective:setAlpha(1)
end
CoD.Hud_ZM_TrialsContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		Trials_HUDDeactivated = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.TrialStrikes:beginAnimation(3000)
				f15_arg0.TrialStrikes:setAlpha(0)
				f15_arg0.TrialStrikes:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.TrialStrikes:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.TrialStrikes:completeAnimation()
			f15_arg0.TrialStrikes:setAlpha(1)
			f15_local0(f15_arg0.TrialStrikes)
			local f15_local1 = function(f17_arg0)
				f15_arg0.HudZMTimer:beginAnimation(3000)
				f15_arg0.HudZMTimer:setAlpha(0)
				f15_arg0.HudZMTimer:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.HudZMTimer:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.HudZMTimer:completeAnimation()
			f15_arg0.HudZMTimer:setAlpha(1)
			f15_local1(f15_arg0.HudZMTimer)
		end,
	},
	Invisible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.TrialStrikes:completeAnimation()
			f18_arg0.TrialStrikes:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.TrialStrikes)
			f18_arg0.HudZMTrialObjective:completeAnimation()
			f18_arg0.HudZMTrialObjective:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.HudZMTrialObjective)
			f18_arg0.HudZMTimer:completeAnimation()
			f18_arg0.HudZMTimer:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.HudZMTimer)
		end,
		DefaultState = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			local f19_local0 = function(f20_arg0)
				f19_arg0.TrialStrikes:beginAnimation(200)
				f19_arg0.TrialStrikes:setAlpha(1)
				f19_arg0.TrialStrikes:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.TrialStrikes:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.TrialStrikes:completeAnimation()
			f19_arg0.TrialStrikes:setAlpha(0)
			f19_local0(f19_arg0.TrialStrikes)
			local f19_local1 = function(f21_arg0)
				f19_arg0.HudZMTrialObjective:beginAnimation(200)
				f19_arg0.HudZMTrialObjective:setAlpha(1)
				f19_arg0.HudZMTrialObjective:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.HudZMTrialObjective:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.HudZMTrialObjective:completeAnimation()
			f19_arg0.HudZMTrialObjective:setAlpha(0)
			f19_local1(f19_arg0.HudZMTrialObjective)
			local f19_local2 = function(f22_arg0)
				f19_arg0.HudZMTimer:beginAnimation(200)
				f19_arg0.HudZMTimer:setAlpha(1)
				f19_arg0.HudZMTimer:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.HudZMTimer:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.HudZMTimer:completeAnimation()
			f19_arg0.HudZMTimer:setAlpha(0)
			f19_local2(f19_arg0.HudZMTimer)
		end,
	},
	Trials_HUDDeactivated = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.TrialStrikes:completeAnimation()
			f23_arg0.TrialStrikes:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.TrialStrikes)
			f23_arg0.HudZMTimer:completeAnimation()
			f23_arg0.HudZMTimer:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.HudZMTimer)
		end,
		DefaultState = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.TrialStrikes:beginAnimation(1000)
				f24_arg0.TrialStrikes:setAlpha(1)
				f24_arg0.TrialStrikes:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.TrialStrikes:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.TrialStrikes:completeAnimation()
			f24_arg0.TrialStrikes:setAlpha(0)
			f24_local0(f24_arg0.TrialStrikes)
			local f24_local1 = function(f26_arg0)
				f24_arg0.HudZMTimer:beginAnimation(1000)
				f24_arg0.HudZMTimer:setAlpha(1)
				f24_arg0.HudZMTimer:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.HudZMTimer:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.HudZMTimer:completeAnimation()
			f24_arg0.HudZMTimer:setAlpha(0)
			f24_local1(f24_arg0.HudZMTimer)
		end,
	},
}
CoD.Hud_ZM_TrialsContainer.__onClose = function(f27_arg0)
	f27_arg0.HudZMTrialCompleted:close()
	f27_arg0.TrialRoundFailed:close()
	f27_arg0.TrialStrikes:close()
	f27_arg0.HudZMTrialMedal:close()
	f27_arg0.HudZMTrialObjective:close()
	f27_arg0.HudZMTimer:close()
end
