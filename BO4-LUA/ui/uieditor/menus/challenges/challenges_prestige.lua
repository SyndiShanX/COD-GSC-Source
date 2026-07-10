require("x64:db806626fb64f10")
require("x64:b157ebcd8b4adcc")
CoD.Challenges_Prestige = InheritFrom(CoD.Menu)
LUI.createMenu.Challenges_Prestige = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Challenges_Prestige", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Challenges_Prestige)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.9)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -862.5, 862.5)
	TabFrame:setTopBottom(0.5, 0.5, -372, 408)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local MenuFrame = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"challenge/prestige"))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local SafeAreaWidget = CoD.Challenges_SafeAreaWidget.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	SafeAreaWidget.FETabBar.Tabs.grid:setHorizontalCount(10)
	SafeAreaWidget.FETabBar.Tabs.grid:setDataSource("PrestigeTabs")
	SafeAreaWidget:registerEventHandler("list_active_changed", function(element, event)
		local f3_local0 = nil
		CoD.ChallengesUtility.UpdateCardListFromTabChanged(f1_local1, element, f1_arg0)
		return f3_local0
	end)
	SafeAreaWidget:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(SafeAreaWidget)
	self.SafeAreaWidget = SafeAreaWidget
	TabFrame:linkToElementModel(SafeAreaWidget.FETabBar.Tabs.grid, "tabWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TabFrame:changeFrameWidget(f5_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	TabFrame.id = "TabFrame"
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	MenuFrame.id = "MenuFrame"
	SafeAreaWidget.id = "SafeAreaWidget"
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
CoD.Challenges_Prestige.__onClose = function(f8_arg0)
	f8_arg0.TabFrame:close()
	f8_arg0.MenuFrame:close()
	f8_arg0.SafeAreaWidget:close()
end
