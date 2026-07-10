require("x64:eda152e1d10147a")
require("x64:6374709588b8a15")
CoD.SpecialistHeadquartersArchives = InheritFrom(CoD.Menu)
LUI.createMenu.SpecialistHeadquartersArchives = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SpecialistHeadquartersArchives", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.SpecialistHeadquartersArchives)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local TEMPBlackBGOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TEMPBlackBGOverlay:setRGB(0, 0, 0)
	TEMPBlackBGOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	TEMPBlackBGOverlay:setShaderVector(0, 0.01, 0.5, 0, 0)
	self:addElement(TEMPBlackBGOverlay)
	self.TEMPBlackBGOverlay = TEMPBlackBGOverlay
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -960, 960)
	TabFrame:setTopBottom(0.5, 0.5, -390, 390)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local Tabs = CoD.StartMenu_SafeAreaContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	Tabs.CommonHeader:setAlpha(0)
	Tabs.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x0))
	Tabs.BackingGrayMediumLeft:setAlpha(0)
	Tabs.TabBar.Tabs.grid:setDataSource("SpecialistNarrativeTabs")
	self:addElement(Tabs)
	self.Tabs = Tabs
	local SocialFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SocialFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	SocialFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/archives"))
	SocialFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SocialFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(SocialFrame)
	self.SocialFrame = SocialFrame
	TabFrame:linkToElementModel(Tabs.TabBar.Tabs.grid, "tabWidget", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TabFrame:changeFrameWidget(f3_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_778D439E1B360368", nil, "ESCAPE")
		return true
	end, false)
	TabFrame.id = "TabFrame"
	Tabs.id = "Tabs"
	SocialFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		SocialFrame.id = "SocialFrame"
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
	local f1_local6 = self
	SizeToSafeArea(TabFrame, f1_arg0)
	SizeToSafeArea(Tabs, f1_arg0)
	return self
end
CoD.SpecialistHeadquartersArchives.__onClose = function(f6_arg0)
	f6_arg0.TabFrame:close()
	f6_arg0.Tabs:close()
	f6_arg0.SocialFrame:close()
end
