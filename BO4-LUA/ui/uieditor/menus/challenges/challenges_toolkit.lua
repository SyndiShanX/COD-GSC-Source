require("x64:db806626fb64f10")
require("x64:78d9663be3f826")
require("x64:81a24c5340caa1e")
CoD.Challenges_Toolkit = InheritFrom(CoD.Menu)
LUI.createMenu.Challenges_Toolkit = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Challenges_Toolkit", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Challenges_Toolkit)
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
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.9)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -862.5, 862.5)
	TabFrame:setTopBottom(0.5, 0.5, -380, 400)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local TabBacking = CoD.CommonTabBarBacking.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 1344, 0, 0, 52, 89)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local MenuFrame = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_1677D363E896D453"))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local FETabBar = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0, 0, 0, 1928, 0, 0, 36, 98)
	FETabBar.Tabs.grid:setHorizontalCount(9)
	FETabBar.Tabs.grid:setDataSource("ToolkitTabs")
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
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
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
CoD.Challenges_Toolkit.__resetProperties = function(f8_arg0)
	f8_arg0.FETabBar:completeAnimation()
	f8_arg0.FETabBar:setLeftRight(0, 0, 0, 1928)
end
CoD.Challenges_Toolkit.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.FETabBar:completeAnimation()
			f10_arg0.FETabBar:setLeftRight(0.5, 0.5, -964, 964)
			f10_arg0.clipFinished(f10_arg0.FETabBar)
		end,
	},
}
CoD.Challenges_Toolkit.__onClose = function(f11_arg0)
	f11_arg0.TabFrame:close()
	f11_arg0.TabBacking:close()
	f11_arg0.MenuFrame:close()
	f11_arg0.FETabBar:close()
end
