require("x64:9827c9c9d4b5a63")
CoD.AmmoWidget_BountyBag = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_BountyBag.__defaultWidth = 105
CoD.AmmoWidget_BountyBag.__defaultHeight = 105
CoD.AmmoWidget_BountyBag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.BountyCarryingBag", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.bountyBagMoney", 0)
	self:setClass(CoD.AmmoWidget_BountyBag)
	self.id = "AmmoWidget_BountyBag"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGBlur = LUI.UIImage.new(0, 0, 19, 79, 0, 0, 23.5, 80.5)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local backplate = LUI.UIImage.new(0, 0, 15, 107, 0, 0, 20.5, 84.5)
	backplate:setImage(RegisterImage(@"uie_ui_hud_core_carryitem_backplate"))
	self:addElement(backplate)
	self.backplate = backplate
	local BagItem = LUI.UIImage.new(0, 0, 3, 119, 0, 0, 6.5, 98.5)
	BagItem:setImage(RegisterImage(@"uie_ui_hud_core_carryitem_heist"))
	self:addElement(BagItem)
	self.BagItem = BagItem
	local BagItem2 = LUI.UIImage.new(0, 0, 15, 107, 0, 0, 20.5, 84.5)
	BagItem2:setAlpha(0)
	BagItem2:setImage(RegisterImage(@"uie_ui_hud_core_carryitem_glow"))
	BagItem2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BagItem2)
	self.BagItem2 = BagItem2
	local PanelGlow = LUI.UIImage.new(0, 0, -24, 127, 0, 0, -22, 131)
	PanelGlow:setRGB(0, 0.31, 0.02)
	PanelGlow:setAlpha(0.9)
	PanelGlow:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	PanelGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PanelGlow)
	self.PanelGlow = PanelGlow
	local MoneyValue = CoD.BountyHunterBagMoney.new(f1_arg0, f1_arg1, 0, 0, 20, 79, 0, 0, 61, 77)
	self:addElement(MoneyValue)
	self.MoneyValue = MoneyValue
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
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.BountyCarryingBag", 1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.BountyCarryingBag"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "hudItems.BountyCarryingBag",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_BountyBag.__resetProperties = function(f21_arg0)
	f21_arg0.PanelGlow:completeAnimation()
	f21_arg0.BagItem:completeAnimation()
	f21_arg0.BagItem2:completeAnimation()
	f21_arg0.backplate:completeAnimation()
	f21_arg0.MoneyValue:completeAnimation()
	f21_arg0.BGBlur:completeAnimation()
	f21_arg0.PanelGlow:setAlpha(0.9)
	f21_arg0.BagItem:setAlpha(1)
	f21_arg0.BagItem2:setAlpha(0)
	f21_arg0.backplate:setAlpha(1)
	f21_arg0.MoneyValue:setAlpha(1)
	f21_arg0.BGBlur:setAlpha(1)
end
CoD.AmmoWidget_BountyBag.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(6)
			f22_arg0.BGBlur:completeAnimation()
			f22_arg0.BGBlur:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BGBlur)
			f22_arg0.backplate:completeAnimation()
			f22_arg0.backplate:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.backplate)
			f22_arg0.BagItem:completeAnimation()
			f22_arg0.BagItem:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BagItem)
			f22_arg0.BagItem2:completeAnimation()
			f22_arg0.BagItem2:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BagItem2)
			f22_arg0.PanelGlow:completeAnimation()
			f22_arg0.PanelGlow:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.PanelGlow)
			f22_arg0.MoneyValue:completeAnimation()
			f22_arg0.MoneyValue:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.MoneyValue)
		end,
	},
	Hide = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(6)
			f23_arg0.BGBlur:completeAnimation()
			f23_arg0.BGBlur:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.BGBlur)
			f23_arg0.backplate:completeAnimation()
			f23_arg0.backplate:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.backplate)
			f23_arg0.BagItem:completeAnimation()
			f23_arg0.BagItem:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.BagItem)
			f23_arg0.BagItem2:completeAnimation()
			f23_arg0.BagItem2:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.BagItem2)
			f23_arg0.PanelGlow:completeAnimation()
			f23_arg0.PanelGlow:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PanelGlow)
			f23_arg0.MoneyValue:completeAnimation()
			f23_arg0.MoneyValue:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.MoneyValue)
		end,
	},
	Show = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(1000)
					f26_arg0:setAlpha(0.7)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.PanelGlow:beginAnimation(1000)
				f24_arg0.PanelGlow:setAlpha(0.1)
				f24_arg0.PanelGlow:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.PanelGlow:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.PanelGlow:completeAnimation()
			f24_arg0.PanelGlow:setAlpha(0.7)
			f24_local0(f24_arg0.PanelGlow)
			f24_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.AmmoWidget_BountyBag.__onClose = function(f27_arg0)
	f27_arg0.MoneyValue:close()
end
