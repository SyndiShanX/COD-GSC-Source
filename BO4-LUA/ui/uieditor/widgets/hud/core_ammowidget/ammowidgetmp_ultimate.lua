require("x64:7412e6c494ab1c8")
require("x64:34cd2d86af1385e")
require("x64:cf90a501f0cd8ba")
require("x64:a3f1c7ee8f95b76")
require("x64:e32fe30fe56b49b")
CoD.AmmoWidgetMP_Ultimate = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_Ultimate.__defaultWidth = 268
CoD.AmmoWidgetMP_Ultimate.__defaultHeight = 120
CoD.AmmoWidgetMP_Ultimate.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_Ultimate)
	self.id = "AmmoWidgetMP_Ultimate"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UltimateRadialMeterwipe = CoD.AmmoWidgetMP_Ultimate_Internal.new(f1_arg0, f1_arg1, 0, 0, 1, 270, 0, 0, 0, 152)
	UltimateRadialMeterwipe:setScale(1.1, 1.1)
	UltimateRadialMeterwipe:linkToElementModel(self, nil, false, function(model)
		UltimateRadialMeterwipe:setModel(model, f1_arg1)
	end)
	self:addElement(UltimateRadialMeterwipe)
	self.UltimateRadialMeterwipe = UltimateRadialMeterwipe
	local AmmoWidgetMPAbilityItem = CoD.AmmoWidgetMP_AbilityItem.new(f1_arg0, f1_arg1, 0, 0, 189, 261, 0, 0, 32, 91)
	AmmoWidgetMPAbilityItem.HeroAbilityUseString.HeroAbilityUseString.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_260A07A7C41A40AA"))
	AmmoWidgetMPAbilityItem.HeroAbilityUseString.HeroAbilityUseString.GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_260A07A7C41A40AA"))
	AmmoWidgetMPAbilityItem:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget0", function(model)
		AmmoWidgetMPAbilityItem:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoWidgetMPAbilityItem)
	self.AmmoWidgetMPAbilityItem = AmmoWidgetMPAbilityItem
	local HealCooldown = CoD.AmmowidgetMP_HealCooldown.new(f1_arg0, f1_arg1, 0, 0, 8, 80, 0, 0, 31.5, 90.5)
	HealCooldown:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget1", function(model)
		HealCooldown:setModel(model, f1_arg1)
	end)
	self:addElement(HealCooldown)
	self.HealCooldown = HealCooldown
	local CodCasterLoadoutSelection = CoD.CodCasterLoadoutSelectionSpec.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -28, 32)
	CodCasterLoadoutSelection:setAlpha(0)
	self:addElement(CodCasterLoadoutSelection)
	self.CodCasterLoadoutSelection = CodCasterLoadoutSelection
	local EMPbacker = LUI.UIImage.new(0, 0, 3, 263, 0, 0, 5, 118)
	EMPbacker:setRGB(0, 0, 0)
	EMPbacker:setAlpha(0)
	EMPbacker:setScale(1.1, 1.1)
	EMPbacker:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_ultimate"))
	EMPbacker:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(EMPbacker)
	self.EMPbacker = EMPbacker
	local UltimateHacked = LUI.UIImage.new(0, 0, 9, 253, 0, 0, 9, 117)
	UltimateHacked:setAlpha(0)
	UltimateHacked:setScale(1.2, 1.2)
	UltimateHacked:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_ultimate"))
	UltimateHacked:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_emp"))
	UltimateHacked:setShaderVector(0, 20, 0, 0, 0)
	UltimateHacked:setShaderVector(1, 1, 0, 0, 0)
	UltimateHacked:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(UltimateHacked)
	self.UltimateHacked = UltimateHacked
	local Hacked = CoD.hud_hacked_hero_widget.new(f1_arg0, f1_arg1, 0, 0, -4, 270, 0, 0, -5.5, 132.5)
	self:addElement(Hacked)
	self.Hacked = Hacked
	self:mergeStateConditions({
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				local f5_local0
				if
					not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
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
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
					and not IsCodCaster(f1_arg1)
				then
					f5_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
					if f5_local0 then
						f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
					end
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f6_local0 then
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
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
						and not IsCodCaster(f1_arg1)
					then
						f6_local0 = IsPC()
						if f6_local0 then
							f6_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("oic")
						end
					else
						f6_local0 = false
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f7_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f7_local0 then
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
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"])
						and not IsCodCaster(f1_arg1)
					then
						f7_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("oic")
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "EMPCodCaster",
			condition = function(menu, element, event)
				local f8_local0 = IsCodCaster(f1_arg1)
				if f8_local0 then
					f8_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_inventory", 1)
					if f8_local0 then
						if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"]) then
							f8_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerhud", 1)
							if f8_local0 then
								if not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1) then
									f8_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "hacked", 1)
								else
									f8_local0 = false
								end
							else
								return f8_local0
							end
						end
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "VisibleCodCaster",
			condition = function(menu, element, event)
				local f9_local0 = IsCodCaster(f1_arg1)
				if f9_local0 then
					f9_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_inventory", 1)
					if f9_local0 then
						if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"]) then
							f9_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerhud", 1)
							if f9_local0 then
								f9_local0 = not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1)
							end
						else
							f9_local0 = false
						end
					end
				end
				return f9_local0
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["factions.isCoDCaster"], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.playerSpawned"], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.profileSettingsUpdated, function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.hacked, function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "hacked",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetMP_Ultimate.__resetProperties = function(f32_arg0)
	f32_arg0.UltimateRadialMeterwipe:completeAnimation()
	f32_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
	f32_arg0.HealCooldown:completeAnimation()
	f32_arg0.UltimateHacked:completeAnimation()
	f32_arg0.EMPbacker:completeAnimation()
	f32_arg0.CodCasterLoadoutSelection:completeAnimation()
	f32_arg0.UltimateRadialMeterwipe:setLeftRight(0, 0, 1, 270)
	f32_arg0.UltimateRadialMeterwipe:setTopBottom(0, 0, 0, 152)
	f32_arg0.UltimateRadialMeterwipe:setAlpha(1)
	f32_arg0.AmmoWidgetMPAbilityItem:setLeftRight(0, 0, 189, 261)
	f32_arg0.AmmoWidgetMPAbilityItem:setTopBottom(0, 0, 32, 91)
	f32_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
	f32_arg0.HealCooldown:setTopBottom(0, 0, 31.5, 90.5)
	f32_arg0.HealCooldown:setAlpha(1)
	f32_arg0.UltimateHacked:setAlpha(0)
	f32_arg0.EMPbacker:setAlpha(0)
	f32_arg0.CodCasterLoadoutSelection:setAlpha(0)
