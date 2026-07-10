CoD.WarzoneQuickInventoryVignette = InheritFrom(LUI.UIElement)
CoD.WarzoneQuickInventoryVignette.__defaultWidth = 1920
CoD.WarzoneQuickInventoryVignette.__defaultHeight = 128
CoD.WarzoneQuickInventoryVignette.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneQuickInventoryVignette)
	self.id = "WarzoneQuickInventoryVignette"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GridTiled = LUI.UIImage.new(0.2, 0.2, -979.5, 2272.5, 0.19, 0.19, -32, 34)
	GridTiled:setAlpha(0)
	GridTiled:setScale(0.7, 0.7)
	GridTiled:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_grid"))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local Image = LUI.UIImage.new(0, 0, -107, 2027, 0, 0, -269, 479)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.9)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	Image:setShaderVector(0, 0.2, 0.5, 0.2, 0.01)
	self:addElement(Image)
	self.Image = Image
	local GridBaked = LUI.UIImage.new(0, 0, 480, 1440, 0, 0, 46, 150)
	GridBaked:setAlpha(0.1)
	GridBaked:setScale(2, 2)
	GridBaked:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_grid_baked"))
	GridBaked:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	GridBaked:setShaderVector(0, 0.03, 0.97, 0, 0)
	GridBaked:setShaderVector(1, 0.05, 0.07, 0, 0)
	GridBaked:setShaderVector(2, 0, 0.7, 0, 0)
	GridBaked:setShaderVector(3, 0, 0.26, 0, 0)
	GridBaked:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(GridBaked)
	self.GridBaked = GridBaked
	local GridBakedEMP = LUI.UIImage.new(0, 0, 480, 1440, 0, 0, 46, 150)
	GridBakedEMP:setAlpha(0)
	GridBakedEMP:setScale(2, 2)
	GridBakedEMP:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_grid_baked"))
	GridBakedEMP:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_emp"))
	GridBakedEMP:setShaderVector(0, 35.93, 0, 0, 0)
	GridBakedEMP:setShaderVector(1, 0.83, 0, 0, 0)
	GridBakedEMP:setShaderVector(2, 0.49, 0, 0, 0)
	self:addElement(GridBakedEMP)
	self.GridBakedEMP = GridBakedEMP
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "HealthAndEquipmentEMP",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableHealthCount", 0)
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableEquipmentCount", 0)
					if f3_local0 then
						if
							not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
							and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_location"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						then
							f3_local0 = not CoD.CodCasterUtility.CodCasterEnabledAndProfileVarEqualTo(f1_arg1, "shoutcaster_ds_inventory", false)
						else
							f3_local0 = false
						end
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "HealthAndEquipment",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableHealthCount", 0) and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableEquipmentCount", 0)
			end,
		},
		{
			stateName = "HealthEMP",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableHealthCount", 0)
				if f5_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_location"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					then
						f5_local0 = not CoD.CodCasterUtility.CodCasterEnabledAndProfileVarEqualTo(f1_arg1, "shoutcaster_ds_inventory", false)
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "Health",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableHealthCount", 0)
			end,
		},
		{
			stateName = "EquipmentEMP",
			condition = function(menu, element, event)
				local f7_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableEquipmentCount", 0)
				if f7_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_location"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					then
						f7_local0 = not CoD.CodCasterUtility.CodCasterEnabledAndProfileVarEqualTo(f1_arg1, "shoutcaster_ds_inventory", false)
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "Equipment",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "WarzoneInventory", "availableEquipmentCount", 0)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.inventory.open"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.availableHealthCount, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "availableHealthCount",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.availableEquipmentCount, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "availableEquipmentCount",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_location"]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_location"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneQuickInventoryVignette.__resetProperties = function(f24_arg0)
	f24_arg0.Image:completeAnimation()
	f24_arg0.GridTiled:completeAnimation()
	f24_arg0.GridBaked:completeAnimation()
	f24_arg0.GridBakedEMP:completeAnimation()
	f24_arg0.Image:setAlpha(0.9)
	f24_arg0.GridTiled:setAlpha(0)
	f24_arg0.GridBaked:setAlpha(0.1)
	f24_arg0.GridBaked:setShaderVector(0, 0.03, 0.97, 0, 0)
	f24_arg0.GridBaked:setShaderVector(1, 0.05, 0.07, 0, 0)
	f24_arg0.GridBaked:setShaderVector(2, 0, 0.7, 0, 0)
	f24_arg0.GridBaked:setShaderVector(3, 0, 0.26, 0, 0)
	f24_arg0.GridBaked:setShaderVector(4, 0, 0, 0, 0)
	f24_arg0.GridBakedEMP:setAlpha(0)
