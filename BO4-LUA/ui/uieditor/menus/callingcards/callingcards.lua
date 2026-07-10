require("x64:db806626fb64f10")
require("x64:b157ebcd8b4adcc")
require("x64:7889ce1e3e2e8a")
require("x64:c7e896ee4bc3f8")
CoD.CallingCards = InheritFrom(CoD.Menu)
LUI.createMenu.CallingCards = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("CallingCards", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.CallingCards)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local MenuFrame = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_3ED22CCD3920E18B"))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -845, 845)
	TabFrame:setTopBottom(0.46, 0.46, -380, 470)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local SafeAreaTabs = CoD.Challenges_SafeAreaWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 1080)
	SafeAreaTabs.FETabBar.Tabs.grid:setDataSource("CallingCardsTabs")
	SafeAreaTabs:registerEventHandler("list_active_changed", function(element, event)
		local f3_local0 = nil
		CoD.ChallengesUtility.UpdateCardListFromTabChanged(f1_local1, element, f1_arg0)
		return f3_local0
	end)
	self:addElement(SafeAreaTabs)
	self.SafeAreaTabs = SafeAreaTabs
	local TrialWidget = CoD.TrialInfoBannerWidget.new(f1_local1, f1_arg0, 1, 1, -640, -125, 1, 1, -235, -200)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "tabCategory", "loot")
			end,
		},
	})
	TrialWidget:linkToElementModel(TrialWidget, "tabCategory", true, function(model)
		f1_local1:updateElementState(TrialWidget, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "tabCategory",
		})
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	TabFrame:linkToElementModel(SafeAreaTabs.FETabBar.Tabs.grid, "tabWidget", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TabFrame:changeFrameWidget(f6_local0)
		end
	end)
	TrialWidget:linkToElementModel(SafeAreaTabs.FETabBar.Tabs.grid, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg0)
	end)
	self:registerEventHandler("list_active_changed", function(self, event)
		local f8_local0 = nil
		CoD.ChallengesUtility.UpdateCardListFromTabChanged(f1_local1, self, f1_arg0)
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		UploadStats(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CallingCards_GoBack(self, f1_arg0)
	end)
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	MenuFrame.id = "MenuFrame"
	TabFrame.id = "TabFrame"
	SafeAreaTabs.id = "SafeAreaTabs"
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
	local f1_local7 = self
	SizeToSafeArea(SafeAreaTabs, f1_arg0)
	return self
end
CoD.CallingCards.__resetProperties = function(f12_arg0)
	f12_arg0.TabFrame:completeAnimation()
	f12_arg0.TabFrame:setAlpha(1)
end
CoD.CallingCards.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(150)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.TabFrame:beginAnimation(150)
				f13_arg0.TabFrame:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.TabFrame:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.TabFrame:completeAnimation()
			f13_arg0.TabFrame:setAlpha(0)
			f13_local0(f13_arg0.TabFrame)
		end,
	},
}
CoD.CallingCards.__onClose = function(f16_arg0)
	f16_arg0.TabFrame:close()
	f16_arg0.TrialWidget:close()
	f16_arg0.Background:close()
	f16_arg0.MenuFrame:close()
	f16_arg0.SafeAreaTabs:close()
end
