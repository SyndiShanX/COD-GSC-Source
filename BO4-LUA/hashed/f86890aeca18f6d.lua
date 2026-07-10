CoD.hud_hacked_ammo_widget = InheritFrom(LUI.UIElement)
CoD.hud_hacked_ammo_widget.__defaultWidth = 310
CoD.hud_hacked_ammo_widget.__defaultHeight = 64
CoD.hud_hacked_ammo_widget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.hud_hacked_ammo_widget)
	self.id = "hud_hacked_ammo_widget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Hacked2 = LUI.UIImage.new(0, 0, 0, 310, 0, 0, 0, 64)
	Hacked2:setRGB(0.32, 0.44, 0.52)
	Hacked2:setAlpha(0.25)
	Hacked2:setZRot(180)
	Hacked2:setImage(RegisterImage(@"uie_ui_hud_core_hacked_ammo_panel"))
	Hacked2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	Hacked2:setShaderVector(0, 4, 4, 0, 0)
	Hacked2:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(Hacked2)
	self.Hacked2 = Hacked2
	local Hacked = LUI.UIImage.new(0, 0, 0, 310, 0, 0, 0, 64)
	Hacked:setRGB(0.32, 0.44, 0.52)
	Hacked:setImage(RegisterImage(@"uie_ui_hud_core_hacked_ammo_panel"))
	Hacked:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	Hacked:setShaderVector(0, 4, 4, 0, 0)
	Hacked:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(Hacked)
	self.Hacked = Hacked
	self:mergeStateConditions({
		{
			stateName = "Hacked",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "hacked", 1)
				if f2_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]) then
						f2_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.hacked, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hacked",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.hud_hacked_ammo_widget.__resetProperties = function(f8_arg0)
	f8_arg0.Hacked:completeAnimation()
	f8_arg0.Hacked2:completeAnimation()
	f8_arg0.Hacked:setAlpha(1)
	f8_arg0.Hacked2:setAlpha(0.25)
end
CoD.hud_hacked_ammo_widget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.Hacked2:completeAnimation()
			f9_arg0.Hacked2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Hacked2)
			f9_arg0.Hacked:completeAnimation()
			f9_arg0.Hacked:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Hacked)
		end,
	},
	Hacked = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
