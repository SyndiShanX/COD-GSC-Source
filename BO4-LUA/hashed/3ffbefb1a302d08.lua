require("x64:567f2a963ddad0f")
require("x64:488c89835c36151")
require("x64:170894c2be18f57")
require("x64:3bf01f3c6be13c6")
require("x64:7e1697b8a432349")
CoD.Rush_Gameover = InheritFrom(LUI.UIElement)
CoD.Rush_Gameover.__defaultWidth = 1920
CoD.Rush_Gameover.__defaultHeight = 1080
CoD.Rush_Gameover.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Rush_Gameover)
	self.id = "Rush_Gameover"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(-0.5, 0.5, 960, 960, 0.5, 1.5, -540, -540)
	Blur:setAlpha(0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	Blur:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToHudArea(element, f1_arg1)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(Blur)
	self.Blur = Blur
	local ZMSmokeBackgroundR = CoD.zm_hud_gameover_smokebackground.new(f1_arg0, f1_arg1, 0.5, 0.5, 929, 1399, 0.5, 0.5, 288, 758)
	ZMSmokeBackgroundR:setAlpha(0)
	ZMSmokeBackgroundR:setScale(4, 3)
	self:addElement(ZMSmokeBackgroundR)
	self.ZMSmokeBackgroundR = ZMSmokeBackgroundR
	local ZMSmokeBackgroundL = CoD.zm_hud_gameover_smokebackground.new(f1_arg0, f1_arg1, 0.5, 0.5, -1498, -1028, 0.5, 0.5, 288, 758)
	ZMSmokeBackgroundL:setAlpha(0)
	ZMSmokeBackgroundL:setZRot(190)
	ZMSmokeBackgroundL:setScale(3.5, 3)
	self:addElement(ZMSmokeBackgroundL)
	self.ZMSmokeBackgroundL = ZMSmokeBackgroundL
	local BackgroundOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundOverlay:setRGB(0, 0, 0)
	BackgroundOverlay:setAlpha(0.7)
	BackgroundOverlay:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToHudArea(element, f1_arg1)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(BackgroundOverlay)
	self.BackgroundOverlay = BackgroundOverlay
	local CroppedZmBacking2 = LUI.UIImage.new(0, 1, -8, 8, 0, 1, -18, 18)
	CroppedZmBacking2:setAlpha(0.5)
	CroppedZmBacking2:setImage(RegisterImage(@"uie_ui_hud_zm_aar_reward_bg"))
	CroppedZmBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	CroppedZmBacking2:setShaderVector(0, 0, 0, 0, 0)
	CroppedZmBacking2:setShaderVector(1, 1, 1, 0, 0)
	CroppedZmBacking2:setShaderVector(2, 0, 0, 0, 0)
	CroppedZmBacking2:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		SizeToHudArea(element, f1_arg1)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(CroppedZmBacking2)
	self.CroppedZmBacking2 = CroppedZmBacking2
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.4)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	NoiseTiledBacking:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		SizeToHudArea(element, f1_arg1)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TrialsEndGameScoreboard = CoD.TrialsEndGameScoreboard.new(f1_arg0, f1_arg1, 0, 0, 516, 1404, 0, 0, 360, 743)
	self:addElement(TrialsEndGameScoreboard)
	self.TrialsEndGameScoreboard = TrialsEndGameScoreboard
	local Scoreboard = CoD.Rush_Gameover_Scoreboard.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, 500, 0, 0, 364, 743)
	self:addElement(Scoreboard)
	self.Scoreboard = Scoreboard
	local TrialTimeText = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 327, 354)
	TrialTimeText:setTTF("skorzhen")
	TrialTimeText:setLetterSpacing(4)
	TrialTimeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TrialTimeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TrialTimeText:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.showScoreboard", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TrialTimeText:setText(CoD.ZombieUtility.GetTrialsCompletetionTime(f1_arg1, f6_local0))
		end
	end)
	self:addElement(TrialTimeText)
	self.TrialTimeText = TrialTimeText
	local RestartLevelPrompt = CoD.ZM_Restart_Level_Prompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -350, 350, 0, 0, 743, 878)
	self:addElement(RestartLevelPrompt)
	self.RestartLevelPrompt = RestartLevelPrompt
	local TitleSequence = CoD.zm_hud_gameover_titlesequence.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0, 0, 37, 507)
	TitleSequence:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.roundNumber", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			TitleSequence.RoundsSurvived:setText(CoD.ZombieUtility.GetSurvivedRoundsText(f7_local0))
		end
	end)
	TitleSequence:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.gameState", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			TitleSequence.TitleShadow:setText(CoD.ZombieUtility.GetTrialsGameOverText(f8_local0))
		end
	end)
	TitleSequence:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.gameState", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			TitleSequence.Title:setText(CoD.ZombieUtility.GetTrialsGameOverText(f9_local0))
		end
	end)
	self:addElement(TitleSequence)
	self.TitleSequence = TitleSequence
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
		{
			stateName = "TrialsPostGameShow",
			condition = function(menu, element, event)
				local f11_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
				if f11_local0 then
					f11_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
					if f11_local0 then
						f11_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.showScoreboard", 1)
					end
				end
				return f11_local0
			end,
		},
	})
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.showScoreboard"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "ZMHudGlobal.trials.showScoreboard",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		if not IsSelfInState(self, "DefaultState") and not IsDemoPlaying() then
			SetFocusToElement(self, "RestartLevelPrompt", controller)
			SetMenuProperty(f1_arg0, "m_inputDisabled", false)
		elseif IsSelfInState(self, "DefaultState") and not IsDemoPlaying() then
			SetLoseFocusToElement(self, "RestartLevelPrompt", controller)
			SetMenuProperty(f1_arg0, "m_inputDisabled", true)
		end
	end)
	TrialsEndGameScoreboard.id = "TrialsEndGameScoreboard"
	Scoreboard.id = "Scoreboard"
	RestartLevelPrompt.id = "RestartLevelPrompt"
	self.__defaultFocus = RestartLevelPrompt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local13 = self
	if not IsDemoPlaying() then
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.RestartLevelPrompt)
	end
	return self
