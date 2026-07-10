require("x64:3317d177bae2759")
require("x64:9e7be51d884ab71")
require("x64:59770670213dba2")
require("x64:83184da3fe634f1")
CoD.PrematchCountdownMinimize = InheritFrom(LUI.UIElement)
CoD.PrematchCountdownMinimize.__defaultWidth = 1920
CoD.PrematchCountdownMinimize.__defaultHeight = 1080
CoD.PrematchCountdownMinimize.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdownMinimize)
	self.id = "PrematchCountdownMinimize"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PrematchCountdownNumbers = CoD.PrematchCountdown_Numbers.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -45, 30)
	PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xF84718EE93F3A4D))
	self.__on_menuOpened_PrematchCountdownNumbers = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = PrematchCountdownNumbers
		PlayClipOnElement(self, {
			elementName = "PrematchCountdownNumbers",
			clipName = "Start",
		}, f2_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_PrematchCountdownNumbers)
	self:addElement(PrematchCountdownNumbers)
	self.PrematchCountdownNumbers = PrematchCountdownNumbers
	local PrematchCountdownNumbersSmall = CoD.PrematchCountdown_NumbersSmall.new(f1_arg0, f1_arg1, 0, 0, -7, 296, 0, 0, 341, 401)
	PrematchCountdownNumbersSmall:setAlpha(0)
	PrematchCountdownNumbersSmall.Message:setText(Engine[0xF9F1239CFD921FE](0xF84718EE93F3A4D))
	self:addElement(PrematchCountdownNumbersSmall)
	self.PrematchCountdownNumbersSmall = PrematchCountdownNumbersSmall
	local GameTypeHintText = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -280, 276, 0, 0, 305, 353)
	GameTypeHintText:setAlpha(0)
	GameTypeHintText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x7E04861C952E4AB))
	GameTypeHintText.MatchText:setBackingAlpha(0.7)
	self:addElement(GameTypeHintText)
	self.GameTypeHintText = GameTypeHintText
	local DoubleXPNotification = CoD.PrematchCountdown_2xpNotification.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0, 0, 0, 255)
	DoubleXPNotification:setAlpha(0)
	self:addElement(DoubleXPNotification)
	self.DoubleXPNotification = DoubleXPNotification
	self:mergeStateConditions({
		{
			stateName = "WarzoneHardcore",
			condition = function(menu, element, event)
				return IsGametypeSettingsValue("wzHardcore", 1)
			end,
		},
		{
			stateName = "PandemicTimerInfected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.prematchTimerUsePandemicLabel") and CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.playerOnInfectedPlatoon", 0)
			end,
		},
		{
			stateName = "PandemicTimer",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.prematchTimerUsePandemicLabel")
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.prematchTimerUsePandemicLabel"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.prematchTimerUsePandemicLabel",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.playerOnInfectedPlatoon"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.playerOnInfectedPlatoon",
		})
	end, false)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_PrematchCountdownNumbers)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.HUDUtility.PrematchCountdownMinimizePostLoad(self, f1_arg1)
	return self
end
CoD.PrematchCountdownMinimize.__resetProperties = function(f9_arg0)
	f9_arg0.PrematchCountdownNumbersSmall:completeAnimation()
	f9_arg0.PrematchCountdownNumbers:completeAnimation()
	f9_arg0.GameTypeHintText:completeAnimation()
	f9_arg0.DoubleXPNotification:completeAnimation()
	f9_arg0.PrematchCountdownNumbersSmall:setTopBottom(0, 0, 341, 401)
	f9_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
	f9_arg0.PrematchCountdownNumbersSmall.Message:setText(Engine[0xF9F1239CFD921FE](0xF84718EE93F3A4D))
	f9_arg0.PrematchCountdownNumbers:setLeftRight(0, 1, 0, 0)
	f9_arg0.PrematchCountdownNumbers:setTopBottom(0.5, 0.5, -45, 30)
	f9_arg0.PrematchCountdownNumbers:setAlpha(1)
	f9_arg0.PrematchCountdownNumbers:setScale(1, 1)
	f9_arg0.PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xF84718EE93F3A4D))
	f9_arg0.GameTypeHintText:setAlpha(0)
	f9_arg0.DoubleXPNotification:setAlpha(0)
