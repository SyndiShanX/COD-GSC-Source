require("x64:71d4e66447f837e")
require("x64:7889ce1e3e2e8a")
require("x64:6374709588b8a15")
require("x64:268b19728179583")
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
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
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
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
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
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
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
	DividerSolidBot:setImage(RegisterImage(0x84B43D5B04D263A))
	DividerSolidBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DividerSolidBot:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidBot:setupNineSliceShader(8, 4)
	self:addElement(DividerSolidBot)
	self.DividerSolidBot = DividerSolidBot
	local SafeAreaContainer = CoD.StartMenu_SafeAreaContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SafeAreaContainer.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x4DC58203AB2DE0))
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
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(DirectorQuitButtonContainer, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		if IsPC() then
			OpenPCQuit(self, menu, self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "MOUSE1")
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
	local f1_local17 = Engine[0x8DF2E5447F384B9]()
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
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyMainMode"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
	end, false)
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f16_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local16(f1_local15, f1_local17.LastInput, function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local16(f1_local15, f1_local17["PositionDraft.stage"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	self:appendEventHandler("on_session_start", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	self:appendEventHandler("on_session_end", function(f20_arg0, f20_arg1)
		f20_arg1.menu = f20_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f20_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local16(f1_local15, f1_local17["hudItems.hasStartedWZMatch"], function(f21_arg0, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f22_local0 = nil
		if self.menuLoaded then
			f22_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f22_local0 = self.super:menuLoaded(event)
		end
		PlaySoundSetSound(self, "menu_enter")
		FileshareGetSlots(self, self, f1_arg0)
		SetHeadingKickerTextToGameMode()
		if not f22_local0 then
			f22_local0 = self:dispatchEventToChildren(event)
		end
		return f22_local0
	end)
	self:registerEventHandler("close_all_ingame_menus", function(self, event)
		local f23_local0 = nil
		StartMenuGoBack(f1_local1, f1_arg0)
		if not f23_local0 then
			f23_local0 = self:dispatchEventToChildren(event)
		end
		return f23_local0
	end)
	self:registerEventHandler("open_migration_menu", function(self, event)
		local f24_local0 = nil
		StartMenuGoBack(f1_local1, f1_arg0)
		if not f24_local0 then
			f24_local0 = self:dispatchEventToChildren(event)
		end
		return f24_local0
	end)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f25_local0 = nil
		if self.OcclusionChange then
			f25_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f25_local0 = self.super:OcclusionChange(event)
		end
		if IsPC() and IsWarzone() and IsInGame() then
			CoD.WZUtility.ClosePCSplitterWidget(self, f1_local1, f1_arg0)
		end
		if not f25_local0 then
			f25_local0 = self:dispatchEventToChildren(event)
		end
		return f25_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if InFrontend() then
			CoD.BaseUtility.SwitchModeOnMenu(controller)
			RefreshLobbyRoom(menu, controller)
			CoD.StartMenuUtility.CleanUpBarracksTab(menu, controller)
			StartMenuGoBack(menu, controller)
			CoD.LobbyUtility.SetMenuControllerRestriction(self, controller, 0)
			return true
		elseif not IsPC() and not IsDemoPlaying() then
			CoD.BaseUtility.SwitchModeOnMenu(controller)
			RefreshLobbyRoom(menu, controller)
			StartMenuGoBack(menu, controller)
			return true
		elseif IsPC() and not IsDemoPlaying() then
			CoD.BaseUtility.SwitchModeOnMenu(controller)
			RefreshLobbyRoom(menu, controller)
			StartMenuGoBack(menu, controller)
			return true
		elseif IsPC() and IsDemoPlaying() then
			CoD.DemoUtility.RunPauseCommandIfNotPlayerPause(controller)
			RefreshLobbyRoom(menu, controller)
			StartMenuGoBack(menu, controller)
			return true
		elseif IsDemoPlaying() and not IsPC() then
			RefreshLobbyRoom(menu, controller)
			StartMenuGoBack(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if InFrontend() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif not IsPC() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x3996BAAC73C3F6D, nil, nil)
			return true
		elseif IsPC() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif IsPC() and IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif IsDemoPlaying() and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.NextWeapon(controller)
			return true
		elseif IsInGame() and not IsLobbyNetworkModeLAN() and not IsDemoPlaying() and not IsPC() and not IsGameTypeCombatTraining() then
			OpenOverlay(self, "Social_Main", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x0, nil, nil)
			return false
		elseif IsInGame() and not IsLobbyNetworkModeLAN() and not IsDemoPlaying() and not IsPC() and not IsGameTypeCombatTraining() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x478E0BA47CFB4A8, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "weapnext", function(element, menu, controller, model)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.NextWeapon(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "weapnext")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "weapprev", function(element, menu, controller, model)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.PrevWeapon(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "weapprev")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "weapswitchprimary", function(element, menu, controller, model)
		if IsPC() and IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.SwitchToWeaponInSlot(controller, 0)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "weapswitchprimary")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "weapswitchsecondary", function(element, menu, controller, model)
		if IsPC() and IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.WZUtility.SwitchToWeaponInSlot(controller, 1)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and IsWarzone() and IsInGame() and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "weapswitchsecondary")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "F1", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and CoD.DirectorUtility.IsMainMode(controller, Enum[0x89C1455C5032969][0x7E41449995CD57E]) and not InFrontend() and AlwaysFalse() then
			CoD.StartMenuUtility.ShowClassSelectSlideout(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and CoD.DirectorUtility.IsMainMode(controller, Enum[0x89C1455C5032969][0x7E41449995CD57E]) and not InFrontend() and AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "F1")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A], nil, function(element, menu, controller, model)
		if IsPC() and IsGamepad(controller) then
			RefreshLobbyRoom(menu, controller)
			StartMenuGoBack(menu, controller)
			return true
		else
			RefreshLobbyRoom(menu, controller)
			StartMenuGoBack(menu, controller)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x0, nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.StartMenuUtility.CanChangeWZStatsFilter(menu, self.TabFrame, controller) then
			CoD.PlayerStatsUtility.UpdateWZStatsFilter(controller)
			PlaySoundAlias("uin_stats_switch")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.StartMenuUtility.CanChangeWZStatsFilter(menu, self.TabFrame, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_contextual_2", function(element, menu, controller, model)
		if IsPC() and CoD.PCUtility.CanShowLeaveGameButton(menu, controller) then
			QuitPCGame_MP(self, controller, false)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCUtility.CanShowLeaveGameButton(menu, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_contextual_2")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_contextual_1", function(element, menu, controller, model)
		if IsPC() and CoD.PCUtility.CanShowStartWarzoneButton(menu, controller) then
			CoD.WZUtility.StartWarzone(controller)
			SetControllerModelValue(controller, "hudItems.hasStartedWZMatch", true)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.PCUtility.CanShowStartWarzoneButton(menu, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_contextual_1")
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
