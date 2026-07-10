require("x64:206f6cc2bb5856d")
CoD.SprintMeterContainer = InheritFrom(LUI.UIElement)
CoD.SprintMeterContainer.__defaultWidth = 255
CoD.SprintMeterContainer.__defaultHeight = 60
CoD.SprintMeterContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SprintMeterContainer)
	self.id = "SprintMeterContainer"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SprintMeter = CoD.SprintMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -127.5, 127.5, 0.5, 0.5, -30, 30)
	self:addElement(SprintMeter)
	self.SprintMeter = SprintMeter
	local Icon = LUI.UIImage.new(0, 0, 118, 148, 0, 0, 55, 85)
	Icon:setXRot(180)
	Icon:setZRot(-90)
	Icon:setImage(RegisterImage(@"uie_hud_sprintmeter_icon"))
	self:addElement(Icon)
	self.Icon = Icon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0
				if Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]) then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
					if not f2_local0 then
						f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						if not f2_local0 then
							f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
							if not f2_local0 then
								f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
								if not f2_local0 then
									f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
									if not f2_local0 then
										f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
										if not f2_local0 then
											f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
											if not f2_local0 then
												f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
												if not f2_local0 then
													f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
													if not f2_local0 then
														f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
														if not f2_local0 then
															f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
															if not f2_local0 then
																f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
																if not f2_local0 then
																	f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				else
					f2_local0 = true
				end
				return f2_local0
			end,
		},
		{
			stateName = "HideForDvar",
			condition = function(menu, element, event)
				return not IsIntDvarNonZero("ui_showMPSprintMeter")
			end,
		},
		{
			stateName = "FullEnergy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "playerAbilities.playerSprintRatio", 1)
			end,
		},
		{
			stateName = "NoEnergy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "playerAbilities.playerSprintRatio", 0) and IsUsingSprintDecay()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["playerAbilities.playerSprintRatio"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "playerAbilities.playerSprintRatio",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SprintMeterContainer.__resetProperties = function(f22_arg0)
	f22_arg0.SprintMeter:completeAnimation()
	f22_arg0.Icon:completeAnimation()
	f22_arg0.SprintMeter:setAlpha(1)
	f22_arg0.Icon:setAlpha(1)
end
CoD.SprintMeterContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
		Hidden = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						local f27_local0 = function(f28_arg0)
							local f28_local0 = function(f29_arg0)
								local f29_local0 = function(f30_arg0)
									local f30_local0 = function(f31_arg0)
										f31_arg0:beginAnimation(90)
										f31_arg0:setAlpha(0)
										f31_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
									end
									f30_arg0:beginAnimation(29)
									f30_arg0:setAlpha(0.5)
									f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
								end
								f29_arg0:beginAnimation(20)
								f29_arg0:setAlpha(0.54)
								f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
							end
							f28_arg0:beginAnimation(59)
							f28_arg0:setAlpha(0.63)
							f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
						end
						f27_arg0:beginAnimation(20)
						f27_arg0:setAlpha(0.77)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
					end
					f26_arg0:beginAnimation(20)
					f26_arg0:setAlpha(0.59)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f24_arg0.SprintMeter:beginAnimation(60)
				f24_arg0.SprintMeter:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.SprintMeter:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.SprintMeter:completeAnimation()
			f24_arg0.SprintMeter:setAlpha(1)
			f24_local0(f24_arg0.SprintMeter)
			local f24_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							local f35_local0 = function(f36_arg0)
								f36_arg0:beginAnimation(120)
								f36_arg0:setAlpha(0)
								f36_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
							end
							f35_arg0:beginAnimation(80)
							f35_arg0:setAlpha(0.14)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
						end
						f34_arg0:beginAnimation(20)
						f34_arg0:setAlpha(0.56)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(20)
					f33_arg0:setAlpha(0.5)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f24_arg0.Icon:beginAnimation(60)
				f24_arg0.Icon:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Icon:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f24_arg0.Icon:completeAnimation()
			f24_arg0.Icon:setAlpha(1)
			f24_local1(f24_arg0.Icon)
		end,
		FullEnergy = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			local f37_local0 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						local f40_local0 = function(f41_arg0)
							local f41_local0 = function(f42_arg0)
								local f42_local0 = function(f43_arg0)
									local f43_local0 = function(f44_arg0)
										local f44_local0 = function(f45_arg0)
											f45_arg0:beginAnimation(89)
											f45_arg0:setAlpha(0)
											f45_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
										end
										f44_arg0:beginAnimation(30)
										f44_arg0:setAlpha(0.5)
										f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
									end
									f43_arg0:beginAnimation(19)
									f43_arg0:setAlpha(0.54)
									f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
								end
								f42_arg0:beginAnimation(60)
								f42_arg0:setAlpha(0.63)
								f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
							end
							f41_arg0:beginAnimation(20)
							f41_arg0:setAlpha(0.77)
							f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
						end
						f40_arg0:beginAnimation(19)
						f40_arg0:setAlpha(0.59)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
					end
					f39_arg0:beginAnimation(60)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f37_arg0.SprintMeter:beginAnimation(700)
				f37_arg0.SprintMeter:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.SprintMeter:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f37_arg0.SprintMeter:completeAnimation()
			f37_arg0.SprintMeter:setAlpha(1)
			f37_local0(f37_arg0.SprintMeter)
			local f37_local1 = function(f46_arg0)
				local f46_local0 = function(f47_arg0)
					f47_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
					f47_arg0:setAlpha(0)
					f47_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
				end
				f37_arg0.Icon:beginAnimation(700)
				f37_arg0.Icon:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Icon:registerEventHandler("transition_complete_keyframe", f46_local0)
			end
			f37_arg0.Icon:completeAnimation()
			f37_arg0.Icon:setAlpha(1)
			f37_local1(f37_arg0.Icon)
		end,
		NoEnergy = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
			local f48_local0 = function(f49_arg0)
				f48_arg0.SprintMeter:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f48_arg0.SprintMeter:setAlpha(0)
				f48_arg0.SprintMeter:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.SprintMeter:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.SprintMeter:completeAnimation()
			f48_arg0.SprintMeter:setAlpha(1)
			f48_local0(f48_arg0.SprintMeter)
			local f48_local1 = function(f50_arg0)
				f48_arg0.Icon:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f48_arg0.Icon:setAlpha(0)
				f48_arg0.Icon:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.Icon:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.Icon:completeAnimation()
			f48_arg0.Icon:setAlpha(1)
			f48_local1(f48_arg0.Icon)
		end,
	},
	Hidden = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(2)
			f51_arg0.SprintMeter:completeAnimation()
			f51_arg0.SprintMeter:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.SprintMeter)
			f51_arg0.Icon:completeAnimation()
			f51_arg0.Icon:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.Icon)
		end,
		DefaultState = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(2)
			local f52_local0 = function(f53_arg0)
				f52_arg0.SprintMeter:beginAnimation(80, Enum[@"luitween"][@"luitween_bounce"])
				f52_arg0.SprintMeter:setAlpha(1)
				f52_arg0.SprintMeter:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.SprintMeter:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.SprintMeter:completeAnimation()
			f52_arg0.SprintMeter:setAlpha(0)
			f52_local0(f52_arg0.SprintMeter)
			local f52_local1 = function(f54_arg0)
				f52_arg0.Icon:beginAnimation(80)
				f52_arg0.Icon:setAlpha(1)
				f52_arg0.Icon:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.Icon:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.Icon:completeAnimation()
			f52_arg0.Icon:setAlpha(0)
			f52_local1(f52_arg0.Icon)
		end,
	},
	HideForDvar = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(2)
			f55_arg0.SprintMeter:completeAnimation()
			f55_arg0.SprintMeter:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.SprintMeter)
			f55_arg0.Icon:completeAnimation()
			f55_arg0.Icon:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Icon)
		end,
		DefaultState = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(2)
			local f56_local0 = function(f57_arg0)
				f56_arg0.SprintMeter:beginAnimation(80, Enum[@"luitween"][@"luitween_bounce"])
				f56_arg0.SprintMeter:setAlpha(1)
				f56_arg0.SprintMeter:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.SprintMeter:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.SprintMeter:completeAnimation()
			f56_arg0.SprintMeter:setAlpha(0)
			f56_local0(f56_arg0.SprintMeter)
			local f56_local1 = function(f58_arg0)
				f56_arg0.Icon:beginAnimation(80)
				f56_arg0.Icon:setAlpha(1)
				f56_arg0.Icon:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.Icon:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.Icon:completeAnimation()
			f56_arg0.Icon:setAlpha(0)
			f56_local1(f56_arg0.Icon)
		end,
	},
	FullEnergy = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(2)
			f59_arg0.SprintMeter:completeAnimation()
			f59_arg0.SprintMeter:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.SprintMeter)
			f59_arg0.Icon:completeAnimation()
			f59_arg0.Icon:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.Icon)
		end,
	},
	NoEnergy = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(2)
			f60_arg0.SprintMeter:completeAnimation()
			f60_arg0.SprintMeter:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.SprintMeter)
			f60_arg0.Icon:completeAnimation()
			f60_arg0.Icon:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.Icon)
		end,
		DefaultState = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(2)
			local f61_local0 = function(f62_arg0)
				f61_arg0.SprintMeter:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f61_arg0.SprintMeter:setAlpha(1)
				f61_arg0.SprintMeter:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.SprintMeter:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.SprintMeter:completeAnimation()
			f61_arg0.SprintMeter:setAlpha(0)
			f61_local0(f61_arg0.SprintMeter)
			local f61_local1 = function(f63_arg0)
				f61_arg0.Icon:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f61_arg0.Icon:setAlpha(1)
				f61_arg0.Icon:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.Icon:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.Icon:completeAnimation()
			f61_arg0.Icon:setAlpha(0)
			f61_local1(f61_arg0.Icon)
		end,
	},
}
CoD.SprintMeterContainer.__onClose = function(f64_arg0)
	f64_arg0.SprintMeter:close()
end