end
CoD.PrematchCountdownMinimize.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		Minimize = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(230)
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(80)
					f13_arg0:setAlpha(0.8)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f11_arg0.PrematchCountdownNumbers:beginAnimation(90)
				f11_arg0.PrematchCountdownNumbers:setAlpha(0.5)
				f11_arg0.PrematchCountdownNumbers:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.PrematchCountdownNumbers:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.PrematchCountdownNumbers:completeAnimation()
			f11_arg0.PrematchCountdownNumbers:setLeftRight(0, 1, 0, 0)
			f11_arg0.PrematchCountdownNumbers:setTopBottom(0.5, 0.5, -45, 30)
			f11_arg0.PrematchCountdownNumbers:setAlpha(1)
			f11_arg0.PrematchCountdownNumbers:setScale(1, 1)
			f11_local0(f11_arg0.PrematchCountdownNumbers)
			local f11_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						local f17_local0 = function(f18_arg0)
							f18_arg0:beginAnimation(69)
							f18_arg0:setAlpha(1)
							f18_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
						end
						f17_arg0:beginAnimation(60)
						f17_arg0:setAlpha(0.1)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
					end
					f16_arg0:beginAnimation(69)
					f16_arg0:setAlpha(0.5)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f11_arg0.PrematchCountdownNumbersSmall:beginAnimation(630)
				f11_arg0.PrematchCountdownNumbersSmall:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.PrematchCountdownNumbersSmall:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f11_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f11_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
			f11_local1(f11_arg0.PrematchCountdownNumbersSmall)
		end,
		Stop = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.PrematchCountdownNumbers:completeAnimation()
			f19_arg0.PrematchCountdownNumbers:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.PrematchCountdownNumbers)
			f19_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f19_arg0.PrematchCountdownNumbersSmall:setAlpha(0.99)
			f19_arg0.clipFinished(f19_arg0.PrematchCountdownNumbersSmall)
		end,
		ShowObjectiveHint = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.PrematchCountdownNumbers:completeAnimation()
			f20_arg0.PrematchCountdownNumbers:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PrematchCountdownNumbers)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						f23_arg0:beginAnimation(1000)
						f23_arg0:setAlpha(0)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
					end
					f22_arg0:beginAnimation(3000)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f20_arg0.GameTypeHintText:beginAnimation(1000)
				f20_arg0.GameTypeHintText:setAlpha(1)
				f20_arg0.GameTypeHintText:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.GameTypeHintText:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.GameTypeHintText:completeAnimation()
			f20_arg0.GameTypeHintText:setAlpha(0)
			f20_local0(f20_arg0.GameTypeHintText)
			local f20_local1 = function(f24_arg0)
				f20_arg0.DoubleXPNotification:beginAnimation(2000)
				f20_arg0.DoubleXPNotification:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.DoubleXPNotification:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("Notify")
					f20_arg0.clipFinished(element, event)
				end)
			end
			f20_arg0.DoubleXPNotification:completeAnimation()
			f20_arg0.DoubleXPNotification:setAlpha(1)
			f20_local1(f20_arg0.DoubleXPNotification)
		end,
	},
	WarzoneHardcore = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
		Minimize = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					local f29_local0 = function(f30_arg0)
						f30_arg0:beginAnimation(230)
						f30_arg0:setAlpha(0)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
					end
					f29_arg0:beginAnimation(80)
					f29_arg0:setAlpha(0.8)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f27_arg0.PrematchCountdownNumbers:beginAnimation(90)
				f27_arg0.PrematchCountdownNumbers:setAlpha(0.5)
				f27_arg0.PrematchCountdownNumbers:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.PrematchCountdownNumbers:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f27_arg0.PrematchCountdownNumbers:completeAnimation()
			f27_arg0.PrematchCountdownNumbers:setLeftRight(0, 1, 0, 0)
			f27_arg0.PrematchCountdownNumbers:setTopBottom(0.5, 0.5, -45, 30)
			f27_arg0.PrematchCountdownNumbers:setAlpha(1)
			f27_arg0.PrematchCountdownNumbers:setScale(1, 1)
			f27_local0(f27_arg0.PrematchCountdownNumbers)
			local f27_local1 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						local f33_local0 = function(f34_arg0)
							f34_arg0:beginAnimation(69)
							f34_arg0:setAlpha(1)
							f34_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
						end
						f33_arg0:beginAnimation(60)
						f33_arg0:setAlpha(0.1)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
					end
					f32_arg0:beginAnimation(69)
					f32_arg0:setAlpha(0.5)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f27_arg0.PrematchCountdownNumbersSmall:beginAnimation(630)
				f27_arg0.PrematchCountdownNumbersSmall:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.PrematchCountdownNumbersSmall:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f27_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f27_arg0.PrematchCountdownNumbersSmall:setTopBottom(0, 0, 35, 95)
			f27_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
			f27_local1(f27_arg0.PrematchCountdownNumbersSmall)
		end,
		Stop = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.PrematchCountdownNumbers:completeAnimation()
			f35_arg0.PrematchCountdownNumbers:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.PrematchCountdownNumbers)
			f35_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f35_arg0.PrematchCountdownNumbersSmall:setTopBottom(0, 0, 35, 95)
			f35_arg0.PrematchCountdownNumbersSmall:setAlpha(0.99)
			f35_arg0.clipFinished(f35_arg0.PrematchCountdownNumbersSmall)
		end,
		ShowObjectiveHint = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(3)
			f36_arg0.PrematchCountdownNumbers:completeAnimation()
			f36_arg0.PrematchCountdownNumbers:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.PrematchCountdownNumbers)
			local f36_local0 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					local f38_local0 = function(f39_arg0)
						f39_arg0:beginAnimation(1000)
						f39_arg0:setAlpha(0)
						f39_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
					end
					f38_arg0:beginAnimation(3000)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
				end
				f36_arg0.GameTypeHintText:beginAnimation(1000)
				f36_arg0.GameTypeHintText:setAlpha(1)
				f36_arg0.GameTypeHintText:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.GameTypeHintText:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f36_arg0.GameTypeHintText:completeAnimation()
			f36_arg0.GameTypeHintText:setAlpha(0)
			f36_local0(f36_arg0.GameTypeHintText)
			local f36_local1 = function(f40_arg0)
				f36_arg0.DoubleXPNotification:beginAnimation(2000)
				f36_arg0.DoubleXPNotification:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.DoubleXPNotification:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("Notify")
					f36_arg0.clipFinished(element, event)
				end)
			end
			f36_arg0.DoubleXPNotification:completeAnimation()
			f36_arg0.DoubleXPNotification:setAlpha(1)
			f36_local1(f36_arg0.DoubleXPNotification)
		end,
	},
	PandemicTimerInfected = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.PrematchCountdownNumbers:completeAnimation()
			f42_arg0.PrematchCountdownNumbers.MatchText.MatchText:completeAnimation()
			f42_arg0.PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x9EDAE9F64B1A109))
			f42_arg0.clipFinished(f42_arg0.PrematchCountdownNumbers)
			f42_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f42_arg0.PrematchCountdownNumbersSmall.Message:completeAnimation()
			f42_arg0.PrematchCountdownNumbersSmall.Message:setText(Engine[0xF9F1239CFD921FE](0x9EDAE9F64B1A109))
			f42_arg0.clipFinished(f42_arg0.PrematchCountdownNumbersSmall)
		end,
		Minimize = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(2)
			local f43_local0 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						f46_arg0:beginAnimation(230)
						f46_arg0:setAlpha(0)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
					end
					f45_arg0:beginAnimation(80)
					f45_arg0:setAlpha(0.8)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f43_arg0.PrematchCountdownNumbers:beginAnimation(90)
				f43_arg0.PrematchCountdownNumbers:setAlpha(0.5)
				f43_arg0.PrematchCountdownNumbers:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.PrematchCountdownNumbers:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f43_arg0.PrematchCountdownNumbers:completeAnimation()
			f43_arg0.PrematchCountdownNumbers.MatchText.MatchText:completeAnimation()
			f43_arg0.PrematchCountdownNumbers:setLeftRight(0, 1, 0, 0)
			f43_arg0.PrematchCountdownNumbers:setTopBottom(0.5, 0.5, -45, 30)
			f43_arg0.PrematchCountdownNumbers:setAlpha(1)
			f43_arg0.PrematchCountdownNumbers:setScale(1, 1)
			f43_arg0.PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x9EDAE9F64B1A109))
			f43_local0(f43_arg0.PrematchCountdownNumbers)
			local f43_local1 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					local f48_local0 = function(f49_arg0)
						local f49_local0 = function(f50_arg0)
							f50_arg0:beginAnimation(69)
							f50_arg0:setAlpha(1)
							f50_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
						end
						f49_arg0:beginAnimation(60)
						f49_arg0:setAlpha(0.1)
						f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
					end
					f48_arg0:beginAnimation(69)
					f48_arg0:setAlpha(0.5)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
				end
				f43_arg0.PrematchCountdownNumbersSmall:beginAnimation(630)
				f43_arg0.PrematchCountdownNumbersSmall:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.PrematchCountdownNumbersSmall:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f43_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f43_arg0.PrematchCountdownNumbersSmall.Message:completeAnimation()
			f43_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
			f43_arg0.PrematchCountdownNumbersSmall.Message:setText(Engine[0xF9F1239CFD921FE](0x9EDAE9F64B1A109))
			f43_local1(f43_arg0.PrematchCountdownNumbersSmall)
		end,
		Stop = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(2)
			f51_arg0.PrematchCountdownNumbers:completeAnimation()
			f51_arg0.PrematchCountdownNumbers.MatchText.MatchText:completeAnimation()
			f51_arg0.PrematchCountdownNumbers:setAlpha(0)
			f51_arg0.PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x9EDAE9F64B1A109))
			f51_arg0.clipFinished(f51_arg0.PrematchCountdownNumbers)
			f51_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f51_arg0.PrematchCountdownNumbersSmall.Message:completeAnimation()
			f51_arg0.PrematchCountdownNumbersSmall:setAlpha(0.99)
			f51_arg0.PrematchCountdownNumbersSmall.Message:setText(Engine[0xF9F1239CFD921FE](0x9EDAE9F64B1A109))
			f51_arg0.clipFinished(f51_arg0.PrematchCountdownNumbersSmall)
		end,
	},
	PandemicTimer = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(2)
			f52_arg0.PrematchCountdownNumbers:completeAnimation()
			f52_arg0.PrematchCountdownNumbers.MatchText.MatchText:completeAnimation()
			f52_arg0.PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x40690424A5FFFE8))
			f52_arg0.clipFinished(f52_arg0.PrematchCountdownNumbers)
			f52_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f52_arg0.PrematchCountdownNumbersSmall.Message:completeAnimation()
			f52_arg0.PrematchCountdownNumbersSmall.Message:setText(Engine[0xF9F1239CFD921FE](0x40690424A5FFFE8))
			f52_arg0.clipFinished(f52_arg0.PrematchCountdownNumbersSmall)
		end,
		Minimize = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(2)
			local f53_local0 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					local f55_local0 = function(f56_arg0)
						f56_arg0:beginAnimation(230)
						f56_arg0:setAlpha(0)
						f56_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
					end
					f55_arg0:beginAnimation(80)
					f55_arg0:setAlpha(0.8)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
				end
				f53_arg0.PrematchCountdownNumbers:beginAnimation(90)
				f53_arg0.PrematchCountdownNumbers:setAlpha(0.5)
				f53_arg0.PrematchCountdownNumbers:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.PrematchCountdownNumbers:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f53_arg0.PrematchCountdownNumbers:completeAnimation()
			f53_arg0.PrematchCountdownNumbers.MatchText.MatchText:completeAnimation()
			f53_arg0.PrematchCountdownNumbers:setLeftRight(0, 1, 0, 0)
			f53_arg0.PrematchCountdownNumbers:setTopBottom(0.5, 0.5, -45, 30)
			f53_arg0.PrematchCountdownNumbers:setAlpha(1)
			f53_arg0.PrematchCountdownNumbers:setScale(1, 1)
			f53_arg0.PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x40690424A5FFFE8))
			f53_local0(f53_arg0.PrematchCountdownNumbers)
			local f53_local1 = function(f57_arg0)
				local f57_local0 = function(f58_arg0)
					local f58_local0 = function(f59_arg0)
						local f59_local0 = function(f60_arg0)
							f60_arg0:beginAnimation(69)
							f60_arg0:setAlpha(1)
							f60_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
						end
						f59_arg0:beginAnimation(60)
						f59_arg0:setAlpha(0.1)
						f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
					end
					f58_arg0:beginAnimation(69)
					f58_arg0:setAlpha(0.5)
					f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
				end
				f53_arg0.PrematchCountdownNumbersSmall:beginAnimation(630)
				f53_arg0.PrematchCountdownNumbersSmall:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.PrematchCountdownNumbersSmall:registerEventHandler("transition_complete_keyframe", f57_local0)
			end
			f53_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f53_arg0.PrematchCountdownNumbersSmall.Message:completeAnimation()
			f53_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
			f53_arg0.PrematchCountdownNumbersSmall.Message:setText(Engine[0xF9F1239CFD921FE](0x40690424A5FFFE8))
			f53_local1(f53_arg0.PrematchCountdownNumbersSmall)
		end,
		Stop = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(2)
			f61_arg0.PrematchCountdownNumbers:completeAnimation()
			f61_arg0.PrematchCountdownNumbers.MatchText.MatchText:completeAnimation()
			f61_arg0.PrematchCountdownNumbers:setAlpha(0)
			f61_arg0.PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x40690424A5FFFE8))
			f61_arg0.clipFinished(f61_arg0.PrematchCountdownNumbers)
			f61_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f61_arg0.PrematchCountdownNumbersSmall.Message:completeAnimation()
			f61_arg0.PrematchCountdownNumbersSmall:setAlpha(0.99)
			f61_arg0.PrematchCountdownNumbersSmall.Message:setText(Engine[0xF9F1239CFD921FE](0x40690424A5FFFE8))
			f61_arg0.clipFinished(f61_arg0.PrematchCountdownNumbersSmall)
		end,
	},
}
CoD.PrematchCountdownMinimize.__onClose = function(f62_arg0)
	f62_arg0.__on_close_removeOverrides()
	f62_arg0.PrematchCountdownNumbers:close()
	f62_arg0.PrematchCountdownNumbersSmall:close()
	f62_arg0.GameTypeHintText:close()
	f62_arg0.DoubleXPNotification:close()
end
