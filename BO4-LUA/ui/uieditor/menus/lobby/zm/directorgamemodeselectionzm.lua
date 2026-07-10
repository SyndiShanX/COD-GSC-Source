require("x64:ade951b2d8c4d9a")
require("x64:f6ae994925ce8e1")
require("x64:ce1e6b6549d478c")
require("x64:662addde48b6aa5")
CoD.DirectorGamemodeSelectionZM = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorGamemodeSelectionZM = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorGamemodeSelectionZM", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.CreateGlobalModel("ZMLobbyExclusions.focusedPlaylistID")
	self:setClass(CoD.DirectorGamemodeSelectionZM)
	self.soundSet = "FrontendMain"
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
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.2)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TiledPlusGrid = LUI.UIImage.new(0.5, 0.5, -1095, 960, 0, 0, 0, 1080)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local DirectorGamemodeSelectionZMInternal = CoD.DirectorGamemodeSelectionZMInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(DirectorGamemodeSelectionZMInternal)
	self.DirectorGamemodeSelectionZMInternal = DirectorGamemodeSelectionZMInternal
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local DirectorHeaderTabSafeArea = CoD.DirectorHeaderTabSafeArea.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 1080)
	DirectorHeaderTabSafeArea.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/zombies_modes"))
	DirectorHeaderTabSafeArea.Tabs.customClasssList:setDataSource("DirectorPlaylistGameTypeList")
	DirectorHeaderTabSafeArea:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorHeaderTabSafeArea.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	DirectorHeaderTabSafeArea:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(DirectorHeaderTabSafeArea)
	self.DirectorHeaderTabSafeArea = DirectorHeaderTabSafeArea
	self:mergeStateConditions({
		{
			stateName = "Featured",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.FeaturedInfo()
			end,
		},
		{
			stateName = "Classic",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.ClassicInfo()
			end,
		},
		{
			stateName = "ZombieRush",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.ZombieRushInfo()
			end,
		},
		{
			stateName = "TCM",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.TCMInfo()
			end,
		},
		{
			stateName = "Trials",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.TrialsInfo()
			end,
		},
		{
			stateName = "Tutorial",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.TutorialInfo()
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local10, f1_local12["ZMLobbyExclusions.ZMPlaylistTab"], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "ZMLobbyExclusions.ZMPlaylistTab",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local10, f1_local12["ZMLobbyExclusions.ZMPlaylistTab"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_start"])
	end, false)
	self:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f13_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_start"])
	end)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local11(f1_local10, f1_local12.LastInput, function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_start"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_start"], nil, function(element, menu, controller, model)
		if CoD.ZombieUtility.TrialsInfo() and IsGamepad(controller) then
			OpenOverlay(self, "DirectorZMTrialsInfo", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ZombieUtility.TrialsInfo() and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"hash_4AB419DD8BD872BA", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.DirectorUtility.UpdateChosenPlaylist(f1_arg0)
		ClearMenuSavedState(f1_local1)
	end)
	DirectorGamemodeSelectionZMInternal.id = "DirectorGamemodeSelectionZMInternal"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	DirectorHeaderTabSafeArea.id = "DirectorHeaderTabSafeArea"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = DirectorGamemodeSelectionZMInternal
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local11 = self
	CoD.ZombieUtility.SetFocusedPlaylistIDToLobbyPlaylistID(f1_arg0)
	CoD.ZombieUtility.SubscribeToZMPlaylistInfoModels(self, f1_arg0)
	return self
end
CoD.DirectorGamemodeSelectionZM.__onClose = function(f20_arg0)
	f20_arg0.DirectorGamemodeSelectionZMInternal:close()
	f20_arg0.FooterContainerFrontendRight:close()
	f20_arg0.DirectorHeaderTabSafeArea:close()
end