end
CoD.Rush_Gameover.__resetProperties = function(f15_arg0)
	f15_arg0.Scoreboard:completeAnimation()
	f15_arg0.TrialTimeText:completeAnimation()
	f15_arg0.BackgroundOverlay:completeAnimation()
	f15_arg0.CroppedZmBacking2:completeAnimation()
	f15_arg0.NoiseTiledBacking:completeAnimation()
	f15_arg0.RestartLevelPrompt:completeAnimation()
	f15_arg0.TitleSequence:completeAnimation()
	f15_arg0.TrialsEndGameScoreboard:completeAnimation()
	f15_arg0.ZMSmokeBackgroundR:completeAnimation()
	f15_arg0.ZMSmokeBackgroundL:completeAnimation()
	f15_arg0.Scoreboard:setAlpha(1)
	f15_arg0.TrialTimeText:setAlpha(1)
	f15_arg0.BackgroundOverlay:setAlpha(0.7)
	f15_arg0.CroppedZmBacking2:setAlpha(0.5)
	f15_arg0.NoiseTiledBacking:setAlpha(0.4)
	f15_arg0.RestartLevelPrompt:setAlpha(1)
	f15_arg0.TitleSequence:setAlpha(1)
	f15_arg0.TrialsEndGameScoreboard:setAlpha(1)
	f15_arg0.ZMSmokeBackgroundR:setAlpha(0)
	f15_arg0.ZMSmokeBackgroundL:setAlpha(0)
