require("x64:dddc350afc94b48")
require("x64:ad2dd10539beaf7")
CoD.zm_laststand_client = InheritFrom(CoD.Menu)
LUI.createMenu.zm_laststand_client = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_laststand_client", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_laststand_client)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local DecorativeBGAnim = CoD.Hud_ZM_LastStand_DecorativeBGInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -88, 88, 1, 1, -413, -237)
	DecorativeBGAnim:setRGB(0, 0, 0)
	self:addElement(DecorativeBGAnim)
	self.DecorativeBGAnim = DecorativeBGAnim
	local bleedout_clock = LUI.UIImage.new(0.5, 0.5, -128, 0, 1, 1, -268.5, -140.5)
	bleedout_clock:setRGB(1, 0, 0)
	bleedout_clock:setAlpha(0.9)
	bleedout_clock:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	bleedout_clock:setShaderVector(0, -0.03, 0, 0, 0)
	bleedout_clock:setShaderVector(1, 0.5, 0, 0, 0)
	bleedout_clock:setShaderVector(2, 0.5, 0, 0, 0)
	bleedout_clock:setShaderVector(3, 0.18, 0, 0, 0)
	bleedout_clock:setShaderVector(4, 4, 0.04, 0, 0)
	self:addElement(bleedout_clock)
	self.bleedout_clock = bleedout_clock
	local revive_clock = LUI.UIImage.new(0.5, 0.5, 0, 136, 1, 1, -268.5, -140.5)
	revive_clock:setRGB(0.12, 1, 0)
	revive_clock:setYRot(180)
	revive_clock:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	revive_clock:setShaderVector(0, -0.21, 0, 0, 0)
	revive_clock:setShaderVector(1, 0.5, 0, 0, 0)
	revive_clock:setShaderVector(2, 0.5, 0, 0, 0)
	revive_clock:setShaderVector(3, 0, 0, 0, 0)
	revive_clock:setShaderVector(4, 0, 0.06, 0, 0)
	self:addElement(revive_clock)
	self.revive_clock = revive_clock
	local bleedout_label = LUI.UIText.new(0.5, 0.5, -100, 100, 1, 1, -370.5, -340.5)
	bleedout_label:setRGB(ColorSet.T8_ZM_BLUE.r, ColorSet.T8_ZM_BLUE.g, ColorSet.T8_ZM_BLUE.b)
	bleedout_label:setTTF("skorzhen")
	bleedout_label:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	bleedout_label:linkToElementModel(self, "num_downs", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			bleedout_label:setText(CoD.ZombieUtility.GetNumDownsText(f2_local0))
		end
	end)
	self:addElement(bleedout_label)
	self.bleedout_label = bleedout_label
	local ReviveBarBG2 = LUI.UIImage.new(0.5, 0.5, -148, 148, 1, 1, -320, -292)
	ReviveBarBG2:setAlpha(0)
	ReviveBarBG2:setYRot(180)
	ReviveBarBG2:setScale(0.81, 0.6)
	ReviveBarBG2:setImage(RegisterImage(@"uie_zm_hud_revive_meterbg"))
	self:addElement(ReviveBarBG2)
	self.ReviveBarBG2 = ReviveBarBG2
	local revive_bar = LUI.UIImage.new(0.5, 0.5, -148, 148, 1, 1, -320, -292)
	revive_bar:setAlpha(0)
	revive_bar:setScale(0.8, 0.6)
	revive_bar:setImage(RegisterImage(@"uie_zm_hud_revive_meterfg"))
	revive_bar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	revive_bar:setShaderVector(1, 0, 0, 0, 0)
	revive_bar:setShaderVector(2, 1, 0, 0, 0)
	revive_bar:setShaderVector(3, 0, 0, 0, 0)
	revive_bar:setShaderVector(4, 0, 0, 0, 0)
	revive_bar:linkToElementModel(self, "revive_progress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			revive_bar:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(revive_bar)
	self.revive_bar = revive_bar
	local ReviveBarBG = LUI.UIImage.new(0.5, 0.5, -148, 148, 1, 1, -340, -312)
	ReviveBarBG:setImage(RegisterImage(@"uie_zm_hud_revive_meterbg"))
	self:addElement(ReviveBarBG)
	self.ReviveBarBG = ReviveBarBG
	local bleedout_bar = LUI.UIImage.new(0.5, 0.5, -148, 148, 1, 1, -340, -312)
	bleedout_bar:setImage(RegisterImage(@"uie_zm_hud_bleedout_meterfg"))
	bleedout_bar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	bleedout_bar:setShaderVector(1, 0, 0, 0, 0)
	bleedout_bar:setShaderVector(2, 1, 0, 0, 0)
	bleedout_bar:setShaderVector(3, 0, 0, 0, 0)
	bleedout_bar:setShaderVector(4, 0, 0.02, 0.05, 0)
	bleedout_bar:linkToElementModel(self, "bleedout_progress", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			bleedout_bar:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(bleedout_bar)
	self.bleedout_bar = bleedout_bar
	local PerkList = LUI.UIList.new(f1_local1, f1_arg0, 16, 0, nil, false, false, false, false)
	PerkList:setLeftRight(0.5, 0.5, -152, 152)
	PerkList:setTopBottom(1, 1, -477, -413)
	PerkList:setWidgetType(CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item)
	PerkList:setHorizontalCount(4)
	PerkList:setSpacing(16)
	PerkList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PerkList:setDataSource("BleedoutPerkVapors")
	self:addElement(PerkList)
	self.PerkList = PerkList
	self:mergeStateConditions({
		{
			stateName = "Trials_HUDDeactivated",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg0, "ztrials") and CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f6_local0 then
					f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f6_local0 then
						f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
						if not f6_local0 then
							f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_game_ended"])
							if not f6_local0 then
								if Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
									f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
									if not f6_local0 then
										f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
										if not f6_local0 then
											f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
											if not f6_local0 then
												f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
												if not f6_local0 then
													f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
													if not f6_local0 then
														f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
														if not f6_local0 then
															f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_stage_ended"])
															if not f6_local0 then
																f6_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_ui_active"])
																if not f6_local0 then
																	f6_local0 = not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
																end
															end
														end
													end
												end
											end
										end
									end
								else
									f6_local0 = true
								end
							end
						end
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "ServerPaused",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg0, "hudItems.serverPaused")
			end,
		},
		{
			stateName = "Revive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg0, "revive_progress", 0)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getglobalmodel"]()
	f1_local12(f1_local11, f1_local13["ZMHudGlobal.trials.hudDeactivated"], function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "ZMHudGlobal.trials.hudDeactivated",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_stage_ended"]], function(f21_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_stage_ended"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f22_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f23_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13["hudItems.serverPaused"], function(f24_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f24_arg0:get(),
			modelName = "hudItems.serverPaused",
		})
	end, false)
	self:linkToElementModel(self, "revive_progress", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "revive_progress",
		})
	end)
	PerkList.id = "PerkList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local12 = self
	CoD.ZMPerkUtility.SubscribeForBleedoutPerkModelUpdate(self, f1_arg0)
	return self
