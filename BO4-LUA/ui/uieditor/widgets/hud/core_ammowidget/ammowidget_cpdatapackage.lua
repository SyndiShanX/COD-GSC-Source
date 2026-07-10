CoD.AmmoWidget_CPDataPackage = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_CPDataPackage.__defaultWidth = 105
CoD.AmmoWidget_CPDataPackage.__defaultHeight = 105
CoD.AmmoWidget_CPDataPackage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_CPDataPackage)
	self.id = "AmmoWidget_CPDataPackage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PanelGlow = LUI.UIImage.new(0, 0, -12, 125, 0, 0, -13, 126)
	PanelGlow:setRGB(0.3, 0.65, 0.82)
	PanelGlow:setAlpha(0.41)
	PanelGlow:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	PanelGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PanelGlow)
	self.PanelGlow = PanelGlow
	local SDBomb = LUI.UIImage.new(0, 0, 0, 105, 0, 0, 0, 105)
	SDBomb:setScale(0.8, 0.8)
	SDBomb:setImage(RegisterImage(@"uie_t7_hud_widget_sd_bomb"))
	self:addElement(SDBomb)
	self.SDBomb = SDBomb
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				local f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f2_local0 then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f2_local0 then
						f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						if not f2_local0 then
							f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							if not f2_local0 then
								if Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
									f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
									if not f2_local0 then
										f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
										if not f2_local0 then
											f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
											if not f2_local0 then
												f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
												if not f2_local0 then
													f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
													if not f2_local0 then
														f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
														if not f2_local0 then
															f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
															if not f2_local0 then
																f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
																if not f2_local0 then
																	f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
																	if not f2_local0 then
																		f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
																		if not f2_local0 then
																			f2_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
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
							end
						end
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return AmICarryingBriefcase(f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.CPGamePlayBundleData.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.briefcaseClient, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "briefcaseClient",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_CPDataPackage.__resetProperties = function(f21_arg0)
	f21_arg0.SDBomb:completeAnimation()
	f21_arg0.PanelGlow:completeAnimation()
	f21_arg0.SDBomb:setAlpha(1)
	f21_arg0.PanelGlow:setAlpha(0.41)
end
CoD.AmmoWidget_CPDataPackage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.PanelGlow:completeAnimation()
			f22_arg0.PanelGlow:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.PanelGlow)
			f22_arg0.SDBomb:completeAnimation()
			f22_arg0.SDBomb:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.SDBomb)
		end,
	},
	Hide = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.PanelGlow:completeAnimation()
			f23_arg0.PanelGlow:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PanelGlow)
			f23_arg0.SDBomb:completeAnimation()
			f23_arg0.SDBomb:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SDBomb)
		end,
	},
	Show = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						local f27_local0 = function(f28_arg0)
							f28_arg0:beginAnimation(339)
							f28_arg0:setAlpha(1)
							f28_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
						end
						f27_arg0:beginAnimation(310)
						f27_arg0:setAlpha(0.65)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
					end
					f26_arg0:beginAnimation(380)
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f24_arg0.SDBomb:beginAnimation(380)
				f24_arg0.SDBomb:setAlpha(0.65)
				f24_arg0.SDBomb:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.SDBomb:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.SDBomb:completeAnimation()
			f24_arg0.SDBomb:setAlpha(1)
			f24_local0(f24_arg0.SDBomb)
		end,
	},
}
