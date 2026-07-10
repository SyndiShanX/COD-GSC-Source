require("x64:8fd38b89728974a")
require("x64:ce1e6b6549d478c")
require("x64:3f6c87f55ffe27")
require("x64:f1d4d05c64c0293")
require("x64:6b6f2b27c486b15")
require("x64:2c6b627aa51405a")
require("x64:c2f9487384df3fe")
require("x64:2614187a845d0b9")
require("x64:9d551119df19927")
require("x64:d9b1c67e297144d")
require("x64:15f0d0ad4bf2fc9")
require("x64:faf84cd2e4b8930")
require("x64:ad7d4586d4cd0eb")
require("x64:6f28821b90063e7")
require("x64:d04ac5283183a96")
require("x64:6fd6b1c6e7fd305")
require("x64:d0018f5bdb9c718")
require("x64:268b19728179583")
require("x64:2675595fa323085")
CoD.GameEndScore_WZ = InheritFrom(LUI.UIElement)
CoD.GameEndScore_WZ.__defaultWidth = 1920
CoD.GameEndScore_WZ.__defaultHeight = 1080
CoD.GameEndScore_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.GameEndScoreUtility.SetupGameEndScoreWidget(self, f1_arg1)
	DisableAutoButtonCallback(f1_arg0, self, f1_arg1)
	CoD.BaseUtility.InitGlobalModel("demo.processedKeyframeJump", 0)
	CoD.BaseUtility.InitGlobalModel("lobbyRoot.publicLobby.stage", 0)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.GameEndScore_WZ)
	self.id = "GameEndScore_WZ"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setAlpha(0)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local BlurWZAAR = CoD.WZAARBlur.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BlurWZAAR)
	self.BlurWZAAR = BlurWZAAR
	local NoiseEliminatedBacking = CoD.GameEndScore_EliminatedBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -551, 551, 0.5, 0.5, -214, 215)
	NoiseEliminatedBacking:setAlpha(0)
	self:addElement(NoiseEliminatedBacking)
	self.NoiseEliminatedBacking = NoiseEliminatedBacking
	local PlayerResultContainer = CoD.GameEndScore_PlayerResultContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	PlayerResultContainer:setAlpha(0)
	PlayerResultContainer:setScale(0.84, 0.84)
	self:addElement(PlayerResultContainer)
	self.PlayerResultContainer = PlayerResultContainer
	local Outcome = LUI.UIText.new(0.5, 0.5, -255, 515, 0.5, 0.5, 23, 113)
	Outcome:setRGB(0.92, 0.92, 0.92)
	Outcome:setAlpha(0)
	Outcome:setTTF("ttmussels_demibold")
	Outcome:setLetterSpacing(24)
	Outcome:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Outcome:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	Outcome:subscribeToGlobalModel(f1_arg1, "GameScore", "titleString", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Outcome:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(Outcome)
	self.Outcome = Outcome
	local EliminatorContainer = CoD.GameEndScore_EliminatorContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -480, 520, 0.5, 0.5, 183, 333)
	EliminatorContainer:setAlpha(0)
	EliminatorContainer:subscribeToGlobalModel(f1_arg1, "GameScore", nil, function(model)
		EliminatorContainer:setModel(model, f1_arg1)
	end)
	self:addElement(EliminatorContainer)
	self.EliminatorContainer = EliminatorContainer
	local GameStatus = CoD.GameEndScore_GameStatus.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, -1, 76)
	GameStatus:setAlpha(0)
	self:addElement(GameStatus)
	self.GameStatus = GameStatus
	local MatchTimerContainer = CoD.GameEndScore_WZ_SafeAreaContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	MatchTimerContainer:setAlpha(0)
	self:addElement(MatchTimerContainer)
	self.MatchTimerContainer = MatchTimerContainer
	local DownNotOut = LUI.UIText.new(0.5, 0.5, -806, 264, 0.5, 0.5, -329, -293)
	DownNotOut:setRGB(0.92, 0.92, 0.92)
	DownNotOut:setAlpha(0)
	DownNotOut:setTTF("default")
	DownNotOut:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	DownNotOut:setShaderVector(0, 0.2, 0, 0, 0)
	DownNotOut:setShaderVector(1, 0.2, 0, 0, 0)
	DownNotOut:setShaderVector(2, 0, 0, 0, 1)
	DownNotOut:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DownNotOut:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	DownNotOut:subscribeToGlobalModel(f1_arg1, "HUDItems", "aliveTeammateCount", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DownNotOut:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.GameEndScoreUtility.GetEliminatedString(f1_arg1, f4_local0)))
		end
	end)
	self:addElement(DownNotOut)
	self.DownNotOut = DownNotOut
	local emptyFocusablePC = nil
	emptyFocusablePC = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusablePC)
	self.emptyFocusablePC = emptyFocusablePC
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() and not IsDemoPlaying() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local DeathCamPrompt = CoD.GameEndScore_DeathCam.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(DeathCamPrompt)
	self.DeathCamPrompt = DeathCamPrompt
	local VoipContainerNoCompass = CoD.Voip_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, -830, -420, 0.5, 0.5, -288, -180)
	VoipContainerNoCompass:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
				if f6_local0 then
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
						f6_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						if f6_local0 then
						else
							return f6_local0
						end
					end
					f6_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
				end
				return f6_local0
			end,
		},
		{
			stateName = "ShowForCodCaster",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local SoundGameOverSlam = VoipContainerNoCompass
	local ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	local DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["hudItems.playerSpawned"], function(f8_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"]], function(f9_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_compass_visible"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f10_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f11_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f12_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f13_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f14_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f15_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f16_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f17_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f18_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f19_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f20_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f21_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	SoundGameOverSlam = VoipContainerNoCompass
	ChallengeCoinSound = VoipContainerNoCompass.subscribeToModel
	DirectorQuitButtonContainer = Engine[@"getmodelforcontroller"](f1_arg1)
	ChallengeCoinSound(SoundGameOverSlam, DirectorQuitButtonContainer["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f22_arg0)
		f1_arg0:updateElementState(VoipContainerNoCompass, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	self:addElement(VoipContainerNoCompass)
	self.VoipContainerNoCompass = VoipContainerNoCompass
	ChallengeCoinSound = LUI.UIElement.new(0, 0, -16, 16, 0, 0, -16, -66)
	self:addElement(ChallengeCoinSound)
	self.ChallengeCoinSound = ChallengeCoinSound
	SoundGameOverSlam = LUI.UIElement.new(0, 0, 30.5, 62.5, 0, 0, -66.5, -34.5)
	self:addElement(SoundGameOverSlam)
	self.SoundGameOverSlam = SoundGameOverSlam
	DirectorQuitButtonContainer = nil
	DirectorQuitButtonContainer = CoD.DirectorQuitButtonContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 768, 968, 0, 0, 11, 47)
	DirectorQuitButtonContainer:setAlpha(0)
	DirectorQuitButtonContainer:registerEventHandler("gain_focus", function(element, event)
		local f23_local0 = nil
		if element.gainFocus then
			f23_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f23_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f23_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorQuitButtonContainer, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		if IsPC() then
			OpenPCQuit(self, menu, self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(DirectorQuitButtonContainer)
	self.DirectorQuitButtonContainer = DirectorQuitButtonContainer
	local BarMiddle = CoD.GameEndScore_HeaderBarMid.new(f1_arg0, f1_arg1, 0.07, 0.93, 0, 0, 0.5, 0.5, -441, -361)
	BarMiddle:setAlpha(0)
	self:addElement(BarMiddle)
	self.BarMiddle = BarMiddle
	local BarLeft = CoD.GameEndScore_HeaderBarTip.new(f1_arg0, f1_arg1, 0, 0.07, 0, 0, 0.5, 0.5, -441, -361)
	BarLeft:setAlpha(0)
	self:addElement(BarLeft)
	self.BarLeft = BarLeft
	local BarRight = CoD.GameEndScore_HeaderBarTip.new(f1_arg0, f1_arg1, 0.93, 1, 0, 0, 0.5, 0.5, -441, -361)
	BarRight:setAlpha(0)
	BarRight:setYRot(180)
	self:addElement(BarRight)
	self.BarRight = BarRight
	local ChallengeCoinFlare2 = LUI.UIImage.new(0.5, 0.5, 515, 965, 0.5, 0.5, -626, -176)
	ChallengeCoinFlare2:setRGB(ColorSet.ParagonRank.r, ColorSet.ParagonRank.g, ColorSet.ParagonRank.b)
	ChallengeCoinFlare2:setAlpha(0)
	ChallengeCoinFlare2:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_flare"))
	ChallengeCoinFlare2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ChallengeCoinFlare2:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ChallengeCoinFlare2)
	self.ChallengeCoinFlare2 = ChallengeCoinFlare2
	local ChallengeCoinFlare3 = LUI.UIImage.new(0.5, 0.5, 515, 965, 0.5, 0.5, -626, -176)
	ChallengeCoinFlare3:setRGB(0.96, 0.31, 0.06)
	ChallengeCoinFlare3:setAlpha(0)
	ChallengeCoinFlare3:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_flare"))
	ChallengeCoinFlare3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ChallengeCoinFlare3:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ChallengeCoinFlare3)
	self.ChallengeCoinFlare3 = ChallengeCoinFlare3
	local ChallengeCoin2 = CoD.ChallengeCoin.new(f1_arg0, f1_arg1, 0.5, 0.5, 626, 826, 0.5, 0.5, -501, -301)
	ChallengeCoin2:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "gameScore.victory")
			end,
		},
	})
	local KillerIdentity = ChallengeCoin2
	local HeaderTextTeamRank = ChallengeCoin2.subscribeToModel
	local MistakesWereMade = Engine[@"getmodelforcontroller"](f1_arg1)
	HeaderTextTeamRank(KillerIdentity, MistakesWereMade["gameScore.victory"], function(f27_arg0)
		f1_arg0:updateElementState(ChallengeCoin2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "gameScore.victory",
		})
	end, false)
	ChallengeCoin2:setAlpha(0)
	ChallengeCoin2:subscribeToGlobalModel(f1_arg1, "GameScore", nil, function(model)
		ChallengeCoin2:setModel(model, f1_arg1)
	end)
	ChallengeCoin2:subscribeToGlobalModel(f1_arg1, "GameScore", "challengeCoinImage", function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			ChallengeCoin2.ChallengeCoinImage:setImage(RegisterImage(f29_local0))
		end
	end)
	self:addElement(ChallengeCoin2)
	self.ChallengeCoin2 = ChallengeCoin2
	HeaderTextTeamRank = CoD.GameEndScore_Placement.new(f1_arg0, f1_arg1, 0.5, 0.5, -809, -309, 0.5, 0.5, -481, -361)
	HeaderTextTeamRank:setAlpha(0)
	self:addElement(HeaderTextTeamRank)
	self.HeaderTextTeamRank = HeaderTextTeamRank
	KillerIdentity = CoD.GameEndScore_KillerIdentity.new(f1_arg0, f1_arg1, 0.5, 0.5, 321, 829, 0.5, 0.5, -441, -361)
	KillerIdentity:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "meansOfDeath", 0)
			end,
		},
	})
	KillerIdentity:linkToElementModel(KillerIdentity, "meansOfDeath", true, function(model)
		f1_arg0:updateElementState(KillerIdentity, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "meansOfDeath",
		})
	end)
	KillerIdentity:setAlpha(0)
	KillerIdentity.TextBoxShadow:setText(LocalizeToUpperString(@"hash_5384588C2F4949A5"))
	KillerIdentity.TextBox:setText(LocalizeToUpperString(@"hash_5384588C2F4949A5"))
	KillerIdentity:subscribeToGlobalModel(f1_arg1, "GameScore", nil, function(model)
		KillerIdentity:setModel(model, f1_arg1)
	end)
	KillerIdentity.AttackerEmblem.__emblem = function(f33_arg0)
		local f33_local0 = f33_arg0:get()
		if f33_local0 ~= nil then
			KillerIdentity.AttackerEmblem:setupPlayerEmblemByXUID(f33_local0)
		end
	end
	KillerIdentity:linkToElementModel(self, "attackerClientModel", true, function(model, f34_arg1)
		if f34_arg1["__KillerIdentity.AttackerEmblem.__emblem_attackerClientModel->xuid"] then
			f34_arg1:removeSubscription(f34_arg1["__KillerIdentity.AttackerEmblem.__emblem_attackerClientModel->xuid"])
			f34_arg1["__KillerIdentity.AttackerEmblem.__emblem_attackerClientModel->xuid"] = nil
		end
		if model then
			local f34_local0 = model:get()
			local f34_local1 = model:get()
			model = f34_local0 and f34_local1.xuid
		end
		if model then
			f34_arg1["__KillerIdentity.AttackerEmblem.__emblem_attackerClientModel->xuid"] = f34_arg1:subscribeToModel(model, KillerIdentity.AttackerEmblem.__emblem)
		end
	end)
	KillerIdentity:linkToElementModel(self, "attackerClientModel", true, function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			KillerIdentity.CallingCardsFrameWidget:setModel(f35_local0, f1_arg1)
		end
	end)
	KillerIdentity.PlayerName.__playerName = function(f36_arg0)
		local f36_local0 = f36_arg0:get()
		if f36_local0 ~= nil then
			KillerIdentity.PlayerName:setText(GetClientName(f1_arg1, f36_local0))
		end
	end
	KillerIdentity:linkToElementModel(self, "attackerClientModel", true, function(model, f37_arg1)
		if f37_arg1["__KillerIdentity.PlayerName.__playerName_attackerClientModel->clientNum"] then
			f37_arg1:removeSubscription(f37_arg1["__KillerIdentity.PlayerName.__playerName_attackerClientModel->clientNum"])
			f37_arg1["__KillerIdentity.PlayerName.__playerName_attackerClientModel->clientNum"] = nil
		end
		if model then
			local f37_local0 = model:get()
			local f37_local1 = model:get()
			model = f37_local0 and f37_local1.clientNum
		end
		if model then
			f37_arg1["__KillerIdentity.PlayerName.__playerName_attackerClientModel->clientNum"] = f37_arg1:subscribeToModel(model, KillerIdentity.PlayerName.__playerName)
		end
	end)
	KillerIdentity.ClanName.__clanName = function(f38_arg0)
		local f38_local0 = f38_arg0:get()
		if f38_local0 ~= nil then
			KillerIdentity.ClanName:setText(CoD.SocialUtility.CleanGamerTag(GetClientClantag(f1_arg1, f38_local0)))
		end
	end
	KillerIdentity:linkToElementModel(self, "attackerClientModel", true, function(model, f39_arg1)
		if f39_arg1["__KillerIdentity.ClanName.__clanName_attackerClientModel->clientNum"] then
			f39_arg1:removeSubscription(f39_arg1["__KillerIdentity.ClanName.__clanName_attackerClientModel->clientNum"])
			f39_arg1["__KillerIdentity.ClanName.__clanName_attackerClientModel->clientNum"] = nil
		end
		if model then
			local f39_local0 = model:get()
			local f39_local1 = model:get()
			model = f39_local0 and f39_local1.clientNum
		end
		if model then
			f39_arg1["__KillerIdentity.ClanName.__clanName_attackerClientModel->clientNum"] = f39_arg1:subscribeToModel(model, KillerIdentity.ClanName.__clanName)
		end
	end)
	KillerIdentity.Rank.__rank = function(f40_arg0)
		local f40_local0 = f40_arg0:get()
		if f40_local0 ~= nil then
			KillerIdentity.Rank:setText(CoD.PrestigeUtility.LocalizeIfMaxRank(@"hash_54008CE61FE52DCD", SetValueIfEmptyString("1", f40_local0)))
		end
	end
	KillerIdentity:linkToElementModel(self, "attackerClientModel", true, function(model, f41_arg1)
		if f41_arg1["__KillerIdentity.Rank.__rank_attackerClientModel->rank"] then
			f41_arg1:removeSubscription(f41_arg1["__KillerIdentity.Rank.__rank_attackerClientModel->rank"])
			f41_arg1["__KillerIdentity.Rank.__rank_attackerClientModel->rank"] = nil
		end
		if model then
			local f41_local0 = model:get()
			local f41_local1 = model:get()
			model = f41_local0 and f41_local1.rank
		end
		if model then
			f41_arg1["__KillerIdentity.Rank.__rank_attackerClientModel->rank"] = f41_arg1:subscribeToModel(model, KillerIdentity.Rank.__rank)
		end
	end)
	KillerIdentity.RankIcon.__rankIcon = function(f42_arg0)
		local f42_local0 = f42_arg0:get()
		if f42_local0 ~= nil then
			KillerIdentity.RankIcon:setImage(RegisterImage(f42_local0))
		end
	end
	KillerIdentity:linkToElementModel(self, "attackerClientModel", true, function(model, f43_arg1)
		if f43_arg1["__KillerIdentity.RankIcon.__rankIcon_attackerClientModel->rankIcon"] then
			f43_arg1:removeSubscription(f43_arg1["__KillerIdentity.RankIcon.__rankIcon_attackerClientModel->rankIcon"])
			f43_arg1["__KillerIdentity.RankIcon.__rankIcon_attackerClientModel->rankIcon"] = nil
		end
		if model then
			local f43_local0 = model:get()
			local f43_local1 = model:get()
			model = f43_local0 and f43_local1.rankIcon
		end
		if model then
			f43_arg1["__KillerIdentity.RankIcon.__rankIcon_attackerClientModel->rankIcon"] = f43_arg1:subscribeToModel(model, KillerIdentity.RankIcon.__rankIcon)
		end
	end)
	self:addElement(KillerIdentity)
	self.KillerIdentity = KillerIdentity
	MistakesWereMade = CoD.GameEndScore_KillerIdentity.new(f1_arg0, f1_arg1, 0.5, 0.5, 321, 829, 0.5, 0.5, -441, -361)
	MistakesWereMade:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "GameScore", "meansOfDeath", 0)
			end,
		},
	})
	local MeansOfDeath = MistakesWereMade
	local WeaponIdentity = MistakesWereMade.subscribeToModel
	local WZAAR = DataSources.GameScore.getModel(f1_arg1)
	WeaponIdentity(MeansOfDeath, WZAAR.meansOfDeath, function(f45_arg0)
		f1_arg0:updateElementState(MistakesWereMade, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "meansOfDeath",
		})
	end, false)
	MistakesWereMade:setAlpha(0)
	MistakesWereMade.TextBoxShadow:setText(LocalizeToUpperString(@"hash_51838FDD5EA1D43A"))
	MistakesWereMade.TextBox:setText(LocalizeToUpperString(@"hash_51838FDD5EA1D43A"))
	MistakesWereMade.AttackerEmblem.__emblem = function(f46_arg0)
		local f46_local0 = f46_arg0:get()
		if f46_local0 ~= nil then
			MistakesWereMade.AttackerEmblem:setupPlayerEmblemByXUID(f46_local0)
		end
	end
	MistakesWereMade:subscribeToGlobalModel(f1_arg1, "PerController", "clientModel", function(model, f47_arg1)
		if f47_arg1["__MistakesWereMade.AttackerEmblem.__emblem_clientModel->xuid"] then
			f47_arg1:removeSubscription(f47_arg1["__MistakesWereMade.AttackerEmblem.__emblem_clientModel->xuid"])
			f47_arg1["__MistakesWereMade.AttackerEmblem.__emblem_clientModel->xuid"] = nil
		end
		if model then
			local f47_local0 = model:get()
			local f47_local1 = model:get()
			model = f47_local0 and f47_local1.xuid
		end
		if model then
			f47_arg1["__MistakesWereMade.AttackerEmblem.__emblem_clientModel->xuid"] = f47_arg1:subscribeToModel(model, MistakesWereMade.AttackerEmblem.__emblem)
		end
	end)
	MistakesWereMade:subscribeToGlobalModel(f1_arg1, "PerController", "clientModel", function(model)
		local f48_local0 = model:get()
		if f48_local0 ~= nil then
			MistakesWereMade.CallingCardsFrameWidget:setModel(f48_local0, f1_arg1)
		end
	end)
	MistakesWereMade.PlayerName.__playerName = function(f49_arg0)
		local f49_local0 = f49_arg0:get()
		if f49_local0 ~= nil then
			MistakesWereMade.PlayerName:setText(GetClientName(f1_arg1, f49_local0))
		end
	end
	MistakesWereMade:subscribeToGlobalModel(f1_arg1, "PerController", "clientModel", function(model, f50_arg1)
		if f50_arg1["__MistakesWereMade.PlayerName.__playerName_clientModel->clientNum"] then
			f50_arg1:removeSubscription(f50_arg1["__MistakesWereMade.PlayerName.__playerName_clientModel->clientNum"])
			f50_arg1["__MistakesWereMade.PlayerName.__playerName_clientModel->clientNum"] = nil
		end
		if model then
			local f50_local0 = model:get()
			local f50_local1 = model:get()
			model = f50_local0 and f50_local1.clientNum
		end
		if model then
			f50_arg1["__MistakesWereMade.PlayerName.__playerName_clientModel->clientNum"] = f50_arg1:subscribeToModel(model, MistakesWereMade.PlayerName.__playerName)
		end
	end)
	MistakesWereMade.ClanName.__clanName = function(f51_arg0)
		local f51_local0 = f51_arg0:get()
		if f51_local0 ~= nil then
			MistakesWereMade.ClanName:setText(CoD.SocialUtility.CleanGamerTag(GetClientClantag(f1_arg1, f51_local0)))
		end
	end
	MistakesWereMade:subscribeToGlobalModel(f1_arg1, "PerController", "clientModel", function(model, f52_arg1)
		if f52_arg1["__MistakesWereMade.ClanName.__clanName_clientModel->clientNum"] then
			f52_arg1:removeSubscription(f52_arg1["__MistakesWereMade.ClanName.__clanName_clientModel->clientNum"])
			f52_arg1["__MistakesWereMade.ClanName.__clanName_clientModel->clientNum"] = nil
		end
		if model then
			local f52_local0 = model:get()
			local f52_local1 = model:get()
			model = f52_local0 and f52_local1.clientNum
		end
		if model then
			f52_arg1["__MistakesWereMade.ClanName.__clanName_clientModel->clientNum"] = f52_arg1:subscribeToModel(model, MistakesWereMade.ClanName.__clanName)
		end
	end)
	MistakesWereMade.Rank.__rank = function(f53_arg0)
		local f53_local0 = f53_arg0:get()
		if f53_local0 ~= nil then
			MistakesWereMade.Rank:setText(CoD.PrestigeUtility.LocalizeIfMaxRank(@"hash_54008CE61FE52DCD", SetValueIfEmptyString("1", f53_local0)))
		end
	end
	MistakesWereMade:subscribeToGlobalModel(f1_arg1, "PerController", "clientModel", function(model, f54_arg1)
		if f54_arg1["__MistakesWereMade.Rank.__rank_clientModel->rank"] then
			f54_arg1:removeSubscription(f54_arg1["__MistakesWereMade.Rank.__rank_clientModel->rank"])
			f54_arg1["__MistakesWereMade.Rank.__rank_clientModel->rank"] = nil
		end
		if model then
			local f54_local0 = model:get()
			local f54_local1 = model:get()
			model = f54_local0 and f54_local1.rank
		end
		if model then
			f54_arg1["__MistakesWereMade.Rank.__rank_clientModel->rank"] = f54_arg1:subscribeToModel(model, MistakesWereMade.Rank.__rank)
		end
	end)
	MistakesWereMade.RankIcon.__rankIcon = function(f55_arg0)
		local f55_local0 = f55_arg0:get()
		if f55_local0 ~= nil then
			MistakesWereMade.RankIcon:setImage(RegisterImage(f55_local0))
		end
	end
	MistakesWereMade:subscribeToGlobalModel(f1_arg1, "PerController", "clientModel", function(model, f56_arg1)
		if f56_arg1["__MistakesWereMade.RankIcon.__rankIcon_clientModel->rankIcon"] then
			f56_arg1:removeSubscription(f56_arg1["__MistakesWereMade.RankIcon.__rankIcon_clientModel->rankIcon"])
			f56_arg1["__MistakesWereMade.RankIcon.__rankIcon_clientModel->rankIcon"] = nil
		end
		if model then
			local f56_local0 = model:get()
			local f56_local1 = model:get()
			model = f56_local0 and f56_local1.rankIcon
		end
		if model then
			f56_arg1["__MistakesWereMade.RankIcon.__rankIcon_clientModel->rankIcon"] = f56_arg1:subscribeToModel(model, MistakesWereMade.RankIcon.__rankIcon)
		end
	end)
	self:addElement(MistakesWereMade)
	self.MistakesWereMade = MistakesWereMade
	WeaponIdentity = CoD.GameEndScore_WeaponIdentity.new(f1_arg0, f1_arg1, 0.5, 0.5, 321, 829, 0.5, 0.5, -328, -248)
	WeaponIdentity:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "meansOfDeath", 0)
			end,
		},
	})
	WeaponIdentity:linkToElementModel(WeaponIdentity, "meansOfDeath", true, function(model)
		f1_arg0:updateElementState(WeaponIdentity, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "meansOfDeath",
		})
	end)
	WeaponIdentity:setAlpha(0)
	WeaponIdentity.HeaderTextBoxShadow:setText(LocalizeToUpperString(@"ui/with"))
	WeaponIdentity.HeaderTextBox:setText(LocalizeToUpperString(@"ui/with"))
	WeaponIdentity:subscribeToGlobalModel(f1_arg1, "GameScore", nil, function(model)
		WeaponIdentity:setModel(model, f1_arg1)
	end)
	WeaponIdentity:linkToElementModel(self, "weaponImage", true, function(model)
		local f60_local0 = model:get()
		if f60_local0 ~= nil then
			WeaponIdentity.WeaponImage:setImage(CoD.BaseUtility.AlreadyRegistered(f60_local0))
		end
	end)
	WeaponIdentity:linkToElementModel(self, "weaponName", true, function(model)
		local f61_local0 = model:get()
		if f61_local0 ~= nil then
			WeaponIdentity.WeaponName:setText(Engine[@"hash_4F9F1239CFD921FE"](f61_local0))
		end
	end)
	self:addElement(WeaponIdentity)
	self.WeaponIdentity = WeaponIdentity
	MeansOfDeath = CoD.GameEndScore_WeaponIdentity.new(f1_arg0, f1_arg1, 0.5, 0.5, 321, 829, 0.5, 0.5, -328, -248)
	MeansOfDeath:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "GameScore", "meansOfDeath", 0)
			end,
		},
	})
	local DirectorStageIndicator = MeansOfDeath
	WZAAR = MeansOfDeath.subscribeToModel
	local CrosshairOccluder = DataSources.GameScore.getModel(f1_arg1)
	WZAAR(DirectorStageIndicator, CrosshairOccluder.meansOfDeath, function(f63_arg0)
		f1_arg0:updateElementState(MeansOfDeath, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f63_arg0:get(),
			modelName = "meansOfDeath",
		})
	end, false)
	MeansOfDeath:setAlpha(0)
	MeansOfDeath.HeaderTextBoxShadow:setText(LocalizeToUpperString(@"hash_65E4FF44BBB1ACC4"))
	MeansOfDeath.HeaderTextBox:setText(LocalizeToUpperString(@"hash_65E4FF44BBB1ACC4"))
	MeansOfDeath:subscribeToGlobalModel(f1_arg1, "GameScore", "meansOfDeathIcon", function(model)
		local f64_local0 = model:get()
		if f64_local0 ~= nil then
			MeansOfDeath.WeaponImage:setImage(RegisterImage(f64_local0))
		end
	end)
	MeansOfDeath:subscribeToGlobalModel(f1_arg1, "GameScore", "meansOfDeathLabel", function(model)
		local f65_local0 = model:get()
		if f65_local0 ~= nil then
			MeansOfDeath.WeaponName:setText(Engine[@"hash_4F9F1239CFD921FE"](f65_local0))
		end
	end)
	self:addElement(MeansOfDeath)
	self.MeansOfDeath = MeansOfDeath
	WZAAR = CoD.WZAAR.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(WZAAR)
	self.WZAAR = WZAAR
	DirectorStageIndicator = CoD.WarzoneDirectorStageIndicator.new(f1_arg0, f1_arg1, 0, 0, 76, 605, 1, 1, -188, -118)
	DirectorStageIndicator:setAlpha(0)
	DirectorStageIndicator.StageTitle:setText(LocalizeToUpperString(@"hash_2968D3B043BAE7EA"))
	self:addElement(DirectorStageIndicator)
	self.DirectorStageIndicator = DirectorStageIndicator
	CrosshairOccluder = LUI.UIImage.new(0, 0, 1859, 1987, 0, 0, 243, 371)
	CrosshairOccluder:setupCrosshairOccluder(f1_arg1)
	self:addElement(CrosshairOccluder)
	self.CrosshairOccluder = CrosshairOccluder
	self:mergeStateConditions({
		{
			stateName = "VictoryPlatoonPC",
			condition = function(menu, element, event)
				local f66_local0 = CoD.GameEndScoreUtility.ShowOutcomeTransition(f1_arg1)
				if f66_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
						f66_local0 = IsPC()
						if f66_local0 then
							f66_local0 = not IsGametypeSettingsValue("platoonCount", 0)
						end
					else
						f66_local0 = false
					end
				end
				return f66_local0
			end,
		},
		{
			stateName = "VictoryPC",
			condition = function(menu, element, event)
				local f67_local0 = CoD.GameEndScoreUtility.ShowOutcomeTransition(f1_arg1)
				if f67_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
						f67_local0 = IsPC()
					else
						f67_local0 = false
					end
				end
				return f67_local0
			end,
		},
		{
			stateName = "DefeatPlatoonPC",
			condition = function(menu, element, event)
				local f68_local0 = CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "defeat")
				if f68_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
						f68_local0 = IsPC()
						if f68_local0 then
							f68_local0 = not IsGametypeSettingsValue("platoonCount", 0)
						end
					else
						f68_local0 = false
					end
				end
				return f68_local0
			end,
		},
		{
			stateName = "DefeatPC",
			condition = function(menu, element, event)
				local f69_local0 = CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "defeat")
				if f69_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
						f69_local0 = IsPC()
					else
						f69_local0 = false
					end
				end
				return f69_local0
			end,
		},
		{
			stateName = "GameOverPC",
			condition = function(menu, element, event)
				local f70_local0 = CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "team_elimination")
				if f70_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
						f70_local0 = IsPC()
					else
						f70_local0 = false
					end
				end
				return f70_local0
			end,
		},
		{
			stateName = "EliminationPC",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "elimination") and IsPC()
			end,
		},
		{
			stateName = "VictoryPlatoon",
			condition = function(menu, element, event)
				local f72_local0 = CoD.GameEndScoreUtility.ShowOutcomeTransition(f1_arg1)
				if f72_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
						f72_local0 = not IsGametypeSettingsValue("platoonCount", 0)
					else
						f72_local0 = false
					end
				end
				return f72_local0
			end,
		},
		{
			stateName = "Victory",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowOutcomeTransition(f1_arg1) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
			end,
		},
		{
			stateName = "DefeatPlatoon",
			condition = function(menu, element, event)
				local f74_local0 = CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "defeat")
				if f74_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) then
						f74_local0 = not IsGametypeSettingsValue("platoonCount", 0)
					else
						f74_local0 = false
					end
				end
				return f74_local0
			end,
		},
		{
			stateName = "Defeat",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "defeat") and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
			end,
		},
		{
			stateName = "GameOver",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "team_elimination") and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
			end,
		},
		{
			stateName = "Elimination",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "elimination")
			end,
		},
	})
	local f1_local31 = self
	local f1_local32 = self.subscribeToModel
	local f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["gameScore.currentState"], function(f78_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f78_arg0:get(),
			modelName = "gameScore.currentState",
		})
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f79_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f79_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f80_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f80_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f81_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f81_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f82_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f82_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["gameScore.currentState"], function(f83_arg0, f83_arg1)
		CoD.Menu.UpdateButtonShownState(f83_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f83_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f83_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f83_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["hudItems.warzone.aarViewed"], function(f84_arg0, f84_arg1)
		CoD.Menu.UpdateButtonShownState(f84_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f84_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f85_arg0, f85_arg1)
		CoD.Menu.UpdateButtonShownState(f85_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f86_arg0, f86_arg1)
		CoD.Menu.UpdateButtonShownState(f86_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["hudItems.warzone.aarVisible"], function(f87_arg0, f87_arg1)
		CoD.Menu.UpdateButtonShownState(f87_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getglobalmodel"]()
	f1_local32(f1_local31, f1_local33["lobbyRoot.privateClient.update"], function(f88_arg0, f88_arg1)
		CoD.Menu.UpdateButtonShownState(f88_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getglobalmodel"]()
	f1_local32(f1_local31, f1_local33["lobbyRoot.lobbyNav"], function(f89_arg0, f89_arg1)
		CoD.Menu.UpdateButtonShownState(f89_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getglobalmodel"]()
	f1_local32(f1_local31, f1_local33["lobbyRoot.publicLobby.stage"], function(f90_arg0, f90_arg1)
		CoD.Menu.UpdateButtonShownState(f90_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local32(f1_local31, f1_local33.aliveTeammateCount, function(f91_arg0, f91_arg1)
		CoD.Menu.UpdateButtonShownState(f91_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["gameScore.hasPlayedDeathCam"], function(f92_arg0, f92_arg1)
		CoD.Menu.UpdateButtonShownState(f92_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f93_arg0, f93_arg1)
		CoD.Menu.UpdateButtonShownState(f93_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f94_arg0, f94_arg1)
		CoD.Menu.UpdateButtonShownState(f94_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f95_arg0, f95_arg1)
		CoD.Menu.UpdateButtonShownState(f95_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f96_arg0, f96_arg1)
		CoD.Menu.UpdateButtonShownState(f96_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f97_arg0, f97_arg1)
		CoD.Menu.UpdateButtonShownState(f97_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f97_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	self:appendEventHandler("input_source_changed", function(f98_arg0, f98_arg1)
		f98_arg1.menu = f98_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f98_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end)
	f1_local31 = self
	f1_local32 = self.subscribeToModel
	f1_local33 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local32(f1_local31, f1_local33.LastInput, function(f99_arg0, f99_arg1)
		CoD.Menu.UpdateButtonShownState(f99_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if CoD.GameEndScoreUtility.CanShowWarzoneSpectate(controller) and not IsPC() and not IsDemoPlaying() and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_game_ended"]) then
			SetControllerModelValue(controller, "huditems.warzone.aarVisible", false)
			HideWidget(self.WZAAR)
			SendMenuResponse(self, "GameEndScore", "skip_deathcam", controller)
			CoD.GameEndScoreUtility.ClearTransition(controller)
			CoD.LobbyUtility.SetPlayerLocation(controller, Enum[@"hash_C0AB9543C5C440B"][@"hash_49B478094C85DBBB"])
			HideWidget(self.CrosshairOccluder)
			return true
		elseif not IsPC() and CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.warzone.aarVisible") and IsOnlineGame() and IsBooleanDvarSet("ui_showWZAAR") and not CoD.HUDUtility.IsWZCustomGame(controller) and not CoD.GameEndScoreUtility.CanShowWarzoneSpectate(controller) then
			SetControllerModelValue(controller, "hudItems.warzone.aarVisible", false)
			BlockGameFromKeyEvent(controller)
			HideWidget(self.WZAAR)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.GameEndScoreUtility.CanShowWarzoneSpectate(controller) and not IsPC() and not IsDemoPlaying() and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_game_ended"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"ui/spectate", nil, nil)
			return true
		elseif not IsPC() and CoD.ModelUtility.IsModelValueTrue(controller, "hudItems.warzone.aarVisible") and IsOnlineGame() and IsBooleanDvarSet("ui_showWZAAR") and not CoD.HUDUtility.IsWZCustomGame(controller) and not CoD.GameEndScoreUtility.CanShowWarzoneSpectate(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_4B914F387B0A33A9", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if IsLobbyPrivateHost() and CoD.LobbyUtility.AllMembersCanRedeploy() and not CoD.DirectorUtility.IsMatchmakingInProgress(controller) and IsBooleanDvarSet("redeploy_enabled") and not CoD.HUDUtility.IsWZCustomGame(controller) then
			CoD.GameEndScoreUtility.Redeploy(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyPrivateHost() and CoD.LobbyUtility.AllMembersCanRedeploy() and not CoD.DirectorUtility.IsMatchmakingInProgress(controller) and IsBooleanDvarSet("redeploy_enabled") and not CoD.HUDUtility.IsWZCustomGame(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"wz/redeploy", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.GameEndScoreUtility.CanShowWarzoneKillcam(controller) and not IsPC() and not IsBooleanDvarSet("ui_killcamButtonAlt") and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and not IsDemoPlaying() and not IsInDefaultState(element) and CoD.GameEndScoreUtility.HasViewedInGameReport(controller) then
			SendMenuResponse(self, "GameEndScore", "play_deathcam", controller)
			SetControllerModelValue(controller, "gameScore.hasPlayedDeathCam", true)
			PlaySoundAlias("uin_killcam_start")
			CoD.BaseUtility.PlayMusic("death")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.GameEndScoreUtility.CanShowWarzoneKillcam(controller) and not IsPC() and not IsBooleanDvarSet("ui_killcamButtonAlt") and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_ui_active"]) and not IsDemoPlaying() and not IsInDefaultState(element) and CoD.GameEndScoreUtility.HasViewedInGameReport(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if not IsPC() and not IsDemoPlaying() and CoD.BaseUtility.IsButtonHoldFinished(model) then
			QuitGame_Raw(self, element, controller, "", menu)
			return true
		elseif IsPC() and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not IsDemoPlaying() and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			QuitPCGame_MP(self, controller, true)
			BlockGameFromKeyEvent(controller)
			return true
		elseif IsPC() and not CoD.GameEndScoreUtility.IsGameScoreCurrentState(controller, "") and not IsDemoPlaying() and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			QuitPCGame_MP(self, controller, true)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], 0x8E2D4EADF54AA3, Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ESCAPE")
			return true
		elseif IsPC() and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, "ESCAPE")
			return false
		elseif IsPC() and not CoD.GameEndScoreUtility.IsGameScoreCurrentState(controller, "") and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, "ESCAPE")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "ui_contextual_2", function(element, menu, controller, model)
		if IsPC() and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not IsDemoPlaying() and IsMouseOrKeyboard(controller) then
			QuitPCGame_MP(self, controller, true)
			BlockGameFromKeyEvent(controller)
			return true
		elseif IsPC() and not CoD.GameEndScoreUtility.IsGameScoreCurrentState(controller, "") and not IsDemoPlaying() then
			QuitPCGame_MP(self, controller, true)
			BlockGameFromKeyEvent(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and not IsVisibilityBitSet(controller, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not IsDemoPlaying() and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_contextual_2")
			return false
		elseif IsPC() and not CoD.GameEndScoreUtility.IsGameScoreCurrentState(controller, "") and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_contextual_2")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f110_arg2, f110_arg3, f110_arg4)
		if not IsInDefaultState(self) and IsDemoPlaying() then
			CoD.GameEndScoreUtility.PlayFirstTimeIntroClipIfNeeded(self, controller)
		elseif not IsInDefaultState(self) and not IsPC() and not IsDemoPlaying() then
			SetFocusToSelf(self, controller)
			CoD.GameEndScoreUtility.PlayFirstTimeIntroClipIfNeeded(self, controller)
		elseif not IsInDefaultState(self) and IsPC() and not CoD.PCUtility.IsCurrentHudOccluded(f1_arg0, controller) then
			SetLoseFocusToSelf(self, controller)
			MakeNotFocusable(element, controller)
			CoD.PCUtility.GameEndScoreWZShowCursor(element, controller, f1_arg0)
			CoD.PCWidgetUtility.CloseChat(f1_arg0, controller)
			CoD.GameEndScoreUtility.PlayFirstTimeIntroClipIfNeeded(self, controller)
		elseif not IsInDefaultState(self) and IsPC() then
			SetLoseFocusToSelf(self, controller)
			MakeNotFocusable(element, controller)
			CoD.PCWidgetUtility.CloseChat(f1_arg0, controller)
			CoD.GameEndScoreUtility.PlayFirstTimeIntroClipIfNeeded(self, controller)
		elseif IsInDefaultState(self) then
			SetLoseFocusToSelf(self, controller)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "demo.processedKeyframeJump", function(model)
		local f111_local0 = self
		if IsDemoPlaying() then
			CoD.GameEndScoreUtility.ClearTransition(f1_arg1)
		end
	end)
	GameStatus.id = "GameStatus"
	if CoD.isPC then
		emptyFocusablePC.id = "emptyFocusablePC"
	end
	FooterContainerFrontendRight:appendEventHandler("menu_loaded", function()
		FooterContainerFrontendRight:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	if CoD.isPC then
		DirectorQuitButtonContainer.id = "DirectorQuitButtonContainer"
	end
	KillerIdentity.id = "KillerIdentity"
	MistakesWereMade.id = "MistakesWereMade"
	WZAAR.id = "WZAAR"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local32 = self
	if IsPC() and not IsDemoPlaying() then
		SetLoseFocusToSelf(self, f1_arg1)
		MakeNotFocusable(f1_local32, f1_arg1)
	elseif IsDemoPlaying() then
		MakeNotFocusable(f1_local32, f1_arg1)
		CoD.BaseUtility.InitGlobalModel("demo.processedKeyframeJump", 0)
	end
	f1_local32 = MatchTimerContainer
	if not IsDemoPlaying() then
		SizeToSafeArea(f1_local32, f1_arg1)
	end
	f1_local32 = DeathCamPrompt
	if not IsDemoPlaying() then
		SizeToSafeArea(f1_local32, f1_arg1)
	end
	return self
end
CoD.GameEndScore_WZ.__resetProperties = function(f113_arg0)
	f113_arg0.Outcome:completeAnimation()
	f113_arg0.PlayerResultContainer:completeAnimation()
	f113_arg0.EliminatorContainer:completeAnimation()
	f113_arg0.GameStatus:completeAnimation()
	f113_arg0.FooterContainerFrontendRight:completeAnimation()
	f113_arg0.DownNotOut:completeAnimation()
	f113_arg0.NoiseEliminatedBacking:completeAnimation()
	f113_arg0.emptyFocusablePC:completeAnimation()
	f113_arg0.DeathCamPrompt:completeAnimation()
	f113_arg0.VoipContainerNoCompass:completeAnimation()
	f113_arg0.CrosshairOccluder:completeAnimation()
	f113_arg0.WZAAR:completeAnimation()
	f113_arg0.Blur:completeAnimation()
	f113_arg0.BlurWZAAR:completeAnimation()
	f113_arg0.ChallengeCoin2:completeAnimation()
	f113_arg0.BarRight:completeAnimation()
	f113_arg0.BarLeft:completeAnimation()
	f113_arg0.BarMiddle:completeAnimation()
	f113_arg0.HeaderTextTeamRank:completeAnimation()
	f113_arg0.MatchTimerContainer:completeAnimation()
	f113_arg0.ChallengeCoinFlare2:completeAnimation()
	f113_arg0.ChallengeCoinFlare3:completeAnimation()
	f113_arg0.SoundGameOverSlam:completeAnimation()
	f113_arg0.ChallengeCoinSound:completeAnimation()
	f113_arg0.KillerIdentity:completeAnimation()
	f113_arg0.MistakesWereMade:completeAnimation()
	f113_arg0.WeaponIdentity:completeAnimation()
	f113_arg0.MeansOfDeath:completeAnimation()
	f113_arg0.Outcome:setAlpha(0)
	f113_arg0.PlayerResultContainer:setAlpha(0)
	f113_arg0.EliminatorContainer:setAlpha(0)
	f113_arg0.GameStatus:setAlpha(0)
	f113_arg0.FooterContainerFrontendRight:setAlpha(1)
	f113_arg0.DownNotOut:setAlpha(0)
	f113_arg0.NoiseEliminatedBacking:setAlpha(0)
	f113_arg0.emptyFocusablePC:setAlpha(1)
	f113_arg0.DeathCamPrompt:setAlpha(1)
	f113_arg0.VoipContainerNoCompass:setLeftRight(0.5, 0.5, -830, -420)
	f113_arg0.VoipContainerNoCompass:setAlpha(1)
	f113_arg0.CrosshairOccluder:setAlpha(1)
	f113_arg0.WZAAR:setAlpha(1)
	f113_arg0.Blur:setAlpha(0)
	f113_arg0.BlurWZAAR:setAlpha(1)
	f113_arg0.ChallengeCoin2:setAlpha(0)
	f113_arg0.ChallengeCoin2:setScale(1, 1)
	f113_arg0.BarRight:setLeftRight(0.93, 1, 0, 0)
	f113_arg0.BarRight:setAlpha(0)
	f113_arg0.BarLeft:setLeftRight(0, 0.07, 0, 0)
	f113_arg0.BarLeft:setAlpha(0)
	f113_arg0.BarMiddle:setTopBottom(0.5, 0.5, -441, -361)
	f113_arg0.BarMiddle:setAlpha(0)
	f113_arg0.HeaderTextTeamRank:setAlpha(0)
	f113_arg0.MatchTimerContainer:setAlpha(0)
	f113_arg0.ChallengeCoinFlare2:setAlpha(0)
	f113_arg0.ChallengeCoinFlare2:setScale(1, 1)
	f113_arg0.ChallengeCoinFlare3:setAlpha(0)
	f113_arg0.ChallengeCoinFlare3:setScale(1, 1)
	f113_arg0.SoundGameOverSlam:setPlaySoundDirect(false)
	f113_arg0.ChallengeCoinSound:setPlaySoundDirect(false)
	f113_arg0.KillerIdentity:setAlpha(0)
	f113_arg0.MistakesWereMade:setAlpha(0)
	f113_arg0.WeaponIdentity:setAlpha(0)
	f113_arg0.MeansOfDeath:setAlpha(0)
end
CoD.GameEndScore_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f114_arg0, f114_arg1)
			f114_arg0:__resetProperties()
			f114_arg0:setupElementClipCounter(14)
			f114_arg0.Blur:completeAnimation()
			f114_arg0.Blur:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.Blur)
			f114_arg0.BlurWZAAR:completeAnimation()
			f114_arg0.BlurWZAAR:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.BlurWZAAR)
			f114_arg0.NoiseEliminatedBacking:completeAnimation()
			f114_arg0.NoiseEliminatedBacking:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.NoiseEliminatedBacking)
			f114_arg0.PlayerResultContainer:completeAnimation()
			f114_arg0.PlayerResultContainer:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.PlayerResultContainer)
			f114_arg0.Outcome:completeAnimation()
			f114_arg0.Outcome:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.Outcome)
			f114_arg0.EliminatorContainer:completeAnimation()
			f114_arg0.EliminatorContainer:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.EliminatorContainer)
			f114_arg0.GameStatus:completeAnimation()
			f114_arg0.GameStatus:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.GameStatus)
			f114_arg0.DownNotOut:completeAnimation()
			f114_arg0.DownNotOut:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.DownNotOut)
			f114_arg0.emptyFocusablePC:completeAnimation()
			f114_arg0.emptyFocusablePC:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.emptyFocusablePC)
			f114_arg0.FooterContainerFrontendRight:completeAnimation()
			f114_arg0.FooterContainerFrontendRight:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.FooterContainerFrontendRight)
			f114_arg0.DeathCamPrompt:completeAnimation()
			f114_arg0.DeathCamPrompt:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.DeathCamPrompt)
			f114_arg0.VoipContainerNoCompass:completeAnimation()
			f114_arg0.VoipContainerNoCompass:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.VoipContainerNoCompass)
			f114_arg0.WZAAR:completeAnimation()
			f114_arg0.WZAAR:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.WZAAR)
			f114_arg0.CrosshairOccluder:completeAnimation()
			f114_arg0.CrosshairOccluder:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.CrosshairOccluder)
		end,
	},
	VictoryPlatoonPC = {
		DefaultClip = function(f115_arg0, f115_arg1)
			f115_arg0:__resetProperties()
			f115_arg0:setupElementClipCounter(10)
			f115_arg0.MatchTimerContainer:completeAnimation()
			f115_arg0.MatchTimerContainer:setAlpha(1)
			f115_arg0.clipFinished(f115_arg0.MatchTimerContainer)
			f115_arg0.DownNotOut:completeAnimation()
			f115_arg0.DownNotOut:setAlpha(0)
			f115_arg0.clipFinished(f115_arg0.DownNotOut)
			f115_arg0.emptyFocusablePC:completeAnimation()
			f115_arg0.emptyFocusablePC:setAlpha(1)
			f115_arg0.clipFinished(f115_arg0.emptyFocusablePC)
			f115_arg0.FooterContainerFrontendRight:completeAnimation()
			f115_arg0.FooterContainerFrontendRight:setAlpha(1)
			f115_arg0.clipFinished(f115_arg0.FooterContainerFrontendRight)
			f115_arg0.DeathCamPrompt:completeAnimation()
			f115_arg0.DeathCamPrompt:setAlpha(1)
			f115_arg0.clipFinished(f115_arg0.DeathCamPrompt)
			f115_arg0.BarMiddle:completeAnimation()
			f115_arg0.BarMiddle:setAlpha(1)
			f115_arg0.clipFinished(f115_arg0.BarMiddle)
			f115_arg0.BarLeft:completeAnimation()
			f115_arg0.BarLeft:setAlpha(1)
			f115_arg0.clipFinished(f115_arg0.BarLeft)
			f115_arg0.BarRight:completeAnimation()
			f115_arg0.BarRight:setAlpha(1)
			f115_arg0.clipFinished(f115_arg0.BarRight)
			f115_arg0.ChallengeCoin2:completeAnimation()
			f115_arg0.ChallengeCoin2:setAlpha(1)
			f115_arg0.clipFinished(f115_arg0.ChallengeCoin2)
			f115_arg0.HeaderTextTeamRank:completeAnimation()
			f115_arg0.HeaderTextTeamRank:setAlpha(1)
			f115_arg0.HeaderTextTeamRank:playClip("Victory")
			f115_arg0.clipFinished(f115_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f116_arg0, f116_arg1)
			f116_arg0:__resetProperties()
			f116_arg0:setupElementClipCounter(13)
			local f116_local0 = function(f117_arg0)
				local f117_local0 = function(f118_arg0)
					f118_arg0:beginAnimation(1000)
					f118_arg0:setAlpha(1)
					f118_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
				end
				f116_arg0.MatchTimerContainer:beginAnimation(4000)
				f116_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f117_local0)
			end
			f116_arg0.MatchTimerContainer:completeAnimation()
			f116_arg0.MatchTimerContainer:setAlpha(0)
			f116_local0(f116_arg0.MatchTimerContainer)
			f116_arg0.DownNotOut:completeAnimation()
			f116_arg0.DownNotOut:setAlpha(0)
			f116_arg0.clipFinished(f116_arg0.DownNotOut)
			local f116_local1 = function(f119_arg0)
				local f119_local0 = function(f120_arg0)
					f120_arg0:beginAnimation(1000)
					f120_arg0:setAlpha(1)
					f120_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
				end
				f116_arg0.FooterContainerFrontendRight:beginAnimation(4000)
				f116_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f119_local0)
			end
			f116_arg0.FooterContainerFrontendRight:completeAnimation()
			f116_arg0.FooterContainerFrontendRight:setAlpha(0)
			f116_local1(f116_arg0.FooterContainerFrontendRight)
			local f116_local2 = function(f121_arg0)
				local f121_local0 = function(f122_arg0)
					f122_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f122_arg0:setAlpha(1)
					f122_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
				end
				f116_arg0.DeathCamPrompt:beginAnimation(4000)
				f116_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f121_local0)
			end
			f116_arg0.DeathCamPrompt:completeAnimation()
			f116_arg0.DeathCamPrompt:setAlpha(0)
			f116_local2(f116_arg0.DeathCamPrompt)
			f116_arg0.ChallengeCoinSound:beginAnimation(1250)
			f116_arg0.ChallengeCoinSound:setPlaySoundDirect(true)
			f116_arg0.ChallengeCoinSound:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
			f116_arg0.ChallengeCoinSound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_victory_medal", f116_arg1)
				f116_arg0.clipFinished(element, event)
			end)
			f116_arg0.SoundGameOverSlam:beginAnimation(680)
			f116_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f116_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
			f116_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f116_arg1)
				f116_arg0.clipFinished(element, event)
			end)
			local f116_local3 = function(f125_arg0)
				local f125_local0 = function(f126_arg0)
					local f126_local0 = function(f127_arg0)
						local f127_local0 = function(f128_arg0)
							local f128_local0 = function(f129_arg0)
								local f129_local0 = function(f130_arg0)
									local f130_local0 = function(f131_arg0)
										local f131_local0 = function(f132_arg0)
											local f132_local0 = function(f133_arg0)
												f133_arg0:beginAnimation(19)
												f133_arg0:setAlpha(1)
												f133_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
											end
											f132_arg0:beginAnimation(20)
											f132_arg0:setAlpha(0.2)
											f132_arg0:registerEventHandler("transition_complete_keyframe", f132_local0)
										end
										f131_arg0:beginAnimation(19)
										f131_arg0:setAlpha(1)
										f131_arg0:registerEventHandler("transition_complete_keyframe", f131_local0)
									end
									f130_arg0:beginAnimation(30)
									f130_arg0:setAlpha(0)
									f130_arg0:registerEventHandler("transition_complete_keyframe", f130_local0)
								end
								f129_arg0:beginAnimation(40, Enum[@"luitween"][@"luitween_ease_out"])
								f129_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f129_arg0:setAlpha(1)
								f129_arg0:registerEventHandler("transition_complete_keyframe", f129_local0)
							end
							f128_arg0:beginAnimation(49, Enum[@"luitween"][@"luitween_ease_out"])
							f128_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f128_arg0:setAlpha(0.95)
							f128_arg0:registerEventHandler("transition_complete_keyframe", f128_local0)
						end
						f127_arg0:beginAnimation(59, Enum[@"luitween"][@"luitween_ease_out"])
						f127_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f127_arg0:setAlpha(0.75)
						f127_arg0:registerEventHandler("transition_complete_keyframe", f127_local0)
					end
					f126_arg0:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_out"])
					f126_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f126_arg0:setAlpha(0.44)
					f126_arg0:registerEventHandler("transition_complete_keyframe", f126_local0)
				end
				f116_arg0.BarMiddle:beginAnimation(30)
				f116_arg0.BarMiddle:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f116_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f125_local0)
			end
			f116_arg0.BarMiddle:completeAnimation()
			f116_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f116_arg0.BarMiddle:setAlpha(0)
			f116_local3(f116_arg0.BarMiddle)
			local f116_local4 = function(f134_arg0)
				local f134_local0 = function(f135_arg0)
					local f135_local0 = function(f136_arg0)
						f136_arg0:beginAnimation(59)
						f136_arg0:setLeftRight(0, 0.07, 0, 0)
						f136_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
					end
					f135_arg0:beginAnimation(80)
					f135_arg0:setLeftRight(0, 0.07, -10, -10)
					f135_arg0:registerEventHandler("transition_complete_keyframe", f135_local0)
				end
				f116_arg0.BarLeft:beginAnimation(99)
				f116_arg0.BarLeft:setLeftRight(0, 0.07, 0, 0)
				f116_arg0.BarLeft:setAlpha(1)
				f116_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f134_local0)
			end
			f116_arg0.BarLeft:completeAnimation()
			f116_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f116_arg0.BarLeft:setAlpha(0)
			f116_local4(f116_arg0.BarLeft)
			local f116_local5 = function(f137_arg0)
				local f137_local0 = function(f138_arg0)
					local f138_local0 = function(f139_arg0)
						f139_arg0:beginAnimation(59)
						f139_arg0:setLeftRight(0.93, 1, 0, 0)
						f139_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
					end
					f138_arg0:beginAnimation(80)
					f138_arg0:setLeftRight(0.93, 1, 10, 10)
					f138_arg0:registerEventHandler("transition_complete_keyframe", f138_local0)
				end
				f116_arg0.BarRight:beginAnimation(99)
				f116_arg0.BarRight:setLeftRight(0.93, 1, 0, 0)
				f116_arg0.BarRight:setAlpha(1)
				f116_arg0.BarRight:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f137_local0)
			end
			f116_arg0.BarRight:completeAnimation()
			f116_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f116_arg0.BarRight:setAlpha(0)
			f116_local5(f116_arg0.BarRight)
			local f116_local6 = function(f140_arg0)
				local f140_local0 = function(f141_arg0)
					local f141_local0 = function(f142_arg0)
						local f142_local0 = function(f143_arg0)
							local f143_local0 = function(f144_arg0)
								f144_arg0:beginAnimation(29, Enum[@"luitween"][@"luitween_ease_out"])
								f144_arg0:setScale(10, 10)
								f144_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
							end
							f143_arg0:beginAnimation(519, Enum[@"luitween"][@"luitween_ease_out"])
							f143_arg0:setAlpha(0)
							f143_arg0:setScale(9.97, 9.97)
							f143_arg0:registerEventHandler("transition_complete_keyframe", f143_local0)
						end
						f142_arg0:beginAnimation(70, Enum[@"luitween"][@"luitween_ease_out"])
						f142_arg0:setScale(3.57, 3.57)
						f142_arg0:registerEventHandler("transition_complete_keyframe", f142_local0)
					end
					f141_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f141_arg0:setAlpha(1)
					f141_arg0:setScale(2.75, 2.75)
					f141_arg0:registerEventHandler("transition_complete_keyframe", f141_local0)
				end
				f116_arg0.ChallengeCoinFlare2:beginAnimation(1350)
				f116_arg0.ChallengeCoinFlare2:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.ChallengeCoinFlare2:registerEventHandler("transition_complete_keyframe", f140_local0)
			end
			f116_arg0.ChallengeCoinFlare2:completeAnimation()
			f116_arg0.ChallengeCoinFlare2:setAlpha(0)
			f116_arg0.ChallengeCoinFlare2:setScale(1, 1)
			f116_local6(f116_arg0.ChallengeCoinFlare2)
			local f116_local7 = function(f145_arg0)
				local f145_local0 = function(f146_arg0)
					local f146_local0 = function(f147_arg0)
						local f147_local0 = function(f148_arg0)
							local f148_local0 = function(f149_arg0)
								f149_arg0:beginAnimation(30)
								f149_arg0:setScale(5, 5)
								f149_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
							end
							f148_arg0:beginAnimation(219)
							f148_arg0:setScale(4.68, 4.68)
							f148_arg0:registerEventHandler("transition_complete_keyframe", f148_local0)
						end
						f147_arg0:beginAnimation(70)
						f147_arg0:setScale(2.34, 2.34)
						f147_arg0:registerEventHandler("transition_complete_keyframe", f147_local0)
					end
					f146_arg0:beginAnimation(149)
					f146_arg0:setScale(1.6, 1.6)
					f146_arg0:registerEventHandler("transition_complete_keyframe", f146_local0)
				end
				f116_arg0.ChallengeCoinFlare3:beginAnimation(1350)
				f116_arg0.ChallengeCoinFlare3:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.ChallengeCoinFlare3:registerEventHandler("transition_complete_keyframe", f145_local0)
			end
			f116_arg0.ChallengeCoinFlare3:completeAnimation()
			f116_arg0.ChallengeCoinFlare3:setAlpha(0)
			f116_arg0.ChallengeCoinFlare3:setScale(0, 1)
			f116_local7(f116_arg0.ChallengeCoinFlare3)
			local f116_local8 = function(f150_arg0)
				local f150_local0 = function(f151_arg0)
					local f151_local0 = function(f152_arg0)
						local f152_local0 = function(f153_arg0)
							local f153_local0 = function(f154_arg0)
								f154_arg0:beginAnimation(50, Enum[@"luitween"][@"luitween_ease_out"])
								f154_arg0:setScale(1, 1)
								f154_arg0:registerEventHandler("transition_complete_keyframe", f116_arg0.clipFinished)
							end
							f153_arg0:beginAnimation(39, Enum[@"luitween"][@"luitween_ease_out"])
							f153_arg0:setScale(1.2, 1.2)
							f153_arg0:registerEventHandler("transition_complete_keyframe", f153_local0)
						end
						f152_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
						f152_arg0:setScale(0.75, 0.75)
						f152_arg0:registerEventHandler("transition_complete_keyframe", f152_local0)
					end
					f151_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f151_arg0:setAlpha(1)
					f151_arg0:setScale(3.95, 3.95)
					f151_arg0:registerEventHandler("transition_complete_keyframe", f151_local0)
				end
				f116_arg0.ChallengeCoin2:beginAnimation(1100)
				f116_arg0.ChallengeCoin2:setScale(10, 10)
				f116_arg0.ChallengeCoin2:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.ChallengeCoin2:registerEventHandler("transition_complete_keyframe", f150_local0)
			end
			f116_arg0.ChallengeCoin2:completeAnimation()
			f116_arg0.ChallengeCoin2:setAlpha(0)
			f116_arg0.ChallengeCoin2:setScale(4, 4)
			f116_local8(f116_arg0.ChallengeCoin2)
			local f116_local9 = function(f155_arg0)
				local f155_local0 = function(f156_arg0)
					f156_arg0:beginAnimation(9)
					f156_arg0:setAlpha(1)
					f156_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("VictoryPlatoonIntro")
						f116_arg0.clipFinished(element, event)
					end)
				end
				f116_arg0.HeaderTextTeamRank:beginAnimation(690)
				f116_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f116_arg0.clipInterrupted)
				f116_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f155_local0)
			end
			f116_arg0.HeaderTextTeamRank:completeAnimation()
			f116_arg0.HeaderTextTeamRank:setAlpha(0)
			f116_local9(f116_arg0.HeaderTextTeamRank)
		end,
	},
	VictoryPC = {
		DefaultClip = function(f158_arg0, f158_arg1)
			f158_arg0:__resetProperties()
			f158_arg0:setupElementClipCounter(10)
			f158_arg0.MatchTimerContainer:completeAnimation()
			f158_arg0.MatchTimerContainer:setAlpha(1)
			f158_arg0.clipFinished(f158_arg0.MatchTimerContainer)
			f158_arg0.DownNotOut:completeAnimation()
			f158_arg0.DownNotOut:setAlpha(0)
			f158_arg0.clipFinished(f158_arg0.DownNotOut)
			f158_arg0.emptyFocusablePC:completeAnimation()
			f158_arg0.emptyFocusablePC:setAlpha(1)
			f158_arg0.clipFinished(f158_arg0.emptyFocusablePC)
			f158_arg0.FooterContainerFrontendRight:completeAnimation()
			f158_arg0.FooterContainerFrontendRight:setAlpha(1)
			f158_arg0.clipFinished(f158_arg0.FooterContainerFrontendRight)
			f158_arg0.DeathCamPrompt:completeAnimation()
			f158_arg0.DeathCamPrompt:setAlpha(1)
			f158_arg0.clipFinished(f158_arg0.DeathCamPrompt)
			f158_arg0.BarMiddle:completeAnimation()
			f158_arg0.BarMiddle:setAlpha(1)
			f158_arg0.clipFinished(f158_arg0.BarMiddle)
			f158_arg0.BarLeft:completeAnimation()
			f158_arg0.BarLeft:setAlpha(1)
			f158_arg0.clipFinished(f158_arg0.BarLeft)
			f158_arg0.BarRight:completeAnimation()
			f158_arg0.BarRight:setAlpha(1)
			f158_arg0.clipFinished(f158_arg0.BarRight)
			f158_arg0.ChallengeCoin2:completeAnimation()
			f158_arg0.ChallengeCoin2:setAlpha(1)
			f158_arg0.clipFinished(f158_arg0.ChallengeCoin2)
			f158_arg0.HeaderTextTeamRank:completeAnimation()
			f158_arg0.HeaderTextTeamRank:setAlpha(1)
			f158_arg0.HeaderTextTeamRank:playClip("Victory")
			f158_arg0.clipFinished(f158_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f159_arg0, f159_arg1)
			f159_arg0:__resetProperties()
			f159_arg0:setupElementClipCounter(13)
			local f159_local0 = function(f160_arg0)
				local f160_local0 = function(f161_arg0)
					f161_arg0:beginAnimation(1000)
					f161_arg0:setAlpha(1)
					f161_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
				end
				f159_arg0.MatchTimerContainer:beginAnimation(4000)
				f159_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f160_local0)
			end
			f159_arg0.MatchTimerContainer:completeAnimation()
			f159_arg0.MatchTimerContainer:setAlpha(0)
			f159_local0(f159_arg0.MatchTimerContainer)
			f159_arg0.DownNotOut:completeAnimation()
			f159_arg0.DownNotOut:setAlpha(0)
			f159_arg0.clipFinished(f159_arg0.DownNotOut)
			local f159_local1 = function(f162_arg0)
				local f162_local0 = function(f163_arg0)
					f163_arg0:beginAnimation(1000)
					f163_arg0:setAlpha(1)
					f163_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
				end
				f159_arg0.FooterContainerFrontendRight:beginAnimation(4000)
				f159_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f162_local0)
			end
			f159_arg0.FooterContainerFrontendRight:completeAnimation()
			f159_arg0.FooterContainerFrontendRight:setAlpha(0)
			f159_local1(f159_arg0.FooterContainerFrontendRight)
			local f159_local2 = function(f164_arg0)
				local f164_local0 = function(f165_arg0)
					f165_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f165_arg0:setAlpha(1)
					f165_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
				end
				f159_arg0.DeathCamPrompt:beginAnimation(4000)
				f159_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f164_local0)
			end
			f159_arg0.DeathCamPrompt:completeAnimation()
			f159_arg0.DeathCamPrompt:setAlpha(0)
			f159_local2(f159_arg0.DeathCamPrompt)
			f159_arg0.ChallengeCoinSound:beginAnimation(1250)
			f159_arg0.ChallengeCoinSound:setPlaySoundDirect(true)
			f159_arg0.ChallengeCoinSound:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
			f159_arg0.ChallengeCoinSound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_victory_medal", f159_arg1)
				f159_arg0.clipFinished(element, event)
			end)
			f159_arg0.SoundGameOverSlam:beginAnimation(680)
			f159_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f159_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
			f159_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f159_arg1)
				f159_arg0.clipFinished(element, event)
			end)
			local f159_local3 = function(f168_arg0)
				local f168_local0 = function(f169_arg0)
					local f169_local0 = function(f170_arg0)
						local f170_local0 = function(f171_arg0)
							local f171_local0 = function(f172_arg0)
								local f172_local0 = function(f173_arg0)
									local f173_local0 = function(f174_arg0)
										local f174_local0 = function(f175_arg0)
											local f175_local0 = function(f176_arg0)
												f176_arg0:beginAnimation(19)
												f176_arg0:setAlpha(1)
												f176_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
											end
											f175_arg0:beginAnimation(20)
											f175_arg0:setAlpha(0.2)
											f175_arg0:registerEventHandler("transition_complete_keyframe", f175_local0)
										end
										f174_arg0:beginAnimation(19)
										f174_arg0:setAlpha(1)
										f174_arg0:registerEventHandler("transition_complete_keyframe", f174_local0)
									end
									f173_arg0:beginAnimation(30)
									f173_arg0:setAlpha(0)
									f173_arg0:registerEventHandler("transition_complete_keyframe", f173_local0)
								end
								f172_arg0:beginAnimation(40, Enum[@"luitween"][@"luitween_ease_out"])
								f172_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f172_arg0:setAlpha(1)
								f172_arg0:registerEventHandler("transition_complete_keyframe", f172_local0)
							end
							f171_arg0:beginAnimation(49, Enum[@"luitween"][@"luitween_ease_out"])
							f171_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f171_arg0:setAlpha(0.95)
							f171_arg0:registerEventHandler("transition_complete_keyframe", f171_local0)
						end
						f170_arg0:beginAnimation(59, Enum[@"luitween"][@"luitween_ease_out"])
						f170_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f170_arg0:setAlpha(0.75)
						f170_arg0:registerEventHandler("transition_complete_keyframe", f170_local0)
					end
					f169_arg0:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_out"])
					f169_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f169_arg0:setAlpha(0.44)
					f169_arg0:registerEventHandler("transition_complete_keyframe", f169_local0)
				end
				f159_arg0.BarMiddle:beginAnimation(30)
				f159_arg0.BarMiddle:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f159_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f168_local0)
			end
			f159_arg0.BarMiddle:completeAnimation()
			f159_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f159_arg0.BarMiddle:setAlpha(0)
			f159_local3(f159_arg0.BarMiddle)
			local f159_local4 = function(f177_arg0)
				local f177_local0 = function(f178_arg0)
					local f178_local0 = function(f179_arg0)
						f179_arg0:beginAnimation(59)
						f179_arg0:setLeftRight(0, 0.07, 0, 0)
						f179_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
					end
					f178_arg0:beginAnimation(80)
					f178_arg0:setLeftRight(0, 0.07, -10, -10)
					f178_arg0:registerEventHandler("transition_complete_keyframe", f178_local0)
				end
				f159_arg0.BarLeft:beginAnimation(99)
				f159_arg0.BarLeft:setLeftRight(0, 0.07, 0, 0)
				f159_arg0.BarLeft:setAlpha(1)
				f159_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f177_local0)
			end
			f159_arg0.BarLeft:completeAnimation()
			f159_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f159_arg0.BarLeft:setAlpha(0)
			f159_local4(f159_arg0.BarLeft)
			local f159_local5 = function(f180_arg0)
				local f180_local0 = function(f181_arg0)
					local f181_local0 = function(f182_arg0)
						f182_arg0:beginAnimation(59)
						f182_arg0:setLeftRight(0.93, 1, 0, 0)
						f182_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
					end
					f181_arg0:beginAnimation(80)
					f181_arg0:setLeftRight(0.93, 1, 10, 10)
					f181_arg0:registerEventHandler("transition_complete_keyframe", f181_local0)
				end
				f159_arg0.BarRight:beginAnimation(99)
				f159_arg0.BarRight:setLeftRight(0.93, 1, 0, 0)
				f159_arg0.BarRight:setAlpha(1)
				f159_arg0.BarRight:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f180_local0)
			end
			f159_arg0.BarRight:completeAnimation()
			f159_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f159_arg0.BarRight:setAlpha(0)
			f159_local5(f159_arg0.BarRight)
			local f159_local6 = function(f183_arg0)
				local f183_local0 = function(f184_arg0)
					local f184_local0 = function(f185_arg0)
						local f185_local0 = function(f186_arg0)
							local f186_local0 = function(f187_arg0)
								f187_arg0:beginAnimation(29, Enum[@"luitween"][@"luitween_ease_out"])
								f187_arg0:setScale(10, 10)
								f187_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
							end
							f186_arg0:beginAnimation(519, Enum[@"luitween"][@"luitween_ease_out"])
							f186_arg0:setAlpha(0)
							f186_arg0:setScale(9.97, 9.97)
							f186_arg0:registerEventHandler("transition_complete_keyframe", f186_local0)
						end
						f185_arg0:beginAnimation(70, Enum[@"luitween"][@"luitween_ease_out"])
						f185_arg0:setScale(3.57, 3.57)
						f185_arg0:registerEventHandler("transition_complete_keyframe", f185_local0)
					end
					f184_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f184_arg0:setAlpha(1)
					f184_arg0:setScale(2.75, 2.75)
					f184_arg0:registerEventHandler("transition_complete_keyframe", f184_local0)
				end
				f159_arg0.ChallengeCoinFlare2:beginAnimation(1350)
				f159_arg0.ChallengeCoinFlare2:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.ChallengeCoinFlare2:registerEventHandler("transition_complete_keyframe", f183_local0)
			end
			f159_arg0.ChallengeCoinFlare2:completeAnimation()
			f159_arg0.ChallengeCoinFlare2:setAlpha(0)
			f159_arg0.ChallengeCoinFlare2:setScale(1, 1)
			f159_local6(f159_arg0.ChallengeCoinFlare2)
			local f159_local7 = function(f188_arg0)
				local f188_local0 = function(f189_arg0)
					local f189_local0 = function(f190_arg0)
						local f190_local0 = function(f191_arg0)
							local f191_local0 = function(f192_arg0)
								f192_arg0:beginAnimation(30)
								f192_arg0:setScale(5, 5)
								f192_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
							end
							f191_arg0:beginAnimation(219)
							f191_arg0:setScale(4.68, 4.68)
							f191_arg0:registerEventHandler("transition_complete_keyframe", f191_local0)
						end
						f190_arg0:beginAnimation(70)
						f190_arg0:setScale(2.34, 2.34)
						f190_arg0:registerEventHandler("transition_complete_keyframe", f190_local0)
					end
					f189_arg0:beginAnimation(149)
					f189_arg0:setScale(1.6, 1.6)
					f189_arg0:registerEventHandler("transition_complete_keyframe", f189_local0)
				end
				f159_arg0.ChallengeCoinFlare3:beginAnimation(1350)
				f159_arg0.ChallengeCoinFlare3:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.ChallengeCoinFlare3:registerEventHandler("transition_complete_keyframe", f188_local0)
			end
			f159_arg0.ChallengeCoinFlare3:completeAnimation()
			f159_arg0.ChallengeCoinFlare3:setAlpha(0)
			f159_arg0.ChallengeCoinFlare3:setScale(0, 1)
			f159_local7(f159_arg0.ChallengeCoinFlare3)
			local f159_local8 = function(f193_arg0)
				local f193_local0 = function(f194_arg0)
					local f194_local0 = function(f195_arg0)
						local f195_local0 = function(f196_arg0)
							local f196_local0 = function(f197_arg0)
								f197_arg0:beginAnimation(50, Enum[@"luitween"][@"luitween_ease_out"])
								f197_arg0:setScale(1, 1)
								f197_arg0:registerEventHandler("transition_complete_keyframe", f159_arg0.clipFinished)
							end
							f196_arg0:beginAnimation(39, Enum[@"luitween"][@"luitween_ease_out"])
							f196_arg0:setScale(1.2, 1.2)
							f196_arg0:registerEventHandler("transition_complete_keyframe", f196_local0)
						end
						f195_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
						f195_arg0:setScale(0.75, 0.75)
						f195_arg0:registerEventHandler("transition_complete_keyframe", f195_local0)
					end
					f194_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f194_arg0:setAlpha(1)
					f194_arg0:setScale(3.95, 3.95)
					f194_arg0:registerEventHandler("transition_complete_keyframe", f194_local0)
				end
				f159_arg0.ChallengeCoin2:beginAnimation(1100)
				f159_arg0.ChallengeCoin2:setScale(10, 10)
				f159_arg0.ChallengeCoin2:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.ChallengeCoin2:registerEventHandler("transition_complete_keyframe", f193_local0)
			end
			f159_arg0.ChallengeCoin2:completeAnimation()
			f159_arg0.ChallengeCoin2:setAlpha(0)
			f159_arg0.ChallengeCoin2:setScale(4, 4)
			f159_local8(f159_arg0.ChallengeCoin2)
			local f159_local9 = function(f198_arg0)
				local f198_local0 = function(f199_arg0)
					f199_arg0:beginAnimation(9)
					f199_arg0:setAlpha(1)
					f199_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("VictoryIntro")
						f159_arg0.clipFinished(element, event)
					end)
				end
				f159_arg0.HeaderTextTeamRank:beginAnimation(690)
				f159_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f159_arg0.clipInterrupted)
				f159_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f198_local0)
			end
			f159_arg0.HeaderTextTeamRank:completeAnimation()
			f159_arg0.HeaderTextTeamRank:setAlpha(0)
			f159_local9(f159_arg0.HeaderTextTeamRank)
		end,
	},
	DefeatPlatoonPC = {
		DefaultClip = function(f201_arg0, f201_arg1)
			f201_arg0:__resetProperties()
			f201_arg0:setupElementClipCounter(7)
			f201_arg0.MatchTimerContainer:completeAnimation()
			f201_arg0.MatchTimerContainer:setAlpha(1)
			f201_arg0.clipFinished(f201_arg0.MatchTimerContainer)
			f201_arg0.FooterContainerFrontendRight:completeAnimation()
			f201_arg0.FooterContainerFrontendRight:setAlpha(1)
			f201_arg0.clipFinished(f201_arg0.FooterContainerFrontendRight)
			f201_arg0.DeathCamPrompt:completeAnimation()
			f201_arg0.DeathCamPrompt:setAlpha(1)
			f201_arg0.clipFinished(f201_arg0.DeathCamPrompt)
			f201_arg0.BarMiddle:completeAnimation()
			f201_arg0.BarMiddle:setAlpha(1)
			f201_arg0.clipFinished(f201_arg0.BarMiddle)
			f201_arg0.BarLeft:completeAnimation()
			f201_arg0.BarLeft:setAlpha(1)
			f201_arg0.clipFinished(f201_arg0.BarLeft)
			f201_arg0.BarRight:completeAnimation()
			f201_arg0.BarRight:setAlpha(1)
			f201_arg0.clipFinished(f201_arg0.BarRight)
			f201_arg0.HeaderTextTeamRank:completeAnimation()
			f201_arg0.HeaderTextTeamRank:setAlpha(1)
			f201_arg0.HeaderTextTeamRank:playClip("DefeatPlatoon")
			f201_arg0.clipFinished(f201_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f202_arg0, f202_arg1)
			f202_arg0:__resetProperties()
			f202_arg0:setupElementClipCounter(8)
			local f202_local0 = function(f203_arg0)
				local f203_local0 = function(f204_arg0)
					f204_arg0:beginAnimation(1000)
					f204_arg0:setAlpha(1)
					f204_arg0:registerEventHandler("transition_complete_keyframe", f202_arg0.clipFinished)
				end
				f202_arg0.MatchTimerContainer:beginAnimation(5500)
				f202_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
				f202_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f203_local0)
			end
			f202_arg0.MatchTimerContainer:completeAnimation()
			f202_arg0.MatchTimerContainer:setAlpha(0)
			f202_local0(f202_arg0.MatchTimerContainer)
			local f202_local1 = function(f205_arg0)
				local f205_local0 = function(f206_arg0)
					f206_arg0:beginAnimation(1000)
					f206_arg0:setAlpha(1)
					f206_arg0:registerEventHandler("transition_complete_keyframe", f202_arg0.clipFinished)
				end
				f202_arg0.FooterContainerFrontendRight:beginAnimation(5500)
				f202_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
				f202_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f205_local0)
			end
			f202_arg0.FooterContainerFrontendRight:completeAnimation()
			f202_arg0.FooterContainerFrontendRight:setAlpha(0)
			f202_local1(f202_arg0.FooterContainerFrontendRight)
			local f202_local2 = function(f207_arg0)
				local f207_local0 = function(f208_arg0)
					f208_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f208_arg0:setAlpha(1)
					f208_arg0:registerEventHandler("transition_complete_keyframe", f202_arg0.clipFinished)
				end
				f202_arg0.DeathCamPrompt:beginAnimation(5500)
				f202_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
				f202_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f207_local0)
			end
			f202_arg0.DeathCamPrompt:completeAnimation()
			f202_arg0.DeathCamPrompt:setAlpha(0)
			f202_local2(f202_arg0.DeathCamPrompt)
			f202_arg0.SoundGameOverSlam:beginAnimation(2190)
			f202_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f202_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
			f202_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f202_arg1)
				f202_arg0.clipFinished(element, event)
			end)
			local f202_local3 = function(f210_arg0)
				local f210_local0 = function(f211_arg0)
					local f211_local0 = function(f212_arg0)
						local f212_local0 = function(f213_arg0)
							local f213_local0 = function(f214_arg0)
								local f214_local0 = function(f215_arg0)
									local f215_local0 = function(f216_arg0)
										local f216_local0 = function(f217_arg0)
											local f217_local0 = function(f218_arg0)
												f218_arg0:beginAnimation(19)
												f218_arg0:setAlpha(1)
												f218_arg0:registerEventHandler("transition_complete_keyframe", f202_arg0.clipFinished)
											end
											f217_arg0:beginAnimation(19)
											f217_arg0:setAlpha(0.2)
											f217_arg0:registerEventHandler("transition_complete_keyframe", f217_local0)
										end
										f216_arg0:beginAnimation(19)
										f216_arg0:setAlpha(1)
										f216_arg0:registerEventHandler("transition_complete_keyframe", f216_local0)
									end
									f215_arg0:beginAnimation(30)
									f215_arg0:setAlpha(0)
									f215_arg0:registerEventHandler("transition_complete_keyframe", f215_local0)
								end
								f214_arg0:beginAnimation(39)
								f214_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f214_arg0:setAlpha(1)
								f214_arg0:registerEventHandler("transition_complete_keyframe", f214_local0)
							end
							f213_arg0:beginAnimation(49)
							f213_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f213_arg0:setAlpha(0.85)
							f213_arg0:registerEventHandler("transition_complete_keyframe", f213_local0)
						end
						f212_arg0:beginAnimation(60)
						f212_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f212_arg0:setAlpha(0.67)
						f212_arg0:registerEventHandler("transition_complete_keyframe", f212_local0)
					end
					f211_arg0:beginAnimation(120)
					f211_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f211_arg0:setAlpha(0.44)
					f211_arg0:registerEventHandler("transition_complete_keyframe", f211_local0)
				end
				f210_arg0:beginAnimation(29)
				f210_arg0:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f210_arg0:registerEventHandler("transition_complete_keyframe", f210_local0)
			end
			f202_arg0.BarMiddle:beginAnimation(1510)
			f202_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f202_arg0.BarMiddle:setAlpha(0)
			f202_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
			f202_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f202_local3)
			local f202_local4 = function(f219_arg0)
				local f219_local0 = function(f220_arg0)
					local f220_local0 = function(f221_arg0)
						f221_arg0:beginAnimation(59)
						f221_arg0:setLeftRight(0, 0.07, 0, 0)
						f221_arg0:registerEventHandler("transition_complete_keyframe", f202_arg0.clipFinished)
					end
					f220_arg0:beginAnimation(80)
					f220_arg0:setLeftRight(0, 0.07, -10, -10)
					f220_arg0:registerEventHandler("transition_complete_keyframe", f220_local0)
				end
				f219_arg0:beginAnimation(100)
				f219_arg0:setLeftRight(0, 0.07, 0, 0)
				f219_arg0:setAlpha(1)
				f219_arg0:registerEventHandler("transition_complete_keyframe", f219_local0)
			end
			f202_arg0.BarLeft:beginAnimation(1510)
			f202_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f202_arg0.BarLeft:setAlpha(0)
			f202_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
			f202_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f202_local4)
			local f202_local5 = function(f222_arg0)
				local f222_local0 = function(f223_arg0)
					local f223_local0 = function(f224_arg0)
						f224_arg0:beginAnimation(59)
						f224_arg0:setLeftRight(0.93, 1, 0, 0)
						f224_arg0:registerEventHandler("transition_complete_keyframe", f202_arg0.clipFinished)
					end
					f223_arg0:beginAnimation(80)
					f223_arg0:setLeftRight(0.93, 1, 10, 10)
					f223_arg0:registerEventHandler("transition_complete_keyframe", f223_local0)
				end
				f222_arg0:beginAnimation(100)
				f222_arg0:setLeftRight(0.93, 1, 0, 0)
				f222_arg0:setAlpha(1)
				f222_arg0:registerEventHandler("transition_complete_keyframe", f222_local0)
			end
			f202_arg0.BarRight:beginAnimation(1510)
			f202_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f202_arg0.BarRight:setAlpha(0)
			f202_arg0.BarRight:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
			f202_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f202_local5)
			local f202_local6 = function(f225_arg0)
				local f225_local0 = function(f226_arg0)
					f226_arg0:beginAnimation(9)
					f226_arg0:setAlpha(1)
					f226_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefeatPlatoonIntro")
						f202_arg0.clipFinished(element, event)
					end)
				end
				f225_arg0:beginAnimation(690)
				f225_arg0:registerEventHandler("transition_complete_keyframe", f225_local0)
			end
			f202_arg0.HeaderTextTeamRank:beginAnimation(1510)
			f202_arg0.HeaderTextTeamRank:setAlpha(0)
			f202_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
			f202_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f202_local6)
		end,
	},
	DefeatPC = {
		DefaultClip = function(f228_arg0, f228_arg1)
			f228_arg0:__resetProperties()
			f228_arg0:setupElementClipCounter(7)
			f228_arg0.MatchTimerContainer:completeAnimation()
			f228_arg0.MatchTimerContainer:setAlpha(1)
			f228_arg0.clipFinished(f228_arg0.MatchTimerContainer)
			f228_arg0.FooterContainerFrontendRight:completeAnimation()
			f228_arg0.FooterContainerFrontendRight:setAlpha(1)
			f228_arg0.clipFinished(f228_arg0.FooterContainerFrontendRight)
			f228_arg0.DeathCamPrompt:completeAnimation()
			f228_arg0.DeathCamPrompt:setAlpha(1)
			f228_arg0.clipFinished(f228_arg0.DeathCamPrompt)
			f228_arg0.BarMiddle:completeAnimation()
			f228_arg0.BarMiddle:setAlpha(1)
			f228_arg0.clipFinished(f228_arg0.BarMiddle)
			f228_arg0.BarLeft:completeAnimation()
			f228_arg0.BarLeft:setAlpha(1)
			f228_arg0.clipFinished(f228_arg0.BarLeft)
			f228_arg0.BarRight:completeAnimation()
			f228_arg0.BarRight:setAlpha(1)
			f228_arg0.clipFinished(f228_arg0.BarRight)
			f228_arg0.HeaderTextTeamRank:completeAnimation()
			f228_arg0.HeaderTextTeamRank:setAlpha(1)
			f228_arg0.HeaderTextTeamRank:playClip("Defeat")
			f228_arg0.clipFinished(f228_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f229_arg0, f229_arg1)
			f229_arg0:__resetProperties()
			f229_arg0:setupElementClipCounter(8)
			local f229_local0 = function(f230_arg0)
				local f230_local0 = function(f231_arg0)
					f231_arg0:beginAnimation(1000)
					f231_arg0:setAlpha(1)
					f231_arg0:registerEventHandler("transition_complete_keyframe", f229_arg0.clipFinished)
				end
				f229_arg0.MatchTimerContainer:beginAnimation(5500)
				f229_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f229_arg0.clipInterrupted)
				f229_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f230_local0)
			end
			f229_arg0.MatchTimerContainer:completeAnimation()
			f229_arg0.MatchTimerContainer:setAlpha(0)
			f229_local0(f229_arg0.MatchTimerContainer)
			local f229_local1 = function(f232_arg0)
				local f232_local0 = function(f233_arg0)
					f233_arg0:beginAnimation(1000)
					f233_arg0:setAlpha(1)
					f233_arg0:registerEventHandler("transition_complete_keyframe", f229_arg0.clipFinished)
				end
				f229_arg0.FooterContainerFrontendRight:beginAnimation(5500)
				f229_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f229_arg0.clipInterrupted)
				f229_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f232_local0)
			end
			f229_arg0.FooterContainerFrontendRight:completeAnimation()
			f229_arg0.FooterContainerFrontendRight:setAlpha(0)
			f229_local1(f229_arg0.FooterContainerFrontendRight)
			local f229_local2 = function(f234_arg0)
				local f234_local0 = function(f235_arg0)
					f235_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f235_arg0:setAlpha(1)
					f235_arg0:registerEventHandler("transition_complete_keyframe", f229_arg0.clipFinished)
				end
				f229_arg0.DeathCamPrompt:beginAnimation(5500)
				f229_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f229_arg0.clipInterrupted)
				f229_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f234_local0)
			end
			f229_arg0.DeathCamPrompt:completeAnimation()
			f229_arg0.DeathCamPrompt:setAlpha(0)
			f229_local2(f229_arg0.DeathCamPrompt)
			f229_arg0.SoundGameOverSlam:beginAnimation(2190)
			f229_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f229_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f229_arg0.clipInterrupted)
			f229_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f229_arg1)
				f229_arg0.clipFinished(element, event)
			end)
			local f229_local3 = function(f237_arg0)
				local f237_local0 = function(f238_arg0)
					local f238_local0 = function(f239_arg0)
						local f239_local0 = function(f240_arg0)
							local f240_local0 = function(f241_arg0)
								local f241_local0 = function(f242_arg0)
									local f242_local0 = function(f243_arg0)
										local f243_local0 = function(f244_arg0)
											local f244_local0 = function(f245_arg0)
												f245_arg0:beginAnimation(19)
												f245_arg0:setAlpha(1)
												f245_arg0:registerEventHandler("transition_complete_keyframe", f229_arg0.clipFinished)
											end
											f244_arg0:beginAnimation(19)
											f244_arg0:setAlpha(0.2)
											f244_arg0:registerEventHandler("transition_complete_keyframe", f244_local0)
										end
										f243_arg0:beginAnimation(19)
										f243_arg0:setAlpha(1)
										f243_arg0:registerEventHandler("transition_complete_keyframe", f243_local0)
									end
									f242_arg0:beginAnimation(30)
									f242_arg0:setAlpha(0)
									f242_arg0:registerEventHandler("transition_complete_keyframe", f242_local0)
								end
								f241_arg0:beginAnimation(39)
								f241_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f241_arg0:setAlpha(1)
								f241_arg0:registerEventHandler("transition_complete_keyframe", f241_local0)
							end
							f240_arg0:beginAnimation(49)
							f240_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f240_arg0:setAlpha(0.85)
							f240_arg0:registerEventHandler("transition_complete_keyframe", f240_local0)
						end
						f239_arg0:beginAnimation(60)
						f239_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f239_arg0:setAlpha(0.67)
						f239_arg0:registerEventHandler("transition_complete_keyframe", f239_local0)
					end
					f238_arg0:beginAnimation(120)
					f238_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f238_arg0:setAlpha(0.44)
					f238_arg0:registerEventHandler("transition_complete_keyframe", f238_local0)
				end
				f237_arg0:beginAnimation(29)
				f237_arg0:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f237_arg0:registerEventHandler("transition_complete_keyframe", f237_local0)
			end
			f229_arg0.BarMiddle:beginAnimation(1510)
			f229_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f229_arg0.BarMiddle:setAlpha(0)
			f229_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f229_arg0.clipInterrupted)
			f229_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f229_local3)
			local f229_local4 = function(f246_arg0)
				local f246_local0 = function(f247_arg0)
					local f247_local0 = function(f248_arg0)
						f248_arg0:beginAnimation(59)
						f248_arg0:setLeftRight(0, 0.07, 0, 0)
						f248_arg0:registerEventHandler("transition_complete_keyframe", f229_arg0.clipFinished)
					end
					f247_arg0:beginAnimation(80)
					f247_arg0:setLeftRight(0, 0.07, -10, -10)
					f247_arg0:registerEventHandler("transition_complete_keyframe", f247_local0)
				end
				f246_arg0:beginAnimation(100)
				f246_arg0:setLeftRight(0, 0.07, 0, 0)
				f246_arg0:setAlpha(1)
				f246_arg0:registerEventHandler("transition_complete_keyframe", f246_local0)
			end
			f229_arg0.BarLeft:beginAnimation(1510)
			f229_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f229_arg0.BarLeft:setAlpha(0)
			f229_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f229_arg0.clipInterrupted)
			f229_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f229_local4)
			local f229_local5 = function(f249_arg0)
				local f249_local0 = function(f250_arg0)
					local f250_local0 = function(f251_arg0)
						f251_arg0:beginAnimation(59)
						f251_arg0:setLeftRight(0.93, 1, 0, 0)
						f251_arg0:registerEventHandler("transition_complete_keyframe", f229_arg0.clipFinished)
					end
					f250_arg0:beginAnimation(80)
					f250_arg0:setLeftRight(0.93, 1, 10, 10)
					f250_arg0:registerEventHandler("transition_complete_keyframe", f250_local0)
				end
				f249_arg0:beginAnimation(100)
				f249_arg0:setLeftRight(0.93, 1, 0, 0)
				f249_arg0:setAlpha(1)
				f249_arg0:registerEventHandler("transition_complete_keyframe", f249_local0)
			end
			f229_arg0.BarRight:beginAnimation(1510)
			f229_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f229_arg0.BarRight:setAlpha(0)
			f229_arg0.BarRight:registerEventHandler("interrupted_keyframe", f229_arg0.clipInterrupted)
			f229_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f229_local5)
			local f229_local6 = function(f252_arg0)
				local f252_local0 = function(f253_arg0)
					f253_arg0:beginAnimation(9)
					f253_arg0:setAlpha(1)
					f253_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefeatIntro")
						f229_arg0.clipFinished(element, event)
					end)
				end
				f252_arg0:beginAnimation(690)
				f252_arg0:registerEventHandler("transition_complete_keyframe", f252_local0)
			end
			f229_arg0.HeaderTextTeamRank:beginAnimation(1510)
			f229_arg0.HeaderTextTeamRank:setAlpha(0)
			f229_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f229_arg0.clipInterrupted)
			f229_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f229_local6)
		end,
	},
	GameOverPC = {
		DefaultClip = function(f255_arg0, f255_arg1)
			f255_arg0:__resetProperties()
			f255_arg0:setupElementClipCounter(8)
			f255_arg0.Blur:beginAnimation(4970)
			f255_arg0.Blur:setAlpha(1)
			f255_arg0.Blur:registerEventHandler("interrupted_keyframe", f255_arg0.clipInterrupted)
			f255_arg0.Blur:registerEventHandler("transition_complete_keyframe", f255_arg0.clipFinished)
			f255_arg0.MatchTimerContainer:completeAnimation()
			f255_arg0.MatchTimerContainer:setAlpha(1)
			f255_arg0.clipFinished(f255_arg0.MatchTimerContainer)
			f255_arg0.FooterContainerFrontendRight:completeAnimation()
			f255_arg0.FooterContainerFrontendRight:setAlpha(1)
			f255_arg0.clipFinished(f255_arg0.FooterContainerFrontendRight)
			f255_arg0.DeathCamPrompt:completeAnimation()
			f255_arg0.DeathCamPrompt:setAlpha(1)
			f255_arg0.clipFinished(f255_arg0.DeathCamPrompt)
			f255_arg0.BarMiddle:completeAnimation()
			f255_arg0.BarMiddle:setAlpha(1)
			f255_arg0.clipFinished(f255_arg0.BarMiddle)
			f255_arg0.BarLeft:completeAnimation()
			f255_arg0.BarLeft:setAlpha(1)
			f255_arg0.clipFinished(f255_arg0.BarLeft)
			f255_arg0.BarRight:completeAnimation()
			f255_arg0.BarRight:setAlpha(1)
			f255_arg0.clipFinished(f255_arg0.BarRight)
			f255_arg0.HeaderTextTeamRank:completeAnimation()
			f255_arg0.HeaderTextTeamRank:setAlpha(1)
			f255_arg0.HeaderTextTeamRank:playClip("Gameover")
			f255_arg0.clipFinished(f255_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f256_arg0, f256_arg1)
			f256_arg0:__resetProperties()
			f256_arg0:setupElementClipCounter(9)
			local f256_local0 = function(f257_arg0)
				f256_arg0.Blur:beginAnimation(2030)
				f256_arg0.Blur:setAlpha(1)
				f256_arg0.Blur:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
				f256_arg0.Blur:registerEventHandler("transition_complete_keyframe", f256_arg0.clipFinished)
			end
			f256_arg0.Blur:completeAnimation()
			f256_arg0.Blur:setAlpha(0)
			f256_local0(f256_arg0.Blur)
			local f256_local1 = function(f258_arg0)
				local f258_local0 = function(f259_arg0)
					f259_arg0:beginAnimation(1000)
					f259_arg0:setAlpha(1)
					f259_arg0:registerEventHandler("transition_complete_keyframe", f256_arg0.clipFinished)
				end
				f256_arg0.MatchTimerContainer:beginAnimation(5500)
				f256_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
				f256_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f258_local0)
			end
			f256_arg0.MatchTimerContainer:completeAnimation()
			f256_arg0.MatchTimerContainer:setAlpha(0)
			f256_local1(f256_arg0.MatchTimerContainer)
			local f256_local2 = function(f260_arg0)
				local f260_local0 = function(f261_arg0)
					f261_arg0:beginAnimation(1000)
					f261_arg0:setAlpha(1)
					f261_arg0:registerEventHandler("transition_complete_keyframe", f256_arg0.clipFinished)
				end
				f256_arg0.FooterContainerFrontendRight:beginAnimation(5500)
				f256_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
				f256_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f260_local0)
			end
			f256_arg0.FooterContainerFrontendRight:completeAnimation()
			f256_arg0.FooterContainerFrontendRight:setAlpha(0)
			f256_local2(f256_arg0.FooterContainerFrontendRight)
			local f256_local3 = function(f262_arg0)
				local f262_local0 = function(f263_arg0)
					f263_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f263_arg0:setAlpha(1)
					f263_arg0:registerEventHandler("transition_complete_keyframe", f256_arg0.clipFinished)
				end
				f256_arg0.DeathCamPrompt:beginAnimation(5500)
				f256_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
				f256_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f262_local0)
			end
			f256_arg0.DeathCamPrompt:completeAnimation()
			f256_arg0.DeathCamPrompt:setAlpha(0)
			f256_local3(f256_arg0.DeathCamPrompt)
			f256_arg0.SoundGameOverSlam:beginAnimation(2180)
			f256_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f256_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
			f256_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f256_arg1)
				f256_arg0.clipFinished(element, event)
			end)
			local f256_local4 = function(f265_arg0)
				local f265_local0 = function(f266_arg0)
					local f266_local0 = function(f267_arg0)
						local f267_local0 = function(f268_arg0)
							local f268_local0 = function(f269_arg0)
								local f269_local0 = function(f270_arg0)
									local f270_local0 = function(f271_arg0)
										local f271_local0 = function(f272_arg0)
											local f272_local0 = function(f273_arg0)
												f273_arg0:beginAnimation(19)
												f273_arg0:setAlpha(1)
												f273_arg0:registerEventHandler("transition_complete_keyframe", f256_arg0.clipFinished)
											end
											f272_arg0:beginAnimation(19)
											f272_arg0:setAlpha(0.2)
											f272_arg0:registerEventHandler("transition_complete_keyframe", f272_local0)
										end
										f271_arg0:beginAnimation(19)
										f271_arg0:setAlpha(1)
										f271_arg0:registerEventHandler("transition_complete_keyframe", f271_local0)
									end
									f270_arg0:beginAnimation(30)
									f270_arg0:setAlpha(0)
									f270_arg0:registerEventHandler("transition_complete_keyframe", f270_local0)
								end
								f269_arg0:beginAnimation(39)
								f269_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f269_arg0:setAlpha(1)
								f269_arg0:registerEventHandler("transition_complete_keyframe", f269_local0)
							end
							f268_arg0:beginAnimation(49)
							f268_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f268_arg0:setAlpha(0.85)
							f268_arg0:registerEventHandler("transition_complete_keyframe", f268_local0)
						end
						f267_arg0:beginAnimation(60)
						f267_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f267_arg0:setAlpha(0.67)
						f267_arg0:registerEventHandler("transition_complete_keyframe", f267_local0)
					end
					f266_arg0:beginAnimation(120)
					f266_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f266_arg0:setAlpha(0.44)
					f266_arg0:registerEventHandler("transition_complete_keyframe", f266_local0)
				end
				f265_arg0:beginAnimation(29)
				f265_arg0:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f265_arg0:registerEventHandler("transition_complete_keyframe", f265_local0)
			end
			f256_arg0.BarMiddle:beginAnimation(1510)
			f256_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f256_arg0.BarMiddle:setAlpha(0)
			f256_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
			f256_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f256_local4)
			local f256_local5 = function(f274_arg0)
				local f274_local0 = function(f275_arg0)
					local f275_local0 = function(f276_arg0)
						f276_arg0:beginAnimation(59)
						f276_arg0:setLeftRight(0, 0.07, 0, 0)
						f276_arg0:registerEventHandler("transition_complete_keyframe", f256_arg0.clipFinished)
					end
					f275_arg0:beginAnimation(80)
					f275_arg0:setLeftRight(0, 0.07, -10, -10)
					f275_arg0:registerEventHandler("transition_complete_keyframe", f275_local0)
				end
				f274_arg0:beginAnimation(100)
				f274_arg0:setLeftRight(0, 0.07, 0, 0)
				f274_arg0:setAlpha(1)
				f274_arg0:registerEventHandler("transition_complete_keyframe", f274_local0)
			end
			f256_arg0.BarLeft:beginAnimation(1510)
			f256_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f256_arg0.BarLeft:setAlpha(0)
			f256_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
			f256_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f256_local5)
			local f256_local6 = function(f277_arg0)
				local f277_local0 = function(f278_arg0)
					local f278_local0 = function(f279_arg0)
						f279_arg0:beginAnimation(59)
						f279_arg0:setLeftRight(0.93, 1, 0, 0)
						f279_arg0:registerEventHandler("transition_complete_keyframe", f256_arg0.clipFinished)
					end
					f278_arg0:beginAnimation(80)
					f278_arg0:setLeftRight(0.93, 1, 10, 10)
					f278_arg0:registerEventHandler("transition_complete_keyframe", f278_local0)
				end
				f277_arg0:beginAnimation(100)
				f277_arg0:setLeftRight(0.93, 1, 0, 0)
				f277_arg0:setAlpha(1)
				f277_arg0:registerEventHandler("transition_complete_keyframe", f277_local0)
			end
			f256_arg0.BarRight:beginAnimation(1510)
			f256_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f256_arg0.BarRight:setAlpha(0)
			f256_arg0.BarRight:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
			f256_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f256_local6)
			local f256_local7 = function(f280_arg0)
				local f280_local0 = function(f281_arg0)
					f281_arg0:beginAnimation(9)
					f281_arg0:setAlpha(1)
					f281_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("GameoverIntro")
						f256_arg0.clipFinished(element, event)
					end)
				end
				f280_arg0:beginAnimation(690)
				f280_arg0:registerEventHandler("transition_complete_keyframe", f280_local0)
			end
			f256_arg0.HeaderTextTeamRank:beginAnimation(1510)
			f256_arg0.HeaderTextTeamRank:setAlpha(0)
			f256_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f256_arg0.clipInterrupted)
			f256_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f256_local7)
		end,
	},
	EliminationPC = {
		DefaultClip = function(f283_arg0, f283_arg1)
			f283_arg0:__resetProperties()
			f283_arg0:setupElementClipCounter(13)
			f283_arg0.Blur:completeAnimation()
			f283_arg0.Blur:setAlpha(1)
			f283_arg0.clipFinished(f283_arg0.Blur)
			f283_arg0.MatchTimerContainer:completeAnimation()
			f283_arg0.MatchTimerContainer:setAlpha(1)
			f283_arg0.clipFinished(f283_arg0.MatchTimerContainer)
			f283_arg0.DownNotOut:completeAnimation()
			f283_arg0.DownNotOut:setAlpha(1)
			f283_arg0.clipFinished(f283_arg0.DownNotOut)
			f283_arg0.FooterContainerFrontendRight:completeAnimation()
			f283_arg0.FooterContainerFrontendRight:setAlpha(1)
			f283_arg0.clipFinished(f283_arg0.FooterContainerFrontendRight)
			f283_arg0.DeathCamPrompt:completeAnimation()
			f283_arg0.DeathCamPrompt:setAlpha(1)
			f283_arg0.clipFinished(f283_arg0.DeathCamPrompt)
			f283_arg0.BarMiddle:completeAnimation()
			f283_arg0.BarMiddle:setAlpha(1)
			f283_arg0.clipFinished(f283_arg0.BarMiddle)
			f283_arg0.BarLeft:completeAnimation()
			f283_arg0.BarLeft:setAlpha(1)
			f283_arg0.clipFinished(f283_arg0.BarLeft)
			f283_arg0.BarRight:completeAnimation()
			f283_arg0.BarRight:setAlpha(1)
			f283_arg0.clipFinished(f283_arg0.BarRight)
			f283_arg0.HeaderTextTeamRank:completeAnimation()
			f283_arg0.HeaderTextTeamRank:setAlpha(1)
			f283_arg0.HeaderTextTeamRank:playClip("Elimination")
			f283_arg0.clipFinished(f283_arg0.HeaderTextTeamRank)
			f283_arg0.KillerIdentity:completeAnimation()
			f283_arg0.KillerIdentity:playClip("Main")
			f283_arg0.clipFinished(f283_arg0.KillerIdentity)
			f283_arg0.MistakesWereMade:completeAnimation()
			f283_arg0.MistakesWereMade:setAlpha(1)
			f283_arg0.MistakesWereMade:playClip("Main")
			f283_arg0.clipFinished(f283_arg0.MistakesWereMade)
			f283_arg0.WeaponIdentity:completeAnimation()
			f283_arg0.WeaponIdentity:setAlpha(1)
			f283_arg0.WeaponIdentity:playClip("Main")
			f283_arg0.clipFinished(f283_arg0.WeaponIdentity)
			f283_arg0.MeansOfDeath:completeAnimation()
			f283_arg0.MeansOfDeath:setAlpha(1)
			f283_arg0.MeansOfDeath:playClip("Main")
			f283_arg0.clipFinished(f283_arg0.MeansOfDeath)
		end,
		FirstTimeIntro = function(f284_arg0, f284_arg1)
			f284_arg0:__resetProperties()
			f284_arg0:setupElementClipCounter(15)
			local f284_local0 = function(f285_arg0)
				f284_arg0.Blur:beginAnimation(1030)
				f284_arg0.Blur:setAlpha(1)
				f284_arg0.Blur:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.Blur:registerEventHandler("transition_complete_keyframe", f284_arg0.clipFinished)
			end
			f284_arg0.Blur:completeAnimation()
			f284_arg0.Blur:setAlpha(0)
			f284_local0(f284_arg0.Blur)
			local f284_local1 = function(f286_arg0)
				local f286_local0 = function(f287_arg0)
					f287_arg0:beginAnimation(1000)
					f287_arg0:setAlpha(1)
					f287_arg0:registerEventHandler("transition_complete_keyframe", f284_arg0.clipFinished)
				end
				f284_arg0.MatchTimerContainer:beginAnimation(4500)
				f284_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f286_local0)
			end
			f284_arg0.MatchTimerContainer:completeAnimation()
			f284_arg0.MatchTimerContainer:setAlpha(0)
			f284_local1(f284_arg0.MatchTimerContainer)
			local f284_local2 = function(f288_arg0)
				local f288_local0 = function(f289_arg0)
					f289_arg0:beginAnimation(1000)
					f289_arg0:setAlpha(1)
					f289_arg0:registerEventHandler("transition_complete_keyframe", f284_arg0.clipFinished)
				end
				f284_arg0.DownNotOut:beginAnimation(3010)
				f284_arg0.DownNotOut:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.DownNotOut:registerEventHandler("transition_complete_keyframe", f288_local0)
			end
			f284_arg0.DownNotOut:completeAnimation()
			f284_arg0.DownNotOut:setAlpha(0)
			f284_local2(f284_arg0.DownNotOut)
			local f284_local3 = function(f290_arg0)
				local f290_local0 = function(f291_arg0)
					f291_arg0:beginAnimation(1000)
					f291_arg0:setAlpha(1)
					f291_arg0:registerEventHandler("transition_complete_keyframe", f284_arg0.clipFinished)
				end
				f284_arg0.FooterContainerFrontendRight:beginAnimation(4500)
				f284_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f290_local0)
			end
			f284_arg0.FooterContainerFrontendRight:completeAnimation()
			f284_arg0.FooterContainerFrontendRight:setAlpha(0)
			f284_local3(f284_arg0.FooterContainerFrontendRight)
			local f284_local4 = function(f292_arg0)
				local f292_local0 = function(f293_arg0)
					f293_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f293_arg0:setAlpha(1)
					f293_arg0:registerEventHandler("transition_complete_keyframe", f284_arg0.clipFinished)
				end
				f284_arg0.DeathCamPrompt:beginAnimation(4500)
				f284_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f292_local0)
			end
			f284_arg0.DeathCamPrompt:completeAnimation()
			f284_arg0.DeathCamPrompt:setAlpha(0)
			f284_local4(f284_arg0.DeathCamPrompt)
			f284_arg0.VoipContainerNoCompass:completeAnimation()
			f284_arg0.VoipContainerNoCompass:setLeftRight(0.5, 0.5, -806, -396)
			f284_arg0.clipFinished(f284_arg0.VoipContainerNoCompass)
			f284_arg0.SoundGameOverSlam:beginAnimation(660)
			f284_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f284_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
			f284_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f284_arg1)
				f284_arg0.clipFinished(element, event)
			end)
			local f284_local5 = function(f295_arg0)
				local f295_local0 = function(f296_arg0)
					local f296_local0 = function(f297_arg0)
						local f297_local0 = function(f298_arg0)
							local f298_local0 = function(f299_arg0)
								local f299_local0 = function(f300_arg0)
									local f300_local0 = function(f301_arg0)
										local f301_local0 = function(f302_arg0)
											local f302_local0 = function(f303_arg0)
												f303_arg0:beginAnimation(19)
												f303_arg0:setAlpha(1)
												f303_arg0:registerEventHandler("transition_complete_keyframe", f284_arg0.clipFinished)
											end
											f302_arg0:beginAnimation(19)
											f302_arg0:setAlpha(0.2)
											f302_arg0:registerEventHandler("transition_complete_keyframe", f302_local0)
										end
										f301_arg0:beginAnimation(20)
										f301_arg0:setAlpha(1)
										f301_arg0:registerEventHandler("transition_complete_keyframe", f301_local0)
									end
									f300_arg0:beginAnimation(30)
									f300_arg0:setAlpha(0)
									f300_arg0:registerEventHandler("transition_complete_keyframe", f300_local0)
								end
								f299_arg0:beginAnimation(39)
								f299_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f299_arg0:setAlpha(1)
								f299_arg0:registerEventHandler("transition_complete_keyframe", f299_local0)
							end
							f298_arg0:beginAnimation(49)
							f298_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f298_arg0:setAlpha(0.85)
							f298_arg0:registerEventHandler("transition_complete_keyframe", f298_local0)
						end
						f297_arg0:beginAnimation(60)
						f297_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f297_arg0:setAlpha(0.67)
						f297_arg0:registerEventHandler("transition_complete_keyframe", f297_local0)
					end
					f296_arg0:beginAnimation(120)
					f296_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f296_arg0:setAlpha(0.44)
					f296_arg0:registerEventHandler("transition_complete_keyframe", f296_local0)
				end
				f295_arg0:beginAnimation(30)
				f295_arg0:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f295_arg0:registerEventHandler("transition_complete_keyframe", f295_local0)
			end
			f284_arg0.BarMiddle:beginAnimation(510)
			f284_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f284_arg0.BarMiddle:setAlpha(0)
			f284_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
			f284_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f284_local5)
			local f284_local6 = function(f304_arg0)
				local f304_local0 = function(f305_arg0)
					local f305_local0 = function(f306_arg0)
						f306_arg0:beginAnimation(59)
						f306_arg0:setLeftRight(0, 0.07, 0, 0)
						f306_arg0:registerEventHandler("transition_complete_keyframe", f284_arg0.clipFinished)
					end
					f305_arg0:beginAnimation(79)
					f305_arg0:setLeftRight(0, 0.07, -10, -10)
					f305_arg0:registerEventHandler("transition_complete_keyframe", f305_local0)
				end
				f304_arg0:beginAnimation(100)
				f304_arg0:setLeftRight(0, 0.07, 0, 0)
				f304_arg0:setAlpha(1)
				f304_arg0:registerEventHandler("transition_complete_keyframe", f304_local0)
			end
			f284_arg0.BarLeft:beginAnimation(510)
			f284_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f284_arg0.BarLeft:setAlpha(0)
			f284_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
			f284_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f284_local6)
			local f284_local7 = function(f307_arg0)
				local f307_local0 = function(f308_arg0)
					local f308_local0 = function(f309_arg0)
						f309_arg0:beginAnimation(59)
						f309_arg0:setLeftRight(0.93, 1, 0, 0)
						f309_arg0:registerEventHandler("transition_complete_keyframe", f284_arg0.clipFinished)
					end
					f308_arg0:beginAnimation(79)
					f308_arg0:setLeftRight(0.93, 1, 10, 10)
					f308_arg0:registerEventHandler("transition_complete_keyframe", f308_local0)
				end
				f307_arg0:beginAnimation(100)
				f307_arg0:setLeftRight(0.93, 1, 0, 0)
				f307_arg0:setAlpha(1)
				f307_arg0:registerEventHandler("transition_complete_keyframe", f307_local0)
			end
			f284_arg0.BarRight:beginAnimation(510)
			f284_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f284_arg0.BarRight:setAlpha(0)
			f284_arg0.BarRight:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
			f284_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f284_local7)
			local f284_local8 = function(f310_arg0)
				local f310_local0 = function(f311_arg0)
					f311_arg0:beginAnimation(9)
					f311_arg0:setAlpha(1)
					f311_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("EliminationIntro")
						f284_arg0.clipFinished(element, event)
					end)
				end
				f310_arg0:beginAnimation(690)
				f310_arg0:registerEventHandler("transition_complete_keyframe", f310_local0)
			end
			f284_arg0.HeaderTextTeamRank:beginAnimation(510)
			f284_arg0.HeaderTextTeamRank:setAlpha(0)
			f284_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
			f284_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f284_local8)
			local f284_local9 = function(f313_arg0)
				local f313_local0 = function(f314_arg0)
					f314_arg0:beginAnimation(9)
					f314_arg0:setAlpha(1)
					f314_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Intro")
						f284_arg0.clipFinished(element, event)
					end)
				end
				f284_arg0.KillerIdentity:beginAnimation(1390)
				f284_arg0.KillerIdentity:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.KillerIdentity:registerEventHandler("transition_complete_keyframe", f313_local0)
			end
			f284_arg0.KillerIdentity:completeAnimation()
			f284_arg0.KillerIdentity:setAlpha(0)
			f284_local9(f284_arg0.KillerIdentity)
			local f284_local10 = function(f316_arg0)
				local f316_local0 = function(f317_arg0)
					f317_arg0:beginAnimation(9)
					f317_arg0:setAlpha(1)
					f317_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Intro")
						f284_arg0.clipFinished(element, event)
					end)
				end
				f284_arg0.MistakesWereMade:beginAnimation(1390)
				f284_arg0.MistakesWereMade:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.MistakesWereMade:registerEventHandler("transition_complete_keyframe", f316_local0)
			end
			f284_arg0.MistakesWereMade:completeAnimation()
			f284_arg0.MistakesWereMade:setAlpha(0)
			f284_local10(f284_arg0.MistakesWereMade)
			local f284_local11 = function(f319_arg0)
				local f319_local0 = function(f320_arg0)
					f320_arg0:beginAnimation(9)
					f320_arg0:setAlpha(1)
					f320_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Intro")
						f284_arg0.clipFinished(element, event)
					end)
				end
				f284_arg0.WeaponIdentity:beginAnimation(1590)
				f284_arg0.WeaponIdentity:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.WeaponIdentity:registerEventHandler("transition_complete_keyframe", f319_local0)
			end
			f284_arg0.WeaponIdentity:completeAnimation()
			f284_arg0.WeaponIdentity:setAlpha(0)
			f284_local11(f284_arg0.WeaponIdentity)
			local f284_local12 = function(f322_arg0)
				local f322_local0 = function(f323_arg0)
					f323_arg0:beginAnimation(9)
					f323_arg0:setAlpha(1)
					f323_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Intro")
						f284_arg0.clipFinished(element, event)
					end)
				end
				f284_arg0.MeansOfDeath:beginAnimation(1590)
				f284_arg0.MeansOfDeath:registerEventHandler("interrupted_keyframe", f284_arg0.clipInterrupted)
				f284_arg0.MeansOfDeath:registerEventHandler("transition_complete_keyframe", f322_local0)
			end
			f284_arg0.MeansOfDeath:completeAnimation()
			f284_arg0.MeansOfDeath:setAlpha(0)
			f284_local12(f284_arg0.MeansOfDeath)
		end,
	},
	VictoryPlatoon = {
		DefaultClip = function(f325_arg0, f325_arg1)
			f325_arg0:__resetProperties()
			f325_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f326_arg0, f326_arg1)
			f326_arg0:__resetProperties()
			f326_arg0:setupElementClipCounter(10)
			f326_arg0.MatchTimerContainer:completeAnimation()
			f326_arg0.MatchTimerContainer:setAlpha(1)
			f326_arg0.clipFinished(f326_arg0.MatchTimerContainer)
			f326_arg0.DownNotOut:completeAnimation()
			f326_arg0.DownNotOut:setAlpha(0)
			f326_arg0.clipFinished(f326_arg0.DownNotOut)
			f326_arg0.emptyFocusablePC:completeAnimation()
			f326_arg0.emptyFocusablePC:setAlpha(1)
			f326_arg0.clipFinished(f326_arg0.emptyFocusablePC)
			f326_arg0.FooterContainerFrontendRight:completeAnimation()
			f326_arg0.FooterContainerFrontendRight:setAlpha(1)
			f326_arg0.clipFinished(f326_arg0.FooterContainerFrontendRight)
			f326_arg0.DeathCamPrompt:completeAnimation()
			f326_arg0.DeathCamPrompt:setAlpha(1)
			f326_arg0.clipFinished(f326_arg0.DeathCamPrompt)
			f326_arg0.BarMiddle:completeAnimation()
			f326_arg0.BarMiddle:setAlpha(1)
			f326_arg0.clipFinished(f326_arg0.BarMiddle)
			f326_arg0.BarLeft:completeAnimation()
			f326_arg0.BarLeft:setAlpha(1)
			f326_arg0.clipFinished(f326_arg0.BarLeft)
			f326_arg0.BarRight:completeAnimation()
			f326_arg0.BarRight:setAlpha(1)
			f326_arg0.clipFinished(f326_arg0.BarRight)
			f326_arg0.ChallengeCoin2:completeAnimation()
			f326_arg0.ChallengeCoin2:setAlpha(1)
			f326_arg0.clipFinished(f326_arg0.ChallengeCoin2)
			f326_arg0.HeaderTextTeamRank:completeAnimation()
			f326_arg0.HeaderTextTeamRank:setAlpha(1)
			f326_arg0.HeaderTextTeamRank:playClip("VictoryPlatoon")
			f326_arg0.clipFinished(f326_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f327_arg0, f327_arg1)
			f327_arg0:__resetProperties()
			f327_arg0:setupElementClipCounter(13)
			local f327_local0 = function(f328_arg0)
				local f328_local0 = function(f329_arg0)
					f329_arg0:beginAnimation(1000)
					f329_arg0:setAlpha(1)
					f329_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
				end
				f327_arg0.MatchTimerContainer:beginAnimation(4000)
				f327_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f328_local0)
			end
			f327_arg0.MatchTimerContainer:completeAnimation()
			f327_arg0.MatchTimerContainer:setAlpha(0)
			f327_local0(f327_arg0.MatchTimerContainer)
			f327_arg0.DownNotOut:completeAnimation()
			f327_arg0.DownNotOut:setAlpha(0)
			f327_arg0.clipFinished(f327_arg0.DownNotOut)
			local f327_local1 = function(f330_arg0)
				local f330_local0 = function(f331_arg0)
					f331_arg0:beginAnimation(1000)
					f331_arg0:setAlpha(1)
					f331_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
				end
				f327_arg0.FooterContainerFrontendRight:beginAnimation(4000)
				f327_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f330_local0)
			end
			f327_arg0.FooterContainerFrontendRight:completeAnimation()
			f327_arg0.FooterContainerFrontendRight:setAlpha(0)
			f327_local1(f327_arg0.FooterContainerFrontendRight)
			local f327_local2 = function(f332_arg0)
				local f332_local0 = function(f333_arg0)
					f333_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f333_arg0:setAlpha(1)
					f333_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
				end
				f327_arg0.DeathCamPrompt:beginAnimation(4000)
				f327_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f332_local0)
			end
			f327_arg0.DeathCamPrompt:completeAnimation()
			f327_arg0.DeathCamPrompt:setAlpha(0)
			f327_local2(f327_arg0.DeathCamPrompt)
			f327_arg0.ChallengeCoinSound:beginAnimation(1250)
			f327_arg0.ChallengeCoinSound:setPlaySoundDirect(true)
			f327_arg0.ChallengeCoinSound:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
			f327_arg0.ChallengeCoinSound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_victory_medal", f327_arg1)
				f327_arg0.clipFinished(element, event)
			end)
			f327_arg0.SoundGameOverSlam:beginAnimation(690)
			f327_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f327_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
			f327_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f327_arg1)
				f327_arg0.clipFinished(element, event)
			end)
			local f327_local3 = function(f336_arg0)
				local f336_local0 = function(f337_arg0)
					local f337_local0 = function(f338_arg0)
						local f338_local0 = function(f339_arg0)
							local f339_local0 = function(f340_arg0)
								local f340_local0 = function(f341_arg0)
									local f341_local0 = function(f342_arg0)
										local f342_local0 = function(f343_arg0)
											local f343_local0 = function(f344_arg0)
												f344_arg0:beginAnimation(19)
												f344_arg0:setAlpha(1)
												f344_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
											end
											f343_arg0:beginAnimation(20)
											f343_arg0:setAlpha(0.2)
											f343_arg0:registerEventHandler("transition_complete_keyframe", f343_local0)
										end
										f342_arg0:beginAnimation(19)
										f342_arg0:setAlpha(1)
										f342_arg0:registerEventHandler("transition_complete_keyframe", f342_local0)
									end
									f341_arg0:beginAnimation(30)
									f341_arg0:setAlpha(0)
									f341_arg0:registerEventHandler("transition_complete_keyframe", f341_local0)
								end
								f340_arg0:beginAnimation(40, Enum[@"luitween"][@"luitween_ease_out"])
								f340_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f340_arg0:setAlpha(1)
								f340_arg0:registerEventHandler("transition_complete_keyframe", f340_local0)
							end
							f339_arg0:beginAnimation(49, Enum[@"luitween"][@"luitween_ease_out"])
							f339_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f339_arg0:setAlpha(0.95)
							f339_arg0:registerEventHandler("transition_complete_keyframe", f339_local0)
						end
						f338_arg0:beginAnimation(59, Enum[@"luitween"][@"luitween_ease_out"])
						f338_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f338_arg0:setAlpha(0.75)
						f338_arg0:registerEventHandler("transition_complete_keyframe", f338_local0)
					end
					f337_arg0:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_out"])
					f337_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f337_arg0:setAlpha(0.44)
					f337_arg0:registerEventHandler("transition_complete_keyframe", f337_local0)
				end
				f327_arg0.BarMiddle:beginAnimation(30)
				f327_arg0.BarMiddle:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f327_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f336_local0)
			end
			f327_arg0.BarMiddle:completeAnimation()
			f327_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f327_arg0.BarMiddle:setAlpha(0)
			f327_local3(f327_arg0.BarMiddle)
			local f327_local4 = function(f345_arg0)
				local f345_local0 = function(f346_arg0)
					local f346_local0 = function(f347_arg0)
						f347_arg0:beginAnimation(59)
						f347_arg0:setLeftRight(0, 0.07, 0, 0)
						f347_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
					end
					f346_arg0:beginAnimation(80)
					f346_arg0:setLeftRight(0, 0.07, -10, -10)
					f346_arg0:registerEventHandler("transition_complete_keyframe", f346_local0)
				end
				f327_arg0.BarLeft:beginAnimation(99)
				f327_arg0.BarLeft:setLeftRight(0, 0.07, 0, 0)
				f327_arg0.BarLeft:setAlpha(1)
				f327_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f345_local0)
			end
			f327_arg0.BarLeft:completeAnimation()
			f327_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f327_arg0.BarLeft:setAlpha(0)
			f327_local4(f327_arg0.BarLeft)
			local f327_local5 = function(f348_arg0)
				local f348_local0 = function(f349_arg0)
					local f349_local0 = function(f350_arg0)
						f350_arg0:beginAnimation(59)
						f350_arg0:setLeftRight(0.93, 1, 0, 0)
						f350_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
					end
					f349_arg0:beginAnimation(80)
					f349_arg0:setLeftRight(0.93, 1, 10, 10)
					f349_arg0:registerEventHandler("transition_complete_keyframe", f349_local0)
				end
				f327_arg0.BarRight:beginAnimation(99)
				f327_arg0.BarRight:setLeftRight(0.93, 1, 0, 0)
				f327_arg0.BarRight:setAlpha(1)
				f327_arg0.BarRight:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f348_local0)
			end
			f327_arg0.BarRight:completeAnimation()
			f327_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f327_arg0.BarRight:setAlpha(0)
			f327_local5(f327_arg0.BarRight)
			local f327_local6 = function(f351_arg0)
				local f351_local0 = function(f352_arg0)
					local f352_local0 = function(f353_arg0)
						local f353_local0 = function(f354_arg0)
							local f354_local0 = function(f355_arg0)
								f355_arg0:beginAnimation(29, Enum[@"luitween"][@"luitween_ease_out"])
								f355_arg0:setScale(10, 10)
								f355_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
							end
							f354_arg0:beginAnimation(519, Enum[@"luitween"][@"luitween_ease_out"])
							f354_arg0:setAlpha(0)
							f354_arg0:setScale(9.97, 9.97)
							f354_arg0:registerEventHandler("transition_complete_keyframe", f354_local0)
						end
						f353_arg0:beginAnimation(70, Enum[@"luitween"][@"luitween_ease_out"])
						f353_arg0:setScale(3.57, 3.57)
						f353_arg0:registerEventHandler("transition_complete_keyframe", f353_local0)
					end
					f352_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f352_arg0:setAlpha(1)
					f352_arg0:setScale(2.75, 2.75)
					f352_arg0:registerEventHandler("transition_complete_keyframe", f352_local0)
				end
				f327_arg0.ChallengeCoinFlare2:beginAnimation(1350)
				f327_arg0.ChallengeCoinFlare2:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.ChallengeCoinFlare2:registerEventHandler("transition_complete_keyframe", f351_local0)
			end
			f327_arg0.ChallengeCoinFlare2:completeAnimation()
			f327_arg0.ChallengeCoinFlare2:setAlpha(0)
			f327_arg0.ChallengeCoinFlare2:setScale(1, 1)
			f327_local6(f327_arg0.ChallengeCoinFlare2)
			local f327_local7 = function(f356_arg0)
				local f356_local0 = function(f357_arg0)
					local f357_local0 = function(f358_arg0)
						local f358_local0 = function(f359_arg0)
							local f359_local0 = function(f360_arg0)
								f360_arg0:beginAnimation(30)
								f360_arg0:setScale(5, 5)
								f360_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
							end
							f359_arg0:beginAnimation(219)
							f359_arg0:setScale(4.68, 4.68)
							f359_arg0:registerEventHandler("transition_complete_keyframe", f359_local0)
						end
						f358_arg0:beginAnimation(70)
						f358_arg0:setScale(2.34, 2.34)
						f358_arg0:registerEventHandler("transition_complete_keyframe", f358_local0)
					end
					f357_arg0:beginAnimation(149)
					f357_arg0:setScale(1.6, 1.6)
					f357_arg0:registerEventHandler("transition_complete_keyframe", f357_local0)
				end
				f327_arg0.ChallengeCoinFlare3:beginAnimation(1350)
				f327_arg0.ChallengeCoinFlare3:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.ChallengeCoinFlare3:registerEventHandler("transition_complete_keyframe", f356_local0)
			end
			f327_arg0.ChallengeCoinFlare3:completeAnimation()
			f327_arg0.ChallengeCoinFlare3:setAlpha(0)
			f327_arg0.ChallengeCoinFlare3:setScale(0, 1)
			f327_local7(f327_arg0.ChallengeCoinFlare3)
			local f327_local8 = function(f361_arg0)
				local f361_local0 = function(f362_arg0)
					local f362_local0 = function(f363_arg0)
						local f363_local0 = function(f364_arg0)
							local f364_local0 = function(f365_arg0)
								f365_arg0:beginAnimation(50, Enum[@"luitween"][@"luitween_ease_out"])
								f365_arg0:setScale(1, 1)
								f365_arg0:registerEventHandler("transition_complete_keyframe", f327_arg0.clipFinished)
							end
							f364_arg0:beginAnimation(39, Enum[@"luitween"][@"luitween_ease_out"])
							f364_arg0:setScale(1.2, 1.2)
							f364_arg0:registerEventHandler("transition_complete_keyframe", f364_local0)
						end
						f363_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
						f363_arg0:setScale(0.75, 0.75)
						f363_arg0:registerEventHandler("transition_complete_keyframe", f363_local0)
					end
					f362_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f362_arg0:setAlpha(1)
					f362_arg0:setScale(3.95, 3.95)
					f362_arg0:registerEventHandler("transition_complete_keyframe", f362_local0)
				end
				f327_arg0.ChallengeCoin2:beginAnimation(1100)
				f327_arg0.ChallengeCoin2:setScale(10, 10)
				f327_arg0.ChallengeCoin2:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.ChallengeCoin2:registerEventHandler("transition_complete_keyframe", f361_local0)
			end
			f327_arg0.ChallengeCoin2:completeAnimation()
			f327_arg0.ChallengeCoin2:setAlpha(0)
			f327_arg0.ChallengeCoin2:setScale(4, 4)
			f327_local8(f327_arg0.ChallengeCoin2)
			local f327_local9 = function(f366_arg0)
				local f366_local0 = function(f367_arg0)
					f367_arg0:beginAnimation(9)
					f367_arg0:setAlpha(1)
					f367_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("VictoryPlatoonIntro")
						f327_arg0.clipFinished(element, event)
					end)
				end
				f327_arg0.HeaderTextTeamRank:beginAnimation(690)
				f327_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f327_arg0.clipInterrupted)
				f327_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f366_local0)
			end
			f327_arg0.HeaderTextTeamRank:completeAnimation()
			f327_arg0.HeaderTextTeamRank:setAlpha(0)
			f327_local9(f327_arg0.HeaderTextTeamRank)
		end,
	},
	Victory = {
		DefaultClip = function(f369_arg0, f369_arg1)
			f369_arg0:__resetProperties()
			f369_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f370_arg0, f370_arg1)
			f370_arg0:__resetProperties()
			f370_arg0:setupElementClipCounter(10)
			f370_arg0.MatchTimerContainer:completeAnimation()
			f370_arg0.MatchTimerContainer:setAlpha(1)
			f370_arg0.clipFinished(f370_arg0.MatchTimerContainer)
			f370_arg0.DownNotOut:completeAnimation()
			f370_arg0.DownNotOut:setAlpha(0)
			f370_arg0.clipFinished(f370_arg0.DownNotOut)
			f370_arg0.emptyFocusablePC:completeAnimation()
			f370_arg0.emptyFocusablePC:setAlpha(1)
			f370_arg0.clipFinished(f370_arg0.emptyFocusablePC)
			f370_arg0.FooterContainerFrontendRight:completeAnimation()
			f370_arg0.FooterContainerFrontendRight:setAlpha(1)
			f370_arg0.clipFinished(f370_arg0.FooterContainerFrontendRight)
			f370_arg0.DeathCamPrompt:completeAnimation()
			f370_arg0.DeathCamPrompt:setAlpha(1)
			f370_arg0.clipFinished(f370_arg0.DeathCamPrompt)
			f370_arg0.BarMiddle:completeAnimation()
			f370_arg0.BarMiddle:setAlpha(1)
			f370_arg0.clipFinished(f370_arg0.BarMiddle)
			f370_arg0.BarLeft:completeAnimation()
			f370_arg0.BarLeft:setAlpha(1)
			f370_arg0.clipFinished(f370_arg0.BarLeft)
			f370_arg0.BarRight:completeAnimation()
			f370_arg0.BarRight:setAlpha(1)
			f370_arg0.clipFinished(f370_arg0.BarRight)
			f370_arg0.ChallengeCoin2:completeAnimation()
			f370_arg0.ChallengeCoin2:setAlpha(1)
			f370_arg0.clipFinished(f370_arg0.ChallengeCoin2)
			f370_arg0.HeaderTextTeamRank:completeAnimation()
			f370_arg0.HeaderTextTeamRank:setAlpha(1)
			f370_arg0.HeaderTextTeamRank:playClip("Victory")
			f370_arg0.clipFinished(f370_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f371_arg0, f371_arg1)
			f371_arg0:__resetProperties()
			f371_arg0:setupElementClipCounter(13)
			local f371_local0 = function(f372_arg0)
				local f372_local0 = function(f373_arg0)
					f373_arg0:beginAnimation(1000)
					f373_arg0:setAlpha(1)
					f373_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
				end
				f371_arg0.MatchTimerContainer:beginAnimation(4000)
				f371_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f372_local0)
			end
			f371_arg0.MatchTimerContainer:completeAnimation()
			f371_arg0.MatchTimerContainer:setAlpha(0)
			f371_local0(f371_arg0.MatchTimerContainer)
			f371_arg0.DownNotOut:completeAnimation()
			f371_arg0.DownNotOut:setAlpha(0)
			f371_arg0.clipFinished(f371_arg0.DownNotOut)
			local f371_local1 = function(f374_arg0)
				local f374_local0 = function(f375_arg0)
					f375_arg0:beginAnimation(1000)
					f375_arg0:setAlpha(1)
					f375_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
				end
				f371_arg0.FooterContainerFrontendRight:beginAnimation(4000)
				f371_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f374_local0)
			end
			f371_arg0.FooterContainerFrontendRight:completeAnimation()
			f371_arg0.FooterContainerFrontendRight:setAlpha(0)
			f371_local1(f371_arg0.FooterContainerFrontendRight)
			local f371_local2 = function(f376_arg0)
				local f376_local0 = function(f377_arg0)
					f377_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f377_arg0:setAlpha(1)
					f377_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
				end
				f371_arg0.DeathCamPrompt:beginAnimation(4000)
				f371_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f376_local0)
			end
			f371_arg0.DeathCamPrompt:completeAnimation()
			f371_arg0.DeathCamPrompt:setAlpha(0)
			f371_local2(f371_arg0.DeathCamPrompt)
			f371_arg0.ChallengeCoinSound:beginAnimation(1250)
			f371_arg0.ChallengeCoinSound:setPlaySoundDirect(true)
			f371_arg0.ChallengeCoinSound:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
			f371_arg0.ChallengeCoinSound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_victory_medal", f371_arg1)
				f371_arg0.clipFinished(element, event)
			end)
			f371_arg0.SoundGameOverSlam:beginAnimation(690)
			f371_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f371_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
			f371_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f371_arg1)
				f371_arg0.clipFinished(element, event)
			end)
			local f371_local3 = function(f380_arg0)
				local f380_local0 = function(f381_arg0)
					local f381_local0 = function(f382_arg0)
						local f382_local0 = function(f383_arg0)
							local f383_local0 = function(f384_arg0)
								local f384_local0 = function(f385_arg0)
									local f385_local0 = function(f386_arg0)
										local f386_local0 = function(f387_arg0)
											local f387_local0 = function(f388_arg0)
												f388_arg0:beginAnimation(19)
												f388_arg0:setAlpha(1)
												f388_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
											end
											f387_arg0:beginAnimation(20)
											f387_arg0:setAlpha(0.2)
											f387_arg0:registerEventHandler("transition_complete_keyframe", f387_local0)
										end
										f386_arg0:beginAnimation(19)
										f386_arg0:setAlpha(1)
										f386_arg0:registerEventHandler("transition_complete_keyframe", f386_local0)
									end
									f385_arg0:beginAnimation(30)
									f385_arg0:setAlpha(0)
									f385_arg0:registerEventHandler("transition_complete_keyframe", f385_local0)
								end
								f384_arg0:beginAnimation(40, Enum[@"luitween"][@"luitween_ease_out"])
								f384_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f384_arg0:setAlpha(1)
								f384_arg0:registerEventHandler("transition_complete_keyframe", f384_local0)
							end
							f383_arg0:beginAnimation(49, Enum[@"luitween"][@"luitween_ease_out"])
							f383_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f383_arg0:setAlpha(0.95)
							f383_arg0:registerEventHandler("transition_complete_keyframe", f383_local0)
						end
						f382_arg0:beginAnimation(59, Enum[@"luitween"][@"luitween_ease_out"])
						f382_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f382_arg0:setAlpha(0.75)
						f382_arg0:registerEventHandler("transition_complete_keyframe", f382_local0)
					end
					f381_arg0:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_out"])
					f381_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f381_arg0:setAlpha(0.44)
					f381_arg0:registerEventHandler("transition_complete_keyframe", f381_local0)
				end
				f371_arg0.BarMiddle:beginAnimation(30)
				f371_arg0.BarMiddle:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f371_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f380_local0)
			end
			f371_arg0.BarMiddle:completeAnimation()
			f371_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f371_arg0.BarMiddle:setAlpha(0)
			f371_local3(f371_arg0.BarMiddle)
			local f371_local4 = function(f389_arg0)
				local f389_local0 = function(f390_arg0)
					local f390_local0 = function(f391_arg0)
						f391_arg0:beginAnimation(59)
						f391_arg0:setLeftRight(0, 0.07, 0, 0)
						f391_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
					end
					f390_arg0:beginAnimation(80)
					f390_arg0:setLeftRight(0, 0.07, -10, -10)
					f390_arg0:registerEventHandler("transition_complete_keyframe", f390_local0)
				end
				f371_arg0.BarLeft:beginAnimation(99)
				f371_arg0.BarLeft:setLeftRight(0, 0.07, 0, 0)
				f371_arg0.BarLeft:setAlpha(1)
				f371_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f389_local0)
			end
			f371_arg0.BarLeft:completeAnimation()
			f371_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f371_arg0.BarLeft:setAlpha(0)
			f371_local4(f371_arg0.BarLeft)
			local f371_local5 = function(f392_arg0)
				local f392_local0 = function(f393_arg0)
					local f393_local0 = function(f394_arg0)
						f394_arg0:beginAnimation(59)
						f394_arg0:setLeftRight(0.93, 1, 0, 0)
						f394_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
					end
					f393_arg0:beginAnimation(80)
					f393_arg0:setLeftRight(0.93, 1, 10, 10)
					f393_arg0:registerEventHandler("transition_complete_keyframe", f393_local0)
				end
				f371_arg0.BarRight:beginAnimation(99)
				f371_arg0.BarRight:setLeftRight(0.93, 1, 0, 0)
				f371_arg0.BarRight:setAlpha(1)
				f371_arg0.BarRight:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f392_local0)
			end
			f371_arg0.BarRight:completeAnimation()
			f371_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f371_arg0.BarRight:setAlpha(0)
			f371_local5(f371_arg0.BarRight)
			local f371_local6 = function(f395_arg0)
				local f395_local0 = function(f396_arg0)
					local f396_local0 = function(f397_arg0)
						local f397_local0 = function(f398_arg0)
							local f398_local0 = function(f399_arg0)
								f399_arg0:beginAnimation(29, Enum[@"luitween"][@"luitween_ease_out"])
								f399_arg0:setScale(10, 10)
								f399_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
							end
							f398_arg0:beginAnimation(519, Enum[@"luitween"][@"luitween_ease_out"])
							f398_arg0:setAlpha(0)
							f398_arg0:setScale(9.97, 9.97)
							f398_arg0:registerEventHandler("transition_complete_keyframe", f398_local0)
						end
						f397_arg0:beginAnimation(70, Enum[@"luitween"][@"luitween_ease_out"])
						f397_arg0:setScale(3.57, 3.57)
						f397_arg0:registerEventHandler("transition_complete_keyframe", f397_local0)
					end
					f396_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f396_arg0:setAlpha(1)
					f396_arg0:setScale(2.75, 2.75)
					f396_arg0:registerEventHandler("transition_complete_keyframe", f396_local0)
				end
				f371_arg0.ChallengeCoinFlare2:beginAnimation(1350)
				f371_arg0.ChallengeCoinFlare2:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.ChallengeCoinFlare2:registerEventHandler("transition_complete_keyframe", f395_local0)
			end
			f371_arg0.ChallengeCoinFlare2:completeAnimation()
			f371_arg0.ChallengeCoinFlare2:setAlpha(0)
			f371_arg0.ChallengeCoinFlare2:setScale(1, 1)
			f371_local6(f371_arg0.ChallengeCoinFlare2)
			local f371_local7 = function(f400_arg0)
				local f400_local0 = function(f401_arg0)
					local f401_local0 = function(f402_arg0)
						local f402_local0 = function(f403_arg0)
							local f403_local0 = function(f404_arg0)
								f404_arg0:beginAnimation(30)
								f404_arg0:setScale(5, 5)
								f404_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
							end
							f403_arg0:beginAnimation(219)
							f403_arg0:setScale(4.68, 4.68)
							f403_arg0:registerEventHandler("transition_complete_keyframe", f403_local0)
						end
						f402_arg0:beginAnimation(70)
						f402_arg0:setScale(2.34, 2.34)
						f402_arg0:registerEventHandler("transition_complete_keyframe", f402_local0)
					end
					f401_arg0:beginAnimation(149)
					f401_arg0:setScale(1.6, 1.6)
					f401_arg0:registerEventHandler("transition_complete_keyframe", f401_local0)
				end
				f371_arg0.ChallengeCoinFlare3:beginAnimation(1350)
				f371_arg0.ChallengeCoinFlare3:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.ChallengeCoinFlare3:registerEventHandler("transition_complete_keyframe", f400_local0)
			end
			f371_arg0.ChallengeCoinFlare3:completeAnimation()
			f371_arg0.ChallengeCoinFlare3:setAlpha(0)
			f371_arg0.ChallengeCoinFlare3:setScale(0, 1)
			f371_local7(f371_arg0.ChallengeCoinFlare3)
			local f371_local8 = function(f405_arg0)
				local f405_local0 = function(f406_arg0)
					local f406_local0 = function(f407_arg0)
						local f407_local0 = function(f408_arg0)
							local f408_local0 = function(f409_arg0)
								f409_arg0:beginAnimation(50, Enum[@"luitween"][@"luitween_ease_out"])
								f409_arg0:setScale(1, 1)
								f409_arg0:registerEventHandler("transition_complete_keyframe", f371_arg0.clipFinished)
							end
							f408_arg0:beginAnimation(39, Enum[@"luitween"][@"luitween_ease_out"])
							f408_arg0:setScale(1.2, 1.2)
							f408_arg0:registerEventHandler("transition_complete_keyframe", f408_local0)
						end
						f407_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
						f407_arg0:setScale(0.75, 0.75)
						f407_arg0:registerEventHandler("transition_complete_keyframe", f407_local0)
					end
					f406_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f406_arg0:setAlpha(1)
					f406_arg0:setScale(3.95, 3.95)
					f406_arg0:registerEventHandler("transition_complete_keyframe", f406_local0)
				end
				f371_arg0.ChallengeCoin2:beginAnimation(1100)
				f371_arg0.ChallengeCoin2:setScale(10, 10)
				f371_arg0.ChallengeCoin2:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.ChallengeCoin2:registerEventHandler("transition_complete_keyframe", f405_local0)
			end
			f371_arg0.ChallengeCoin2:completeAnimation()
			f371_arg0.ChallengeCoin2:setAlpha(0)
			f371_arg0.ChallengeCoin2:setScale(4, 4)
			f371_local8(f371_arg0.ChallengeCoin2)
			local f371_local9 = function(f410_arg0)
				local f410_local0 = function(f411_arg0)
					f411_arg0:beginAnimation(9)
					f411_arg0:setAlpha(1)
					f411_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("VictoryIntro")
						f371_arg0.clipFinished(element, event)
					end)
				end
				f371_arg0.HeaderTextTeamRank:beginAnimation(690)
				f371_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f371_arg0.clipInterrupted)
				f371_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f410_local0)
			end
			f371_arg0.HeaderTextTeamRank:completeAnimation()
			f371_arg0.HeaderTextTeamRank:setAlpha(0)
			f371_local9(f371_arg0.HeaderTextTeamRank)
		end,
	},
	DefeatPlatoon = {
		DefaultClip = function(f413_arg0, f413_arg1)
			f413_arg0:__resetProperties()
			f413_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f414_arg0, f414_arg1)
			f414_arg0:__resetProperties()
			f414_arg0:setupElementClipCounter(7)
			f414_arg0.MatchTimerContainer:completeAnimation()
			f414_arg0.MatchTimerContainer:setAlpha(1)
			f414_arg0.clipFinished(f414_arg0.MatchTimerContainer)
			f414_arg0.FooterContainerFrontendRight:completeAnimation()
			f414_arg0.FooterContainerFrontendRight:setAlpha(1)
			f414_arg0.clipFinished(f414_arg0.FooterContainerFrontendRight)
			f414_arg0.DeathCamPrompt:completeAnimation()
			f414_arg0.DeathCamPrompt:setAlpha(1)
			f414_arg0.clipFinished(f414_arg0.DeathCamPrompt)
			f414_arg0.BarMiddle:completeAnimation()
			f414_arg0.BarMiddle:setAlpha(1)
			f414_arg0.clipFinished(f414_arg0.BarMiddle)
			f414_arg0.BarLeft:completeAnimation()
			f414_arg0.BarLeft:setAlpha(1)
			f414_arg0.clipFinished(f414_arg0.BarLeft)
			f414_arg0.BarRight:completeAnimation()
			f414_arg0.BarRight:setAlpha(1)
			f414_arg0.clipFinished(f414_arg0.BarRight)
			f414_arg0.HeaderTextTeamRank:completeAnimation()
			f414_arg0.HeaderTextTeamRank:setAlpha(1)
			f414_arg0.HeaderTextTeamRank:playClip("DefeatPlatoon")
			f414_arg0.clipFinished(f414_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f415_arg0, f415_arg1)
			f415_arg0:__resetProperties()
			f415_arg0:setupElementClipCounter(8)
			local f415_local0 = function(f416_arg0)
				local f416_local0 = function(f417_arg0)
					f417_arg0:beginAnimation(1000)
					f417_arg0:setAlpha(1)
					f417_arg0:registerEventHandler("transition_complete_keyframe", f415_arg0.clipFinished)
				end
				f415_arg0.MatchTimerContainer:beginAnimation(5500)
				f415_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f415_arg0.clipInterrupted)
				f415_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f416_local0)
			end
			f415_arg0.MatchTimerContainer:completeAnimation()
			f415_arg0.MatchTimerContainer:setAlpha(0)
			f415_local0(f415_arg0.MatchTimerContainer)
			local f415_local1 = function(f418_arg0)
				local f418_local0 = function(f419_arg0)
					f419_arg0:beginAnimation(1000)
					f419_arg0:setAlpha(1)
					f419_arg0:registerEventHandler("transition_complete_keyframe", f415_arg0.clipFinished)
				end
				f415_arg0.FooterContainerFrontendRight:beginAnimation(5500)
				f415_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f415_arg0.clipInterrupted)
				f415_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f418_local0)
			end
			f415_arg0.FooterContainerFrontendRight:completeAnimation()
			f415_arg0.FooterContainerFrontendRight:setAlpha(0)
			f415_local1(f415_arg0.FooterContainerFrontendRight)
			local f415_local2 = function(f420_arg0)
				local f420_local0 = function(f421_arg0)
					f421_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f421_arg0:setAlpha(1)
					f421_arg0:registerEventHandler("transition_complete_keyframe", f415_arg0.clipFinished)
				end
				f415_arg0.DeathCamPrompt:beginAnimation(5500)
				f415_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f415_arg0.clipInterrupted)
				f415_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f420_local0)
			end
			f415_arg0.DeathCamPrompt:completeAnimation()
			f415_arg0.DeathCamPrompt:setAlpha(0)
			f415_local2(f415_arg0.DeathCamPrompt)
			f415_arg0.SoundGameOverSlam:beginAnimation(2200)
			f415_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f415_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f415_arg0.clipInterrupted)
			f415_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f415_arg1)
				f415_arg0.clipFinished(element, event)
			end)
			local f415_local3 = function(f423_arg0)
				local f423_local0 = function(f424_arg0)
					local f424_local0 = function(f425_arg0)
						local f425_local0 = function(f426_arg0)
							local f426_local0 = function(f427_arg0)
								local f427_local0 = function(f428_arg0)
									local f428_local0 = function(f429_arg0)
										local f429_local0 = function(f430_arg0)
											local f430_local0 = function(f431_arg0)
												f431_arg0:beginAnimation(19)
												f431_arg0:setAlpha(1)
												f431_arg0:registerEventHandler("transition_complete_keyframe", f415_arg0.clipFinished)
											end
											f430_arg0:beginAnimation(19)
											f430_arg0:setAlpha(0.2)
											f430_arg0:registerEventHandler("transition_complete_keyframe", f430_local0)
										end
										f429_arg0:beginAnimation(19)
										f429_arg0:setAlpha(1)
										f429_arg0:registerEventHandler("transition_complete_keyframe", f429_local0)
									end
									f428_arg0:beginAnimation(30)
									f428_arg0:setAlpha(0)
									f428_arg0:registerEventHandler("transition_complete_keyframe", f428_local0)
								end
								f427_arg0:beginAnimation(39)
								f427_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f427_arg0:setAlpha(1)
								f427_arg0:registerEventHandler("transition_complete_keyframe", f427_local0)
							end
							f426_arg0:beginAnimation(49)
							f426_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f426_arg0:setAlpha(0.85)
							f426_arg0:registerEventHandler("transition_complete_keyframe", f426_local0)
						end
						f425_arg0:beginAnimation(60)
						f425_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f425_arg0:setAlpha(0.67)
						f425_arg0:registerEventHandler("transition_complete_keyframe", f425_local0)
					end
					f424_arg0:beginAnimation(120)
					f424_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f424_arg0:setAlpha(0.44)
					f424_arg0:registerEventHandler("transition_complete_keyframe", f424_local0)
				end
				f423_arg0:beginAnimation(29)
				f423_arg0:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f423_arg0:registerEventHandler("transition_complete_keyframe", f423_local0)
			end
			f415_arg0.BarMiddle:beginAnimation(1510)
			f415_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f415_arg0.BarMiddle:setAlpha(0)
			f415_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f415_arg0.clipInterrupted)
			f415_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f415_local3)
			local f415_local4 = function(f432_arg0)
				local f432_local0 = function(f433_arg0)
					local f433_local0 = function(f434_arg0)
						f434_arg0:beginAnimation(59)
						f434_arg0:setLeftRight(0, 0.07, 0, 0)
						f434_arg0:registerEventHandler("transition_complete_keyframe", f415_arg0.clipFinished)
					end
					f433_arg0:beginAnimation(80)
					f433_arg0:setLeftRight(0, 0.07, -10, -10)
					f433_arg0:registerEventHandler("transition_complete_keyframe", f433_local0)
				end
				f432_arg0:beginAnimation(100)
				f432_arg0:setLeftRight(0, 0.07, 0, 0)
				f432_arg0:setAlpha(1)
				f432_arg0:registerEventHandler("transition_complete_keyframe", f432_local0)
			end
			f415_arg0.BarLeft:beginAnimation(1510)
			f415_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f415_arg0.BarLeft:setAlpha(0)
			f415_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f415_arg0.clipInterrupted)
			f415_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f415_local4)
			local f415_local5 = function(f435_arg0)
				local f435_local0 = function(f436_arg0)
					local f436_local0 = function(f437_arg0)
						f437_arg0:beginAnimation(59)
						f437_arg0:setLeftRight(0.93, 1, 0, 0)
						f437_arg0:registerEventHandler("transition_complete_keyframe", f415_arg0.clipFinished)
					end
					f436_arg0:beginAnimation(80)
					f436_arg0:setLeftRight(0.93, 1, 10, 10)
					f436_arg0:registerEventHandler("transition_complete_keyframe", f436_local0)
				end
				f435_arg0:beginAnimation(100)
				f435_arg0:setLeftRight(0.93, 1, 0, 0)
				f435_arg0:setAlpha(1)
				f435_arg0:registerEventHandler("transition_complete_keyframe", f435_local0)
			end
			f415_arg0.BarRight:beginAnimation(1510)
			f415_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f415_arg0.BarRight:setAlpha(0)
			f415_arg0.BarRight:registerEventHandler("interrupted_keyframe", f415_arg0.clipInterrupted)
			f415_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f415_local5)
			local f415_local6 = function(f438_arg0)
				local f438_local0 = function(f439_arg0)
					f439_arg0:beginAnimation(9)
					f439_arg0:setAlpha(1)
					f439_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefeatPlatoonIntro")
						f415_arg0.clipFinished(element, event)
					end)
				end
				f438_arg0:beginAnimation(690)
				f438_arg0:registerEventHandler("transition_complete_keyframe", f438_local0)
			end
			f415_arg0.HeaderTextTeamRank:beginAnimation(1510)
			f415_arg0.HeaderTextTeamRank:setAlpha(0)
			f415_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f415_arg0.clipInterrupted)
			f415_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f415_local6)
		end,
	},
	Defeat = {
		DefaultClip = function(f441_arg0, f441_arg1)
			f441_arg0:__resetProperties()
			f441_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f442_arg0, f442_arg1)
			f442_arg0:__resetProperties()
			f442_arg0:setupElementClipCounter(7)
			f442_arg0.MatchTimerContainer:completeAnimation()
			f442_arg0.MatchTimerContainer:setAlpha(1)
			f442_arg0.clipFinished(f442_arg0.MatchTimerContainer)
			f442_arg0.FooterContainerFrontendRight:completeAnimation()
			f442_arg0.FooterContainerFrontendRight:setAlpha(1)
			f442_arg0.clipFinished(f442_arg0.FooterContainerFrontendRight)
			f442_arg0.DeathCamPrompt:completeAnimation()
			f442_arg0.DeathCamPrompt:setAlpha(1)
			f442_arg0.clipFinished(f442_arg0.DeathCamPrompt)
			f442_arg0.BarMiddle:completeAnimation()
			f442_arg0.BarMiddle:setAlpha(1)
			f442_arg0.clipFinished(f442_arg0.BarMiddle)
			f442_arg0.BarLeft:completeAnimation()
			f442_arg0.BarLeft:setAlpha(1)
			f442_arg0.clipFinished(f442_arg0.BarLeft)
			f442_arg0.BarRight:completeAnimation()
			f442_arg0.BarRight:setAlpha(1)
			f442_arg0.clipFinished(f442_arg0.BarRight)
			f442_arg0.HeaderTextTeamRank:completeAnimation()
			f442_arg0.HeaderTextTeamRank:setAlpha(1)
			f442_arg0.HeaderTextTeamRank:playClip("Defeat")
			f442_arg0.clipFinished(f442_arg0.HeaderTextTeamRank)
		end,
		FirstTimeIntro = function(f443_arg0, f443_arg1)
			f443_arg0:__resetProperties()
			f443_arg0:setupElementClipCounter(8)
			local f443_local0 = function(f444_arg0)
				local f444_local0 = function(f445_arg0)
					f445_arg0:beginAnimation(1000)
					f445_arg0:setAlpha(1)
					f445_arg0:registerEventHandler("transition_complete_keyframe", f443_arg0.clipFinished)
				end
				f443_arg0.MatchTimerContainer:beginAnimation(5500)
				f443_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f443_arg0.clipInterrupted)
				f443_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f444_local0)
			end
			f443_arg0.MatchTimerContainer:completeAnimation()
			f443_arg0.MatchTimerContainer:setAlpha(0)
			f443_local0(f443_arg0.MatchTimerContainer)
			local f443_local1 = function(f446_arg0)
				local f446_local0 = function(f447_arg0)
					f447_arg0:beginAnimation(1000)
					f447_arg0:setAlpha(1)
					f447_arg0:registerEventHandler("transition_complete_keyframe", f443_arg0.clipFinished)
				end
				f443_arg0.FooterContainerFrontendRight:beginAnimation(5500)
				f443_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f443_arg0.clipInterrupted)
				f443_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f446_local0)
			end
			f443_arg0.FooterContainerFrontendRight:completeAnimation()
			f443_arg0.FooterContainerFrontendRight:setAlpha(0)
			f443_local1(f443_arg0.FooterContainerFrontendRight)
			local f443_local2 = function(f448_arg0)
				local f448_local0 = function(f449_arg0)
					f449_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f449_arg0:setAlpha(1)
					f449_arg0:registerEventHandler("transition_complete_keyframe", f443_arg0.clipFinished)
				end
				f443_arg0.DeathCamPrompt:beginAnimation(5500)
				f443_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f443_arg0.clipInterrupted)
				f443_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f448_local0)
			end
			f443_arg0.DeathCamPrompt:completeAnimation()
			f443_arg0.DeathCamPrompt:setAlpha(0)
			f443_local2(f443_arg0.DeathCamPrompt)
			f443_arg0.SoundGameOverSlam:beginAnimation(2200)
			f443_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f443_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f443_arg0.clipInterrupted)
			f443_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f443_arg1)
				f443_arg0.clipFinished(element, event)
			end)
			local f443_local3 = function(f451_arg0)
				local f451_local0 = function(f452_arg0)
					local f452_local0 = function(f453_arg0)
						local f453_local0 = function(f454_arg0)
							local f454_local0 = function(f455_arg0)
								local f455_local0 = function(f456_arg0)
									local f456_local0 = function(f457_arg0)
										local f457_local0 = function(f458_arg0)
											local f458_local0 = function(f459_arg0)
												f459_arg0:beginAnimation(19)
												f459_arg0:setAlpha(1)
												f459_arg0:registerEventHandler("transition_complete_keyframe", f443_arg0.clipFinished)
											end
											f458_arg0:beginAnimation(19)
											f458_arg0:setAlpha(0.2)
											f458_arg0:registerEventHandler("transition_complete_keyframe", f458_local0)
										end
										f457_arg0:beginAnimation(19)
										f457_arg0:setAlpha(1)
										f457_arg0:registerEventHandler("transition_complete_keyframe", f457_local0)
									end
									f456_arg0:beginAnimation(30)
									f456_arg0:setAlpha(0)
									f456_arg0:registerEventHandler("transition_complete_keyframe", f456_local0)
								end
								f455_arg0:beginAnimation(39)
								f455_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f455_arg0:setAlpha(1)
								f455_arg0:registerEventHandler("transition_complete_keyframe", f455_local0)
							end
							f454_arg0:beginAnimation(49)
							f454_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f454_arg0:setAlpha(0.85)
							f454_arg0:registerEventHandler("transition_complete_keyframe", f454_local0)
						end
						f453_arg0:beginAnimation(60)
						f453_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f453_arg0:setAlpha(0.67)
						f453_arg0:registerEventHandler("transition_complete_keyframe", f453_local0)
					end
					f452_arg0:beginAnimation(120)
					f452_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f452_arg0:setAlpha(0.44)
					f452_arg0:registerEventHandler("transition_complete_keyframe", f452_local0)
				end
				f451_arg0:beginAnimation(29)
				f451_arg0:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f451_arg0:registerEventHandler("transition_complete_keyframe", f451_local0)
			end
			f443_arg0.BarMiddle:beginAnimation(1510)
			f443_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f443_arg0.BarMiddle:setAlpha(0)
			f443_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f443_arg0.clipInterrupted)
			f443_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f443_local3)
			local f443_local4 = function(f460_arg0)
				local f460_local0 = function(f461_arg0)
					local f461_local0 = function(f462_arg0)
						f462_arg0:beginAnimation(59)
						f462_arg0:setLeftRight(0, 0.07, 0, 0)
						f462_arg0:registerEventHandler("transition_complete_keyframe", f443_arg0.clipFinished)
					end
					f461_arg0:beginAnimation(80)
					f461_arg0:setLeftRight(0, 0.07, -10, -10)
					f461_arg0:registerEventHandler("transition_complete_keyframe", f461_local0)
				end
				f460_arg0:beginAnimation(100)
				f460_arg0:setLeftRight(0, 0.07, 0, 0)
				f460_arg0:setAlpha(1)
				f460_arg0:registerEventHandler("transition_complete_keyframe", f460_local0)
			end
			f443_arg0.BarLeft:beginAnimation(1510)
			f443_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f443_arg0.BarLeft:setAlpha(0)
			f443_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f443_arg0.clipInterrupted)
			f443_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f443_local4)
			local f443_local5 = function(f463_arg0)
				local f463_local0 = function(f464_arg0)
					local f464_local0 = function(f465_arg0)
						f465_arg0:beginAnimation(59)
						f465_arg0:setLeftRight(0.93, 1, 0, 0)
						f465_arg0:registerEventHandler("transition_complete_keyframe", f443_arg0.clipFinished)
					end
					f464_arg0:beginAnimation(80)
					f464_arg0:setLeftRight(0.93, 1, 10, 10)
					f464_arg0:registerEventHandler("transition_complete_keyframe", f464_local0)
				end
				f463_arg0:beginAnimation(100)
				f463_arg0:setLeftRight(0.93, 1, 0, 0)
				f463_arg0:setAlpha(1)
				f463_arg0:registerEventHandler("transition_complete_keyframe", f463_local0)
			end
			f443_arg0.BarRight:beginAnimation(1510)
			f443_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f443_arg0.BarRight:setAlpha(0)
			f443_arg0.BarRight:registerEventHandler("interrupted_keyframe", f443_arg0.clipInterrupted)
			f443_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f443_local5)
			local f443_local6 = function(f466_arg0)
				local f466_local0 = function(f467_arg0)
					f467_arg0:beginAnimation(9)
					f467_arg0:setAlpha(1)
					f467_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefeatIntro")
						f443_arg0.clipFinished(element, event)
					end)
				end
				f466_arg0:beginAnimation(690)
				f466_arg0:registerEventHandler("transition_complete_keyframe", f466_local0)
			end
			f443_arg0.HeaderTextTeamRank:beginAnimation(1510)
			f443_arg0.HeaderTextTeamRank:setAlpha(0)
			f443_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f443_arg0.clipInterrupted)
			f443_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f443_local6)
		end,
	},
	GameOver = {
		DefaultClip = function(f469_arg0, f469_arg1)
			f469_arg0:__resetProperties()
			f469_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f470_arg0, f470_arg1)
			f470_arg0:__resetProperties()
			f470_arg0:setupElementClipCounter(9)
			f470_arg0.Blur:completeAnimation()
			f470_arg0.Blur:setAlpha(1)
			f470_arg0.clipFinished(f470_arg0.Blur)
			f470_arg0.MatchTimerContainer:completeAnimation()
			f470_arg0.MatchTimerContainer:setAlpha(1)
			f470_arg0.clipFinished(f470_arg0.MatchTimerContainer)
			f470_arg0.FooterContainerFrontendRight:completeAnimation()
			f470_arg0.FooterContainerFrontendRight:setAlpha(1)
			f470_arg0.clipFinished(f470_arg0.FooterContainerFrontendRight)
			f470_arg0.DeathCamPrompt:completeAnimation()
			f470_arg0.DeathCamPrompt:setAlpha(1)
			f470_arg0.clipFinished(f470_arg0.DeathCamPrompt)
			f470_arg0.BarMiddle:completeAnimation()
			f470_arg0.BarMiddle:setAlpha(1)
			f470_arg0.clipFinished(f470_arg0.BarMiddle)
			f470_arg0.BarLeft:completeAnimation()
			f470_arg0.BarLeft:setAlpha(1)
			f470_arg0.clipFinished(f470_arg0.BarLeft)
			f470_arg0.BarRight:completeAnimation()
			f470_arg0.BarRight:setAlpha(1)
			f470_arg0.clipFinished(f470_arg0.BarRight)
			f470_arg0.HeaderTextTeamRank:completeAnimation()
			f470_arg0.HeaderTextTeamRank:setAlpha(1)
			f470_arg0.HeaderTextTeamRank:playClip("Gameover")
			f470_arg0.clipFinished(f470_arg0.HeaderTextTeamRank)
			f470_arg0.CrosshairOccluder:completeAnimation()
			f470_arg0.CrosshairOccluder:setAlpha(1)
			f470_arg0.clipFinished(f470_arg0.CrosshairOccluder)
		end,
		FirstTimeIntro = function(f471_arg0, f471_arg1)
			f471_arg0:__resetProperties()
			f471_arg0:setupElementClipCounter(10)
			local f471_local0 = function(f472_arg0)
				f471_arg0.Blur:beginAnimation(2030)
				f471_arg0.Blur:setAlpha(1)
				f471_arg0.Blur:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
				f471_arg0.Blur:registerEventHandler("transition_complete_keyframe", f471_arg0.clipFinished)
			end
			f471_arg0.Blur:completeAnimation()
			f471_arg0.Blur:setAlpha(0)
			f471_local0(f471_arg0.Blur)
			local f471_local1 = function(f473_arg0)
				local f473_local0 = function(f474_arg0)
					f474_arg0:beginAnimation(1000)
					f474_arg0:setAlpha(1)
					f474_arg0:registerEventHandler("transition_complete_keyframe", f471_arg0.clipFinished)
				end
				f471_arg0.MatchTimerContainer:beginAnimation(5500)
				f471_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
				f471_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f473_local0)
			end
			f471_arg0.MatchTimerContainer:completeAnimation()
			f471_arg0.MatchTimerContainer:setAlpha(0)
			f471_local1(f471_arg0.MatchTimerContainer)
			local f471_local2 = function(f475_arg0)
				local f475_local0 = function(f476_arg0)
					f476_arg0:beginAnimation(1000)
					f476_arg0:setAlpha(1)
					f476_arg0:registerEventHandler("transition_complete_keyframe", f471_arg0.clipFinished)
				end
				f471_arg0.FooterContainerFrontendRight:beginAnimation(5500)
				f471_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
				f471_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f475_local0)
			end
			f471_arg0.FooterContainerFrontendRight:completeAnimation()
			f471_arg0.FooterContainerFrontendRight:setAlpha(0)
			f471_local2(f471_arg0.FooterContainerFrontendRight)
			local f471_local3 = function(f477_arg0)
				local f477_local0 = function(f478_arg0)
					f478_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f478_arg0:setAlpha(1)
					f478_arg0:registerEventHandler("transition_complete_keyframe", f471_arg0.clipFinished)
				end
				f471_arg0.DeathCamPrompt:beginAnimation(5500)
				f471_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
				f471_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f477_local0)
			end
			f471_arg0.DeathCamPrompt:completeAnimation()
			f471_arg0.DeathCamPrompt:setAlpha(0)
			f471_local3(f471_arg0.DeathCamPrompt)
			f471_arg0.SoundGameOverSlam:beginAnimation(2200)
			f471_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f471_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
			f471_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f471_arg1)
				f471_arg0.clipFinished(element, event)
			end)
			local f471_local4 = function(f480_arg0)
				local f480_local0 = function(f481_arg0)
					local f481_local0 = function(f482_arg0)
						local f482_local0 = function(f483_arg0)
							local f483_local0 = function(f484_arg0)
								local f484_local0 = function(f485_arg0)
									local f485_local0 = function(f486_arg0)
										local f486_local0 = function(f487_arg0)
											local f487_local0 = function(f488_arg0)
												f488_arg0:beginAnimation(19)
												f488_arg0:setAlpha(1)
												f488_arg0:registerEventHandler("transition_complete_keyframe", f471_arg0.clipFinished)
											end
											f487_arg0:beginAnimation(19)
											f487_arg0:setAlpha(0.2)
											f487_arg0:registerEventHandler("transition_complete_keyframe", f487_local0)
										end
										f486_arg0:beginAnimation(19)
										f486_arg0:setAlpha(1)
										f486_arg0:registerEventHandler("transition_complete_keyframe", f486_local0)
									end
									f485_arg0:beginAnimation(30)
									f485_arg0:setAlpha(0)
									f485_arg0:registerEventHandler("transition_complete_keyframe", f485_local0)
								end
								f484_arg0:beginAnimation(39)
								f484_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f484_arg0:setAlpha(1)
								f484_arg0:registerEventHandler("transition_complete_keyframe", f484_local0)
							end
							f483_arg0:beginAnimation(49)
							f483_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f483_arg0:setAlpha(0.85)
							f483_arg0:registerEventHandler("transition_complete_keyframe", f483_local0)
						end
						f482_arg0:beginAnimation(60)
						f482_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f482_arg0:setAlpha(0.67)
						f482_arg0:registerEventHandler("transition_complete_keyframe", f482_local0)
					end
					f481_arg0:beginAnimation(120)
					f481_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f481_arg0:setAlpha(0.44)
					f481_arg0:registerEventHandler("transition_complete_keyframe", f481_local0)
				end
				f480_arg0:beginAnimation(29)
				f480_arg0:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f480_arg0:registerEventHandler("transition_complete_keyframe", f480_local0)
			end
			f471_arg0.BarMiddle:beginAnimation(1510)
			f471_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f471_arg0.BarMiddle:setAlpha(0)
			f471_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
			f471_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f471_local4)
			local f471_local5 = function(f489_arg0)
				local f489_local0 = function(f490_arg0)
					local f490_local0 = function(f491_arg0)
						f491_arg0:beginAnimation(59)
						f491_arg0:setLeftRight(0, 0.07, 0, 0)
						f491_arg0:registerEventHandler("transition_complete_keyframe", f471_arg0.clipFinished)
					end
					f490_arg0:beginAnimation(80)
					f490_arg0:setLeftRight(0, 0.07, -10, -10)
					f490_arg0:registerEventHandler("transition_complete_keyframe", f490_local0)
				end
				f489_arg0:beginAnimation(100)
				f489_arg0:setLeftRight(0, 0.07, 0, 0)
				f489_arg0:setAlpha(1)
				f489_arg0:registerEventHandler("transition_complete_keyframe", f489_local0)
			end
			f471_arg0.BarLeft:beginAnimation(1510)
			f471_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f471_arg0.BarLeft:setAlpha(0)
			f471_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
			f471_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f471_local5)
			local f471_local6 = function(f492_arg0)
				local f492_local0 = function(f493_arg0)
					local f493_local0 = function(f494_arg0)
						f494_arg0:beginAnimation(59)
						f494_arg0:setLeftRight(0.93, 1, 0, 0)
						f494_arg0:registerEventHandler("transition_complete_keyframe", f471_arg0.clipFinished)
					end
					f493_arg0:beginAnimation(80)
					f493_arg0:setLeftRight(0.93, 1, 10, 10)
					f493_arg0:registerEventHandler("transition_complete_keyframe", f493_local0)
				end
				f492_arg0:beginAnimation(100)
				f492_arg0:setLeftRight(0.93, 1, 0, 0)
				f492_arg0:setAlpha(1)
				f492_arg0:registerEventHandler("transition_complete_keyframe", f492_local0)
			end
			f471_arg0.BarRight:beginAnimation(1510)
			f471_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f471_arg0.BarRight:setAlpha(0)
			f471_arg0.BarRight:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
			f471_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f471_local6)
			local f471_local7 = function(f495_arg0)
				local f495_local0 = function(f496_arg0)
					f496_arg0:beginAnimation(9)
					f496_arg0:setAlpha(1)
					f496_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("GameoverIntro")
						f471_arg0.clipFinished(element, event)
					end)
				end
				f495_arg0:beginAnimation(690)
				f495_arg0:registerEventHandler("transition_complete_keyframe", f495_local0)
			end
			f471_arg0.HeaderTextTeamRank:beginAnimation(1510)
			f471_arg0.HeaderTextTeamRank:setAlpha(0)
			f471_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f471_arg0.clipInterrupted)
			f471_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f471_local7)
			f471_arg0.CrosshairOccluder:completeAnimation()
			f471_arg0.CrosshairOccluder:setAlpha(1)
			f471_arg0.clipFinished(f471_arg0.CrosshairOccluder)
		end,
	},
	Elimination = {
		DefaultClip = function(f498_arg0, f498_arg1)
			f498_arg0:__resetProperties()
			f498_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f499_arg0, f499_arg1)
			f499_arg0:__resetProperties()
			f499_arg0:setupElementClipCounter(14)
			f499_arg0.Blur:completeAnimation()
			f499_arg0.Blur:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.Blur)
			f499_arg0.MatchTimerContainer:completeAnimation()
			f499_arg0.MatchTimerContainer:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.MatchTimerContainer)
			f499_arg0.DownNotOut:completeAnimation()
			f499_arg0.DownNotOut:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.DownNotOut)
			f499_arg0.FooterContainerFrontendRight:completeAnimation()
			f499_arg0.FooterContainerFrontendRight:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.FooterContainerFrontendRight)
			f499_arg0.DeathCamPrompt:completeAnimation()
			f499_arg0.DeathCamPrompt:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.DeathCamPrompt)
			f499_arg0.BarMiddle:completeAnimation()
			f499_arg0.BarMiddle:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.BarMiddle)
			f499_arg0.BarLeft:completeAnimation()
			f499_arg0.BarLeft:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.BarLeft)
			f499_arg0.BarRight:completeAnimation()
			f499_arg0.BarRight:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.BarRight)
			f499_arg0.HeaderTextTeamRank:completeAnimation()
			f499_arg0.HeaderTextTeamRank:setAlpha(1)
			f499_arg0.HeaderTextTeamRank:playClip("Elimination")
			f499_arg0.clipFinished(f499_arg0.HeaderTextTeamRank)
			f499_arg0.KillerIdentity:completeAnimation()
			f499_arg0.KillerIdentity:setAlpha(1)
			f499_arg0.KillerIdentity:playClip("Main")
			f499_arg0.clipFinished(f499_arg0.KillerIdentity)
			f499_arg0.MistakesWereMade:completeAnimation()
			f499_arg0.MistakesWereMade:setAlpha(1)
			f499_arg0.MistakesWereMade:playClip("Main")
			f499_arg0.clipFinished(f499_arg0.MistakesWereMade)
			f499_arg0.WeaponIdentity:completeAnimation()
			f499_arg0.WeaponIdentity:setAlpha(1)
			f499_arg0.WeaponIdentity:playClip("Main")
			f499_arg0.clipFinished(f499_arg0.WeaponIdentity)
			f499_arg0.MeansOfDeath:completeAnimation()
			f499_arg0.MeansOfDeath:setAlpha(1)
			f499_arg0.MeansOfDeath:playClip("Main")
			f499_arg0.clipFinished(f499_arg0.MeansOfDeath)
			f499_arg0.CrosshairOccluder:completeAnimation()
			f499_arg0.CrosshairOccluder:setAlpha(1)
			f499_arg0.clipFinished(f499_arg0.CrosshairOccluder)
		end,
		FirstTimeIntro = function(f500_arg0, f500_arg1)
			f500_arg0:__resetProperties()
			f500_arg0:setupElementClipCounter(16)
			local f500_local0 = function(f501_arg0)
				f500_arg0.Blur:beginAnimation(1210)
				f500_arg0.Blur:setAlpha(1)
				f500_arg0.Blur:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.Blur:registerEventHandler("transition_complete_keyframe", f500_arg0.clipFinished)
			end
			f500_arg0.Blur:completeAnimation()
			f500_arg0.Blur:setAlpha(0)
			f500_local0(f500_arg0.Blur)
			local f500_local1 = function(f502_arg0)
				local f502_local0 = function(f503_arg0)
					f503_arg0:beginAnimation(1000)
					f503_arg0:setAlpha(1)
					f503_arg0:registerEventHandler("transition_complete_keyframe", f500_arg0.clipFinished)
				end
				f500_arg0.MatchTimerContainer:beginAnimation(4000)
				f500_arg0.MatchTimerContainer:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.MatchTimerContainer:registerEventHandler("transition_complete_keyframe", f502_local0)
			end
			f500_arg0.MatchTimerContainer:completeAnimation()
			f500_arg0.MatchTimerContainer:setAlpha(0)
			f500_local1(f500_arg0.MatchTimerContainer)
			local f500_local2 = function(f504_arg0)
				local f504_local0 = function(f505_arg0)
					f505_arg0:beginAnimation(1000)
					f505_arg0:setAlpha(1)
					f505_arg0:registerEventHandler("transition_complete_keyframe", f500_arg0.clipFinished)
				end
				f500_arg0.DownNotOut:beginAnimation(3010)
				f500_arg0.DownNotOut:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.DownNotOut:registerEventHandler("transition_complete_keyframe", f504_local0)
			end
			f500_arg0.DownNotOut:completeAnimation()
			f500_arg0.DownNotOut:setAlpha(0)
			f500_local2(f500_arg0.DownNotOut)
			local f500_local3 = function(f506_arg0)
				local f506_local0 = function(f507_arg0)
					f507_arg0:beginAnimation(1000)
					f507_arg0:setAlpha(1)
					f507_arg0:registerEventHandler("transition_complete_keyframe", f500_arg0.clipFinished)
				end
				f500_arg0.FooterContainerFrontendRight:beginAnimation(4000)
				f500_arg0.FooterContainerFrontendRight:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.FooterContainerFrontendRight:registerEventHandler("transition_complete_keyframe", f506_local0)
			end
			f500_arg0.FooterContainerFrontendRight:completeAnimation()
			f500_arg0.FooterContainerFrontendRight:setAlpha(0)
			f500_local3(f500_arg0.FooterContainerFrontendRight)
			local f500_local4 = function(f508_arg0)
				local f508_local0 = function(f509_arg0)
					f509_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f509_arg0:setAlpha(1)
					f509_arg0:registerEventHandler("transition_complete_keyframe", f500_arg0.clipFinished)
				end
				f500_arg0.DeathCamPrompt:beginAnimation(4000)
				f500_arg0.DeathCamPrompt:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.DeathCamPrompt:registerEventHandler("transition_complete_keyframe", f508_local0)
			end
			f500_arg0.DeathCamPrompt:completeAnimation()
			f500_arg0.DeathCamPrompt:setAlpha(0)
			f500_local4(f500_arg0.DeathCamPrompt)
			f500_arg0.VoipContainerNoCompass:completeAnimation()
			f500_arg0.VoipContainerNoCompass:setLeftRight(0.5, 0.5, -806, -396)
			f500_arg0.clipFinished(f500_arg0.VoipContainerNoCompass)
			f500_arg0.SoundGameOverSlam:beginAnimation(670)
			f500_arg0.SoundGameOverSlam:setPlaySoundDirect(true)
			f500_arg0.SoundGameOverSlam:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
			f500_arg0.SoundGameOverSlam:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_gameover_slam", f500_arg1)
				f500_arg0.clipFinished(element, event)
			end)
			local f500_local5 = function(f511_arg0)
				local f511_local0 = function(f512_arg0)
					local f512_local0 = function(f513_arg0)
						local f513_local0 = function(f514_arg0)
							local f514_local0 = function(f515_arg0)
								local f515_local0 = function(f516_arg0)
									local f516_local0 = function(f517_arg0)
										local f517_local0 = function(f518_arg0)
											local f518_local0 = function(f519_arg0)
												f519_arg0:beginAnimation(19)
												f519_arg0:setAlpha(1)
												f519_arg0:registerEventHandler("transition_complete_keyframe", f500_arg0.clipFinished)
											end
											f518_arg0:beginAnimation(19)
											f518_arg0:setAlpha(0.2)
											f518_arg0:registerEventHandler("transition_complete_keyframe", f518_local0)
										end
										f517_arg0:beginAnimation(20)
										f517_arg0:setAlpha(1)
										f517_arg0:registerEventHandler("transition_complete_keyframe", f517_local0)
									end
									f516_arg0:beginAnimation(29)
									f516_arg0:setAlpha(0)
									f516_arg0:registerEventHandler("transition_complete_keyframe", f516_local0)
								end
								f515_arg0:beginAnimation(40)
								f515_arg0:setTopBottom(0.5, 0.5, -441, -361)
								f515_arg0:setAlpha(1)
								f515_arg0:registerEventHandler("transition_complete_keyframe", f515_local0)
							end
							f514_arg0:beginAnimation(49)
							f514_arg0:setTopBottom(0.5, 0.5, -431, -351)
							f514_arg0:setAlpha(0.85)
							f514_arg0:registerEventHandler("transition_complete_keyframe", f514_local0)
						end
						f513_arg0:beginAnimation(60)
						f513_arg0:setTopBottom(0.5, 0.5, -441, -361)
						f513_arg0:setAlpha(0.67)
						f513_arg0:registerEventHandler("transition_complete_keyframe", f513_local0)
					end
					f512_arg0:beginAnimation(120)
					f512_arg0:setTopBottom(0.5, 0.5, -421, -341)
					f512_arg0:setAlpha(0.44)
					f512_arg0:registerEventHandler("transition_complete_keyframe", f512_local0)
				end
				f511_arg0:beginAnimation(30)
				f511_arg0:setTopBottom(0.5, 0.5, -671.4, -591.4)
				f511_arg0:registerEventHandler("transition_complete_keyframe", f511_local0)
			end
			f500_arg0.BarMiddle:beginAnimation(510)
			f500_arg0.BarMiddle:setTopBottom(0.5, 0.5, -734, -654)
			f500_arg0.BarMiddle:setAlpha(0)
			f500_arg0.BarMiddle:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
			f500_arg0.BarMiddle:registerEventHandler("transition_complete_keyframe", f500_local5)
			local f500_local6 = function(f520_arg0)
				local f520_local0 = function(f521_arg0)
					local f521_local0 = function(f522_arg0)
						f522_arg0:beginAnimation(59)
						f522_arg0:setLeftRight(0, 0.07, 0, 0)
						f522_arg0:registerEventHandler("transition_complete_keyframe", f500_arg0.clipFinished)
					end
					f521_arg0:beginAnimation(80)
					f521_arg0:setLeftRight(0, 0.07, -10, -10)
					f521_arg0:registerEventHandler("transition_complete_keyframe", f521_local0)
				end
				f520_arg0:beginAnimation(99)
				f520_arg0:setLeftRight(0, 0.07, 0, 0)
				f520_arg0:setAlpha(1)
				f520_arg0:registerEventHandler("transition_complete_keyframe", f520_local0)
			end
			f500_arg0.BarLeft:beginAnimation(930)
			f500_arg0.BarLeft:setLeftRight(0, 0.07, -130, -130)
			f500_arg0.BarLeft:setAlpha(0)
			f500_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
			f500_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f500_local6)
			local f500_local7 = function(f523_arg0)
				local f523_local0 = function(f524_arg0)
					local f524_local0 = function(f525_arg0)
						f525_arg0:beginAnimation(59)
						f525_arg0:setLeftRight(0.93, 1, 0, 0)
						f525_arg0:registerEventHandler("transition_complete_keyframe", f500_arg0.clipFinished)
					end
					f524_arg0:beginAnimation(80)
					f524_arg0:setLeftRight(0.93, 1, 10, 10)
					f524_arg0:registerEventHandler("transition_complete_keyframe", f524_local0)
				end
				f523_arg0:beginAnimation(99)
				f523_arg0:setLeftRight(0.93, 1, 0, 0)
				f523_arg0:setAlpha(1)
				f523_arg0:registerEventHandler("transition_complete_keyframe", f523_local0)
			end
			f500_arg0.BarRight:beginAnimation(930)
			f500_arg0.BarRight:setLeftRight(0.93, 1, 130, 130)
			f500_arg0.BarRight:setAlpha(0)
			f500_arg0.BarRight:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
			f500_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f500_local7)
			local f500_local8 = function(f526_arg0)
				local f526_local0 = function(f527_arg0)
					f527_arg0:beginAnimation(9)
					f527_arg0:setAlpha(1)
					f527_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("EliminationIntro")
						f500_arg0.clipFinished(element, event)
					end)
				end
				f526_arg0:beginAnimation(690)
				f526_arg0:registerEventHandler("transition_complete_keyframe", f526_local0)
			end
			f500_arg0.HeaderTextTeamRank:beginAnimation(510)
			f500_arg0.HeaderTextTeamRank:setAlpha(0)
			f500_arg0.HeaderTextTeamRank:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
			f500_arg0.HeaderTextTeamRank:registerEventHandler("transition_complete_keyframe", f500_local8)
			local f500_local9 = function(f529_arg0)
				local f529_local0 = function(f530_arg0)
					f530_arg0:beginAnimation(10)
					f530_arg0:setAlpha(1)
					f530_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Main")
						f500_arg0.clipFinished(element, event)
					end)
				end
				f500_arg0.KillerIdentity:playClip("Main")
				f500_arg0.KillerIdentity:beginAnimation(1180)
				f500_arg0.KillerIdentity:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.KillerIdentity:registerEventHandler("transition_complete_keyframe", f529_local0)
			end
			f500_arg0.KillerIdentity:completeAnimation()
			f500_arg0.KillerIdentity:setAlpha(0)
			f500_local9(f500_arg0.KillerIdentity)
			local f500_local10 = function(f532_arg0)
				local f532_local0 = function(f533_arg0)
					f533_arg0:beginAnimation(10)
					f533_arg0:setAlpha(1)
					f533_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Main")
						f500_arg0.clipFinished(element, event)
					end)
				end
				f500_arg0.MistakesWereMade:playClip("Main")
				f500_arg0.MistakesWereMade:beginAnimation(1180)
				f500_arg0.MistakesWereMade:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.MistakesWereMade:registerEventHandler("transition_complete_keyframe", f532_local0)
			end
			f500_arg0.MistakesWereMade:completeAnimation()
			f500_arg0.MistakesWereMade:setAlpha(0)
			f500_local10(f500_arg0.MistakesWereMade)
			local f500_local11 = function(f535_arg0)
				local f535_local0 = function(f536_arg0)
					f536_arg0:beginAnimation(9)
					f536_arg0:setAlpha(1)
					f536_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Main")
						f500_arg0.clipFinished(element, event)
					end)
				end
				f500_arg0.WeaponIdentity:playClip("Main")
				f500_arg0.WeaponIdentity:beginAnimation(1380)
				f500_arg0.WeaponIdentity:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.WeaponIdentity:registerEventHandler("transition_complete_keyframe", f535_local0)
			end
			f500_arg0.WeaponIdentity:completeAnimation()
			f500_arg0.WeaponIdentity:setAlpha(0)
			f500_local11(f500_arg0.WeaponIdentity)
			local f500_local12 = function(f538_arg0)
				local f538_local0 = function(f539_arg0)
					f539_arg0:beginAnimation(9)
					f539_arg0:setAlpha(1)
					f539_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("Main")
						f500_arg0.clipFinished(element, event)
					end)
				end
				f500_arg0.MeansOfDeath:playClip("Main")
				f500_arg0.MeansOfDeath:beginAnimation(1380)
				f500_arg0.MeansOfDeath:registerEventHandler("interrupted_keyframe", f500_arg0.clipInterrupted)
				f500_arg0.MeansOfDeath:registerEventHandler("transition_complete_keyframe", f538_local0)
			end
			f500_arg0.MeansOfDeath:completeAnimation()
			f500_arg0.MeansOfDeath:setAlpha(0)
			f500_local12(f500_arg0.MeansOfDeath)
			f500_arg0.CrosshairOccluder:completeAnimation()
			f500_arg0.CrosshairOccluder:setAlpha(1)
			f500_arg0.clipFinished(f500_arg0.CrosshairOccluder)
		end,
	},
}
CoD.GameEndScore_WZ.__onClose = function(f541_arg0)
	f541_arg0.BlurWZAAR:close()
	f541_arg0.NoiseEliminatedBacking:close()
	f541_arg0.PlayerResultContainer:close()
	f541_arg0.Outcome:close()
	f541_arg0.EliminatorContainer:close()
	f541_arg0.GameStatus:close()
	f541_arg0.MatchTimerContainer:close()
	f541_arg0.DownNotOut:close()
	f541_arg0.emptyFocusablePC:close()
	f541_arg0.FooterContainerFrontendRight:close()
	f541_arg0.DeathCamPrompt:close()
	f541_arg0.VoipContainerNoCompass:close()
	f541_arg0.DirectorQuitButtonContainer:close()
	f541_arg0.BarMiddle:close()
	f541_arg0.BarLeft:close()
	f541_arg0.BarRight:close()
	f541_arg0.ChallengeCoin2:close()
	f541_arg0.HeaderTextTeamRank:close()
	f541_arg0.KillerIdentity:close()
	f541_arg0.MistakesWereMade:close()
	f541_arg0.WeaponIdentity:close()
	f541_arg0.MeansOfDeath:close()
	f541_arg0.WZAAR:close()
	f541_arg0.DirectorStageIndicator:close()
end
