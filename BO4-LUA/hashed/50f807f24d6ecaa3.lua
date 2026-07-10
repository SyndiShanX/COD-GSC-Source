require("x64:3317d177bae2759")
require("x64:9e7be51d884ab71")
require("x64:59770670213dba2")
require("x64:83184da3fe634f1")
CoD.HoldingPenNotification = InheritFrom(LUI.UIElement)
CoD.HoldingPenNotification.__defaultWidth = 1920
CoD.HoldingPenNotification.__defaultHeight = 1080
CoD.HoldingPenNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HoldingPenNotification)
	self.id = "HoldingPenNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PrematchCountdownNumbers = CoD.PrematchCountdown_Numbers.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -45, 30)
	PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_41842D668F2BC505"))
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
	PrematchCountdownNumbersSmall.Message:setAlpha(0)
	PrematchCountdownNumbersSmall.Message:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_51D0DA5DFB8F016F"))
	self:addElement(PrematchCountdownNumbersSmall)
	self.PrematchCountdownNumbersSmall = PrematchCountdownNumbersSmall
	local GameTypeHintText = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -280, 276, 0, 0, 305, 353)
	GameTypeHintText:setAlpha(0)
	GameTypeHintText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_17E04861C952E4AB"))
	GameTypeHintText.MatchText:setBackingAlpha(0.7)
	self:addElement(GameTypeHintText)
	self.GameTypeHintText = GameTypeHintText
	local Message = LUI.UIText.new(0, 0, 7, 282, 0, 0, 354, 390)
	Message:setRGB(0, 0.56, 1)
	Message:setAlpha(0)
	Message:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_51D0DA5DFB8F016F"))
	Message:setTTF("ttmussels_regular")
	Message:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Message:setShaderVector(0, 1.02, 0, 0, 0)
	Message:setShaderVector(1, -0.23, 0, 0, 0)
	Message:setShaderVector(2, 0, 0, 1, 1)
	Message:setLetterSpacing(2)
	Message:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	Message:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"]))
	self:addElement(Message)
	self.Message = Message
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
			stateName = "HiddenPC",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsPcInventoryOpen(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.isOpen, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "isOpen",
		})
	end, false)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_PrematchCountdownNumbers)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.HUDUtility.HoldingPenNotificationPostLoad(self, f1_arg1)
	PlayClip(self, "GameStart", f1_arg1)
	return self
end
CoD.HoldingPenNotification.__resetProperties = function(f9_arg0)
	f9_arg0.GameTypeHintText:completeAnimation()
	f9_arg0.PrematchCountdownNumbers:completeAnimation()
	f9_arg0.PrematchCountdownNumbersSmall:completeAnimation()
	f9_arg0.Message:completeAnimation()
	f9_arg0.DoubleXPNotification:completeAnimation()
	f9_arg0.GameTypeHintText:setAlpha(0)
	f9_arg0.PrematchCountdownNumbers:setLeftRight(0, 1, 0, 0)
	f9_arg0.PrematchCountdownNumbers:setTopBottom(0.5, 0.5, -45, 30)
	f9_arg0.PrematchCountdownNumbers:setAlpha(1)
	f9_arg0.PrematchCountdownNumbers:setScale(1, 1)
	f9_arg0.PrematchCountdownNumbersSmall:setTopBottom(0, 0, 341, 401)
	f9_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
	f9_arg0.Message:setTopBottom(0, 0, 354, 390)
	f9_arg0.Message:setAlpha(0)
	f9_arg0.DoubleXPNotification:setAlpha(0)
