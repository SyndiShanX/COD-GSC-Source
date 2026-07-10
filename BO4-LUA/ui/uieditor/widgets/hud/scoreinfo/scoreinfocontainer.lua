require("x64:7757ffe244726b9")
require("x64:edd35fd876fa2db")
require("x64:a096a04b0ce686d")
require("x64:2b8a915cdb60244")
CoD.ScoreInfoContainer = InheritFrom(LUI.UIElement)
CoD.ScoreInfoContainer.__defaultWidth = 210
CoD.ScoreInfoContainer.__defaultHeight = 103
CoD.ScoreInfoContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.tankState", 0)
	self:setClass(CoD.ScoreInfoContainer)
	self.id = "ScoreInfoContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BountyHunterCashMoney = CoD.BountyHunterPlayerMoney.new(f1_arg0, f1_arg1, 0.5, 0.5, -102.5, 102.5, 0, 0, -36, 4)
	BountyHunterCashMoney:subscribeToGlobalModel(f1_arg1, "PerController", nil, function(model)
		BountyHunterCashMoney:setModel(model, f1_arg1)
	end)
	self:addElement(BountyHunterCashMoney)
	self.BountyHunterCashMoney = BountyHunterCashMoney
	local ScoreInfoTimer = CoD.ScoreInfo_Timer.new(f1_arg0, f1_arg1, 0.5, 0.5, -102.5, 102.5, 0, 0, 63, 103)
	ScoreInfoTimer:mergeStateConditions({
		{
			stateName = "HardpointActive",
			condition = function(menu, element, event)
				local f3_local0 = CoD.HUDUtility.IsGameTypeEqualToString("koth")
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0)
					if f3_local0 then
						if not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "gameScore.gameTimeLow", 1) then
							f3_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						else
							f3_local0 = false
						end
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "HardpointTimeLow",
			condition = function(menu, element, event)
				local f4_local0 = CoD.HUDUtility.IsGameTypeEqualToString("koth")
				if f4_local0 then
					f4_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0)
					if f4_local0 then
						f4_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "PropHunt",
			condition = function(menu, element, event)
				local f5_local0 = CoD.HUDUtility.IsGameTypeEqualToString("prop")
				if f5_local0 then
					f5_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0)
					if f5_local0 then
						if not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "gameScore.gameTimeLow", 1) then
							f5_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						else
							f5_local0 = false
						end
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "PropHuntTimeLow",
			condition = function(menu, element, event)
				local f6_local0 = CoD.HUDUtility.IsGameTypeEqualToString("prop")
				if f6_local0 then
					f6_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0)
					if f6_local0 then
						f6_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f7_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0)
				if f7_local0 then
					if not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "gameScore.gameTimeLow", 1) then
						f7_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "Overtime",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "gameScore.gameTimeOvertime") and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
			end,
		},
		{
			stateName = "TimeLow",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
			end,
		},
	})
	local EMPbacker = ScoreInfoTimer
	local ScoreInfo = ScoreInfoTimer.subscribeToModel
	local ScoreInfoHacked = Engine[@"getmodelforcontroller"](f1_arg1)
	ScoreInfo(EMPbacker, ScoreInfoHacked["gameScore.gameTimeEnd"], function(f10_arg0)
		f1_arg0:updateElementState(ScoreInfoTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "gameScore.gameTimeEnd",
		})
	end, false)
	EMPbacker = ScoreInfoTimer
	ScoreInfo = ScoreInfoTimer.subscribeToModel
	ScoreInfoHacked = Engine[@"getmodelforcontroller"](f1_arg1)
	ScoreInfo(EMPbacker, ScoreInfoHacked["gameScore.gameTimeLow"], function(f11_arg0)
		f1_arg0:updateElementState(ScoreInfoTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "gameScore.gameTimeLow",
		})
	end, false)
	EMPbacker = ScoreInfoTimer
	ScoreInfo = ScoreInfoTimer.subscribeToModel
	ScoreInfoHacked = Engine[@"getmodelforcontroller"](f1_arg1)
	ScoreInfo(EMPbacker, ScoreInfoHacked["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f12_arg0)
		f1_arg0:updateElementState(ScoreInfoTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	EMPbacker = ScoreInfoTimer
	ScoreInfo = ScoreInfoTimer.subscribeToModel
	ScoreInfoHacked = Engine[@"getmodelforcontroller"](f1_arg1)
	ScoreInfo(EMPbacker, ScoreInfoHacked["gameScore.gameTimeOvertime"], function(f13_arg0)
		f1_arg0:updateElementState(ScoreInfoTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "gameScore.gameTimeOvertime",
		})
	end, false)
	self:addElement(ScoreInfoTimer)
	self.ScoreInfoTimer = ScoreInfoTimer
	ScoreInfo = CoD.ScoreInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 210, 0, 0, 0, 68)
	self:addElement(ScoreInfo)
	self.ScoreInfo = ScoreInfo
	EMPbacker = LUI.UIImage.new(0, 0, -10.5, 221.5, 0, 0, -11.5, 112.5)
	EMPbacker:setRGB(0, 0, 0)
	EMPbacker:setAlpha(0)
	EMPbacker:setImage(RegisterImage(@"hash_3F90B8BFAD34F9E3"))
	self:addElement(EMPbacker)
	self.EMPbacker = EMPbacker
	ScoreInfoHacked = LUI.UIImage.new(0, 0, 1, 209, 0, 0, -1, 103)
	ScoreInfoHacked:setAlpha(0)
	ScoreInfoHacked:setImage(RegisterImage(@"hash_3F90B8BFAD34F9E3"))
	ScoreInfoHacked:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_emp"))
	ScoreInfoHacked:setShaderVector(0, 25, 0, 0, 0)
	ScoreInfoHacked:setShaderVector(1, 1, 0, 0, 0)
	ScoreInfoHacked:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(ScoreInfoHacked)
	self.ScoreInfoHacked = ScoreInfoHacked
	local Hacked = CoD.hud_hacked_score_widget.new(f1_arg0, f1_arg1, 0, 0, -2.5, 217.5, 0, 0, -2, 70)
	self:addElement(Hacked)
	self.Hacked = Hacked
	self:mergeStateConditions({
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				local f14_local0
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
					f14_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
					if f14_local0 then
						f14_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
					end
				else
					f14_local0 = false
				end
				return f14_local0
			end,
		},
		{
			stateName = "VisibleSpawnSelectPC",
			condition = function(menu, element, event)
				local f15_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f15_local0 then
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
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
						and not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
					then
						f15_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
						if f15_local0 then
							f15_local0 = IsPC()
						end
					else
						f15_local0 = false
					end
				end
				return f15_local0
			end,
		},
		{
			stateName = "VisibleBountyPC",
			condition = function(menu, element, event)
				local f16_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f16_local0 then
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
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
						and not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
					then
						f16_local0 = CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1)
						if f16_local0 then
							f16_local0 = IsPC()
						end
					else
						f16_local0 = false
					end
				end
				return f16_local0
			end,
		},
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f17_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f17_local0 then
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
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
						and not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
					then
						f17_local0 = IsPC()
					else
						f17_local0 = false
					end
				end
				return f17_local0
			end,
		},
		{
			stateName = "VisibleSpawnSelect",
			condition = function(menu, element, event)
				local f18_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f18_local0 then
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
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
						and not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
					then
						f18_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
					else
						f18_local0 = false
					end
				end
				return f18_local0
			end,
		},
		{
			stateName = "VisibleBounty",
			condition = function(menu, element, event)
				local f19_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f19_local0 then
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
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
						and not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
					then
						f19_local0 = CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1)
					else
						f19_local0 = false
					end
				end
				return f19_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f20_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f20_local0 then
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
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_team_spectator"])
					then
						f20_local0 = not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
					else
						f20_local0 = false
					end
				end
				return f20_local0
			end,
		},
		{
			stateName = "CodCasterInvisible",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f36_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["factions.isCoDCaster"], function(f37_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.playerSpawned"], function(f38_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f39_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f40_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"]], function(f41_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.showSpawnSelect"], function(f42_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	ScoreInfo.id = "ScoreInfo"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoContainer.__resetProperties = function(f43_arg0)
	f43_arg0.ScoreInfoTimer:completeAnimation()
	f43_arg0.ScoreInfo:completeAnimation()
	f43_arg0.BountyHunterCashMoney:completeAnimation()
	f43_arg0.ScoreInfoHacked:completeAnimation()
	f43_arg0.EMPbacker:completeAnimation()
	f43_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
	f43_arg0.ScoreInfoTimer:setTopBottom(0, 0, 63, 103)
	f43_arg0.ScoreInfoTimer:setAlpha(1)
	f43_arg0.ScoreInfo:setLeftRight(0, 0, 0, 210)
	f43_arg0.ScoreInfo:setTopBottom(0, 0, 0, 68)
	f43_arg0.ScoreInfo:setAlpha(1)
	f43_arg0.BountyHunterCashMoney:setLeftRight(0.5, 0.5, -102.5, 102.5)
	f43_arg0.BountyHunterCashMoney:setTopBottom(0, 0, -36, 4)
	f43_arg0.BountyHunterCashMoney:setAlpha(1)
	f43_arg0.ScoreInfoHacked:setAlpha(0)
	f43_arg0.EMPbacker:setAlpha(0)
end
CoD.ScoreInfoContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(3)
			f44_arg0.BountyHunterCashMoney:completeAnimation()
			f44_arg0.BountyHunterCashMoney:setTopBottom(0, 0, -36, 4)
			f44_arg0.BountyHunterCashMoney:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.BountyHunterCashMoney)
			f44_arg0.ScoreInfoTimer:completeAnimation()
			f44_arg0.ScoreInfoTimer:setTopBottom(0, 0, 59, 93)
			f44_arg0.ScoreInfoTimer:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.ScoreInfoTimer)
			f44_arg0.ScoreInfo:completeAnimation()
			f44_arg0.ScoreInfo:setTopBottom(0, 0, 0, 68)
			f44_arg0.ScoreInfo:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.ScoreInfo)
		end,
		Visible = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			local f45_local0 = function(f46_arg0)
				f45_arg0.ScoreInfoTimer:beginAnimation(600)
				f45_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f45_arg0.ScoreInfoTimer:setAlpha(1)
				f45_arg0.ScoreInfoTimer:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.ScoreInfoTimer:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.ScoreInfoTimer:completeAnimation()
			f45_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f45_arg0.ScoreInfoTimer:setAlpha(0)
			f45_local0(f45_arg0.ScoreInfoTimer)
			local f45_local1 = function(f47_arg0)
				f45_arg0.ScoreInfo:beginAnimation(600)
				f45_arg0.ScoreInfo:setLeftRight(0, 0, 0, 166)
				f45_arg0.ScoreInfo:setAlpha(1)
				f45_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.ScoreInfo:completeAnimation()
			f45_arg0.ScoreInfo:setLeftRight(0, 0, -20, 146)
			f45_arg0.ScoreInfo:setAlpha(0)
			f45_local1(f45_arg0.ScoreInfo)
		end,
		VisibleSpawnSelect = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
			local f48_local0 = function(f49_arg0)
				f48_arg0.ScoreInfoTimer:beginAnimation(600)
				f48_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f48_arg0.ScoreInfoTimer:setAlpha(1)
				f48_arg0.ScoreInfoTimer:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.ScoreInfoTimer:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.ScoreInfoTimer:completeAnimation()
			f48_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f48_arg0.ScoreInfoTimer:setAlpha(0)
			f48_local0(f48_arg0.ScoreInfoTimer)
			local f48_local1 = function(f50_arg0)
				f48_arg0.ScoreInfo:beginAnimation(600)
				f48_arg0.ScoreInfo:setLeftRight(0, 0, 0, 166)
				f48_arg0.ScoreInfo:setAlpha(1)
				f48_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.ScoreInfo:completeAnimation()
			f48_arg0.ScoreInfo:setLeftRight(0, 0, -20, 146)
			f48_arg0.ScoreInfo:setAlpha(0)
			f48_local1(f48_arg0.ScoreInfo)
		end,
		VisibleBounty = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(3)
			local f51_local0 = function(f52_arg0)
				f51_arg0.BountyHunterCashMoney:beginAnimation(600)
				f51_arg0.BountyHunterCashMoney:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f51_arg0.BountyHunterCashMoney:setAlpha(1)
				f51_arg0.BountyHunterCashMoney:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.BountyHunterCashMoney:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.BountyHunterCashMoney:completeAnimation()
			f51_arg0.BountyHunterCashMoney:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f51_arg0.BountyHunterCashMoney:setTopBottom(0, 0, 0, 40)
			f51_arg0.BountyHunterCashMoney:setAlpha(0)
			f51_local0(f51_arg0.BountyHunterCashMoney)
			local f51_local1 = function(f53_arg0)
				f51_arg0.ScoreInfoTimer:beginAnimation(600)
				f51_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f51_arg0.ScoreInfoTimer:setTopBottom(0, 0, 99, 139)
				f51_arg0.ScoreInfoTimer:setAlpha(1)
				f51_arg0.ScoreInfoTimer:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.ScoreInfoTimer:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.ScoreInfoTimer:completeAnimation()
			f51_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f51_arg0.ScoreInfoTimer:setTopBottom(0, 0, 98.5, 138.5)
			f51_arg0.ScoreInfoTimer:setAlpha(0)
			f51_local1(f51_arg0.ScoreInfoTimer)
			local f51_local2 = function(f54_arg0)
				f51_arg0.ScoreInfo:beginAnimation(600)
				f51_arg0.ScoreInfo:setLeftRight(0, 0, 0, 210)
				f51_arg0.ScoreInfo:setAlpha(1)
				f51_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.ScoreInfo:completeAnimation()
			f51_arg0.ScoreInfo:setLeftRight(0, 0, -20, 190)
			f51_arg0.ScoreInfo:setTopBottom(0, 0, 36, 104)
			f51_arg0.ScoreInfo:setAlpha(0)
			f51_local2(f51_arg0.ScoreInfo)
		end,
		VisibleSpawnSelectPC = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(2)
			local f55_local0 = function(f56_arg0)
				f55_arg0.ScoreInfoTimer:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f55_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f55_arg0.ScoreInfoTimer:setAlpha(1)
				f55_arg0.ScoreInfoTimer:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.ScoreInfoTimer:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.ScoreInfoTimer:completeAnimation()
			f55_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f55_arg0.ScoreInfoTimer:setAlpha(0)
			f55_local0(f55_arg0.ScoreInfoTimer)
			local f55_local1 = function(f57_arg0)
				f55_arg0.ScoreInfo:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f55_arg0.ScoreInfo:setLeftRight(0, 0, 0, 166)
				f55_arg0.ScoreInfo:setAlpha(1)
				f55_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.ScoreInfo:completeAnimation()
			f55_arg0.ScoreInfo:setLeftRight(0, 0, -20, 146)
			f55_arg0.ScoreInfo:setAlpha(0)
			f55_local1(f55_arg0.ScoreInfo)
		end,
		VisiblePC = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(2)
			local f58_local0 = function(f59_arg0)
				f58_arg0.ScoreInfoTimer:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f58_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f58_arg0.ScoreInfoTimer:setAlpha(1)
				f58_arg0.ScoreInfoTimer:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.ScoreInfoTimer:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
			end
			f58_arg0.ScoreInfoTimer:completeAnimation()
			f58_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f58_arg0.ScoreInfoTimer:setAlpha(0)
			f58_local0(f58_arg0.ScoreInfoTimer)
			local f58_local1 = function(f60_arg0)
				f58_arg0.ScoreInfo:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f58_arg0.ScoreInfo:setLeftRight(0, 0, 0, 166)
				f58_arg0.ScoreInfo:setAlpha(1)
				f58_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f58_arg0.clipInterrupted)
				f58_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f58_arg0.clipFinished)
			end
			f58_arg0.ScoreInfo:completeAnimation()
			f58_arg0.ScoreInfo:setLeftRight(0, 0, -20, 146)
			f58_arg0.ScoreInfo:setAlpha(0)
			f58_local1(f58_arg0.ScoreInfo)
		end,
		VisibleBountyPC = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(3)
			local f61_local0 = function(f62_arg0)
				f61_arg0.BountyHunterCashMoney:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f61_arg0.BountyHunterCashMoney:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f61_arg0.BountyHunterCashMoney:setAlpha(1)
				f61_arg0.BountyHunterCashMoney:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.BountyHunterCashMoney:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.BountyHunterCashMoney:completeAnimation()
			f61_arg0.BountyHunterCashMoney:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f61_arg0.BountyHunterCashMoney:setTopBottom(0, 0, 0, 40)
			f61_arg0.BountyHunterCashMoney:setAlpha(0)
			f61_local0(f61_arg0.BountyHunterCashMoney)
			local f61_local1 = function(f63_arg0)
				f61_arg0.ScoreInfoTimer:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f61_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f61_arg0.ScoreInfoTimer:setTopBottom(0, 0, 99, 139)
				f61_arg0.ScoreInfoTimer:setAlpha(1)
				f61_arg0.ScoreInfoTimer:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.ScoreInfoTimer:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.ScoreInfoTimer:completeAnimation()
			f61_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f61_arg0.ScoreInfoTimer:setTopBottom(0, 0, 98.5, 138.5)
			f61_arg0.ScoreInfoTimer:setAlpha(0)
			f61_local1(f61_arg0.ScoreInfoTimer)
			local f61_local2 = function(f64_arg0)
				f61_arg0.ScoreInfo:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f61_arg0.ScoreInfo:setLeftRight(0, 0, 0, 210)
				f61_arg0.ScoreInfo:setAlpha(1)
				f61_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.ScoreInfo:completeAnimation()
			f61_arg0.ScoreInfo:setLeftRight(0, 0, -20, 190)
			f61_arg0.ScoreInfo:setTopBottom(0, 0, 36, 104)
			f61_arg0.ScoreInfo:setAlpha(0)
			f61_local2(f61_arg0.ScoreInfo)
		end,
	},
	EMP = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(5)
			f65_arg0.BountyHunterCashMoney:completeAnimation()
			f65_arg0.BountyHunterCashMoney:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.BountyHunterCashMoney)
			f65_arg0.ScoreInfoTimer:completeAnimation()
			f65_arg0.ScoreInfoTimer:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.ScoreInfoTimer)
			f65_arg0.ScoreInfo:completeAnimation()
			f65_arg0.ScoreInfo:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.ScoreInfo)
			f65_arg0.EMPbacker:completeAnimation()
			f65_arg0.EMPbacker:setAlpha(0.9)
			f65_arg0.clipFinished(f65_arg0.EMPbacker)
			f65_arg0.ScoreInfoHacked:completeAnimation()
			f65_arg0.ScoreInfoHacked:setAlpha(1)
			f65_arg0.clipFinished(f65_arg0.ScoreInfoHacked)
		end,
	},
	VisibleSpawnSelectPC = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(0)
		end,
		Visible = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(2)
			local f67_local0 = function(f68_arg0)
				f67_arg0.ScoreInfoTimer:beginAnimation(600)
				f67_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f67_arg0.ScoreInfoTimer:setAlpha(1)
				f67_arg0.ScoreInfoTimer:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.ScoreInfoTimer:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.ScoreInfoTimer:completeAnimation()
			f67_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f67_arg0.ScoreInfoTimer:setAlpha(0)
			f67_local0(f67_arg0.ScoreInfoTimer)
			local f67_local1 = function(f69_arg0)
				f67_arg0.ScoreInfo:beginAnimation(600)
				f67_arg0.ScoreInfo:setLeftRight(0, 0, 0, 166)
				f67_arg0.ScoreInfo:setAlpha(1)
				f67_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f67_arg0.clipInterrupted)
				f67_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f67_arg0.clipFinished)
			end
			f67_arg0.ScoreInfo:completeAnimation()
			f67_arg0.ScoreInfo:setLeftRight(0, 0, -20, 146)
			f67_arg0.ScoreInfo:setAlpha(0)
			f67_local1(f67_arg0.ScoreInfo)
		end,
	},
	VisibleBountyPC = {
		DefaultClip = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(3)
			f70_arg0.BountyHunterCashMoney:completeAnimation()
			f70_arg0.BountyHunterCashMoney:setTopBottom(0, 0, 0, 40)
			f70_arg0.clipFinished(f70_arg0.BountyHunterCashMoney)
			f70_arg0.ScoreInfoTimer:completeAnimation()
			f70_arg0.ScoreInfoTimer:setTopBottom(0, 0, 99, 139)
			f70_arg0.clipFinished(f70_arg0.ScoreInfoTimer)
			f70_arg0.ScoreInfo:completeAnimation()
			f70_arg0.ScoreInfo:setTopBottom(0, 0, 36, 104)
			f70_arg0.clipFinished(f70_arg0.ScoreInfo)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(2)
			f71_arg0.ScoreInfoTimer:completeAnimation()
			f71_arg0.ScoreInfoTimer:setTopBottom(0, 0, 63, 103)
			f71_arg0.clipFinished(f71_arg0.ScoreInfoTimer)
			f71_arg0.ScoreInfo:completeAnimation()
			f71_arg0.ScoreInfo:setTopBottom(0, 0, 0, 68)
			f71_arg0.clipFinished(f71_arg0.ScoreInfo)
		end,
	},
	VisibleSpawnSelect = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(0)
		end,
		Visible = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(2)
			local f73_local0 = function(f74_arg0)
				f73_arg0.ScoreInfoTimer:beginAnimation(600)
				f73_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -102.5, 102.5)
				f73_arg0.ScoreInfoTimer:setAlpha(1)
				f73_arg0.ScoreInfoTimer:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.ScoreInfoTimer:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.ScoreInfoTimer:completeAnimation()
			f73_arg0.ScoreInfoTimer:setLeftRight(0.5, 0.5, -122.5, 82.5)
			f73_arg0.ScoreInfoTimer:setAlpha(0)
			f73_local0(f73_arg0.ScoreInfoTimer)
			local f73_local1 = function(f75_arg0)
				f73_arg0.ScoreInfo:beginAnimation(600)
				f73_arg0.ScoreInfo:setLeftRight(0, 0, 0, 166)
				f73_arg0.ScoreInfo:setAlpha(1)
				f73_arg0.ScoreInfo:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.ScoreInfo:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.ScoreInfo:completeAnimation()
			f73_arg0.ScoreInfo:setLeftRight(0, 0, -20, 146)
			f73_arg0.ScoreInfo:setAlpha(0)
			f73_local1(f73_arg0.ScoreInfo)
		end,
	},
	VisibleBounty = {
		DefaultClip = function(f76_arg0, f76_arg1)
			f76_arg0:__resetProperties()
			f76_arg0:setupElementClipCounter(3)
			f76_arg0.BountyHunterCashMoney:completeAnimation()
			f76_arg0.BountyHunterCashMoney:setTopBottom(0, 0, 0, 40)
			f76_arg0.clipFinished(f76_arg0.BountyHunterCashMoney)
			f76_arg0.ScoreInfoTimer:completeAnimation()
			f76_arg0.ScoreInfoTimer:setTopBottom(0, 0, 99, 139)
			f76_arg0.clipFinished(f76_arg0.ScoreInfoTimer)
			f76_arg0.ScoreInfo:completeAnimation()
			f76_arg0.ScoreInfo:setTopBottom(0, 0, 36, 104)
			f76_arg0.clipFinished(f76_arg0.ScoreInfo)
		end,
	},
	Visible = {
		DefaultClip = function(f77_arg0, f77_arg1)
			f77_arg0:__resetProperties()
			f77_arg0:setupElementClipCounter(2)
			f77_arg0.ScoreInfoTimer:completeAnimation()
			f77_arg0.ScoreInfoTimer:setTopBottom(0, 0, 63, 103)
			f77_arg0.clipFinished(f77_arg0.ScoreInfoTimer)
			f77_arg0.ScoreInfo:completeAnimation()
			f77_arg0.ScoreInfo:setTopBottom(0, 0, 0, 68)
			f77_arg0.clipFinished(f77_arg0.ScoreInfo)
		end,
	},
	CodCasterInvisible = {
		DefaultClip = function(f78_arg0, f78_arg1)
			f78_arg0:__resetProperties()
			f78_arg0:setupElementClipCounter(3)
			f78_arg0.BountyHunterCashMoney:completeAnimation()
			f78_arg0.BountyHunterCashMoney:setAlpha(0)
			f78_arg0.clipFinished(f78_arg0.BountyHunterCashMoney)
			f78_arg0.ScoreInfoTimer:completeAnimation()
			f78_arg0.ScoreInfoTimer:setAlpha(0)
			f78_arg0.clipFinished(f78_arg0.ScoreInfoTimer)
			f78_arg0.ScoreInfo:completeAnimation()
			f78_arg0.ScoreInfo:setAlpha(0)
			f78_arg0.clipFinished(f78_arg0.ScoreInfo)
		end,
	},
}
CoD.ScoreInfoContainer.__onClose = function(f79_arg0)
	f79_arg0.BountyHunterCashMoney:close()
	f79_arg0.ScoreInfoTimer:close()
	f79_arg0.ScoreInfo:close()
	f79_arg0.Hacked:close()
end
