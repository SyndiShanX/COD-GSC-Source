require("ui/uieditor/widgets/backgroundframes/menuframeingame")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsbackground")
require("ui/uieditor/widgets/startmenu/startmenu_safeareacontainer")
require("ui/uieditor/widgets/director/directorquitbuttoncontainer")
require("x64:b710bc406e458bd")
CoD.StartMenu_Main = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Main = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Main", f1_arg0)
	local f1_local1 = self
	CoD.StartMenuUtility.InitDataForStartMenu(self, f1_local1, f1_arg0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "hudItems.hasStartedWZMatch", false)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "PositionDraft.stage", 0)
	self:setClass(CoD.StartMenu_Main)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.2)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local TopBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0.5, 86.5)
	TopBacking:setRGB(0, 0, 0)
	TopBacking:setAlpha(0)
	self:addElement(TopBacking)
	self.TopBacking = TopBacking
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -960, 960)
	TabFrame:setTopBottom(0.5, 0.5, -390, 390)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local MenuFrameIngame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(MenuFrameIngame)
	self.MenuFrameIngame = MenuFrameIngame
	local TiledPlusGrid = LUI.UIImage.new(0, 0, -135, 1920, 0, 0, 0, 1080)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage("uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local Box = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -21, 43)
	Box:setRGB(0, 0, 0)
	Box:setAlpha(0)
	self:addElement(Box)
	self.Box = Box
	local DividerSolidBot = LUI.UIImage.new(0, 1.01, -11, -11, 0, 0, 41, 45)
	DividerSolidBot:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	DividerSolidBot:setAlpha(0)
	DividerSolidBot:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	DividerSolidBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	DividerSolidBot:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidBot:setupNineSliceShader(8, 4)
	self:addElement(DividerSolidBot)
	self.DividerSolidBot = DividerSolidBot
	local SafeAreaContainer = CoD.StartMenu_SafeAreaContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SafeAreaContainer.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/menu"))
	self:addElement(SafeAreaContainer)
	self.SafeAreaContainer = SafeAreaContainer
	local DirectorQuitButtonContainer = nil
	DirectorQuitButtonContainer = CoD.DirectorQuitButtonContainer.new(f1_local1, f1_arg0, 0.5, 0.5, 768, 968, 0, 0, 11, 47)
	DirectorQuitButtonContainer:setAlpha(0)
	DirectorQuitButtonContainer:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(DirectorQuitButtonContainer, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		if IsPC() then
			OpenPCQuit(self, f3_arg1, self, f3_arg2)
			return true
		else
		end
	end, function(f4_arg0, f4_arg1, f4_arg2)
		if IsPC() then
			CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(DirectorQuitButtonContainer)
	self.DirectorQuitButtonContainer = DirectorQuitButtonContainer
	local PCKoreaContentDescriptorsContainer = nil
	PCKoreaContentDescriptorsContainer = CoD.PC_Korea_ContentDescriptors_Container.new(f1_local1, f1_arg0, 0.5, 0.5, 737, 926, 0, 0, 110, 446)
	PCKoreaContentDescriptorsContainer:mergeStateConditions({
		{
			stateName = "Is15PlusFrontend",
			condition = function(menu, element, event)
				local f5_local0 = IsPC()
				if f5_local0 then
					f5_local0 = InFrontend()
					if f5_local0 then
						f5_local0 = CoD.PCKoreaUtility.IsInKorea()
						if f5_local0 then
							f5_local0 = IsGameTypeCombatTraining()
						end
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "Is15Plus",
			condition = function(menu, element, event)
				local f6_local0 = IsPC()
				if f6_local0 then
					f6_local0 = CoD.PCKoreaUtility.IsInKorea()
					if f6_local0 then
						f6_local0 = IsGameTypeCombatTraining()
					end
				end
				return f6_local0
			end,
		},
	})
	self:addElement(PCKoreaContentDescriptorsContainer)
	self.PCKoreaContentDescriptorsContainer = PCKoreaContentDescriptorsContainer
	TabFrame:linkToElementModel(SafeAreaContainer.TabBar.Tabs.grid, "tabWidget", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			TabFrame:changeFrameWidget(f7_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "IsFrontEnd",
			condition = function(menu, element, event)
				return InFrontend()
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
		{
			stateName = "Campaign",
			condition = function(menu, element, event)
				return IsCampaign()
			end,
		},
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				return IsInGame() and IsWarzone()
			end,
		},
		{
			stateName = "Ingame",
			condition = function(menu, element, event)
				return IsInGame()
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine.GetGlobalModel()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine.GetGlobalModel()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_ltrig"])
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine.GetGlobalModel()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyMainMode"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_ltrig"])
	end, false)
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f16_arg0, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_start"])
	end)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine.GetModelForController(f1_arg0)
	f1_local16(f1_local15, f1_local17.LastInput, function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_start"])
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine.GetModelForController(f1_arg0)
	f1_local16(f1_local15, f1_local17["PositionDraft.stage"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
	end, false)
	self:appendEventHandler("on_session_start", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
	end)
	self:appendEventHandler("on_session_end", function(f20_arg0, f20_arg1)
		f20_arg1.menu = f20_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f20_arg0, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
	end)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine.GetModelForController(f1_arg0)
	f1_local16(f1_local15, f1_local17["hudItems.hasStartedWZMatch"], function(f21_arg0, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
	end, false)
	self:registerEventHandler("menu_loaded", function(element, event)
		local f22_local0 = nil
		if element.menuLoaded then
			f22_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f22_local0 = element.super:menuLoaded(event)
		end
		PlaySoundSetSound(self, "menu_enter")
		FileshareGetSlots(self, element, f1_arg0)
		SetHeadingKickerTextToGameMode()
		if not f22_local0 then
			f22_local0 = element:dispatchEventToChildren(event)
		end
		return f22_local0
	end)
	self:registerEventHandler("close_all_ingame_menus", function(element, event)
		local f23_local0 = nil
		StartMenuGoBack(f1_local1, f1_arg0)
		if not f23_local0 then
			f23_local0 = element:dispatchEventToChildren(event)
		end
		return f23_local0
	end)
	self:registerEventHandler("open_migration_menu", function(element, event)
		local f24_local0 = nil
		StartMenuGoBack(f1_local1, f1_arg0)
		if not f24_local0 then
			f24_local0 = element:dispatchEventToChildren(event)
		end
		return f24_local0
	end)
	self:registerEventHandler("occlusion_change", function(element, event)
		local f25_local0 = nil
		if element.OcclusionChange then
			f25_local0 = element:OcclusionChange(event)
		elseif element.super.OcclusionChange then
			f25_local0 = element.super:OcclusionChange(event)
		end
		if IsPC() and IsWarzone() and IsInGame() then
			CoD.WZUtility.ClosePCSplitterWidget(self, f1_local1, f1_arg0)
		end
		if not f25_local0 then
			f25_local0 = element:dispatchEventToChildren(event)
		end
		return f25_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
		if InFrontend() then
			CoD.BaseUtility.SwitchModeOnMenu(f26_arg2)
			RefreshLobbyRoom(f26_arg1, f26_arg2)
			CoD.StartMenuUtility.CleanUpBarracksTab(f26_arg1, f26_arg2)
			StartMenuGoBack(f26_arg1, f26_arg2)
			CoD.LobbyUtility.SetMenuControllerRestriction(self, f26_arg2, 0)
			return true
		elseif not IsPC() and not IsDemoPlaying() then
			CoD.BaseUtility.SwitchModeOnMenu(f26_arg2)
			RefreshLobbyRoom(f26_arg1, f26_arg2)
			StartMenuGoBack(f26_arg1, f26_arg2)
			return true
		elseif IsPC() and not IsDemoPlaying() then
			CoD.BaseUtility.SwitchModeOnMenu(f26_arg2)
			RefreshLobbyRoom(f26_arg1, f26_arg2)
			StartMenuGoBack(f26_arg1, f26_arg2)
			return true
		elseif IsPC() and IsDemoPlaying() then
			CoD.DemoUtility.RunPauseCommandIfNotPlayerPause(f26_arg2)
			RefreshLobbyRoom(f26_arg1, f26_arg2)
			StartMenuGoBack(f26_arg1, f26_arg2)
			return true
		elseif IsDemoPlaying() and not IsPC() then
			RefreshLobbyRoom(f26_arg1, f26_arg2)
			StartMenuGoBack(f26_arg1, f26_arg2)
			return true
		else
		end
	end, function(f27_arg0, f27_arg1, f27_arg2)
		if InFrontend() then
			CoD.Menu.SetButtonLabel(f27_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif not IsPC() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(f27_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/dismiss", nil, nil)
			return true
		elseif IsPC() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(f27_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsPC() and IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(f27_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsDemoPlaying() and not IsPC() then
			CoD.Menu.SetButtonLabel(f27_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xby_pstriangle"], nil, function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.NextWeapon(f28_arg2)
			return true
		elseif IsInGame() and not IsLobbyNetworkModeLAN() and not IsDemoPlaying() and not IsPC() and not IsGameTypeCombatTraining() then
			OpenOverlay(self, "Social_Main", f28_arg2, nil)
			return true
		else
		end
	end, function(f29_arg0, f29_arg1, f29_arg2)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(f29_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], 0x0, nil, nil)
			return false
		elseif IsInGame() and not IsLobbyNetworkModeLAN() and not IsDemoPlaying() and not IsPC() and not IsGameTypeCombatTraining() then
			CoD.Menu.SetButtonLabel(f29_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], @"menu/social", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_none"], "weapnext", function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.NextWeapon(f30_arg2)
			return true
		else
		end
	end, function(f31_arg0, f31_arg1, f31_arg2)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(f31_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "weapnext")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_none"], "weapprev", function(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.PrevWeapon(f32_arg2)
			return true
		else
		end
	end, function(f33_arg0, f33_arg1, f33_arg2)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(f33_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "weapprev")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_none"], "weapswitchprimary", function(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
		if IsPC() and IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.SwitchToWeaponInSlot(f34_arg2, 0)
			return true
		else
		end
	end, function(f35_arg0, f35_arg1, f35_arg2)
		if IsPC() and IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(f35_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "weapswitchprimary")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_none"], "weapswitchsecondary", function(f36_arg0, f36_arg1, f36_arg2, f36_arg3)
		if IsPC() and IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.SwitchToWeaponInSlot(f36_arg2, 1)
			return true
		else
		end
	end, function(f37_arg0, f37_arg1, f37_arg2)
		if IsPC() and IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(f37_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "weapswitchsecondary")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_ltrig"], "F1", function(f38_arg0, f38_arg1, f38_arg2, f38_arg3)
		if not IsRepeatButtonPress(f38_arg3) and CoD.DirectorUtility.IsMainMode(f38_arg2, Enum.LobbyMainMode[@"lobby_mainmode_mp"]) and not InFrontend() and AlwaysFalse() then
			CoD.StartMenuUtility.ShowClassSelectSlideout(f38_arg1, f38_arg2)
			return true
		else
		end
	end, function(f39_arg0, f39_arg1, f39_arg2)
		if not IsRepeatButtonPress(nil) and CoD.DirectorUtility.IsMainMode(f39_arg2, Enum.LobbyMainMode[@"lobby_mainmode_mp"]) and not InFrontend() and AlwaysFalse() then
			CoD.Menu.SetButtonLabel(f39_arg1, Enum.LUIButton[@"lui_key_ltrig"], 0x0, nil, "F1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_start"], nil, function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
		if IsPC() and IsGamepad(f40_arg2) then
			RefreshLobbyRoom(f40_arg1, f40_arg2)
			StartMenuGoBack(f40_arg1, f40_arg2)
			return true
		else
			RefreshLobbyRoom(f40_arg1, f40_arg2)
			StartMenuGoBack(f40_arg1, f40_arg2)
			return true
		end
	end, function(f41_arg0, f41_arg1, f41_arg2)
		CoD.Menu.SetButtonLabel(f41_arg1, Enum.LUIButton[@"lui_key_start"], 0x0, nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"], nil, function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
		if CoD.StartMenuUtility.CanChangeWZStatsFilter(f42_arg1, self.TabFrame, f42_arg2) then
			CoD.PlayerStatsUtility.UpdateWZStatsFilter(f42_arg2)
			PlaySoundAlias("uin_stats_switch")
			return true
		else
		end
	end, function(f43_arg0, f43_arg1, f43_arg2)
		if CoD.StartMenuUtility.CanChangeWZStatsFilter(f43_arg1, self.TabFrame, f43_arg2) then
			CoD.Menu.SetButtonLabel(f43_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_none"], "ui_contextual_2", function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
		if IsPC() and CoD.PCUtility.CanShowLeaveGameButton(f44_arg1, f44_arg2) then
			QuitPCGame_MP(self, f44_arg2, false)
			return true
		else
		end
	end, function(f45_arg0, f45_arg1, f45_arg2)
		if IsPC() and CoD.PCUtility.CanShowLeaveGameButton(f45_arg1, f45_arg2) then
			CoD.Menu.SetButtonLabel(f45_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "ui_contextual_2")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_none"], "ui_contextual_1", function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
		if IsPC() and CoD.PCUtility.CanShowStartWarzoneButton(f46_arg1, f46_arg2) then
			CoD.WZUtility.StartWarzone(f46_arg2)
			SetControllerModelValue(f46_arg2, "hudItems.hasStartedWZMatch", true)
			return true
		else
		end
	end, function(f47_arg0, f47_arg1, f47_arg2)
		if IsPC() and CoD.PCUtility.CanShowStartWarzoneButton(f47_arg1, f47_arg2) then
			CoD.Menu.SetButtonLabel(f47_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "factions.isCoDCaster", function(model)
		local f49_local0 = self
		UpdateStartMenuTabsDatasource(f1_local1)
	end)
	TabFrame.id = "TabFrame"
	MenuFrameIngame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrameIngame.id = "MenuFrameIngame"
	end
	SafeAreaContainer.id = "SafeAreaContainer"
	if CoD.isPC then
		DirectorQuitButtonContainer.id = "DirectorQuitButtonContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = TabFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local16 = self
	if IsInGame() and IsMultiplayer() then
		CoD.StartMenuUtility.AddClassSelectSlideout(f1_local1, f1_arg0)
	end
	SizeToSafeArea(TabFrame, f1_arg0)
	f1_local16 = SafeAreaContainer
	if not IsPC() then
		SizeToSafeArea(f1_local16, f1_arg0)
	end
	return self
end
CoD.StartMenu_Main.__resetProperties = function(f50_arg0)
	f50_arg0.TabFrame:completeAnimation()
	f50_arg0.Background:completeAnimation()
	f50_arg0.BGEnhancement:completeAnimation()
	f50_arg0.TiledPlusGrid:completeAnimation()
	f50_arg0.NoiseTiledBacking:completeAnimation()
	f50_arg0.DirectorQuitButtonContainer:completeAnimation()
	f50_arg0.DividerSolidBot:completeAnimation()
	f50_arg0.Box:completeAnimation()
	f50_arg0.SafeAreaContainer:completeAnimation()
	f50_arg0.TopBacking:completeAnimation()
	f50_arg0.TabFrame:setAlpha(1)
	f50_arg0.Background:setAlpha(0)
	f50_arg0.BGEnhancement:setRGB(0, 0, 0)
	f50_arg0.BGEnhancement:setAlpha(0.2)
	f50_arg0.TiledPlusGrid:setAlpha(0.05)
	f50_arg0.NoiseTiledBacking:setAlpha(0)
	f50_arg0.DirectorQuitButtonContainer:setAlpha(0)
	f50_arg0.DividerSolidBot:setTopBottom(0, 0, 41, 45)
	f50_arg0.DividerSolidBot:setAlpha(0)
	f50_arg0.Box:setTopBottom(0, 0, -21, 43)
	f50_arg0.Box:setAlpha(0)
	f50_arg0.SafeAreaContainer.CommonIdentityWidgetStreamlined:setAlpha(1)
	f50_arg0.TopBacking:setAlpha(0)
end
CoD.StartMenu_Main.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(1)
			local f51_local0 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					f53_arg0:beginAnimation(150)
					f53_arg0:setAlpha(1)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
				end
				f51_arg0.TabFrame:beginAnimation(150)
				f51_arg0.TabFrame:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.TabFrame:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f51_arg0.TabFrame:completeAnimation()
			f51_arg0.TabFrame:setAlpha(0)
			f51_local0(f51_arg0.TabFrame)
		end,
	},
	IsFrontEnd = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(1)
			f54_arg0.Background:completeAnimation()
			f54_arg0.Background:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.Background)
		end,
	},
	Zombies = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(5)
			f55_arg0.Background:completeAnimation()
			f55_arg0.Background:setAlpha(1)
			f55_arg0.clipFinished(f55_arg0.Background)
			f55_arg0.BGEnhancement:completeAnimation()
			f55_arg0.BGEnhancement:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.BGEnhancement)
			f55_arg0.NoiseTiledBacking:completeAnimation()
			f55_arg0.NoiseTiledBacking:setAlpha(0.6)
			f55_arg0.clipFinished(f55_arg0.NoiseTiledBacking)
			f55_arg0.TiledPlusGrid:completeAnimation()
			f55_arg0.TiledPlusGrid:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.TiledPlusGrid)
			f55_arg0.DirectorQuitButtonContainer:completeAnimation()
			f55_arg0.DirectorQuitButtonContainer:setAlpha(1)
			f55_arg0.clipFinished(f55_arg0.DirectorQuitButtonContainer)
		end,
	},
	Campaign = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(0)
		end,
	},
	WZ = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(6)
			f57_arg0.BGEnhancement:completeAnimation()
			f57_arg0.BGEnhancement:setRGB(0, 0, 0)
			f57_arg0.BGEnhancement:setAlpha(0.94)
			f57_arg0.clipFinished(f57_arg0.BGEnhancement)
			f57_arg0.TiledPlusGrid:completeAnimation()
			f57_arg0.TiledPlusGrid:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.TiledPlusGrid)
			f57_arg0.Box:completeAnimation()
			f57_arg0.Box:setTopBottom(0, 0, -17, 47)
			f57_arg0.Box:setAlpha(0.8)
			f57_arg0.clipFinished(f57_arg0.Box)
			f57_arg0.DividerSolidBot:completeAnimation()
			f57_arg0.DividerSolidBot:setTopBottom(0, 0, 45, 49)
			f57_arg0.DividerSolidBot:setAlpha(0.76)
			f57_arg0.clipFinished(f57_arg0.DividerSolidBot)
			f57_arg0.SafeAreaContainer:completeAnimation()
			f57_arg0.SafeAreaContainer.CommonIdentityWidgetStreamlined:completeAnimation()
			f57_arg0.SafeAreaContainer.CommonIdentityWidgetStreamlined:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.SafeAreaContainer)
			f57_arg0.DirectorQuitButtonContainer:completeAnimation()
			f57_arg0.DirectorQuitButtonContainer:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.DirectorQuitButtonContainer)
		end,
	},
	Ingame = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(4)
			f58_arg0.BGEnhancement:completeAnimation()
			f58_arg0.BGEnhancement:setRGB(0.63, 0.24, 0.24)
			f58_arg0.BGEnhancement:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.BGEnhancement)
			f58_arg0.TopBacking:completeAnimation()
			f58_arg0.TopBacking:setAlpha(0.8)
			f58_arg0.clipFinished(f58_arg0.TopBacking)
			f58_arg0.SafeAreaContainer:completeAnimation()
			f58_arg0.SafeAreaContainer.CommonIdentityWidgetStreamlined:completeAnimation()
			f58_arg0.SafeAreaContainer.CommonIdentityWidgetStreamlined:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.SafeAreaContainer)
			f58_arg0.DirectorQuitButtonContainer:completeAnimation()
			f58_arg0.DirectorQuitButtonContainer:setAlpha(1)
			f58_arg0.clipFinished(f58_arg0.DirectorQuitButtonContainer)
		end,
	},
}
CoD.StartMenu_Main.__onClose = function(f59_arg0)
	f59_arg0.TabFrame:close()
	f59_arg0.Background:close()
	f59_arg0.MenuFrameIngame:close()
	f59_arg0.SafeAreaContainer:close()
	f59_arg0.DirectorQuitButtonContainer:close()
	f59_arg0.PCKoreaContentDescriptorsContainer:close()
end
