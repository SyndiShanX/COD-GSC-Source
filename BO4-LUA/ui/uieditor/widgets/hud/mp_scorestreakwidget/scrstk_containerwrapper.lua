require("x64:34a92edebb7e23a")
require("x64:14d8c528b28bbcf")
CoD.ScrStk_ContainerWrapper = InheritFrom(LUI.UIElement)
CoD.ScrStk_ContainerWrapper.__defaultWidth = 163
CoD.ScrStk_ContainerWrapper.__defaultHeight = 262
CoD.ScrStk_ContainerWrapper.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_ContainerWrapper)
	self.id = "ScrStk_ContainerWrapper"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScrStkContainer = CoD.ScrStk_Container.new(f1_arg0, f1_arg1, 0, 0, 0, 163, 0, 0, 0, 262)
	ScrStkContainer:setAlpha(0)
	self:addElement(ScrStkContainer)
	self.ScrStkContainer = ScrStkContainer
	local EMPbacker = LUI.UIImage.new(0, 0, 82.5, 162.5, 0, 0, 44, 244)
	EMPbacker:setRGB(0, 0, 0)
	EMPbacker:setAlpha(0)
	EMPbacker:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_score_streak"))
	self:addElement(EMPbacker)
	self.EMPbacker = EMPbacker
	local ScrStkHackedBg = LUI.UIImage.new(0, 0, 88, 158, 0, 0, 49.5, 237.5)
	ScrStkHackedBg:setAlpha(0)
	ScrStkHackedBg:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_score_streak"))
	self:addElement(ScrStkHackedBg)
	self.ScrStkHackedBg = ScrStkHackedBg
	local ScrStkHackedScrambled02 = LUI.UIImage.new(0, 0, 88, 158, 0, 0, 49.5, 237.5)
	ScrStkHackedScrambled02:setAlpha(0)
	ScrStkHackedScrambled02:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_score_streak"))
	ScrStkHackedScrambled02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1EA736E2B2799BB4"))
	ScrStkHackedScrambled02:setShaderVector(2, 3.8, 0, 0, 0)
	self:addElement(ScrStkHackedScrambled02)
	self.ScrStkHackedScrambled02 = ScrStkHackedScrambled02
	local ScrStkHackedEMP = LUI.UIImage.new(0, 0, 88, 158, 0, 0, 49.5, 237.5)
	ScrStkHackedEMP:setAlpha(0)
	ScrStkHackedEMP:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_score_streak"))
	ScrStkHackedEMP:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_emp"))
	ScrStkHackedEMP:setShaderVector(0, 20, 0, 0, 0)
	ScrStkHackedEMP:setShaderVector(1, 1, 0, 0, 0)
	ScrStkHackedEMP:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(ScrStkHackedEMP)
	self.ScrStkHackedEMP = ScrStkHackedEMP
	local ScrStkHackedScrambled01 = LUI.UIImage.new(0, 0, 88, 158, 0, 0, 49.5, 237.5)
	ScrStkHackedScrambled01:setAlpha(0)
	ScrStkHackedScrambled01:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_score_streak"))
	ScrStkHackedScrambled01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1EA736E2B2799BB4"))
	ScrStkHackedScrambled01:setShaderVector(2, 2.5, 0, 0, 0)
	self:addElement(ScrStkHackedScrambled01)
	self.ScrStkHackedScrambled01 = ScrStkHackedScrambled01
	local Hacked = CoD.hud_hacked_streaks_widget.new(f1_arg0, f1_arg1, 0, 0, 88, 156, 0, 0, 52, 241)
	self:addElement(Hacked)
	self.Hacked = Hacked
	self:mergeStateConditions({
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				local f2_local0
				if
					not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
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
				then
					f2_local0 = CoD.BountyHunterUtility.HasBountyStreakOrNotBounty(f1_arg1)
					if f2_local0 then
						if not CoD.HUDUtility.IsGameTypeEqualToString("gun") then
							f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						else
							f2_local0 = false
						end
					end
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f3_local0
				if
					not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
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
				then
					f3_local0 = CoD.BountyHunterUtility.HasBountyStreakOrNotBounty(f1_arg1)
					if f3_local0 then
						f3_local0 = IsPC()
						if f3_local0 then
							f3_local0 = not CoD.HUDUtility.ShouldHideScorestreaks()
						end
					end
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f4_local0
				if
					not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
					and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
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
				then
					f4_local0 = CoD.BountyHunterUtility.HasBountyStreakOrNotBounty(f1_arg1)
					if f4_local0 then
						f4_local0 = not CoD.HUDUtility.ShouldHideScorestreaks()
					end
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "InvisibleHardcore",
			condition = function(menu, element, event)
				local f5_local0 = IsVisibilityBitSet(f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
				if f5_local0 then
					if not IsVisibilityBitSet(f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not IsGameTypeCombatTraining() then
						f5_local0 = CoD.PlayerRoleUtility.IsPositionDraftStage(f1_arg1, CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_NONE)
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.showSpawnSelect"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
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
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["killstreaks.killstreak3.rewardAmmo"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "killstreaks.killstreak3.rewardAmmo",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["PositionDraft.stage"], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "PositionDraft.stage",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f27_arg2, f27_arg3, f27_arg4)
		if IsSelfInState(self, "DefaultState") then
			SetLoseFocusToSelf(self, controller)
		elseif not IsDemoPlaying() then
			SetFocusToSelf(self, controller)
		end
	end)
	ScrStkContainer.id = "ScrStkContainer"
	self.__defaultFocus = ScrStkContainer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.ScrStkContainer)
	return self
end
CoD.ScrStk_ContainerWrapper.__resetProperties = function(f28_arg0)
	f28_arg0.ScrStkHackedEMP:completeAnimation()
	f28_arg0.EMPbacker:completeAnimation()
	f28_arg0.ScrStkContainer:completeAnimation()
	f28_arg0.ScrStkHackedScrambled02:completeAnimation()
	f28_arg0.ScrStkHackedBg:completeAnimation()
	f28_arg0.ScrStkHackedScrambled01:completeAnimation()
	f28_arg0.Hacked:completeAnimation()
	f28_arg0.ScrStkHackedEMP:setAlpha(0)
	f28_arg0.EMPbacker:setAlpha(0)
	f28_arg0.ScrStkContainer:setLeftRight(0, 0, 0, 163)
	f28_arg0.ScrStkContainer:setAlpha(0)
	f28_arg0.ScrStkHackedScrambled02:setAlpha(0)
	f28_arg0.ScrStkHackedBg:setAlpha(0)
	f28_arg0.ScrStkHackedScrambled01:setAlpha(0)
	f28_arg0.Hacked:setAlpha(1)
end
CoD.ScrStk_ContainerWrapper.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.EMPbacker:completeAnimation()
			f29_arg0.EMPbacker:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.EMPbacker)
			f29_arg0.ScrStkHackedEMP:completeAnimation()
			f29_arg0.ScrStkHackedEMP:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ScrStkHackedEMP)
		end,
		Visable = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.ScrStkContainer:beginAnimation(600, Enum[@"luitween"][@"luitween_ease_both"])
				f30_arg0.ScrStkContainer:setLeftRight(0, 0, 0, 163)
				f30_arg0.ScrStkContainer:setAlpha(1)
				f30_arg0.ScrStkContainer:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.ScrStkContainer:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.ScrStkContainer:completeAnimation()
			f30_arg0.ScrStkContainer:setLeftRight(0, 0, 20, 183)
			f30_arg0.ScrStkContainer:setAlpha(0)
			f30_local0(f30_arg0.ScrStkContainer)
		end,
		VisiblePC = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			local f32_local0 = function(f33_arg0)
				f32_arg0.ScrStkContainer:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f32_arg0.ScrStkContainer:setLeftRight(0, 0, 0, 163)
				f32_arg0.ScrStkContainer:setAlpha(1)
				f32_arg0.ScrStkContainer:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ScrStkContainer:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.ScrStkContainer:completeAnimation()
			f32_arg0.ScrStkContainer:setLeftRight(0, 0, 20, 183)
			f32_arg0.ScrStkContainer:setAlpha(0)
			f32_local0(f32_arg0.ScrStkContainer)
		end,
	},
	EMP = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(6)
			f34_arg0.EMPbacker:completeAnimation()
			f34_arg0.EMPbacker:setAlpha(0.9)
			f34_arg0.clipFinished(f34_arg0.EMPbacker)
			f34_arg0.ScrStkHackedBg:completeAnimation()
			f34_arg0.ScrStkHackedBg:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ScrStkHackedBg)
			f34_arg0.ScrStkHackedScrambled02:completeAnimation()
			f34_arg0.ScrStkHackedScrambled02:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ScrStkHackedScrambled02)
			f34_arg0.ScrStkHackedEMP:completeAnimation()
			f34_arg0.ScrStkHackedEMP:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.ScrStkHackedEMP)
			f34_arg0.ScrStkHackedScrambled01:completeAnimation()
			f34_arg0.ScrStkHackedScrambled01:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ScrStkHackedScrambled01)
			f34_arg0.Hacked:completeAnimation()
			f34_arg0.Hacked:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Hacked)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.ScrStkContainer:completeAnimation()
			f35_arg0.ScrStkContainer:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.ScrStkContainer)
		end,
	},
	Visible = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.ScrStkContainer:completeAnimation()
			f36_arg0.ScrStkContainer:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.ScrStkContainer)
		end,
	},
	InvisibleHardcore = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ScrStk_ContainerWrapper.__onClose = function(f38_arg0)
	f38_arg0.ScrStkContainer:close()
	f38_arg0.Hacked:close()
end
