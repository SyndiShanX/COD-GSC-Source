require("x64:dad384961396711")
CoD.zm_trial_timer = InheritFrom(CoD.Menu)
LUI.createMenu.zm_trial_timer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_trial_timer", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_trial_timer)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Timer = CoD.TrialTimer.new(f1_local1, f1_arg0, 0.5, 0.5, -124, 124, 0.5, 0.5, 125.5, 263.5)
	Timer:mergeStateConditions({
		{
			stateName = "CenteredTimerText",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "DefaultState")
			end,
		},
	})
	Timer:subscribeToGlobalModel(f1_arg0, "ZMHud", "trialsTimer", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Timer.Timer:setupEndTimer(f3_local0)
		end
	end)
	Timer:linkToElementModel(self, "timer_text", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Timer.TimerText2:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	Timer:linkToElementModel(self, "timer_text", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Timer.TimerText:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f6_local0 then
					f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f6_local0 then
						f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						if not f6_local0 then
							f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
							if not f6_local0 then
								f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_game_ended"])
								if not f6_local0 then
									f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
									if not f6_local0 then
										f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
										if not f6_local0 then
											f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
											if not f6_local0 then
												f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
												if not f6_local0 then
													f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
													if not f6_local0 then
														f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
														if not f6_local0 then
															f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
															if not f6_local0 then
																f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_player_dead"])
																if not f6_local0 then
																	f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_popups_visible"])
																	if not f6_local0 then
																		f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
																		if not f6_local0 then
																			f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_stage_ended"])
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
						end
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "LastStand",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "ZMHud.lastStand", 1)
			end,
		},
		{
			stateName = "Spectating",
			condition = function(menu, element, event)
				return IsVisibilityBitSet(f1_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
			end,
		},
		{
			stateName = "TimerUnderScoreboard",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrZero(self, f1_arg0, "under_round_rules")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f21_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f22_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_popups_visible"]], function(f23_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_popups_visible"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f24_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_stage_ended"]], function(f25_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_stage_ended"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["ZMHud.lastStand"], function(f26_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f26_arg0:get(),
			modelName = "ZMHud.lastStand",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f27_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	self:linkToElementModel(self, "under_round_rules", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "under_round_rules",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f29_arg2, f29_arg3, f29_arg4)
		UpdateElementState(self, "Timer", controller)
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local4 = self
	SizeToSafeArea(self, f1_arg0)
	return self
end
CoD.zm_trial_timer.__resetProperties = function(f30_arg0)
	f30_arg0.Timer:completeAnimation()
	f30_arg0.Timer:setLeftRight(0.5, 0.5, -124, 124)
	f30_arg0.Timer:setTopBottom(0.5, 0.5, 125.5, 263.5)
	f30_arg0.Timer:setAlpha(1)
end
CoD.zm_trial_timer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.Timer:completeAnimation()
			f32_arg0.Timer:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Timer)
		end,
	},
	LastStand = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.Timer:completeAnimation()
			f33_arg0.Timer:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Timer)
		end,
	},
	Spectating = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.Timer:completeAnimation()
			f34_arg0.Timer:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Timer)
		end,
	},
	TimerUnderScoreboard = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.Timer:completeAnimation()
			f35_arg0.Timer:setLeftRight(0, 0, 29, 277)
			f35_arg0.Timer:setTopBottom(0, 0, 275, 413)
			f35_arg0.clipFinished(f35_arg0.Timer)
		end,
	},
}
CoD.zm_trial_timer.__onClose = function(f36_arg0)
	f36_arg0.Timer:close()
end