end
CoD.HoldingPenNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.PrematchCountdownNumbers:completeAnimation()
			f10_arg0.PrematchCountdownNumbers:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PrematchCountdownNumbers)
			f10_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f10_arg0.PrematchCountdownNumbersSmall:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.PrematchCountdownNumbersSmall)
			f10_arg0.GameTypeHintText:completeAnimation()
			f10_arg0.GameTypeHintText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.GameTypeHintText)
			f10_arg0.Message:completeAnimation()
			f10_arg0.Message:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Message)
		end,
		Minimize = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
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
			local f11_local2 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(199)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.Message:beginAnimation(630)
				f11_arg0.Message:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Message:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f11_arg0.Message:completeAnimation()
			f11_arg0.Message:setAlpha(0)
			f11_local2(f11_arg0.Message)
		end,
		Stop = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.PrematchCountdownNumbers:completeAnimation()
			f21_arg0.PrematchCountdownNumbers:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PrematchCountdownNumbers)
			f21_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f21_arg0.PrematchCountdownNumbersSmall:setAlpha(0.99)
			f21_arg0.clipFinished(f21_arg0.PrematchCountdownNumbersSmall)
			f21_arg0.Message:completeAnimation()
			f21_arg0.Message:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Message)
		end,
		ShowObjectiveHint = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.PrematchCountdownNumbers:completeAnimation()
			f22_arg0.PrematchCountdownNumbers:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.PrematchCountdownNumbers)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						f25_arg0:beginAnimation(1000)
						f25_arg0:setAlpha(0)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
					end
					f24_arg0:beginAnimation(3000)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f22_arg0.GameTypeHintText:beginAnimation(1000)
				f22_arg0.GameTypeHintText:setAlpha(1)
				f22_arg0.GameTypeHintText:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.GameTypeHintText:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.GameTypeHintText:completeAnimation()
			f22_arg0.GameTypeHintText:setAlpha(0)
			f22_local0(f22_arg0.GameTypeHintText)
			local f22_local1 = function(f26_arg0)
				f22_arg0.DoubleXPNotification:beginAnimation(2000)
				f22_arg0.DoubleXPNotification:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.DoubleXPNotification:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("Notify")
					f22_arg0.clipFinished(element, event)
				end)
			end
			f22_arg0.DoubleXPNotification:completeAnimation()
			f22_arg0.DoubleXPNotification:setAlpha(1)
			f22_local1(f22_arg0.DoubleXPNotification)
		end,
		GameStart = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			f28_arg0.PrematchCountdownNumbers:completeAnimation()
			f28_arg0.PrematchCountdownNumbers:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.PrematchCountdownNumbers)
			f28_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f28_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.PrematchCountdownNumbersSmall)
			f28_arg0.GameTypeHintText:completeAnimation()
			f28_arg0.GameTypeHintText:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.GameTypeHintText)
		end,
	},
	WarzoneHardcore = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(4)
			f29_arg0.PrematchCountdownNumbers:completeAnimation()
			f29_arg0.PrematchCountdownNumbers:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.PrematchCountdownNumbers)
			f29_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f29_arg0.PrematchCountdownNumbersSmall:setTopBottom(0, 0, 35, 95)
			f29_arg0.PrematchCountdownNumbersSmall:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.PrematchCountdownNumbersSmall)
			f29_arg0.GameTypeHintText:completeAnimation()
			f29_arg0.GameTypeHintText:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.GameTypeHintText)
			f29_arg0.Message:completeAnimation()
			f29_arg0.Message:setTopBottom(0, 0, 47, 83)
			f29_arg0.Message:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.Message)
		end,
		Minimize = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						f33_arg0:beginAnimation(230)
						f33_arg0:setAlpha(0)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
					end
					f32_arg0:beginAnimation(80)
					f32_arg0:setAlpha(0.8)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f30_arg0.PrematchCountdownNumbers:beginAnimation(90)
				f30_arg0.PrematchCountdownNumbers:setAlpha(0.5)
				f30_arg0.PrematchCountdownNumbers:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.PrematchCountdownNumbers:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.PrematchCountdownNumbers:completeAnimation()
			f30_arg0.PrematchCountdownNumbers:setLeftRight(0, 1, 0, 0)
			f30_arg0.PrematchCountdownNumbers:setTopBottom(0.5, 0.5, -45, 30)
			f30_arg0.PrematchCountdownNumbers:setAlpha(1)
			f30_arg0.PrematchCountdownNumbers:setScale(1, 1)
			f30_local0(f30_arg0.PrematchCountdownNumbers)
			local f30_local1 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						local f36_local0 = function(f37_arg0)
							f37_arg0:beginAnimation(69)
							f37_arg0:setAlpha(1)
							f37_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
						end
						f36_arg0:beginAnimation(60)
						f36_arg0:setAlpha(0.1)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
					end
					f35_arg0:beginAnimation(69)
					f35_arg0:setAlpha(0.5)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f30_arg0.PrematchCountdownNumbersSmall:beginAnimation(630)
				f30_arg0.PrematchCountdownNumbersSmall:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.PrematchCountdownNumbersSmall:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f30_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f30_arg0.PrematchCountdownNumbersSmall:setTopBottom(0, 0, 35, 95)
			f30_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
			f30_local1(f30_arg0.PrematchCountdownNumbersSmall)
			local f30_local2 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(199)
					f39_arg0:setAlpha(1)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.Message:beginAnimation(630)
				f30_arg0.Message:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.Message:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f30_arg0.Message:completeAnimation()
			f30_arg0.Message:setTopBottom(0, 0, 47, 83)
			f30_arg0.Message:setAlpha(0)
			f30_local2(f30_arg0.Message)
		end,
		Stop = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(3)
			f40_arg0.PrematchCountdownNumbers:completeAnimation()
			f40_arg0.PrematchCountdownNumbers:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.PrematchCountdownNumbers)
			f40_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f40_arg0.PrematchCountdownNumbersSmall:setTopBottom(0, 0, 35, 95)
			f40_arg0.PrematchCountdownNumbersSmall:setAlpha(0.99)
			f40_arg0.clipFinished(f40_arg0.PrematchCountdownNumbersSmall)
			f40_arg0.Message:completeAnimation()
			f40_arg0.Message:setTopBottom(0, 0, 47, 83)
			f40_arg0.Message:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.Message)
		end,
		ShowObjectiveHint = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(3)
			f41_arg0.PrematchCountdownNumbers:completeAnimation()
			f41_arg0.PrematchCountdownNumbers:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.PrematchCountdownNumbers)
			local f41_local0 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						f44_arg0:beginAnimation(1000)
						f44_arg0:setAlpha(0)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
					end
					f43_arg0:beginAnimation(3000)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f41_arg0.GameTypeHintText:beginAnimation(1000)
				f41_arg0.GameTypeHintText:setAlpha(1)
				f41_arg0.GameTypeHintText:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.GameTypeHintText:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f41_arg0.GameTypeHintText:completeAnimation()
			f41_arg0.GameTypeHintText:setAlpha(0)
			f41_local0(f41_arg0.GameTypeHintText)
			local f41_local1 = function(f45_arg0)
				f41_arg0.DoubleXPNotification:beginAnimation(2000)
				f41_arg0.DoubleXPNotification:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.DoubleXPNotification:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("Notify")
					f41_arg0.clipFinished(element, event)
				end)
			end
			f41_arg0.DoubleXPNotification:completeAnimation()
			f41_arg0.DoubleXPNotification:setAlpha(1)
			f41_local1(f41_arg0.DoubleXPNotification)
		end,
		GameStart = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			f47_arg0.PrematchCountdownNumbers:completeAnimation()
			f47_arg0.PrematchCountdownNumbers:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.PrematchCountdownNumbers)
			f47_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f47_arg0.PrematchCountdownNumbersSmall:setTopBottom(0, 0, 35, 95)
			f47_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.PrematchCountdownNumbersSmall)
			f47_arg0.GameTypeHintText:completeAnimation()
			f47_arg0.GameTypeHintText:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.GameTypeHintText)
			f47_arg0.Message:completeAnimation()
			f47_arg0.Message:setTopBottom(0, 0, 47, 83)
			f47_arg0.clipFinished(f47_arg0.Message)
		end,
	},
	HiddenPC = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(3)
			f48_arg0.PrematchCountdownNumbers:completeAnimation()
			f48_arg0.PrematchCountdownNumbers:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.PrematchCountdownNumbers)
			f48_arg0.PrematchCountdownNumbersSmall:completeAnimation()
			f48_arg0.PrematchCountdownNumbersSmall:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.PrematchCountdownNumbersSmall)
			f48_arg0.GameTypeHintText:completeAnimation()
			f48_arg0.GameTypeHintText:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.GameTypeHintText)
		end,
	},
}
CoD.HoldingPenNotification.__onClose = function(f49_arg0)
	f49_arg0.__on_close_removeOverrides()
	f49_arg0.PrematchCountdownNumbers:close()
	f49_arg0.PrematchCountdownNumbersSmall:close()
	f49_arg0.GameTypeHintText:close()
	f49_arg0.DoubleXPNotification:close()
end