end
CoD.zm_laststand_client.__resetProperties = function(f26_arg0)
	f26_arg0.DecorativeBGAnim:completeAnimation()
	f26_arg0.bleedout_bar:completeAnimation()
	f26_arg0.ReviveBarBG:completeAnimation()
	f26_arg0.bleedout_label:completeAnimation()
	f26_arg0.revive_clock:completeAnimation()
	f26_arg0.bleedout_clock:completeAnimation()
	f26_arg0.PerkList:completeAnimation()
	f26_arg0.revive_bar:completeAnimation()
	f26_arg0.ReviveBarBG2:completeAnimation()
	f26_arg0.DecorativeBGAnim:setAlpha(1)
	f26_arg0.DecorativeBGAnim:setScale(1, 1)
	f26_arg0.bleedout_bar:setAlpha(1)
	f26_arg0.bleedout_bar:setScale(1, 1)
	f26_arg0.ReviveBarBG:setAlpha(1)
	f26_arg0.ReviveBarBG:setScale(1, 1)
	f26_arg0.bleedout_label:setAlpha(1)
	f26_arg0.bleedout_label:setScale(1, 1)
	f26_arg0.revive_clock:setAlpha(1)
	f26_arg0.bleedout_clock:setAlpha(0.9)
	f26_arg0.PerkList:setAlpha(1)
	f26_arg0.revive_bar:setAlpha(0)
	f26_arg0.revive_bar:setScale(0.8, 0.6)
	f26_arg0.ReviveBarBG2:setAlpha(0)
	f26_arg0.ReviveBarBG2:setScale(0.81, 0.6)