end
CoD.AmmoWidgetMP_Ultimate.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
			f33_arg0.UltimateRadialMeterwipe:completeAnimation()
			f33_arg0.UltimateRadialMeterwipe:setLeftRight(0, 0, -28.5, 101.5)
			f33_arg0.UltimateRadialMeterwipe:setTopBottom(0, 0, -59, 93)
			f33_arg0.UltimateRadialMeterwipe:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.UltimateRadialMeterwipe)
			f33_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f33_arg0.AmmoWidgetMPAbilityItem:setLeftRight(0, 0, 122, 194)
			f33_arg0.AmmoWidgetMPAbilityItem:setTopBottom(0, 0, -29.5, 29.5)
			f33_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.AmmoWidgetMPAbilityItem)
			f33_arg0.HealCooldown:completeAnimation()
			f33_arg0.HealCooldown:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.HealCooldown)
		end,
	},
	EMP = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(5)
			f34_arg0.UltimateRadialMeterwipe:completeAnimation()
			f34_arg0.UltimateRadialMeterwipe:setLeftRight(0, 0, -28.5, 101.5)
			f34_arg0.UltimateRadialMeterwipe:setTopBottom(0, 0, -59, 93)
			f34_arg0.UltimateRadialMeterwipe:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.UltimateRadialMeterwipe)
			f34_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f34_arg0.AmmoWidgetMPAbilityItem:setLeftRight(0, 0, 122, 194)
			f34_arg0.AmmoWidgetMPAbilityItem:setTopBottom(0, 0, -29.5, 29.5)
			f34_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.AmmoWidgetMPAbilityItem)
			f34_arg0.HealCooldown:completeAnimation()
			f34_arg0.HealCooldown:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.HealCooldown)
			f34_arg0.EMPbacker:completeAnimation()
			f34_arg0.EMPbacker:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.EMPbacker)
			f34_arg0.UltimateHacked:completeAnimation()
			f34_arg0.UltimateHacked:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.UltimateHacked)
		end,
		Visible = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(4)
			local f35_local0 = function(f36_arg0)
				f35_arg0.UltimateRadialMeterwipe:beginAnimation(600, Enum[@"luitween"][@"luitween_ease_both"])
				f35_arg0.UltimateRadialMeterwipe:setTopBottom(0, 0, 0, 152)
				f35_arg0.UltimateRadialMeterwipe:setAlpha(1)
				f35_arg0.UltimateRadialMeterwipe:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.UltimateRadialMeterwipe:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.UltimateRadialMeterwipe:completeAnimation()
			f35_arg0.UltimateRadialMeterwipe:setTopBottom(0, 0, 20, 20)
			f35_arg0.UltimateRadialMeterwipe:setAlpha(0)
			f35_local0(f35_arg0.UltimateRadialMeterwipe)
			local f35_local1 = function(f37_arg0)
				f35_arg0.AmmoWidgetMPAbilityItem:beginAnimation(600, Enum[@"luitween"][@"luitween_ease_both"])
				f35_arg0.AmmoWidgetMPAbilityItem:setTopBottom(0, 0, 32, 91)
				f35_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
				f35_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f35_arg0.AmmoWidgetMPAbilityItem:setTopBottom(0, 0, 61, 120)
			f35_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f35_local1(f35_arg0.AmmoWidgetMPAbilityItem)
			local f35_local2 = function(f38_arg0)
				f35_arg0.HealCooldown:beginAnimation(600, Enum[@"luitween"][@"luitween_ease_both"])
				f35_arg0.HealCooldown:setTopBottom(0, 0, 30.5, 89.5)
				f35_arg0.HealCooldown:setAlpha(1)
				f35_arg0.HealCooldown:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.HealCooldown:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.HealCooldown:completeAnimation()
			f35_arg0.HealCooldown:setTopBottom(0, 0, 59.5, 118.5)
			f35_arg0.HealCooldown:setAlpha(0)
			f35_local2(f35_arg0.HealCooldown)
			f35_arg0.UltimateHacked:completeAnimation()
			f35_arg0.UltimateHacked:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.UltimateHacked)
		end,
		VisiblePC = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(3)
			local f39_local0 = function(f40_arg0)
				f39_arg0.UltimateRadialMeterwipe:beginAnimation(200)
				f39_arg0.UltimateRadialMeterwipe:setTopBottom(0, 0, 0, 152)
				f39_arg0.UltimateRadialMeterwipe:setAlpha(1)
				f39_arg0.UltimateRadialMeterwipe:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.UltimateRadialMeterwipe:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.UltimateRadialMeterwipe:completeAnimation()
			f39_arg0.UltimateRadialMeterwipe:setTopBottom(0, 0, 20, 20)
			f39_arg0.UltimateRadialMeterwipe:setAlpha(0)
			f39_local0(f39_arg0.UltimateRadialMeterwipe)
			local f39_local1 = function(f41_arg0)
				f39_arg0.AmmoWidgetMPAbilityItem:beginAnimation(200)
				f39_arg0.AmmoWidgetMPAbilityItem:setTopBottom(0, 0, 32, 91)
				f39_arg0.AmmoWidgetMPAbilityItem:setAlpha(1)
				f39_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.AmmoWidgetMPAbilityItem:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.AmmoWidgetMPAbilityItem:completeAnimation()
			f39_arg0.AmmoWidgetMPAbilityItem:setTopBottom(0, 0, 61, 120)
			f39_arg0.AmmoWidgetMPAbilityItem:setAlpha(0)
			f39_local1(f39_arg0.AmmoWidgetMPAbilityItem)
			local f39_local2 = function(f42_arg0)
				f39_arg0.HealCooldown:beginAnimation(200)
				f39_arg0.HealCooldown:setTopBottom(0, 0, 30.5, 89.5)
				f39_arg0.HealCooldown:setAlpha(1)
				f39_arg0.HealCooldown:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.HealCooldown:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.HealCooldown:completeAnimation()
			f39_arg0.HealCooldown:setTopBottom(0, 0, 59.5, 118.5)
			f39_arg0.HealCooldown:setAlpha(0)
			f39_local2(f39_arg0.HealCooldown)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(1)
			f44_arg0.CodCasterLoadoutSelection:completeAnimation()
			f44_arg0.CodCasterLoadoutSelection:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.CodCasterLoadoutSelection)
		end,
	},
	EMPCodCaster = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(0)
		end,
	},
	VisibleCodCaster = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.AmmoWidgetMP_Ultimate.__onClose = function(f47_arg0)
	f47_arg0.UltimateRadialMeterwipe:close()
	f47_arg0.AmmoWidgetMPAbilityItem:close()
	f47_arg0.HealCooldown:close()
	f47_arg0.CodCasterLoadoutSelection:close()
	f47_arg0.Hacked:close()
end