end
CoD.Rush_Gameover.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(8)
			f16_arg0.BackgroundOverlay:completeAnimation()
			f16_arg0.BackgroundOverlay:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.BackgroundOverlay)
			f16_arg0.CroppedZmBacking2:completeAnimation()
			f16_arg0.CroppedZmBacking2:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CroppedZmBacking2)
			f16_arg0.NoiseTiledBacking:completeAnimation()
			f16_arg0.NoiseTiledBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.NoiseTiledBacking)
			f16_arg0.TrialsEndGameScoreboard:completeAnimation()
			f16_arg0.TrialsEndGameScoreboard:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TrialsEndGameScoreboard)
			f16_arg0.Scoreboard:completeAnimation()
			f16_arg0.Scoreboard:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Scoreboard)
			f16_arg0.TrialTimeText:completeAnimation()
			f16_arg0.TrialTimeText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TrialTimeText)
			f16_arg0.RestartLevelPrompt:completeAnimation()
			f16_arg0.RestartLevelPrompt:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.RestartLevelPrompt)
			f16_arg0.TitleSequence:completeAnimation()
			f16_arg0.TitleSequence:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TitleSequence)
		end,
	},
	Show = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(10)
			local f17_local0 = function(f18_arg0)
				f18_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_both"])
				f18_arg0:setAlpha(0.05)
				f18_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ZMSmokeBackgroundR:beginAnimation(200)
			f17_arg0.ZMSmokeBackgroundR:setAlpha(0)
			f17_arg0.ZMSmokeBackgroundR:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
			f17_arg0.ZMSmokeBackgroundR:registerEventHandler("transition_complete_keyframe", f17_local0)
			local f17_local1 = function(f19_arg0)
				f19_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_both"])
				f19_arg0:setAlpha(0.05)
				f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ZMSmokeBackgroundL:beginAnimation(200)
			f17_arg0.ZMSmokeBackgroundL:setAlpha(0)
			f17_arg0.ZMSmokeBackgroundL:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
			f17_arg0.ZMSmokeBackgroundL:registerEventHandler("transition_complete_keyframe", f17_local1)
			local f17_local2 = function(f20_arg0)
				f17_arg0.BackgroundOverlay:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f17_arg0.BackgroundOverlay:setAlpha(0.7)
				f17_arg0.BackgroundOverlay:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.BackgroundOverlay:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.BackgroundOverlay:completeAnimation()
			f17_arg0.BackgroundOverlay:setAlpha(0)
			f17_local2(f17_arg0.BackgroundOverlay)
			local f17_local3 = function(f21_arg0)
				f17_arg0.CroppedZmBacking2:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_in"])
				f17_arg0.CroppedZmBacking2:setAlpha(0.5)
				f17_arg0.CroppedZmBacking2:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.CroppedZmBacking2:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.CroppedZmBacking2:completeAnimation()
			f17_arg0.CroppedZmBacking2:setAlpha(0)
			f17_local3(f17_arg0.CroppedZmBacking2)
			local f17_local4 = function(f22_arg0)
				f17_arg0.NoiseTiledBacking:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f17_arg0.NoiseTiledBacking:setAlpha(0.4)
				f17_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.NoiseTiledBacking:completeAnimation()
			f17_arg0.NoiseTiledBacking:setAlpha(0)
			f17_local4(f17_arg0.NoiseTiledBacking)
			f17_arg0.TrialsEndGameScoreboard:completeAnimation()
			f17_arg0.TrialsEndGameScoreboard:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TrialsEndGameScoreboard)
			local f17_local5 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(200)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.Scoreboard:beginAnimation(400)
				f17_arg0.Scoreboard:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Scoreboard:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f17_arg0.Scoreboard:completeAnimation()
			f17_arg0.Scoreboard:setAlpha(0)
			f17_local5(f17_arg0.Scoreboard)
			f17_arg0.TrialTimeText:completeAnimation()
			f17_arg0.TrialTimeText:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TrialTimeText)
			local f17_local6 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(200)
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.RestartLevelPrompt:beginAnimation(400)
				f17_arg0.RestartLevelPrompt:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.RestartLevelPrompt:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f17_arg0.RestartLevelPrompt:completeAnimation()
			f17_arg0.RestartLevelPrompt:setAlpha(0)
			f17_local6(f17_arg0.RestartLevelPrompt)
			local f17_local7 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(200)
					f28_arg0:setAlpha(1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.TitleSequence:beginAnimation(400)
				f17_arg0.TitleSequence:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.TitleSequence:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f17_arg0.TitleSequence:completeAnimation()
			f17_arg0.TitleSequence:setAlpha(0)
			f17_local7(f17_arg0.TitleSequence)
		end,
	},
	TrialsPostGameShow = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(10)
			local f29_local0 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_both"])
					f31_arg0:setAlpha(0.05)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.ZMSmokeBackgroundR:beginAnimation(200)
				f29_arg0.ZMSmokeBackgroundR:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ZMSmokeBackgroundR:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f29_arg0.ZMSmokeBackgroundR:completeAnimation()
			f29_arg0.ZMSmokeBackgroundR:setAlpha(0)
			f29_local0(f29_arg0.ZMSmokeBackgroundR)
			local f29_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_both"])
					f33_arg0:setAlpha(0.05)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.ZMSmokeBackgroundL:beginAnimation(200)
				f29_arg0.ZMSmokeBackgroundL:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ZMSmokeBackgroundL:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f29_arg0.ZMSmokeBackgroundL:completeAnimation()
			f29_arg0.ZMSmokeBackgroundL:setAlpha(0)
			f29_local1(f29_arg0.ZMSmokeBackgroundL)
			local f29_local2 = function(f34_arg0)
				f29_arg0.BackgroundOverlay:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f29_arg0.BackgroundOverlay:setAlpha(0.7)
				f29_arg0.BackgroundOverlay:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.BackgroundOverlay:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.BackgroundOverlay:completeAnimation()
			f29_arg0.BackgroundOverlay:setAlpha(0)
			f29_local2(f29_arg0.BackgroundOverlay)
			local f29_local3 = function(f35_arg0)
				f29_arg0.CroppedZmBacking2:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_in"])
				f29_arg0.CroppedZmBacking2:setAlpha(0.5)
				f29_arg0.CroppedZmBacking2:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.CroppedZmBacking2:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.CroppedZmBacking2:completeAnimation()
			f29_arg0.CroppedZmBacking2:setAlpha(0)
			f29_local3(f29_arg0.CroppedZmBacking2)
			local f29_local4 = function(f36_arg0)
				f29_arg0.NoiseTiledBacking:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f29_arg0.NoiseTiledBacking:setAlpha(0.4)
				f29_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.NoiseTiledBacking:completeAnimation()
			f29_arg0.NoiseTiledBacking:setAlpha(0)
			f29_local4(f29_arg0.NoiseTiledBacking)
			local f29_local5 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_out"])
					f38_arg0:setAlpha(1)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.TrialsEndGameScoreboard:beginAnimation(800)
				f29_arg0.TrialsEndGameScoreboard:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.TrialsEndGameScoreboard:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f29_arg0.TrialsEndGameScoreboard:completeAnimation()
			f29_arg0.TrialsEndGameScoreboard:setAlpha(0)
			f29_local5(f29_arg0.TrialsEndGameScoreboard)
			f29_arg0.Scoreboard:completeAnimation()
			f29_arg0.Scoreboard:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.Scoreboard)
			local f29_local6 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(199)
					f40_arg0:setAlpha(1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.TrialTimeText:beginAnimation(500)
				f29_arg0.TrialTimeText:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.TrialTimeText:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f29_arg0.TrialTimeText:completeAnimation()
			f29_arg0.TrialTimeText:setAlpha(0)
			f29_local6(f29_arg0.TrialTimeText)
			local f29_local7 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_out"])
					f42_arg0:setAlpha(1)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.RestartLevelPrompt:beginAnimation(800)
				f29_arg0.RestartLevelPrompt:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.RestartLevelPrompt:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f29_arg0.RestartLevelPrompt:completeAnimation()
			f29_arg0.RestartLevelPrompt:setAlpha(0)
			f29_local7(f29_arg0.RestartLevelPrompt)
			local f29_local8 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					f44_arg0:beginAnimation(500)
					f44_arg0:setAlpha(1)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.TitleSequence:beginAnimation(200)
				f29_arg0.TitleSequence:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.TitleSequence:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f29_arg0.TitleSequence:completeAnimation()
			f29_arg0.TitleSequence:setAlpha(0)
			f29_local8(f29_arg0.TitleSequence)
		end,
	},
}
CoD.Rush_Gameover.__onClose = function(f45_arg0)
	f45_arg0.ZMSmokeBackgroundR:close()
	f45_arg0.ZMSmokeBackgroundL:close()
	f45_arg0.TrialsEndGameScoreboard:close()
	f45_arg0.Scoreboard:close()
	f45_arg0.TrialTimeText:close()
	f45_arg0.RestartLevelPrompt:close()
	f45_arg0.TitleSequence:close()
end