end
CoD.zm_laststand_client.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			local f27_local0 = function(f28_arg0)
				f27_arg0.DecorativeBGAnim:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f27_arg0.DecorativeBGAnim:setAlpha(1)
				f27_arg0.DecorativeBGAnim:setScale(1, 1)
				f27_arg0.DecorativeBGAnim:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.DecorativeBGAnim:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.DecorativeBGAnim:completeAnimation()
			f27_arg0.DecorativeBGAnim:setAlpha(0)
			f27_arg0.DecorativeBGAnim:setScale(2, 2)
			f27_local0(f27_arg0.DecorativeBGAnim)
			local f27_local1 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
					f30_arg0:setAlpha(1)
					f30_arg0:setScale(1, 1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.bleedout_label:beginAnimation(100)
				f27_arg0.bleedout_label:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.bleedout_label:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f27_arg0.bleedout_label:completeAnimation()
			f27_arg0.bleedout_label:setAlpha(0)
			f27_arg0.bleedout_label:setScale(2, 2)
			f27_local1(f27_arg0.bleedout_label)
			local f27_local2 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
					f32_arg0:setAlpha(1)
					f32_arg0:setScale(1, 1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.ReviveBarBG:beginAnimation(200)
				f27_arg0.ReviveBarBG:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.ReviveBarBG:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f27_arg0.ReviveBarBG:completeAnimation()
			f27_arg0.ReviveBarBG:setAlpha(0)
			f27_arg0.ReviveBarBG:setScale(2, 2)
			f27_local2(f27_arg0.ReviveBarBG)
			local f27_local3 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
					f34_arg0:setAlpha(1)
					f34_arg0:setScale(1, 1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.bleedout_bar:beginAnimation(200)
				f27_arg0.bleedout_bar:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.bleedout_bar:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f27_arg0.bleedout_bar:completeAnimation()
			f27_arg0.bleedout_bar:setAlpha(0)
			f27_arg0.bleedout_bar:setScale(2, 2)
			f27_local3(f27_arg0.bleedout_bar)
		end,
	},
	Trials_HUDDeactivated = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(9)
			f35_arg0.DecorativeBGAnim:completeAnimation()
			f35_arg0.DecorativeBGAnim:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.DecorativeBGAnim)
			f35_arg0.bleedout_clock:completeAnimation()
			f35_arg0.bleedout_clock:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.bleedout_clock)
			f35_arg0.revive_clock:completeAnimation()
			f35_arg0.revive_clock:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.revive_clock)
			f35_arg0.bleedout_label:completeAnimation()
			f35_arg0.bleedout_label:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.bleedout_label)
			f35_arg0.ReviveBarBG2:completeAnimation()
			f35_arg0.ReviveBarBG2:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ReviveBarBG2)
			f35_arg0.revive_bar:completeAnimation()
			f35_arg0.revive_bar:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.revive_bar)
			f35_arg0.ReviveBarBG:completeAnimation()
			f35_arg0.ReviveBarBG:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ReviveBarBG)
			f35_arg0.bleedout_bar:completeAnimation()
			f35_arg0.bleedout_bar:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.bleedout_bar)
			f35_arg0.PerkList:completeAnimation()
			f35_arg0.PerkList:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.PerkList)
		end,
	},
	Hidden = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(9)
			f36_arg0.DecorativeBGAnim:completeAnimation()
			f36_arg0.DecorativeBGAnim:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.DecorativeBGAnim)
			f36_arg0.bleedout_clock:completeAnimation()
			f36_arg0.bleedout_clock:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.bleedout_clock)
			f36_arg0.revive_clock:completeAnimation()
			f36_arg0.revive_clock:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.revive_clock)
			f36_arg0.bleedout_label:completeAnimation()
			f36_arg0.bleedout_label:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.bleedout_label)
			f36_arg0.ReviveBarBG2:completeAnimation()
			f36_arg0.ReviveBarBG2:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ReviveBarBG2)
			f36_arg0.revive_bar:completeAnimation()
			f36_arg0.revive_bar:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.revive_bar)
			f36_arg0.ReviveBarBG:completeAnimation()
			f36_arg0.ReviveBarBG:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ReviveBarBG)
			f36_arg0.bleedout_bar:completeAnimation()
			f36_arg0.bleedout_bar:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.bleedout_bar)
			f36_arg0.PerkList:completeAnimation()
			f36_arg0.PerkList:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.PerkList)
		end,
	},
	ServerPaused = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(9)
			f37_arg0.DecorativeBGAnim:completeAnimation()
			f37_arg0.DecorativeBGAnim:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.DecorativeBGAnim)
			f37_arg0.bleedout_clock:completeAnimation()
			f37_arg0.bleedout_clock:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.bleedout_clock)
			f37_arg0.revive_clock:completeAnimation()
			f37_arg0.revive_clock:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.revive_clock)
			f37_arg0.bleedout_label:completeAnimation()
			f37_arg0.bleedout_label:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.bleedout_label)
			f37_arg0.ReviveBarBG2:completeAnimation()
			f37_arg0.ReviveBarBG2:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ReviveBarBG2)
			f37_arg0.revive_bar:completeAnimation()
			f37_arg0.revive_bar:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.revive_bar)
			f37_arg0.ReviveBarBG:completeAnimation()
			f37_arg0.ReviveBarBG:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ReviveBarBG)
			f37_arg0.bleedout_bar:completeAnimation()
			f37_arg0.bleedout_bar:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.bleedout_bar)
			f37_arg0.PerkList:completeAnimation()
			f37_arg0.PerkList:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.PerkList)
		end,
	},
	Revive = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			local f38_local0 = function(f39_arg0)
				f38_arg0.ReviveBarBG2:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f38_arg0.ReviveBarBG2:setAlpha(1)
				f38_arg0.ReviveBarBG2:setScale(0.81, 0.6)
				f38_arg0.ReviveBarBG2:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.ReviveBarBG2:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.ReviveBarBG2:completeAnimation()
			f38_arg0.ReviveBarBG2:setAlpha(0)
			f38_arg0.ReviveBarBG2:setScale(1.62, 1.2)
			f38_local0(f38_arg0.ReviveBarBG2)
			local f38_local1 = function(f40_arg0)
				f38_arg0.revive_bar:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f38_arg0.revive_bar:setAlpha(1)
				f38_arg0.revive_bar:setScale(0.8, 0.6)
				f38_arg0.revive_bar:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.revive_bar:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.revive_bar:completeAnimation()
			f38_arg0.revive_bar:setAlpha(0)
			f38_arg0.revive_bar:setScale(1.6, 1.2)
			f38_local1(f38_arg0.revive_bar)
		end,
	},
}
CoD.zm_laststand_client.__onClose = function(f41_arg0)
	f41_arg0.DecorativeBGAnim:close()
	f41_arg0.bleedout_label:close()
	f41_arg0.revive_bar:close()
	f41_arg0.bleedout_bar:close()
	f41_arg0.PerkList:close()
end
