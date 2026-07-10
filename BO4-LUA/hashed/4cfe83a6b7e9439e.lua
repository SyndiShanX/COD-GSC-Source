require("x64:6ec0690014b8ff0")
require("x64:1f3dba742640cfa")
require("x64:98de092f5b8db48")
require("x64:c373b5a993aef46")
require("x64:e7c33fa6fce93e4")
require("x64:94e166fa0d10785")
CoD.HealthInfoZM = InheritFrom(LUI.UIElement)
CoD.HealthInfoZM.__defaultWidth = 238
CoD.HealthInfoZM.__defaultHeight = 112
CoD.HealthInfoZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthInfoZM)
	self.id = "HealthInfoZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArmorPortrait = CoD.ArmorPortraitZM.new(f1_arg0, f1_arg1, 0, 0, 264, 314, 0, 0, 11.5, 61.5)
	ArmorPortrait:linkToElementModel(self, nil, false, function(model)
		ArmorPortrait:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorPortrait)
	self.ArmorPortrait = ArmorPortrait
	local HealCooldown = CoD.HealCooldown.new(f1_arg0, f1_arg1, 0, 0, 107, 179, 0, 0, 35, 75)
	HealCooldown:setAlpha(0)
	HealCooldown:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget1", function(model)
		HealCooldown:setModel(model, f1_arg1)
	end)
	self:addElement(HealCooldown)
	self.HealCooldown = HealCooldown
	local ArmorBar = CoD.ArmorBarZM.new(f1_arg0, f1_arg1, 0, 0, 132, 266, 0, 0, 25.5, 29.5)
	ArmorBar:linkToElementModel(self, nil, false, function(model)
		ArmorBar:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorBar)
	self.ArmorBar = ArmorBar
	local HealthBar = CoD.HealthBarWidgetZM.new(f1_arg0, f1_arg1, 0, 0, 123, 275, 0, 0, 32.5, 43.5)
	HealthBar:setScale(0.9, 0.9)
	HealthBar:linkToElementModel(self, "health", false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local HealthValue = LUI.UIText.new(0, 0, 64, 128, 0, 0, 30, 50)
	HealthValue:setTTF("skorzhen")
	HealthValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	HealthValue:setShaderVector(0, 0.8, 0, 0, 0)
	HealthValue:setShaderVector(1, 0, 0, 0, 0)
	HealthValue:setShaderVector(2, 1, 1, 1, 0.55)
	HealthValue:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	HealthValue:setLetterSpacing(2)
	HealthValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	HealthValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	HealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HealthValue:setText(CoD.BaseUtility.AlreadyLocalized(f6_local0))
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	local GlowBlueOver = LUI.UIImage.new(0, 0, 86, 134, 0, 0, 14.5, 282.5)
	GlowBlueOver:setAlpha(0)
	GlowBlueOver:setZRot(90)
	GlowBlueOver:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	GlowBlueOver:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowBlueOver)
	self.GlowBlueOver = GlowBlueOver
	local HealthDOT = CoD.HealthDOT.new(f1_arg0, f1_arg1, 0, 0, 267, 367, 0, 0, 66, 94)
	HealthDOT:setAlpha(0)
	self:addElement(HealthDOT)
	self.HealthDOT = HealthDOT
	local HealthBoostNotificationContainer = CoD.HealthBoostNotificationContainer.new(f1_arg0, f1_arg1, 0, 0, 67, 131, 0, 0, 30, 50)
	self:addElement(HealthBoostNotificationContainer)
	self.HealthBoostNotificationContainer = HealthBoostNotificationContainer
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dead")
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f8_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
				if f8_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
					then
						f8_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				local f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f9_local0 then
					f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f9_local0 then
						f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						if not f9_local0 then
							f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							if not f9_local0 then
								if Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
									f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
									if not f9_local0 then
										f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
										if not f9_local0 then
											f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
											if not f9_local0 then
												f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
												if not f9_local0 then
													f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
													if not f9_local0 then
														f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
														if not f9_local0 then
															f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
															if not f9_local0 then
																f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
																if not f9_local0 then
																	f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
																	if not f9_local0 then
																		f9_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
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
									f9_local0 = true
								end
							end
						end
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "LowHealth",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsCharacterInCriticalState(self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "dead", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dead",
		})
	end)
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	if IsMultiplayer() then
		CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
		CoD.HealthUtility.InitHealthBarLossPulse(self, self.HealthBar, f1_arg1, CoD.HealthBarWidgetPulse, f1_arg0)
	elseif IsZombies() then
		CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
		CoD.HealthUtility.InitHealthBarLossPulse(self, self.HealthBar, f1_arg1, CoD.HealthBarWidgetPulse, f1_arg0)
	else
		CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
	end
	f1_local10 = HealthBoostNotificationContainer
	if IsMultiplayer() then
		CoD.HUDUtility.InitHealthBoostNotification(self, f1_local10, f1_arg1, f1_arg0, CoD.HealthBoostNotification)
	end
	return self
