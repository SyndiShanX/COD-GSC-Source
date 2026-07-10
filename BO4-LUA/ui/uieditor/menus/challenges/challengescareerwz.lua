require("x64:db806626fb64f10")
require("x64:b74057f7884b1f5")
CoD.ChallengesCareerWZ = InheritFrom(CoD.Menu)
LUI.createMenu.ChallengesCareerWZ = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ChallengesCareerWZ", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ChallengesCareerWZ)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.9)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -862.5, 862.5)
	TabFrame:setTopBottom(0.5, 0.5, -372, 408)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local MenuFrame = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x1BEB13BCC1D1E4E))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local FETabBar = CoD.StartMenu_challengesCareerTab.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 62)
	FETabBar:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	FETabBar:registerEventHandler("list_active_changed", function(element, event)
		local f4_local0 = nil
		CoD.ChallengesUtility.UpdateCardListFromTabChanged(f1_local1, element, f1_arg0)
		return f4_local0
	end)
	self:addElement(FETabBar)
	self.FETabBar = FETabBar
	TabFrame:linkToElementModel(FETabBar.FETabBar.Tabs.grid, "tabWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TabFrame:changeFrameWidget(f5_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	TabFrame.id = "TabFrame"
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	MenuFrame.id = "MenuFrame"
	FETabBar.id = "FETabBar"
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
	return self
end
CoD.ChallengesCareerWZ.__onClose = function(f8_arg0)
	f8_arg0.TabFrame:close()
	f8_arg0.MenuFrame:close()
	f8_arg0.FETabBar:close()
end
