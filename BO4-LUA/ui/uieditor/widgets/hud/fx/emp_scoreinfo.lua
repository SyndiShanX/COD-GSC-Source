CoD.EMP_ScoreInfo = InheritFrom(LUI.UIElement)
CoD.EMP_ScoreInfo.__defaultWidth = 511
CoD.EMP_ScoreInfo.__defaultHeight = 256
CoD.EMP_ScoreInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EMP_ScoreInfo)
	self.id = "EMP_ScoreInfo"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EMPbacker = LUI.UIImage.new(0, 0, 0.5, 332.5, 0, 0, -2.5, 85.5)
	EMPbacker:setRGB(0, 0, 0)
	EMPbacker:setAlpha(0)
	EMPbacker:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_player"))
	self:addElement(EMPbacker)
	self.EMPbacker = EMPbacker
	local EMPScoreInfoBlackOps = LUI.UIImage.new(0, 0, 0, 332, 1, 1, -256, -168)
	EMPScoreInfoBlackOps:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_player"))
	EMPScoreInfoBlackOps:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_emp"))
	EMPScoreInfoBlackOps:setShaderVector(0, 26, 0, 0, 0)
	EMPScoreInfoBlackOps:setShaderVector(1, 1, 0, 0, 0)
	EMPScoreInfoBlackOps:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(EMPScoreInfoBlackOps)
	self.EMPScoreInfoBlackOps = EMPScoreInfoBlackOps
	local EMPScoreInfoCDP = LUI.UIImage.new(0, 0, 0, 332, 1, 1, -256, -168)
	EMPScoreInfoCDP:setAlpha(0)
	EMPScoreInfoCDP:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_player"))
	EMPScoreInfoCDP:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_emp"))
	EMPScoreInfoCDP:setShaderVector(0, 26, 0, 0, 0)
	EMPScoreInfoCDP:setShaderVector(1, 1, 0, 0, 0)
	EMPScoreInfoCDP:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(EMPScoreInfoCDP)
	self.EMPScoreInfoCDP = EMPScoreInfoCDP
	self:mergeStateConditions({
		{
			stateName = "HideForVisibilityBits",
			condition = function(menu, element, event)
				local f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f2_local0 then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f2_local0 then
						if Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"]) then
							f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
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
													f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
													if not f2_local0 then
														f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
														if not f2_local0 then
															f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_location"])
															if not f2_local0 then
																f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
																if not f2_local0 then
																	f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
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
								else
									return f2_local0
								end
							else
								return f2_local0
							end
						end
						f2_local0 = true
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.CodCasterEnabledAndProfileVarEqualTo(f1_arg1, "shoutcaster_ds_teamscore", false)
			end,
		},
		{
			stateName = "axis",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "factions.playerFactionName", "axis")
			end,
		},
		{
			stateName = "allies",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "factions.playerFactionName", "allies")
			end,
		},
		{
			stateName = "emblem",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "factions.playerFactionName", "free")
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
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
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
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_location"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_location"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["factions.playerFactionName"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "factions.playerFactionName",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EMP_ScoreInfo.__resetProperties = function(f22_arg0)
	f22_arg0.EMPScoreInfoBlackOps:completeAnimation()
	f22_arg0.EMPScoreInfoCDP:completeAnimation()
	f22_arg0.EMPbacker:completeAnimation()
	f22_arg0.EMPScoreInfoBlackOps:setAlpha(1)
	f22_arg0.EMPScoreInfoCDP:setAlpha(0)
	f22_arg0.EMPbacker:setAlpha(0)
end
CoD.EMP_ScoreInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.EMPScoreInfoBlackOps:completeAnimation()
			f23_arg0.EMPScoreInfoBlackOps:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.EMPScoreInfoBlackOps)
			f23_arg0.EMPScoreInfoCDP:completeAnimation()
			f23_arg0.EMPScoreInfoCDP:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.EMPScoreInfoCDP)
		end,
	},
	HideForVisibilityBits = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.EMPScoreInfoBlackOps:completeAnimation()
			f24_arg0.EMPScoreInfoBlackOps:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.EMPScoreInfoBlackOps)
			f24_arg0.EMPScoreInfoCDP:completeAnimation()
			f24_arg0.EMPScoreInfoCDP:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.EMPScoreInfoCDP)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.EMPScoreInfoBlackOps:completeAnimation()
			f25_arg0.EMPScoreInfoBlackOps:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.EMPScoreInfoBlackOps)
		end,
	},
	axis = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.EMPbacker:completeAnimation()
			f26_arg0.EMPbacker:setAlpha(0.9)
			f26_arg0.clipFinished(f26_arg0.EMPbacker)
			f26_arg0.EMPScoreInfoBlackOps:completeAnimation()
			f26_arg0.EMPScoreInfoBlackOps:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.EMPScoreInfoBlackOps)
			f26_arg0.EMPScoreInfoCDP:completeAnimation()
			f26_arg0.EMPScoreInfoCDP:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.EMPScoreInfoCDP)
		end,
	},
	allies = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.EMPbacker:completeAnimation()
			f27_arg0.EMPbacker:setAlpha(0.9)
			f27_arg0.clipFinished(f27_arg0.EMPbacker)
		end,
	},
	emblem = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.EMPbacker:completeAnimation()
			f28_arg0.EMPbacker:setAlpha(0.9)
			f28_arg0.clipFinished(f28_arg0.EMPbacker)
		end,
	},
}