end
CoD.HealthInfoZM.__resetProperties = function(f28_arg0)
	f28_arg0.HealthValue:completeAnimation()
	f28_arg0.GlowBlueOver:completeAnimation()
	f28_arg0.HealthDOT:completeAnimation()
	f28_arg0.HealthBar:completeAnimation()
	f28_arg0.ArmorPortrait:completeAnimation()
	f28_arg0.HealthBoostNotificationContainer:completeAnimation()
	f28_arg0.ArmorBar:completeAnimation()
	f28_arg0.HealCooldown:completeAnimation()
	f28_arg0.HealthValue:setRGB(1, 1, 1)
	f28_arg0.HealthValue:setAlpha(1)
	f28_arg0.HealthValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	f28_arg0.HealthValue:setShaderVector(0, 0.8, 0, 0, 0)
	f28_arg0.HealthValue:setShaderVector(1, 0, 0, 0, 0)
	f28_arg0.HealthValue:setShaderVector(2, 1, 1, 1, 0.55)
	f28_arg0.HealthValue:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	f28_arg0.HealthValue:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f28_arg0.HealthValue:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	f28_arg0.GlowBlueOver:setAlpha(0)
	f28_arg0.HealthDOT:setAlpha(0)
	f28_arg0.HealthBar:setAlpha(1)
	f28_arg0.ArmorPortrait:setAlpha(1)
	f28_arg0.HealthBoostNotificationContainer:setAlpha(1)
	f28_arg0.ArmorBar:setAlpha(1)
	f28_arg0.HealCooldown:setAlpha(0)
end
CoD.HealthInfoZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(7)
			f30_arg0.ArmorPortrait:completeAnimation()
			f30_arg0.ArmorPortrait:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ArmorPortrait)
			f30_arg0.ArmorBar:completeAnimation()
			f30_arg0.ArmorBar:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ArmorBar)
			f30_arg0.HealthBar:completeAnimation()
			f30_arg0.HealthBar:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.HealthBar)
			f30_arg0.HealthValue:completeAnimation()
			f30_arg0.HealthValue:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.HealthValue)
			f30_arg0.GlowBlueOver:completeAnimation()
			f30_arg0.GlowBlueOver:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.GlowBlueOver)
			f30_arg0.HealthDOT:completeAnimation()
			f30_arg0.HealthDOT:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.HealthDOT)
			f30_arg0.HealthBoostNotificationContainer:completeAnimation()
			f30_arg0.HealthBoostNotificationContainer:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.HealthBoostNotificationContainer)
		end,
	},
	Visible = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(4)
			f32_arg0.ArmorBar:completeAnimation()
			f32_arg0.ArmorBar:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ArmorBar)
			f32_arg0.HealthValue:completeAnimation()
			f32_arg0.HealthValue:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.HealthValue)
			f32_arg0.GlowBlueOver:completeAnimation()
			f32_arg0.GlowBlueOver:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.GlowBlueOver)
			f32_arg0.HealthDOT:completeAnimation()
			f32_arg0.HealthDOT:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.HealthDOT)
		end,
	},
	LowHealth = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.HealCooldown:completeAnimation()
			f33_arg0.HealCooldown:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.HealCooldown)
			local f33_local0 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						local f36_local0 = function(f37_arg0)
							f37_arg0:beginAnimation(350)
							f37_arg0:setRGB(1, 0.42, 0.42)
							f37_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
						end
						f36_arg0:beginAnimation(440)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
					end
					f35_arg0:beginAnimation(460)
					f35_arg0:setRGB(1, 0, 0)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f33_arg0.HealthValue:beginAnimation(330)
				f33_arg0.HealthValue:setRGB(1, 0.42, 0.42)
				f33_arg0.HealthValue:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.HealthValue:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f33_arg0.HealthValue:completeAnimation()
			f33_arg0.HealthValue:setRGB(1, 0.04, 0.04)
			f33_arg0.HealthValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
			f33_arg0.HealthValue:setShaderVector(0, 0.8, 0, 0, 0)
			f33_arg0.HealthValue:setShaderVector(1, 0, 0, 0, 0)
			f33_arg0.HealthValue:setShaderVector(2, 1, 0, 0, 0.55)
			f33_arg0.HealthValue:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f33_arg0.HealthValue:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f33_arg0.HealthValue:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
			f33_local0(f33_arg0.HealthValue)
			f33_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.HealthInfoZM.__onClose = function(f38_arg0)
	f38_arg0.ArmorPortrait:close()
	f38_arg0.HealCooldown:close()
	f38_arg0.ArmorBar:close()
	f38_arg0.HealthBar:close()
	f38_arg0.HealthValue:close()
	f38_arg0.HealthDOT:close()
	f38_arg0.HealthBoostNotificationContainer:close()
end
