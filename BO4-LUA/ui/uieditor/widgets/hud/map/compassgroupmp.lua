require("x64:2b390c8152e424d")
require("x64:12bbcf811bbabdb")
require("x64:468ab2ec3656329")
require("x64:ab6874427430d62")
CoD.CompassGroupMP = InheritFrom(LUI.UIElement)
CoD.CompassGroupMP.__defaultWidth = 424
CoD.CompassGroupMP.__defaultHeight = 424
CoD.CompassGroupMP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "hudItems.smokeEffect", -0.1)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.CompassGroupMP)
	self.id = "CompassGroupMP"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SquareCompassBacking = LUI.UIImage.new(0, 1, 6, -6, 0, 1, 6, -6)
	SquareCompassBacking:setRGB(0, 0, 0)
	SquareCompassBacking:setScale(0.98, 0.98)
	SquareCompassBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(SquareCompassBacking)
	self.SquareCompassBacking = SquareCompassBacking
	local BackgroundNoFog = LUI.UIImage.new(0, 1, 10, -10, 0, 1, 10, -10)
	self:addElement(BackgroundNoFog)
	self.BackgroundNoFog = BackgroundNoFog
	local CompassMinimap = CoD.CompassMinimapMap.new(f1_arg0, f1_arg1, 0, 1, 10, -10, 0, 1, 10, -10)
	self:addElement(CompassMinimap)
	self.CompassMinimap = CompassMinimap
	local CompassItems0 = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0, 1, 10, -10, 0, 1, 10, -10)
	CompassItems0:setRGB(0, 0, 0)
	CompassItems0:setAlpha(0.6)
	self:addElement(CompassItems0)
	self.CompassItems0 = CompassItems0
	local CompassItems = CoD.CompassMinimapItems.new(f1_arg0, f1_arg1, 0, 1, 10, -10, 0, 1, 10, -10)
	self:addElement(CompassItems)
	self.CompassItems = CompassItems
	local CompassOverlay = CoD.CompassMinimapOverlay.new(f1_arg0, f1_arg1, 0, 1, 10, -10, 0, 1, 10, -10)
	self:addElement(CompassOverlay)
	self.CompassOverlay = CompassOverlay
	local smokeGrenadeEffect = CoD.CompassGroupMPSmoke.new(f1_arg0, f1_arg1, 0, 1, 10, -10, 0, 1, 10, -10)
	self:addElement(smokeGrenadeEffect)
	self.smokeGrenadeEffect = smokeGrenadeEffect
	self:mergeStateConditions({
		{
			stateName = "HudStartFog",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f2_local0 then
					if
						Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_compass_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					then
						f2_local0 = CoD.HUDUtility.IsFogOfWarEnabled(f1_arg1)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f3_local0 then
					if
						Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_compass_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
					then
						f3_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "HudPause",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned") and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
			end,
		},
		{
			stateName = "CodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.playerSpawned"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["factions.isCoDCaster"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassGroupMP.__resetProperties = function(f22_arg0)
	f22_arg0.CompassOverlay:completeAnimation()
	f22_arg0.CompassItems:completeAnimation()
	f22_arg0.CompassMinimap:completeAnimation()
	f22_arg0.CompassItems0:completeAnimation()
	f22_arg0.BackgroundNoFog:completeAnimation()
	f22_arg0.smokeGrenadeEffect:completeAnimation()
	f22_arg0.SquareCompassBacking:completeAnimation()
	f22_arg0.CompassOverlay:setAlpha(1)
	f22_arg0.CompassOverlay:setZoom(0)
	f22_arg0.CompassItems:setAlpha(1)
	f22_arg0.CompassItems:setZoom(0)
	f22_arg0.CompassMinimap:setRGB(1, 1, 1)
	f22_arg0.CompassMinimap:setAlpha(1)
	f22_arg0.CompassMinimap:setZoom(0)
	f22_arg0.CompassItems0:setAlpha(0.6)
	f22_arg0.BackgroundNoFog:setAlpha(1)
	f22_arg0.smokeGrenadeEffect:setAlpha(1)
	f22_arg0.SquareCompassBacking:setAlpha(1)
end
CoD.CompassGroupMP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(7)
			f23_arg0.SquareCompassBacking:completeAnimation()
			f23_arg0.SquareCompassBacking:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SquareCompassBacking)
			f23_arg0.BackgroundNoFog:completeAnimation()
			f23_arg0.BackgroundNoFog:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.BackgroundNoFog)
			f23_arg0.CompassMinimap:completeAnimation()
			f23_arg0.CompassMinimap:setAlpha(0)
			f23_arg0.CompassMinimap:setZoom(20)
			f23_arg0.clipFinished(f23_arg0.CompassMinimap)
			f23_arg0.CompassItems0:completeAnimation()
			f23_arg0.CompassItems0:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CompassItems0)
			f23_arg0.CompassItems:completeAnimation()
			f23_arg0.CompassItems:setAlpha(0)
			f23_arg0.CompassItems:setZoom(20)
			f23_arg0.clipFinished(f23_arg0.CompassItems)
			f23_arg0.CompassOverlay:completeAnimation()
			f23_arg0.CompassOverlay:setAlpha(0)
			f23_arg0.CompassOverlay:setZoom(20)
			f23_arg0.clipFinished(f23_arg0.CompassOverlay)
			f23_arg0.smokeGrenadeEffect:completeAnimation()
			f23_arg0.smokeGrenadeEffect:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.smokeGrenadeEffect)
		end,
		HudStart = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(5)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						f27_arg0:beginAnimation(130, Enum[@"luitween"][@"luitween_ease_out"])
						f27_arg0:setAlpha(1)
						f27_arg0:setZoom(0)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
					end
					f26_arg0:beginAnimation(69)
					f26_arg0:setZoom(13)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f24_arg0.CompassMinimap:beginAnimation(800)
				f24_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.CompassMinimap:completeAnimation()
			f24_arg0.CompassMinimap:setAlpha(0)
			f24_arg0.CompassMinimap:setZoom(20)
			f24_local0(f24_arg0.CompassMinimap)
			local f24_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(269)
					f29_arg0:setAlpha(0.6)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.CompassItems0:beginAnimation(770)
				f24_arg0.CompassItems0:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.CompassItems0:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f24_arg0.CompassItems0:completeAnimation()
			f24_arg0.CompassItems0:setAlpha(0)
			f24_local1(f24_arg0.CompassItems0)
			local f24_local2 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(129)
					f31_arg0:setAlpha(0.75)
					f31_arg0:setZoom(0)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.CompassItems:beginAnimation(910)
				f24_arg0.CompassItems:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.CompassItems:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f24_arg0.CompassItems:completeAnimation()
			f24_arg0.CompassItems:setAlpha(0)
			f24_arg0.CompassItems:setZoom(20)
			f24_local2(f24_arg0.CompassItems)
			local f24_local3 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							local f35_local0 = function(f36_arg0)
								local f36_local0 = function(f37_arg0)
									local f37_local0 = function(f38_arg0)
										local f38_local0 = function(f39_arg0)
											local f39_local0 = function(f40_arg0)
												local f40_local0 = function(f41_arg0)
													f41_arg0:beginAnimation(9)
													f41_arg0:setAlpha(1)
													f41_arg0:setZoom(0)
													f41_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
												end
												f40_arg0:beginAnimation(19)
												f40_arg0:setZoom(2)
												f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
											end
											f39_arg0:beginAnimation(9)
											f39_arg0:setAlpha(0.5)
											f39_arg0:setZoom(5)
											f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
										end
										f38_arg0:beginAnimation(20)
										f38_arg0:setZoom(6)
										f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
									end
									f37_arg0:beginAnimation(9)
									f37_arg0:setAlpha(1)
									f37_arg0:setZoom(9)
									f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
								end
								f36_arg0:beginAnimation(19)
								f36_arg0:setZoom(11)
								f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
							end
							f35_arg0:beginAnimation(9)
							f35_arg0:setAlpha(0)
							f35_arg0:setZoom(14)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
						end
						f34_arg0:beginAnimation(19)
						f34_arg0:setZoom(15)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(9)
					f33_arg0:setAlpha(0.5)
					f33_arg0:setZoom(18)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f24_arg0.CompassOverlay:beginAnimation(980)
				f24_arg0.CompassOverlay:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.CompassOverlay:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f24_arg0.CompassOverlay:completeAnimation()
			f24_arg0.CompassOverlay:setAlpha(0)
			f24_arg0.CompassOverlay:setZoom(20)
			f24_local3(f24_arg0.CompassOverlay)
			local f24_local4 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					f43_arg0:beginAnimation(9)
					f43_arg0:setAlpha(1)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.smokeGrenadeEffect:beginAnimation(1130)
				f24_arg0.smokeGrenadeEffect:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.smokeGrenadeEffect:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f24_arg0.smokeGrenadeEffect:completeAnimation()
			f24_arg0.smokeGrenadeEffect:setAlpha(0)
			f24_local4(f24_arg0.smokeGrenadeEffect)
		end,
		HudStartFog = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(6)
			f44_arg0.BackgroundNoFog:completeAnimation()
			f44_arg0.BackgroundNoFog:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.BackgroundNoFog)
			local f44_local0 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					local f46_local0 = function(f47_arg0)
						f47_arg0:beginAnimation(130)
						f47_arg0:setAlpha(1)
						f47_arg0:setZoom(0)
						f47_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
					end
					f46_arg0:beginAnimation(69)
					f46_arg0:setZoom(13)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
				end
				f44_arg0.CompassMinimap:beginAnimation(800)
				f44_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f44_arg0.CompassMinimap:completeAnimation()
			f44_arg0.CompassMinimap:setRGB(1, 1, 1)
			f44_arg0.CompassMinimap:setAlpha(0)
			f44_arg0.CompassMinimap:setZoom(20)
			f44_local0(f44_arg0.CompassMinimap)
			local f44_local1 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					f49_arg0:beginAnimation(269)
					f49_arg0:setAlpha(0.6)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
				end
				f44_arg0.CompassItems0:beginAnimation(770)
				f44_arg0.CompassItems0:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.CompassItems0:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f44_arg0.CompassItems0:completeAnimation()
			f44_arg0.CompassItems0:setAlpha(0)
			f44_local1(f44_arg0.CompassItems0)
			local f44_local2 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					f51_arg0:beginAnimation(129)
					f51_arg0:setAlpha(0.75)
					f51_arg0:setZoom(0)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
				end
				f44_arg0.CompassItems:beginAnimation(910)
				f44_arg0.CompassItems:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.CompassItems:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f44_arg0.CompassItems:completeAnimation()
			f44_arg0.CompassItems:setAlpha(0)
			f44_arg0.CompassItems:setZoom(20)
			f44_local2(f44_arg0.CompassItems)
			local f44_local3 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					local f53_local0 = function(f54_arg0)
						local f54_local0 = function(f55_arg0)
							local f55_local0 = function(f56_arg0)
								local f56_local0 = function(f57_arg0)
									local f57_local0 = function(f58_arg0)
										local f58_local0 = function(f59_arg0)
											local f59_local0 = function(f60_arg0)
												local f60_local0 = function(f61_arg0)
													f61_arg0:beginAnimation(9)
													f61_arg0:setAlpha(1)
													f61_arg0:setZoom(0)
													f61_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
												end
												f60_arg0:beginAnimation(19)
												f60_arg0:setZoom(2)
												f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
											end
											f59_arg0:beginAnimation(9)
											f59_arg0:setAlpha(0.5)
											f59_arg0:setZoom(5)
											f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
										end
										f58_arg0:beginAnimation(20)
										f58_arg0:setZoom(6)
										f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
									end
									f57_arg0:beginAnimation(9)
									f57_arg0:setAlpha(1)
									f57_arg0:setZoom(9)
									f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
								end
								f56_arg0:beginAnimation(19)
								f56_arg0:setZoom(11)
								f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
							end
							f55_arg0:beginAnimation(9)
							f55_arg0:setAlpha(0)
							f55_arg0:setZoom(14)
							f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
						end
						f54_arg0:beginAnimation(19)
						f54_arg0:setZoom(15)
						f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
					end
					f53_arg0:beginAnimation(9)
					f53_arg0:setAlpha(0.5)
					f53_arg0:setZoom(18)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
				end
				f44_arg0.CompassOverlay:beginAnimation(980)
				f44_arg0.CompassOverlay:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.CompassOverlay:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f44_arg0.CompassOverlay:completeAnimation()
			f44_arg0.CompassOverlay:setAlpha(0)
			f44_arg0.CompassOverlay:setZoom(20)
			f44_local3(f44_arg0.CompassOverlay)
			local f44_local4 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					f63_arg0:beginAnimation(9)
					f63_arg0:setAlpha(1)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
				end
				f44_arg0.smokeGrenadeEffect:beginAnimation(1130)
				f44_arg0.smokeGrenadeEffect:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.smokeGrenadeEffect:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f44_arg0.smokeGrenadeEffect:completeAnimation()
			f44_arg0.smokeGrenadeEffect:setAlpha(0)
			f44_local4(f44_arg0.smokeGrenadeEffect)
		end,
	},
	HudStartFog = {
		DefaultClip = function(f64_arg0, f64_arg1)
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter(2)
			f64_arg0.BackgroundNoFog:completeAnimation()
			f64_arg0.BackgroundNoFog:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.BackgroundNoFog)
			local f64_local0 = function(f65_arg0)
				f64_arg0.CompassMinimap:beginAnimation(1210)
				f64_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f64_arg0.clipInterrupted)
				f64_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f64_arg0.clipFinished)
			end
			f64_arg0.CompassMinimap:completeAnimation()
			f64_arg0.CompassMinimap:setRGB(1, 1, 1)
			f64_local0(f64_arg0.CompassMinimap)
		end,
		DefaultState = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(5)
			local f66_local0 = function(f67_arg0)
				f66_arg0.CompassMinimap:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f66_arg0.CompassMinimap:setAlpha(0)
				f66_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.CompassMinimap:completeAnimation()
			f66_arg0.CompassMinimap:setAlpha(1)
			f66_local0(f66_arg0.CompassMinimap)
			local f66_local1 = function(f68_arg0)
				f66_arg0.CompassItems0:beginAnimation(500)
				f66_arg0.CompassItems0:setAlpha(0)
				f66_arg0.CompassItems0:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.CompassItems0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.CompassItems0:completeAnimation()
			f66_arg0.CompassItems0:setAlpha(0.6)
			f66_local1(f66_arg0.CompassItems0)
			local f66_local2 = function(f69_arg0)
				f66_arg0.CompassItems:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f66_arg0.CompassItems:setAlpha(0)
				f66_arg0.CompassItems:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.CompassItems:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.CompassItems:completeAnimation()
			f66_arg0.CompassItems:setAlpha(0.75)
			f66_local2(f66_arg0.CompassItems)
			local f66_local3 = function(f70_arg0)
				f66_arg0.CompassOverlay:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f66_arg0.CompassOverlay:setAlpha(0)
				f66_arg0.CompassOverlay:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.CompassOverlay:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.CompassOverlay:completeAnimation()
			f66_arg0.CompassOverlay:setAlpha(1)
			f66_local3(f66_arg0.CompassOverlay)
			local f66_local4 = function(f71_arg0)
				f66_arg0.smokeGrenadeEffect:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f66_arg0.smokeGrenadeEffect:setAlpha(0)
				f66_arg0.smokeGrenadeEffect:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.smokeGrenadeEffect:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.smokeGrenadeEffect:completeAnimation()
			f66_arg0.smokeGrenadeEffect:setAlpha(1)
			f66_local4(f66_arg0.smokeGrenadeEffect)
		end,
	},
	HudStart = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(1)
			f72_arg0.CompassMinimap:completeAnimation()
			f72_arg0.CompassMinimap:setRGB(0.51, 0.51, 0.51)
			f72_arg0.clipFinished(f72_arg0.CompassMinimap)
		end,
		DefaultState = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(5)
			local f73_local0 = function(f74_arg0)
				f73_arg0.CompassMinimap:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f73_arg0.CompassMinimap:setAlpha(0)
				f73_arg0.CompassMinimap:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.CompassMinimap:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.CompassMinimap:completeAnimation()
			f73_arg0.CompassMinimap:setAlpha(1)
			f73_local0(f73_arg0.CompassMinimap)
			local f73_local1 = function(f75_arg0)
				f73_arg0.CompassItems0:beginAnimation(500)
				f73_arg0.CompassItems0:setAlpha(0)
				f73_arg0.CompassItems0:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.CompassItems0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.CompassItems0:completeAnimation()
			f73_arg0.CompassItems0:setAlpha(0.6)
			f73_local1(f73_arg0.CompassItems0)
			local f73_local2 = function(f76_arg0)
				f73_arg0.CompassItems:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f73_arg0.CompassItems:setAlpha(0)
				f73_arg0.CompassItems:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.CompassItems:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.CompassItems:completeAnimation()
			f73_arg0.CompassItems:setAlpha(0.75)
			f73_local2(f73_arg0.CompassItems)
			local f73_local3 = function(f77_arg0)
				f73_arg0.CompassOverlay:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f73_arg0.CompassOverlay:setAlpha(0)
				f73_arg0.CompassOverlay:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.CompassOverlay:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.CompassOverlay:completeAnimation()
			f73_arg0.CompassOverlay:setAlpha(1)
			f73_local3(f73_arg0.CompassOverlay)
			local f73_local4 = function(f78_arg0)
				f73_arg0.smokeGrenadeEffect:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f73_arg0.smokeGrenadeEffect:setAlpha(0)
				f73_arg0.smokeGrenadeEffect:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.smokeGrenadeEffect:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.smokeGrenadeEffect:completeAnimation()
			f73_arg0.smokeGrenadeEffect:setAlpha(1)
			f73_local4(f73_arg0.smokeGrenadeEffect)
		end,
	},
	HudPause = {
		DefaultClip = function(f79_arg0, f79_arg1)
			f79_arg0:__resetProperties()
			f79_arg0:setupElementClipCounter(0)
		end,
	},
	CodCaster = {
		DefaultClip = function(f80_arg0, f80_arg1)
			f80_arg0:__resetProperties()
			f80_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CompassGroupMP.__onClose = function(f81_arg0)
	f81_arg0.CompassMinimap:close()
	f81_arg0.CompassItems0:close()
	f81_arg0.CompassItems:close()
	f81_arg0.CompassOverlay:close()
	f81_arg0.smokeGrenadeEffect:close()
end
