require("x64:e201e7e41431aa7")
CoD.ContextNotification_SpecialistWeaponHintList = InheritFrom(LUI.UIElement)
CoD.ContextNotification_SpecialistWeaponHintList.__defaultWidth = 300
CoD.ContextNotification_SpecialistWeaponHintList.__defaultHeight = 30
CoD.ContextNotification_SpecialistWeaponHintList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContextNotification_SpecialistWeaponHintList)
	self.id = "ContextNotification_SpecialistWeaponHintList"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NotificationTextCenter = LUI.UIText.new(0, 0, 0, 300, 0, 0, 0, 30)
	NotificationTextCenter:setTTF("ttmussels_regular")
	NotificationTextCenter:setLetterSpacing(1)
	NotificationTextCenter:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NotificationTextCenter:setBackingType(1)
	NotificationTextCenter:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationTextCenter:setBackingColor(0, 0, 0)
	NotificationTextCenter:setBackingAlpha(0.62)
	NotificationTextCenter:setBackingXPadding(12)
	NotificationTextCenter:subscribeToGlobalModel(f1_arg1, "HUDItems", "abilityHintIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NotificationTextCenter:setText(CoD.HUDUtility.GetSpecialistWeaponHintStringLower(1, f2_local0))
		end
	end)
	self:addElement(NotificationTextCenter)
	self.NotificationTextCenter = NotificationTextCenter
	local NotificationTextLeft = LUI.UIText.new(0, 0, -170, 130, 0, 0, 0, 30)
	NotificationTextLeft:setAlpha(0)
	NotificationTextLeft:setTTF("ttmussels_regular")
	NotificationTextLeft:setLetterSpacing(1)
	NotificationTextLeft:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	NotificationTextLeft:setBackingType(1)
	NotificationTextLeft:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationTextLeft:setBackingColor(0, 0, 0)
	NotificationTextLeft:setBackingAlpha(0.62)
	NotificationTextLeft:setBackingXPadding(12)
	NotificationTextLeft:subscribeToGlobalModel(f1_arg1, "HUDItems", "abilityHintIndex", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			NotificationTextLeft:setText(CoD.HUDUtility.GetSpecialistWeaponHintStringLower(1, f3_local0))
		end
	end)
	self:addElement(NotificationTextLeft)
	self.NotificationTextLeft = NotificationTextLeft
	local NotificationTextRight = LUI.UIText.new(0, 0, 170, 470, 0, 0, 0, 30)
	NotificationTextRight:setAlpha(0)
	NotificationTextRight:setTTF("ttmussels_regular")
	NotificationTextRight:setLetterSpacing(1)
	NotificationTextRight:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NotificationTextRight:setBackingType(1)
	NotificationTextRight:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationTextRight:setBackingColor(0, 0, 0)
	NotificationTextRight:setBackingAlpha(0.62)
	NotificationTextRight:setBackingXPadding(12)
	NotificationTextRight:subscribeToGlobalModel(f1_arg1, "HUDItems", "abilityHintIndex", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NotificationTextRight:setText(CoD.HUDUtility.GetSpecialistWeaponHintStringLower(2, f4_local0))
		end
	end)
	self:addElement(NotificationTextRight)
	self.NotificationTextRight = NotificationTextRight
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f5_local0 then
					f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f5_local0 then
						f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						if not f5_local0 then
							f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							if not f5_local0 then
								if Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
									f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
									if not f5_local0 then
										f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
										if not f5_local0 then
											f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
											if not f5_local0 then
												f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
												if not f5_local0 then
													f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
													if not f5_local0 then
														f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
														if not f5_local0 then
															f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
															if not f5_local0 then
																f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
																if not f5_local0 then
																	f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
																	if not f5_local0 then
																		f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
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
									f5_local0 = true
								end
							end
						end
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "TwoEntries",
			condition = function(menu, element, event)
				return CoD.HUDUtility.SpecialistWeaponHintStringLowerNumElements(f1_arg1, 2)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.abilityHintIndex, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "abilityHintIndex",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContextNotification_SpecialistWeaponHintList.__resetProperties = function(f23_arg0)
	f23_arg0.NotificationTextCenter:completeAnimation()
	f23_arg0.NotificationTextLeft:completeAnimation()
	f23_arg0.NotificationTextRight:completeAnimation()
	f23_arg0.NotificationTextCenter:setAlpha(1)
	f23_arg0.NotificationTextLeft:setAlpha(0)
	f23_arg0.NotificationTextRight:setAlpha(0)
end
CoD.ContextNotification_SpecialistWeaponHintList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.NotificationTextCenter:completeAnimation()
			f25_arg0.NotificationTextCenter:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.NotificationTextCenter)
			f25_arg0.NotificationTextLeft:completeAnimation()
			f25_arg0.NotificationTextLeft:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.NotificationTextLeft)
			f25_arg0.NotificationTextRight:completeAnimation()
			f25_arg0.NotificationTextRight:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.NotificationTextRight)
		end,
	},
	TwoEntries = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.NotificationTextCenter:completeAnimation()
			f26_arg0.NotificationTextCenter:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.NotificationTextCenter)
			f26_arg0.NotificationTextLeft:completeAnimation()
			f26_arg0.NotificationTextLeft:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.NotificationTextLeft)
			f26_arg0.NotificationTextRight:completeAnimation()
			f26_arg0.NotificationTextRight:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.NotificationTextRight)
		end,
	},
}
CoD.ContextNotification_SpecialistWeaponHintList.__onClose = function(f27_arg0)
	f27_arg0.NotificationTextCenter:close()
	f27_arg0.NotificationTextLeft:close()
	f27_arg0.NotificationTextRight:close()
end