end
CoD.WarzoneQuickInventoryVignette.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.GridTiled:completeAnimation()
			f26_arg0.GridTiled:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.GridTiled)
			f26_arg0.Image:completeAnimation()
			f26_arg0.Image:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Image)
			f26_arg0.GridBaked:completeAnimation()
			f26_arg0.GridBaked:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.GridBaked)
		end,
	},
	HealthAndEquipmentEMP = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			local f27_local0 = function(f28_arg0)
				f27_arg0.Image:beginAnimation(140)
				f27_arg0.Image:setAlpha(0.9)
				f27_arg0.Image:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.Image:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.Image:completeAnimation()
			f27_arg0.Image:setAlpha(0)
			f27_local0(f27_arg0.Image)
			local f27_local1 = function(f29_arg0)
				f27_arg0.GridBaked:beginAnimation(210, Enum[@"luitween"][@"luitween_ease_both"])
				f27_arg0.GridBaked:setShaderVector(0, 0.03, 0.97, 0, 0)
				f27_arg0.GridBaked:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.GridBaked:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.GridBaked:completeAnimation()
			f27_arg0.GridBaked:setAlpha(0)
			f27_arg0.GridBaked:setShaderVector(0, 0.5, 0.5, 0, 0)
			f27_arg0.GridBaked:setShaderVector(1, 0.05, 0.07, 0, 0)
			f27_arg0.GridBaked:setShaderVector(2, 0, 0.7, 0, 0)
			f27_arg0.GridBaked:setShaderVector(3, 0, 0, 0, 0)
			f27_arg0.GridBaked:setShaderVector(4, 0, 0, 0, 0)
			f27_local1(f27_arg0.GridBaked)
			f27_arg0.GridBakedEMP:completeAnimation()
			f27_arg0.GridBakedEMP:setAlpha(0.22)
			f27_arg0.clipFinished(f27_arg0.GridBakedEMP)
		end,
	},
	HealthAndEquipment = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			local f30_local0 = function(f31_arg0)
				f30_arg0.Image:beginAnimation(140)
				f30_arg0.Image:setAlpha(0.9)
				f30_arg0.Image:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.Image:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.Image:completeAnimation()
			f30_arg0.Image:setAlpha(0)
			f30_local0(f30_arg0.Image)
			local f30_local1 = function(f32_arg0)
				f30_arg0.GridBaked:beginAnimation(210, Enum[@"luitween"][@"luitween_ease_both"])
				f30_arg0.GridBaked:setShaderVector(0, 0.03, 0.97, 0, 0)
				f30_arg0.GridBaked:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.GridBaked:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.GridBaked:completeAnimation()
			f30_arg0.GridBaked:setShaderVector(0, 0.5, 0.5, 0, 0)
			f30_arg0.GridBaked:setShaderVector(1, 0.05, 0.07, 0, 0)
			f30_arg0.GridBaked:setShaderVector(2, 0, 0.7, 0, 0)
			f30_arg0.GridBaked:setShaderVector(3, 0, 0, 0, 0)
			f30_arg0.GridBaked:setShaderVector(4, 0, 0, 0, 0)
			f30_local1(f30_arg0.GridBaked)
		end,
	},
	HealthEMP = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
			local f33_local0 = function(f34_arg0)
				f33_arg0.Image:beginAnimation(140)
				f33_arg0.Image:setAlpha(0.9)
				f33_arg0.Image:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Image:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.Image:completeAnimation()
			f33_arg0.Image:setAlpha(0)
			f33_local0(f33_arg0.Image)
			local f33_local1 = function(f35_arg0)
				f33_arg0.GridBaked:beginAnimation(200)
				f33_arg0.GridBaked:setShaderVector(0, 0.03, 0.97, 0, 0)
				f33_arg0.GridBaked:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.GridBaked:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.GridBaked:completeAnimation()
			f33_arg0.GridBaked:setAlpha(0)
			f33_arg0.GridBaked:setShaderVector(0, 0.5, 0.5, 0, 0)
			f33_arg0.GridBaked:setShaderVector(1, 0.05, 0.07, 0, 0)
			f33_arg0.GridBaked:setShaderVector(2, 0, 0.7, 0, 0)
			f33_arg0.GridBaked:setShaderVector(3, 0, 0.26, 0, 0)
			f33_arg0.GridBaked:setShaderVector(4, 0, 0, 0, 0)
			f33_local1(f33_arg0.GridBaked)
			f33_arg0.GridBakedEMP:completeAnimation()
			f33_arg0.GridBakedEMP:setAlpha(0.22)
			f33_arg0.clipFinished(f33_arg0.GridBakedEMP)
		end,
	},
	Health = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			local f36_local0 = function(f37_arg0)
				f36_arg0.Image:beginAnimation(140)
				f36_arg0.Image:setAlpha(0.9)
				f36_arg0.Image:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.Image:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.Image:completeAnimation()
			f36_arg0.Image:setAlpha(0)
			f36_local0(f36_arg0.Image)
			local f36_local1 = function(f38_arg0)
				f36_arg0.GridBaked:beginAnimation(200)
				f36_arg0.GridBaked:setShaderVector(0, 0.03, 0.97, 0, 0)
				f36_arg0.GridBaked:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.GridBaked:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.GridBaked:completeAnimation()
			f36_arg0.GridBaked:setShaderVector(0, 0.5, 0.5, 0, 0)
			f36_arg0.GridBaked:setShaderVector(1, 0.05, 0.07, 0, 0)
			f36_arg0.GridBaked:setShaderVector(2, 0, 0.7, 0, 0)
			f36_arg0.GridBaked:setShaderVector(3, 0, 0.26, 0, 0)
			f36_arg0.GridBaked:setShaderVector(4, 0, 0, 0, 0)
			f36_local1(f36_arg0.GridBaked)
		end,
	},
	EquipmentEMP = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(3)
			local f39_local0 = function(f40_arg0)
				f39_arg0.Image:beginAnimation(140)
				f39_arg0.Image:setAlpha(0.9)
				f39_arg0.Image:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Image:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.Image:completeAnimation()
			f39_arg0.Image:setAlpha(0)
			f39_local0(f39_arg0.Image)
			local f39_local1 = function(f41_arg0)
				f39_arg0.GridBaked:beginAnimation(200)
				f39_arg0.GridBaked:setShaderVector(0, 0.03, 0.97, 0, 0)
				f39_arg0.GridBaked:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.GridBaked:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.GridBaked:completeAnimation()
			f39_arg0.GridBaked:setAlpha(0)
			f39_arg0.GridBaked:setShaderVector(0, 0.5, 0.5, 0, 0)
			f39_arg0.GridBaked:setShaderVector(1, 0.05, 0.07, 0, 0)
			f39_arg0.GridBaked:setShaderVector(2, 0, 0.7, 0, 0)
			f39_arg0.GridBaked:setShaderVector(3, 0, 0.26, 0, 0)
			f39_arg0.GridBaked:setShaderVector(4, 0, 0, 0, 0)
			f39_local1(f39_arg0.GridBaked)
			f39_arg0.GridBakedEMP:completeAnimation()
			f39_arg0.GridBakedEMP:setAlpha(0.22)
			f39_arg0.clipFinished(f39_arg0.GridBakedEMP)
		end,
	},
	Equipment = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			local f42_local0 = function(f43_arg0)
				f42_arg0.Image:beginAnimation(140)
				f42_arg0.Image:setAlpha(0.9)
				f42_arg0.Image:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.Image:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.Image:completeAnimation()
			f42_arg0.Image:setAlpha(0)
			f42_local0(f42_arg0.Image)
			local f42_local1 = function(f44_arg0)
				f42_arg0.GridBaked:beginAnimation(200)
				f42_arg0.GridBaked:setShaderVector(0, 0.03, 0.97, 0, 0)
				f42_arg0.GridBaked:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.GridBaked:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.GridBaked:completeAnimation()
			f42_arg0.GridBaked:setShaderVector(0, 0.5, 0.5, 0, 0)
			f42_arg0.GridBaked:setShaderVector(1, 0.05, 0.07, 0, 0)
			f42_arg0.GridBaked:setShaderVector(2, 0, 0.7, 0, 0)
			f42_arg0.GridBaked:setShaderVector(3, 0, 0.26, 0, 0)
			f42_arg0.GridBaked:setShaderVector(4, 0, 0, 0, 0)
			f42_local1(f42_arg0.GridBaked)
		end,
	},
}
