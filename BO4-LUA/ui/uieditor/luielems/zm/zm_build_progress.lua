CoD.zm_build_progress = InheritFrom(CoD.Menu)
LUI.createMenu.zm_build_progress = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_build_progress", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_build_progress)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0.5, 0.5, -140, 140, 0.5, 0.5, -150, -130)
	backing:setRGB(0, 0, 0)
	backing:setAlpha(0.6)
	self:addElement(backing)
	self.backing = backing
	local fill = LUI.UIImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -150, -130)
	fill:setImage(RegisterImage(@"uie_progress_bar_background"))
	fill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	fill:setShaderVector(1, 0, 0, 0, 0)
	fill:setShaderVector(2, 1, 0, 0, 0)
	fill:setShaderVector(3, 0, 0, 0, 0)
	fill:setShaderVector(4, 0, 0, 0, 0)
	fill:linkToElementModel(self, "progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			fill:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(fill)
	self.fill = fill
	local text = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, -192.5, -155.5)
	text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"zombie/building"))
	text:setTTF("default")
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(text)
	self.text = text
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f3_local0 then
					f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f3_local0 then
						f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						if not f3_local0 then
							f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							if not f3_local0 then
								if Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
									f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
									if not f3_local0 then
										f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
										if not f3_local0 then
											f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
											if not f3_local0 then
												f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
												if not f3_local0 then
													f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
													if not f3_local0 then
														f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
														if not f3_local0 then
															f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
															if not f3_local0 then
																f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
																if not f3_local0 then
																	f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
																	if not f3_local0 then
																		f3_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_ui_active"])
																		if not f3_local0 then
																			f3_local0 = not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
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
									f3_local0 = true
								end
							end
						end
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f4_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.zm_build_progress.__resetProperties = function(f20_arg0)
	f20_arg0.text:completeAnimation()
	f20_arg0.fill:completeAnimation()
	f20_arg0.backing:completeAnimation()
	f20_arg0.text:setAlpha(1)
	f20_arg0.fill:setAlpha(1)
	f20_arg0.backing:setAlpha(0.6)
end
CoD.zm_build_progress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.backing:completeAnimation()
			f22_arg0.backing:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.backing)
			f22_arg0.fill:completeAnimation()
			f22_arg0.fill:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.fill)
			f22_arg0.text:completeAnimation()
			f22_arg0.text:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.text)
		end,
	},
}
CoD.zm_build_progress.__onClose = function(f23_arg0)
	f23_arg0.fill:close()
end
