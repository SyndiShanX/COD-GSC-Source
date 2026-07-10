CoD.zm_arcade_keys = InheritFrom(CoD.Menu)
LUI.createMenu.zm_arcade_keys = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_arcade_keys", f1_arg0)
	local f1_local1 = self
	SetProperty(self, "cachedKeyCount", 0)
	self:setClass(CoD.zm_arcade_keys)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local KeyEmptyBg = LUI.UIImage.new(0, 0, 14.5, 230.5, 0, 0, 69, 151)
	KeyEmptyBg:setImage(RegisterImage(@"hash_3C326F68BED7EC04"))
	self:addElement(KeyEmptyBg)
	self.KeyEmptyBg = KeyEmptyBg
	local Glow = LUI.UIImage.new(0, 0, 163, 291, 0, 0, 53, 152)
	Glow:setRGB(1, 0.26, 0)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local KeyFull = LUI.UIImage.new(0, 0, 43, 151, 0, 0, 86, 138)
	KeyFull:setAlpha(0)
	KeyFull:setImage(RegisterImage(0x92C3826B1AB38D))
	self:addElement(KeyFull)
	self.KeyFull = KeyFull
	local KeyEnabled = LUI.UIImage.new(0, 0, 43, 151, 0, 0, 86, 138)
	KeyEnabled:setImage(RegisterImage(0x92C3826B1AB38D))
	self:addElement(KeyEnabled)
	self.KeyEnabled = KeyEnabled
	local KeyCount = LUI.UIText.new(0, 0, 171.5, 202.5, 0, 0, 95.5, 128.5)
	KeyCount:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_478C6299DB16E268"))
	KeyCount:setTTF("skorzhen")
	KeyCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KeyCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(KeyCount)
	self.KeyCount = KeyCount
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f2_local0 then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f2_local0 then
						f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						if not f2_local0 then
							f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
							if not f2_local0 then
								f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_game_ended"])
								if not f2_local0 then
									f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
									if not f2_local0 then
										if Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
											f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
											if not f2_local0 then
												f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
												if not f2_local0 then
													f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
													if not f2_local0 then
														f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
														if not f2_local0 then
															f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
															if not f2_local0 then
																f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
																if not f2_local0 then
																	f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
																	if not f2_local0 then
																		f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
																		if not f2_local0 then
																			f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_ui_active"])
																			if not f2_local0 then
																				f2_local0 = not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
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
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "HiddenCopy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg0, "key_count")
			end,
		},
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg0, "key_count", 1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f21_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	self:linkToElementModel(self, "key_count", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "key_count",
		})
	end)
	self:linkToElementModel(self, "key_count", true, function(model)
		local f23_local0 = self
		if CoD.ZombieUtility.IsSelfModelValueGreaterThanCachedValue(f1_arg0, self, "key_count", "cachedKeyCount") and CoD.ModelUtility.IsParamModelGreaterThanOrEqualTo(model, 2) then
			SetElementProperty(f23_local0, "cachedKeyCount", model:get())
			PlayClip(self, "AddKey", f1_arg0)
		elseif not CoD.ZombieUtility.IsSelfModelValueGreaterThanCachedValue(f1_arg0, self, "key_count", "cachedKeyCount") and CoD.ModelUtility.IsParamModelGreaterThanOrEqualTo(model, 1) then
			SetElementProperty(f23_local0, "cachedKeyCount", model:get())
			PlayClip(self, "BurnKey", f1_arg0)
		else
			SetElementProperty(f23_local0, "cachedKeyCount", model:get())
		end
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	SizeToSafeArea(self, f1_arg0)
	return self
end
CoD.zm_arcade_keys.__resetProperties = function(f24_arg0)
	f24_arg0.KeyCount:completeAnimation()
	f24_arg0.KeyEnabled:completeAnimation()
	f24_arg0.KeyFull:completeAnimation()
	f24_arg0.Glow:completeAnimation()
	f24_arg0.KeyEmptyBg:completeAnimation()
	f24_arg0.KeyCount:setAlpha(1)
	f24_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
	f24_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
	f24_arg0.KeyEnabled:setAlpha(1)
	f24_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
	f24_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
	f24_arg0.KeyFull:setAlpha(0)
	f24_arg0.Glow:setLeftRight(0, 0, 163, 291)
	f24_arg0.Glow:setTopBottom(0, 0, 53, 152)
	f24_arg0.Glow:setRGB(1, 0.26, 0)
	f24_arg0.Glow:setAlpha(0)
	f24_arg0.KeyEmptyBg:setAlpha(1)
end
CoD.zm_arcade_keys.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(5)
			f26_arg0.KeyEmptyBg:completeAnimation()
			f26_arg0.KeyEmptyBg:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.KeyEmptyBg)
			f26_arg0.Glow:completeAnimation()
			f26_arg0.Glow:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Glow)
			f26_arg0.KeyFull:completeAnimation()
			f26_arg0.KeyFull:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.KeyFull)
			f26_arg0.KeyEnabled:completeAnimation()
			f26_arg0.KeyEnabled:setTopBottom(0, 0, 26, 78)
			f26_arg0.KeyEnabled:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.KeyEnabled)
			f26_arg0.KeyCount:completeAnimation()
			f26_arg0.KeyCount:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.KeyCount)
		end,
	},
	HiddenCopy = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(5)
			f27_arg0.KeyEmptyBg:completeAnimation()
			f27_arg0.KeyEmptyBg:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.KeyEmptyBg)
			f27_arg0.Glow:completeAnimation()
			f27_arg0.Glow:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Glow)
			f27_arg0.KeyFull:completeAnimation()
			f27_arg0.KeyFull:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.KeyFull)
			f27_arg0.KeyEnabled:completeAnimation()
			f27_arg0.KeyEnabled:setTopBottom(0, 0, 26, 78)
			f27_arg0.KeyEnabled:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.KeyEnabled)
			f27_arg0.KeyCount:completeAnimation()
			f27_arg0.KeyCount:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.KeyCount)
		end,
		Full = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(4)
			f28_arg0.KeyEmptyBg:completeAnimation()
			f28_arg0.KeyEmptyBg:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.KeyEmptyBg)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(130)
					f30_arg0:setAlpha(0)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.Glow:beginAnimation(700)
				f28_arg0.Glow:setLeftRight(0, 0, -34, 278)
				f28_arg0.Glow:setTopBottom(0, 0, 36.5, 165.5)
				f28_arg0.Glow:setAlpha(0.8)
				f28_arg0.Glow:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Glow:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.Glow:completeAnimation()
			f28_arg0.Glow:setLeftRight(0, 0, 735, 1047)
			f28_arg0.Glow:setTopBottom(0, 0, 91.5, 220.5)
			f28_arg0.Glow:setRGB(ColorSet.CoreMartial.r, ColorSet.CoreMartial.g, ColorSet.CoreMartial.b)
			f28_arg0.Glow:setAlpha(1)
			f28_local0(f28_arg0.Glow)
			local f28_local1 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(130)
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.KeyFull:beginAnimation(700)
				f28_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
				f28_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
				f28_arg0.KeyFull:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.KeyFull:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f28_arg0.KeyFull:completeAnimation()
			f28_arg0.KeyFull:setLeftRight(0, 0, 41, 186)
			f28_arg0.KeyFull:setTopBottom(0, 0, 69, 139)
			f28_arg0.KeyFull:setAlpha(0)
			f28_local1(f28_arg0.KeyFull)
			local f28_local2 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(130)
					f34_arg0:setAlpha(0)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.KeyEnabled:beginAnimation(700)
				f28_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
				f28_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
				f28_arg0.KeyEnabled:setAlpha(0.7)
				f28_arg0.KeyEnabled:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.KeyEnabled:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f28_arg0.KeyEnabled:completeAnimation()
			f28_arg0.KeyEnabled:setLeftRight(0, 0, 779, 1003)
			f28_arg0.KeyEnabled:setTopBottom(0, 0, 97, 205)
			f28_arg0.KeyEnabled:setAlpha(1)
			f28_local2(f28_arg0.KeyEnabled)
		end,
	},
	Full = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.KeyEmptyBg:completeAnimation()
			f35_arg0.KeyEmptyBg:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.KeyEmptyBg)
			f35_arg0.KeyEnabled:completeAnimation()
			f35_arg0.KeyEnabled:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.KeyEnabled)
		end,
		AddKey = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(4)
			f36_arg0.KeyEmptyBg:completeAnimation()
			f36_arg0.KeyEmptyBg:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.KeyEmptyBg)
			local f36_local0 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(130)
					f38_arg0:setAlpha(0)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.Glow:beginAnimation(700)
				f36_arg0.Glow:setLeftRight(0, 0, -34, 278)
				f36_arg0.Glow:setTopBottom(0, 0, 34, 163)
				f36_arg0.Glow:setAlpha(0.8)
				f36_arg0.Glow:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.Glow:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f36_arg0.Glow:completeAnimation()
			f36_arg0.Glow:setLeftRight(0, 0, 735, 1047)
			f36_arg0.Glow:setTopBottom(0, 0, 91.5, 220.5)
			f36_arg0.Glow:setRGB(ColorSet.CoreMartial.r, ColorSet.CoreMartial.g, ColorSet.CoreMartial.b)
			f36_arg0.Glow:setAlpha(1)
			f36_local0(f36_arg0.Glow)
			f36_arg0.KeyFull:completeAnimation()
			f36_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
			f36_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
			f36_arg0.KeyFull:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.KeyFull)
			local f36_local1 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(130)
					f40_arg0:setAlpha(0)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.KeyEnabled:beginAnimation(700)
				f36_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
				f36_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
				f36_arg0.KeyEnabled:setAlpha(0.7)
				f36_arg0.KeyEnabled:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.KeyEnabled:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f36_arg0.KeyEnabled:completeAnimation()
			f36_arg0.KeyEnabled:setLeftRight(0, 0, 779, 1003)
			f36_arg0.KeyEnabled:setTopBottom(0, 0, 97, 205)
			f36_arg0.KeyEnabled:setAlpha(1)
			f36_local1(f36_arg0.KeyEnabled)
		end,
		BurnKey = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(3)
			f41_arg0.KeyEmptyBg:completeAnimation()
			f41_arg0.KeyEmptyBg:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.KeyEmptyBg)
			f41_arg0.KeyFull:completeAnimation()
			f41_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
			f41_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
			f41_arg0.KeyFull:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.KeyFull)
			local f41_local0 = function(f42_arg0)
				f41_arg0.KeyEnabled:beginAnimation(1000)
				f41_arg0.KeyEnabled:setTopBottom(0, 0, 222, 274)
				f41_arg0.KeyEnabled:setAlpha(0)
				f41_arg0.KeyEnabled:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.KeyEnabled:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.KeyEnabled:completeAnimation()
			f41_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
			f41_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
			f41_arg0.KeyEnabled:setAlpha(1)
			f41_local0(f41_arg0.KeyEnabled)
		end,
		HiddenCopy = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(3)
			local f43_local0 = function(f44_arg0)
				f43_arg0.KeyEmptyBg:beginAnimation(1000)
				f43_arg0.KeyEmptyBg:setAlpha(0)
				f43_arg0.KeyEmptyBg:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.KeyEmptyBg:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.KeyEmptyBg:completeAnimation()
			f43_arg0.KeyEmptyBg:setAlpha(1)
			f43_local0(f43_arg0.KeyEmptyBg)
			local f43_local1 = function(f45_arg0)
				f43_arg0.KeyFull:beginAnimation(1000)
				f43_arg0.KeyFull:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.KeyFull:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.KeyFull:completeAnimation()
			f43_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
			f43_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
			f43_arg0.KeyFull:setAlpha(0)
			f43_local1(f43_arg0.KeyFull)
			local f43_local2 = function(f46_arg0)
				f43_arg0.KeyEnabled:beginAnimation(1000)
				f43_arg0.KeyEnabled:setTopBottom(0, 0, 283.5, 353.5)
				f43_arg0.KeyEnabled:setAlpha(0)
				f43_arg0.KeyEnabled:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.KeyEnabled:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.KeyEnabled:completeAnimation()
			f43_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
			f43_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
			f43_arg0.KeyEnabled:setAlpha(1)
			f43_local2(f43_arg0.KeyEnabled)
		end,
	},
}
CoD.zm_arcade_keys.__onClose = function(f47_arg0) end
