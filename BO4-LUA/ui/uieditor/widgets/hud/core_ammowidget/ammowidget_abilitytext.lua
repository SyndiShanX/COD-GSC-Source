require("x64:34778f864da9dda")
require("x64:714f18fa2092a4a")
CoD.AmmoWidget_AbilityText = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_AbilityText.__defaultWidth = 192
CoD.AmmoWidget_AbilityText.__defaultHeight = 25
CoD.AmmoWidget_AbilityText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.tankState", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.dogState", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.smartCoverState", 0)
	self:setClass(CoD.AmmoWidget_AbilityText)
	self.id = "AmmoWidget_AbilityText"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AbilityTextInfo = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -12.5, 5.5)
	AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7811F06542057CEC"))
	AbilityTextInfo:setTTF("ttmussels_regular")
	AbilityTextInfo:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	AbilityTextInfo:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AbilityTextInfo)
	self.AbilityTextInfo = AbilityTextInfo
	local Text_Prompt_Arrow = CoD.Prompt_Arrow.new(f1_arg0, f1_arg1, 0, 0, -10, 0, 0.5, 0.5, -5, 5)
	Text_Prompt_Arrow:setAlpha(0)
	self:addElement(Text_Prompt_Arrow)
	self.Text_Prompt_Arrow = Text_Prompt_Arrow
	local TextPromptArrow = CoD.Prompt_Arrow.new(f1_arg0, f1_arg1, 1, 1, 0, 10, 0.5, 0.5, -5, 5)
	TextPromptArrow:setAlpha(0)
	TextPromptArrow:setZRot(180)
	self:addElement(TextPromptArrow)
	self.TextPromptArrow = TextPromptArrow
	local TabletLocationSelectorFlare = LUI.UIImage.new(0, 0, 23, 151, 0, 0, -56.5, 71.5)
	TabletLocationSelectorFlare:setScale(0, 0)
	TabletLocationSelectorFlare:setImage(RegisterImage(@"uie_ui_hud_cp_hud_tacmode_flare"))
	self:addElement(TabletLocationSelectorFlare)
	self.TabletLocationSelectorFlare = TabletLocationSelectorFlare
	local HeroAbilityUseString = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -44.5, 44.5, 0, 0, 24, 46)
	HeroAbilityUseString:mergeStateConditions({
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbility",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseUltimate",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysTrue()
			end,
		},
		{
			stateName = "KeyboardAndMouseScoreStreak",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
	})
	local f1_local6 = HeroAbilityUseString
	local f1_local7 = HeroAbilityUseString.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f6_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local6 = HeroAbilityUseString
	f1_local7 = HeroAbilityUseString.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f7_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	HeroAbilityUseString:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(HeroAbilityUseString, f8_arg1)
	end)
	f1_local6 = HeroAbilityUseString
	f1_local7 = HeroAbilityUseString.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f9_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	HeroAbilityUseString:setAlpha(0)
	HeroAbilityUseString.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2EC61C43D90FCF56"))
	HeroAbilityUseString.GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29E6A8D0F83F4FC6"))
	HeroAbilityUseString.GamepadText:setTTF("ttmussels_regular")
	HeroAbilityUseString.GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(HeroAbilityUseString)
	self.HeroAbilityUseString = HeroAbilityUseString
	self:mergeStateConditions({
		{
			stateName = "TankInbound",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.tankState", CoD.AmmoWidgetUtility.TankState.TANK_INBOUND)
			end,
		},
		{
			stateName = "TankReadyForCommands",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.tankState", CoD.AmmoWidgetUtility.TankState.TANK_READY_FOR_COMMANDS)
			end,
		},
		{
			stateName = "TankEntered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.tankState", CoD.AmmoWidgetUtility.TankState.TANK_ENTERED)
			end,
		},
		{
			stateName = "SmartCoverHUDDestroy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.smartCoverState", CoD.AmmoWidgetUtility.SmartCoverState.SMART_COVER_HUD_DESTROY)
			end,
		},
		{
			stateName = "DogFollowReady",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.dogState", CoD.AmmoWidgetUtility.DogState.DOG_PATROLLING) and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "DogPatrolReady",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.dogState", CoD.AmmoWidgetUtility.DogState.DOG_FOLLOWING) and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "DogFollowReadyPC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.dogState", CoD.AmmoWidgetUtility.DogState.DOG_PATROLLING) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "DogPatrolReadyPC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.dogState", CoD.AmmoWidgetUtility.DogState.DOG_FOLLOWING) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.tankState"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.tankState",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.smartCoverState"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "hudItems.smartCoverState",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.dogState"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "hudItems.dogState",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f21_arg0, f21_arg1)
		f21_arg1.menu = f21_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f21_arg1)
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_AbilityText.__resetProperties = function(f23_arg0)
	f23_arg0.AbilityTextInfo:completeAnimation()
	f23_arg0.Text_Prompt_Arrow:completeAnimation()
	f23_arg0.TextPromptArrow:completeAnimation()
	f23_arg0.HeroAbilityUseString:completeAnimation()
	f23_arg0.TabletLocationSelectorFlare:completeAnimation()
	f23_arg0.AbilityTextInfo:setLeftRight(0, 1, 0, 0)
	f23_arg0.AbilityTextInfo:setTopBottom(0.5, 0.5, -12.5, 5.5)
	f23_arg0.AbilityTextInfo:setAlpha(1)
	f23_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7811F06542057CEC"))
	f23_arg0.Text_Prompt_Arrow:setLeftRight(0, 0, -10, 0)
	f23_arg0.Text_Prompt_Arrow:setTopBottom(0.5, 0.5, -5, 5)
	f23_arg0.Text_Prompt_Arrow:setAlpha(0)
	f23_arg0.TextPromptArrow:setLeftRight(1, 1, 0, 10)
	f23_arg0.TextPromptArrow:setTopBottom(0.5, 0.5, -5, 5)
	f23_arg0.TextPromptArrow:setAlpha(0)
	f23_arg0.TextPromptArrow:setZRot(180)
	f23_arg0.HeroAbilityUseString:setLeftRight(0.5, 0.5, -44.5, 44.5)
	f23_arg0.HeroAbilityUseString:setTopBottom(0, 0, 24, 46)
	f23_arg0.HeroAbilityUseString:setAlpha(0)
	f23_arg0.TabletLocationSelectorFlare:setLeftRight(0, 0, 23, 151)
	f23_arg0.TabletLocationSelectorFlare:setTopBottom(0, 0, -56.5, 71.5)
	f23_arg0.TabletLocationSelectorFlare:setAlpha(1)
	f23_arg0.TabletLocationSelectorFlare:setScale(0, 0)
	f23_arg0.TabletLocationSelectorFlare:setImage(RegisterImage(@"uie_ui_hud_cp_hud_tacmode_flare"))
	f23_arg0.TabletLocationSelectorFlare:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
