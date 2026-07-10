require("x64:db806626fb64f10")
require("x64:78d9663be3f826")
require("x64:81a24c5340caa1e")
CoD.Challenges_Expert = InheritFrom(CoD.Menu)
LUI.createMenu.Challenges_Expert = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Challenges_Expert", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Challenges_Expert)
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
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -862.5, 862.5)
	TabFrame:setTopBottom(0.5, 0.5, -380, 400)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local TabBacking = CoD.CommonTabBarBacking.new(f1_local1, f1_arg0, 0.5, 0.5, -1152, 1152, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local MenuFrame = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_6892ED10E8BF4877"))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local FETabBar = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0.5, 0.5, -964, 964, 0, 0, 36, 98)
	FETabBar.Tabs.grid:setHorizontalCount(9)
	FETabBar.Tabs.grid:setDataSource("ExpertTabs")
	FETabBar:registerEventHandler("list_active_changed", function(element, event)
		local f3_local0 = nil
		CoD.ChallengesUtility.UpdateCardListFromTabChanged(f1_local1, element, f1_arg0)
		return f3_local0
	end)
	self:addElement(FETabBar)
	self.FETabBar = FETabBar
	TabFrame:linkToElementModel(FETabBar.Tabs.grid, "tabWidget", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TabFrame:changeFrameWidget(f4_local0)
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
CoD.Challenges_Expert.__onClose = function(f7_arg0)
	f7_arg0.TabFrame:close()
	f7_arg0.TabBacking:close()
	f7_arg0.MenuFrame:close()
	f7_arg0.FETabBar:close()
end
