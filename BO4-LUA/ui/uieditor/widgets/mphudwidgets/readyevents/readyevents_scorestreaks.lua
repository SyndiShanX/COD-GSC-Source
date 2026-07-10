require("x64:f65b3780508b5c7")
require("x64:34778f864da9dda")
require("x64:21cbd2e8fb322c5")
CoD.ReadyEvents_Scorestreaks = InheritFrom(LUI.UIElement)
CoD.ReadyEvents_Scorestreaks.__defaultWidth = 300
CoD.ReadyEvents_Scorestreaks.__defaultHeight = 50
CoD.ReadyEvents_Scorestreaks.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ReadyEvents_Scorestreaks)
	self.id = "ReadyEvents_Scorestreaks"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(1, 0.84, 0)
	Background:setAlpha(0.3)
	self:addElement(Background)
	self.Background = Background
	local BackgroundAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundAdd:setRGB(1, 0.84, 0)
	BackgroundAdd:setAlpha(0.5)
	BackgroundAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scanlines"))
	BackgroundAdd:setShaderVector(0, 0.5, 0, 0, 0)
	BackgroundAdd:setShaderVector(1, 1, 0, 0, 0)
	BackgroundAdd:setShaderVector(2, 0.03, 0, 0, 0)
	self:addElement(BackgroundAdd)
	self.BackgroundAdd = BackgroundAdd
	local NotificationFlare = LUI.UIImage.new(0, 0, -47, 241, 0, 0, 0, 50)
	NotificationFlare:setImage(RegisterImage(0x6CA2666560B030))
	NotificationFlare:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	NotificationFlare:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(NotificationFlare)
	self.NotificationFlare = NotificationFlare
	local ScorestreakInfo = CoD.ReadyEvents_Scorestreaks_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 0.5, 0.5, -25, 25)
	LUI.OverrideFunction_CallOriginalFirst(ScorestreakInfo, "setWidth", function(element, controller)
		ScaleToElementWidth(self, element, 30)
	end)
	self:addElement(ScorestreakInfo)
	self.ScorestreakInfo = ScorestreakInfo
	local ButtonProgressRing = CoD.ButtonProgressRing.new(f1_arg0, f1_arg1, 0, 0, -47, -5, 0.5, 0.5, -21, 21)
	ButtonProgressRing:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	ButtonProgressRing:setScale(0.7, 0.7)
	ButtonProgressRing:subscribeToGlobalModel(f1_arg1, "HUDItems", "heroHoldProgress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ButtonProgressRing.progressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(ButtonProgressRing)
	self.ButtonProgressRing = ButtonProgressRing
	local ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0, 0, -47, -5, 0.5, 0.5, -21, 21)
	ControllerDependentTextBox:mergeStateConditions({
		{
			stateName = "PCGamepadReadyEvents",
			condition = function(menu, element, event)
				return IsPC() and IsGamepad(f1_arg1)
			end,
		},
	})
	local f1_local7 = ControllerDependentTextBox
	local f1_local8 = ControllerDependentTextBox.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f6_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local7 = ControllerDependentTextBox
	f1_local8 = ControllerDependentTextBox.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f7_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	ControllerDependentTextBox:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ControllerDependentTextBox, f8_arg1)
	end)
	f1_local7 = ControllerDependentTextBox
	f1_local8 = ControllerDependentTextBox.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f9_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ControllerDependentTextBox:setAlpha(0)
	ControllerDependentTextBox.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{ultimate}]"))
	ControllerDependentTextBox.KBMText:setLetterSpacing(0)
	ControllerDependentTextBox.GamepadText:setText(CoD.BaseUtility.AlreadyLocalized("[{+weapnext_inventory}]"))
	ControllerDependentTextBox.GamepadText:setLetterSpacing(0)
	ControllerDependentTextBox.GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	self:mergeStateConditions({
		{
			stateName = "CodCasterInvisible",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["factions.isCoDCaster"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReadyEvents_Scorestreaks.__resetProperties = function(f13_arg0)
	f13_arg0.BackgroundAdd:completeAnimation()
	f13_arg0.ControllerDependentTextBox:completeAnimation()
	f13_arg0.ButtonProgressRing:completeAnimation()
	f13_arg0.ScorestreakInfo:completeAnimation()
	f13_arg0.NotificationFlare:completeAnimation()
	f13_arg0.Background:completeAnimation()
	f13_arg0.BackgroundAdd:setAlpha(0.5)
	f13_arg0.ControllerDependentTextBox:setLeftRight(0, 0, -47, -5)
	f13_arg0.ControllerDependentTextBox:setTopBottom(0.5, 0.5, -21, 21)
	f13_arg0.ControllerDependentTextBox:setAlpha(0)
	f13_arg0.ButtonProgressRing:setAlpha(1)
	f13_arg0.ScorestreakInfo:setAlpha(1)
	f13_arg0.NotificationFlare:setAlpha(1)
	f13_arg0.NotificationFlare:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f13_arg0.NotificationFlare:setShaderVector(0, 1, 0, 0, 0)
	f13_arg0.Background:setAlpha(0.3)
end
CoD.ReadyEvents_Scorestreaks.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		IntroAnim = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(6)
			local f15_local0 = function(f16_arg0)
				f15_arg0.Background:beginAnimation(120)
				f15_arg0.Background:setAlpha(0.3)
				f15_arg0.Background:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Background:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Background:completeAnimation()
			f15_arg0.Background:setAlpha(0)
			f15_local0(f15_arg0.Background)
			local f15_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							local f20_local0 = function(f21_arg0)
								local f21_local0 = function(f22_arg0)
									local f22_local0 = function(f23_arg0)
										f23_arg0:beginAnimation(480)
										f23_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
									end
									f22_arg0:beginAnimation(19)
									f22_arg0:setAlpha(0.5)
									f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
								end
								f21_arg0:beginAnimation(20)
								f21_arg0:setAlpha(0.7)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
							end
							f20_arg0:beginAnimation(20)
							f20_arg0:setAlpha(0.5)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(20)
						f19_arg0:setAlpha(0.7)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(20)
					f18_arg0:setAlpha(0.5)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f15_arg0.BackgroundAdd:beginAnimation(20)
				f15_arg0.BackgroundAdd:setAlpha(0.7)
				f15_arg0.BackgroundAdd:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.BackgroundAdd:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f15_arg0.BackgroundAdd:completeAnimation()
			f15_arg0.BackgroundAdd:setAlpha(0.5)
			f15_local1(f15_arg0.BackgroundAdd)
			local f15_local2 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						f26_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
						f26_arg0:setAlpha(0)
						f26_arg0:setShaderVector(0, 1, 0, 0, 0)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
					end
					f25_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_both"])
					f25_arg0:setAlpha(0.5)
					f25_arg0:setShaderVector(0, 1.6, 0, 0, 0)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f15_arg0.NotificationFlare:beginAnimation(450)
				f15_arg0.NotificationFlare:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.NotificationFlare:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f15_arg0.NotificationFlare:completeAnimation()
			f15_arg0.NotificationFlare:setAlpha(0)
			f15_arg0.NotificationFlare:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f15_arg0.NotificationFlare:setShaderVector(0, 1, 0, 0, 0)
			f15_local2(f15_arg0.NotificationFlare)
			local f15_local3 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_both"])
					f28_arg0:setAlpha(1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.ScorestreakInfo:beginAnimation(200)
				f15_arg0.ScorestreakInfo:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.ScorestreakInfo:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f15_arg0.ScorestreakInfo:completeAnimation()
			f15_arg0.ScorestreakInfo:setAlpha(0)
			f15_local3(f15_arg0.ScorestreakInfo)
			local f15_local4 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_both"])
					f30_arg0:setAlpha(1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.ButtonProgressRing:beginAnimation(200)
				f15_arg0.ButtonProgressRing:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.ButtonProgressRing:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f15_arg0.ButtonProgressRing:completeAnimation()
			f15_arg0.ButtonProgressRing:setAlpha(0)
			f15_local4(f15_arg0.ButtonProgressRing)
			local f15_local5 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_both"])
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.ControllerDependentTextBox:beginAnimation(200)
				f15_arg0.ControllerDependentTextBox:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.ControllerDependentTextBox:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f15_arg0.ControllerDependentTextBox:completeAnimation()
			f15_arg0.ControllerDependentTextBox:setAlpha(0)
			f15_local5(f15_arg0.ControllerDependentTextBox)
		end,
	},
	CodCasterInvisible = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.ButtonProgressRing:completeAnimation()
			f33_arg0.ButtonProgressRing:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ButtonProgressRing)
			f33_arg0.ControllerDependentTextBox:completeAnimation()
			f33_arg0.ControllerDependentTextBox:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ControllerDependentTextBox)
		end,
	},
	PC = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(0)
		end,
		IntroAnim = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(6)
			local f35_local0 = function(f36_arg0)
				f35_arg0.Background:beginAnimation(120)
				f35_arg0.Background:setAlpha(0.3)
				f35_arg0.Background:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Background:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.Background:completeAnimation()
			f35_arg0.Background:setAlpha(0)
			f35_local0(f35_arg0.Background)
			local f35_local1 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					local f38_local0 = function(f39_arg0)
						local f39_local0 = function(f40_arg0)
							local f40_local0 = function(f41_arg0)
								local f41_local0 = function(f42_arg0)
									local f42_local0 = function(f43_arg0)
										f43_arg0:beginAnimation(480)
										f43_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
									end
									f42_arg0:beginAnimation(19)
									f42_arg0:setAlpha(0.5)
									f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
								end
								f41_arg0:beginAnimation(20)
								f41_arg0:setAlpha(0.7)
								f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
							end
							f40_arg0:beginAnimation(20)
							f40_arg0:setAlpha(0.5)
							f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
						end
						f39_arg0:beginAnimation(20)
						f39_arg0:setAlpha(0.7)
						f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
					end
					f38_arg0:beginAnimation(20)
					f38_arg0:setAlpha(0.5)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
				end
				f35_arg0.BackgroundAdd:beginAnimation(20)
				f35_arg0.BackgroundAdd:setAlpha(0.7)
				f35_arg0.BackgroundAdd:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.BackgroundAdd:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f35_arg0.BackgroundAdd:completeAnimation()
			f35_arg0.BackgroundAdd:setAlpha(0.5)
			f35_local1(f35_arg0.BackgroundAdd)
			local f35_local2 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						f46_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
						f46_arg0:setAlpha(0)
						f46_arg0:setShaderVector(0, 1, 0, 0, 0)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
					end
					f45_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_both"])
					f45_arg0:setAlpha(0.5)
					f45_arg0:setShaderVector(0, 1.6, 0, 0, 0)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f35_arg0.NotificationFlare:beginAnimation(450)
				f35_arg0.NotificationFlare:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.NotificationFlare:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f35_arg0.NotificationFlare:completeAnimation()
			f35_arg0.NotificationFlare:setAlpha(0)
			f35_arg0.NotificationFlare:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f35_arg0.NotificationFlare:setShaderVector(0, 1, 0, 0, 0)
			f35_local2(f35_arg0.NotificationFlare)
			local f35_local3 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_both"])
					f48_arg0:setAlpha(1)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
				end
				f35_arg0.ScorestreakInfo:beginAnimation(200)
				f35_arg0.ScorestreakInfo:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.ScorestreakInfo:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f35_arg0.ScorestreakInfo:completeAnimation()
			f35_arg0.ScorestreakInfo:setAlpha(0)
			f35_local3(f35_arg0.ScorestreakInfo)
			local f35_local4 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_both"])
					f50_arg0:setAlpha(1)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
				end
				f35_arg0.ButtonProgressRing:beginAnimation(200)
				f35_arg0.ButtonProgressRing:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.ButtonProgressRing:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f35_arg0.ButtonProgressRing:completeAnimation()
			f35_arg0.ButtonProgressRing:setAlpha(0)
			f35_local4(f35_arg0.ButtonProgressRing)
			local f35_local5 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_both"])
					f52_arg0:setAlpha(1)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
				end
				f35_arg0.ControllerDependentTextBox:beginAnimation(200)
				f35_arg0.ControllerDependentTextBox:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.ControllerDependentTextBox:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f35_arg0.ControllerDependentTextBox:completeAnimation()
			f35_arg0.ControllerDependentTextBox:setLeftRight(0, 0, -94, -5)
			f35_arg0.ControllerDependentTextBox:setTopBottom(0.5, 0.5, -2, 20)
			f35_arg0.ControllerDependentTextBox:setAlpha(0)
			f35_local5(f35_arg0.ControllerDependentTextBox)
		end,
	},
}
CoD.ReadyEvents_Scorestreaks.__onClose = function(f53_arg0)
	f53_arg0.ScorestreakInfo:close()
	f53_arg0.ButtonProgressRing:close()
	f53_arg0.ControllerDependentTextBox:close()
end