end
CoD.AmmoWidget_AbilityText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.AbilityTextInfo:completeAnimation()
			f24_arg0.AbilityTextInfo:setAlpha(0)
			f24_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D23BFBCD5F26261"))
			f24_arg0.clipFinished(f24_arg0.AbilityTextInfo)
		end,
		TankInbound = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			local f25_local0 = function(f26_arg0)
				f25_arg0.AbilityTextInfo:beginAnimation(810)
				f25_arg0.AbilityTextInfo:setTopBottom(0.5, 0.5, -12.5, 12.5)
				f25_arg0.AbilityTextInfo:setAlpha(1)
				f25_arg0.AbilityTextInfo:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.AbilityTextInfo:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.AbilityTextInfo:completeAnimation()
			f25_arg0.AbilityTextInfo:setLeftRight(0, 1, 0, 0)
			f25_arg0.AbilityTextInfo:setTopBottom(0.5, 0.5, -38.5, -13.5)
			f25_arg0.AbilityTextInfo:setAlpha(0)
			f25_local0(f25_arg0.AbilityTextInfo)
			local f25_local1 = function(f27_arg0)
				f25_arg0.Text_Prompt_Arrow:beginAnimation(810)
				f25_arg0.Text_Prompt_Arrow:setTopBottom(0.5, 0.5, -8, 8)
				f25_arg0.Text_Prompt_Arrow:setAlpha(0.99)
				f25_arg0.Text_Prompt_Arrow:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.Text_Prompt_Arrow:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.Text_Prompt_Arrow:completeAnimation()
			f25_arg0.Text_Prompt_Arrow:setLeftRight(0, 0, -16, 0)
			f25_arg0.Text_Prompt_Arrow:setTopBottom(0, 0, -23, -7)
			f25_arg0.Text_Prompt_Arrow:setAlpha(0)
			f25_local1(f25_arg0.Text_Prompt_Arrow)
			local f25_local2 = function(f28_arg0)
				f25_arg0.TextPromptArrow:beginAnimation(810)
				f25_arg0.TextPromptArrow:setTopBottom(0, 0, 4, 20)
				f25_arg0.TextPromptArrow:setAlpha(1)
				f25_arg0.TextPromptArrow:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.TextPromptArrow:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.TextPromptArrow:completeAnimation()
			f25_arg0.TextPromptArrow:setLeftRight(1, 1, 0, 16)
			f25_arg0.TextPromptArrow:setTopBottom(0, 0, -23, -7)
			f25_arg0.TextPromptArrow:setAlpha(0)
			f25_arg0.TextPromptArrow:setZRot(180)
			f25_local2(f25_arg0.TextPromptArrow)
		end,
	},
	TankInbound = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.AbilityTextInfo:completeAnimation()
			f29_arg0.AbilityTextInfo:setAlpha(1)
			f29_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D23BFBCD5F26261"))
			f29_arg0.clipFinished(f29_arg0.AbilityTextInfo)
			f29_arg0.Text_Prompt_Arrow:completeAnimation()
			f29_arg0.Text_Prompt_Arrow:setLeftRight(0, 0, -10, 0)
			f29_arg0.Text_Prompt_Arrow:setTopBottom(0.5, 0.5, -5, 5)
			f29_arg0.Text_Prompt_Arrow:setAlpha(0.99)
			f29_arg0.clipFinished(f29_arg0.Text_Prompt_Arrow)
			f29_arg0.TextPromptArrow:completeAnimation()
			f29_arg0.TextPromptArrow:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.TextPromptArrow)
		end,
		TankReadyForCommands = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(5)
			local f30_local0 = function(f31_arg0)
				f30_arg0.AbilityTextInfo:beginAnimation(390)
				f30_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_FBCFC36F0C79D9A"))
				f30_arg0.AbilityTextInfo:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.AbilityTextInfo:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.AbilityTextInfo:completeAnimation()
			f30_arg0.AbilityTextInfo:setAlpha(1)
			f30_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D23BFBCD5F26261"))
			f30_local0(f30_arg0.AbilityTextInfo)
			f30_arg0.Text_Prompt_Arrow:completeAnimation()
			f30_arg0.Text_Prompt_Arrow:setAlpha(0.99)
			f30_arg0.clipFinished(f30_arg0.Text_Prompt_Arrow)
			f30_arg0.TextPromptArrow:completeAnimation()
			f30_arg0.TextPromptArrow:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TextPromptArrow)
			local f30_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							f35_arg0:beginAnimation(99)
							f35_arg0:setAlpha(0)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
						end
						f34_arg0:beginAnimation(59)
						f34_arg0:setScale(1.75, 1.75)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(70)
					f33_arg0:setScale(2.87, 2.87)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f30_arg0.TabletLocationSelectorFlare:beginAnimation(160)
				f30_arg0.TabletLocationSelectorFlare:setAlpha(1)
				f30_arg0.TabletLocationSelectorFlare:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.TabletLocationSelectorFlare:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f30_arg0.TabletLocationSelectorFlare:completeAnimation()
			f30_arg0.TabletLocationSelectorFlare:setLeftRight(0, 0, 1, 129)
			f30_arg0.TabletLocationSelectorFlare:setTopBottom(0, 0, -56.5, 71.5)
			f30_arg0.TabletLocationSelectorFlare:setAlpha(0)
			f30_arg0.TabletLocationSelectorFlare:setScale(1.75, 1.75)
			f30_arg0.TabletLocationSelectorFlare:setImage(RegisterImage(@"uie_ui_hud_cp_hud_tacmode_flare"))
			f30_arg0.TabletLocationSelectorFlare:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f30_local1(f30_arg0.TabletLocationSelectorFlare)
			local f30_local2 = function(f36_arg0)
				f30_arg0.HeroAbilityUseString:beginAnimation(390)
				f30_arg0.HeroAbilityUseString:setAlpha(1)
				f30_arg0.HeroAbilityUseString:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.HeroAbilityUseString:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.HeroAbilityUseString:completeAnimation()
			f30_arg0.HeroAbilityUseString:setAlpha(0)
			f30_local2(f30_arg0.HeroAbilityUseString)
		end,
	},
	TankReadyForCommands = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			f37_arg0.AbilityTextInfo:completeAnimation()
			f37_arg0.AbilityTextInfo:setAlpha(1)
			f37_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_FBCFC36F0C79D9A"))
			f37_arg0.clipFinished(f37_arg0.AbilityTextInfo)
			f37_arg0.Text_Prompt_Arrow:completeAnimation()
			f37_arg0.Text_Prompt_Arrow:setAlpha(0.99)
			f37_arg0.clipFinished(f37_arg0.Text_Prompt_Arrow)
			f37_arg0.TextPromptArrow:completeAnimation()
			f37_arg0.TextPromptArrow:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.TextPromptArrow)
			f37_arg0.HeroAbilityUseString:completeAnimation()
			f37_arg0.HeroAbilityUseString:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.HeroAbilityUseString)
		end,
		TankInbound = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(5)
			local f38_local0 = function(f39_arg0)
				f38_arg0.AbilityTextInfo:beginAnimation(200)
				f38_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D23BFBCD5F26261"))
				f38_arg0.AbilityTextInfo:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.AbilityTextInfo:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.AbilityTextInfo:completeAnimation()
			f38_arg0.AbilityTextInfo:setAlpha(1)
			f38_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_FBCFC36F0C79D9A"))
			f38_local0(f38_arg0.AbilityTextInfo)
			f38_arg0.Text_Prompt_Arrow:completeAnimation()
			f38_arg0.Text_Prompt_Arrow:setLeftRight(0, 0, -10, 0)
			f38_arg0.Text_Prompt_Arrow:setTopBottom(0.5, 0.5, -5, 5)
			f38_arg0.Text_Prompt_Arrow:setAlpha(0.99)
			f38_arg0.clipFinished(f38_arg0.Text_Prompt_Arrow)
			f38_arg0.TextPromptArrow:completeAnimation()
			f38_arg0.TextPromptArrow:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.TextPromptArrow)
			local f38_local1 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					local f41_local0 = function(f42_arg0)
						local f42_local0 = function(f43_arg0)
							f43_arg0:beginAnimation(99)
							f43_arg0:setAlpha(0)
							f43_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
						end
						f42_arg0:beginAnimation(59)
						f42_arg0:setScale(1.75, 1.75)
						f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
					end
					f41_arg0:beginAnimation(70)
					f41_arg0:setScale(2.87, 2.87)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
				end
				f38_arg0.TabletLocationSelectorFlare:beginAnimation(160)
				f38_arg0.TabletLocationSelectorFlare:setAlpha(1)
				f38_arg0.TabletLocationSelectorFlare:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.TabletLocationSelectorFlare:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f38_arg0.TabletLocationSelectorFlare:completeAnimation()
			f38_arg0.TabletLocationSelectorFlare:setLeftRight(0, 0, 1, 129)
			f38_arg0.TabletLocationSelectorFlare:setTopBottom(0, 0, -56.5, 71.5)
			f38_arg0.TabletLocationSelectorFlare:setAlpha(0)
			f38_arg0.TabletLocationSelectorFlare:setScale(1.75, 1.75)
			f38_arg0.TabletLocationSelectorFlare:setImage(RegisterImage(@"uie_ui_hud_cp_hud_tacmode_flare"))
			f38_arg0.TabletLocationSelectorFlare:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f38_local1(f38_arg0.TabletLocationSelectorFlare)
			local f38_local2 = function(f44_arg0)
				f38_arg0.HeroAbilityUseString:beginAnimation(200)
				f38_arg0.HeroAbilityUseString:setAlpha(0)
				f38_arg0.HeroAbilityUseString:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.HeroAbilityUseString:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.HeroAbilityUseString:completeAnimation()
			f38_arg0.HeroAbilityUseString:setAlpha(1)
			f38_local2(f38_arg0.HeroAbilityUseString)
		end,
	},
	TankEntered = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(5)
			f45_arg0.AbilityTextInfo:completeAnimation()
			f45_arg0.AbilityTextInfo:setLeftRight(0, 1, 0, 0)
			f45_arg0.AbilityTextInfo:setTopBottom(0.5, 0.5, -9, 9)
			f45_arg0.AbilityTextInfo:setAlpha(1)
			f45_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/remote_exit"))
			f45_arg0.clipFinished(f45_arg0.AbilityTextInfo)
			f45_arg0.Text_Prompt_Arrow:completeAnimation()
			f45_arg0.Text_Prompt_Arrow:setAlpha(0.99)
			f45_arg0.clipFinished(f45_arg0.Text_Prompt_Arrow)
			f45_arg0.TextPromptArrow:completeAnimation()
			f45_arg0.TextPromptArrow:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.TextPromptArrow)
			f45_arg0.TabletLocationSelectorFlare:completeAnimation()
			f45_arg0.TabletLocationSelectorFlare:setLeftRight(0, 0, 23, 151)
			f45_arg0.TabletLocationSelectorFlare:setTopBottom(0, 0, -56.5, 71.5)
			f45_arg0.clipFinished(f45_arg0.TabletLocationSelectorFlare)
			f45_arg0.HeroAbilityUseString:completeAnimation()
			f45_arg0.HeroAbilityUseString:setLeftRight(0.5, 0.5, -44.5, 44.5)
			f45_arg0.HeroAbilityUseString:setTopBottom(0, 0, 24, 46)
			f45_arg0.HeroAbilityUseString:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.HeroAbilityUseString)
		end,
		TankReadyForCommands = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(5)
			local f46_local0 = function(f47_arg0)
				f46_arg0.AbilityTextInfo:beginAnimation(200)
				f46_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_FBCFC36F0C79D9A"))
				f46_arg0.AbilityTextInfo:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.AbilityTextInfo:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.AbilityTextInfo:completeAnimation()
			f46_arg0.AbilityTextInfo:setAlpha(1)
			f46_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2CBFB7C2C1736BB0"))
			f46_local0(f46_arg0.AbilityTextInfo)
			f46_arg0.Text_Prompt_Arrow:completeAnimation()
			f46_arg0.Text_Prompt_Arrow:setAlpha(0.99)
			f46_arg0.clipFinished(f46_arg0.Text_Prompt_Arrow)
			f46_arg0.TextPromptArrow:completeAnimation()
			f46_arg0.TextPromptArrow:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.TextPromptArrow)
			local f46_local1 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					local f49_local0 = function(f50_arg0)
						local f50_local0 = function(f51_arg0)
							f51_arg0:beginAnimation(99)
							f51_arg0:setAlpha(0)
							f51_arg0:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
						end
						f50_arg0:beginAnimation(59)
						f50_arg0:setScale(1.75, 1.75)
						f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
					end
					f49_arg0:beginAnimation(70)
					f49_arg0:setScale(2.87, 2.87)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
				end
				f46_arg0.TabletLocationSelectorFlare:beginAnimation(160)
				f46_arg0.TabletLocationSelectorFlare:setAlpha(1)
				f46_arg0.TabletLocationSelectorFlare:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.TabletLocationSelectorFlare:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f46_arg0.TabletLocationSelectorFlare:completeAnimation()
			f46_arg0.TabletLocationSelectorFlare:setLeftRight(0, 0, 1, 129)
			f46_arg0.TabletLocationSelectorFlare:setTopBottom(0, 0, -56.5, 71.5)
			f46_arg0.TabletLocationSelectorFlare:setAlpha(0)
			f46_arg0.TabletLocationSelectorFlare:setScale(1.75, 1.75)
			f46_arg0.TabletLocationSelectorFlare:setImage(RegisterImage(@"uie_ui_hud_cp_hud_tacmode_flare"))
			f46_arg0.TabletLocationSelectorFlare:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f46_local1(f46_arg0.TabletLocationSelectorFlare)
			f46_arg0.HeroAbilityUseString:completeAnimation()
			f46_arg0.HeroAbilityUseString:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.HeroAbilityUseString)
		end,
	},
	SmartCoverHUDDestroy = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(2)
			f52_arg0.AbilityTextInfo:completeAnimation()
			f52_arg0.AbilityTextInfo:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.AbilityTextInfo)
			f52_arg0.HeroAbilityUseString:completeAnimation()
			f52_arg0.HeroAbilityUseString:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.HeroAbilityUseString)
		end,
	},
	DogFollowReady = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(2)
			f53_arg0.AbilityTextInfo:completeAnimation()
			f53_arg0.AbilityTextInfo:setAlpha(1)
			f53_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4DDC1166E6112C8B"))
			f53_arg0.clipFinished(f53_arg0.AbilityTextInfo)
			f53_arg0.HeroAbilityUseString:completeAnimation()
			f53_arg0.HeroAbilityUseString:setLeftRight(0.5, 0.5, -44.5, 44.5)
			f53_arg0.HeroAbilityUseString:setTopBottom(0, 0, 23.5, 45.5)
			f53_arg0.HeroAbilityUseString:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.HeroAbilityUseString)
		end,
	},
	DogPatrolReady = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(2)
			f54_arg0.AbilityTextInfo:completeAnimation()
			f54_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7811F06542057CEC"))
			f54_arg0.clipFinished(f54_arg0.AbilityTextInfo)
			f54_arg0.HeroAbilityUseString:completeAnimation()
			f54_arg0.HeroAbilityUseString:setLeftRight(0.5, 0.5, -44.5, 44.5)
			f54_arg0.HeroAbilityUseString:setTopBottom(0, 0, 23.5, 45.5)
			f54_arg0.HeroAbilityUseString:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.HeroAbilityUseString)
		end,
	},
	DogFollowReadyPC = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(2)
			f55_arg0.AbilityTextInfo:completeAnimation()
			f55_arg0.AbilityTextInfo:setLeftRight(0, 1, 1, 1)
			f55_arg0.AbilityTextInfo:setTopBottom(0.5, 0.5, -35.5, -17.5)
			f55_arg0.AbilityTextInfo:setAlpha(1)
			f55_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4DDC1166E6112C8B"))
			f55_arg0.clipFinished(f55_arg0.AbilityTextInfo)
			f55_arg0.HeroAbilityUseString:completeAnimation()
			f55_arg0.HeroAbilityUseString:setLeftRight(0.5, 0.5, -45.5, 43.5)
			f55_arg0.HeroAbilityUseString:setTopBottom(0, 0, 24, 47)
			f55_arg0.HeroAbilityUseString:setAlpha(1)
			f55_arg0.clipFinished(f55_arg0.HeroAbilityUseString)
		end,
	},
	DogPatrolReadyPC = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(2)
			f56_arg0.AbilityTextInfo:completeAnimation()
			f56_arg0.AbilityTextInfo:setLeftRight(0, 1, 1, 1)
			f56_arg0.AbilityTextInfo:setTopBottom(0.5, 0.5, -35.5, -17.5)
			f56_arg0.AbilityTextInfo:setAlpha(1)
			f56_arg0.AbilityTextInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7811F06542057CEC"))
			f56_arg0.clipFinished(f56_arg0.AbilityTextInfo)
			f56_arg0.HeroAbilityUseString:completeAnimation()
			f56_arg0.HeroAbilityUseString:setLeftRight(0.5, 0.5, -45.5, 43.5)
			f56_arg0.HeroAbilityUseString:setTopBottom(0, 0, 24, 47)
			f56_arg0.HeroAbilityUseString:setAlpha(1)
			f56_arg0.clipFinished(f56_arg0.HeroAbilityUseString)
		end,
	},
}
CoD.AmmoWidget_AbilityText.__onClose = function(f57_arg0)
	f57_arg0.Text_Prompt_Arrow:close()
	f57_arg0.TextPromptArrow:close()
	f57_arg0.HeroAbilityUseString:close()
end
