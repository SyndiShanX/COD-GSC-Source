require("x64:eda152e1d10147a")
require("x64:78d9663be3f826")
require("x64:71d2a0ed724628e")
require("x64:329a92dee2ea1ff")
require("x64:7889ce1e3e2e8a")
CoD.Barracks_Medals = InheritFrom(CoD.Menu)
LUI.createMenu.Barracks_Medals = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Barracks_Medals", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.Barracks_Medals)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local MedalTabsInternal = CoD.MedalsTabInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 183, 955)
	MedalTabsInternal.MedalsGrid:setDataSource("MedalsList")
	self:addElement(MedalTabsInternal)
	self.MedalTabsInternal = MedalTabsInternal
	local MedalsTab = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0.5, 0.5, -1650, 1650, 0, 0, 82, 143)
	MedalsTab:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = MedalsTab
	local SocialFrame = MedalsTab.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	SocialFrame(CommonIdentityWidgetStreamlinedSafeAreaContainer, f1_local7["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_local1:updateElementState(MedalsTab, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	MedalsTab:appendEventHandler("grid_updated", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		f1_local1:updateElementState(MedalsTab, f4_arg1)
	end)
	MedalsTab:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_local1
		f1_local1:updateElementState(MedalsTab, f5_arg1)
	end)
	CommonIdentityWidgetStreamlinedSafeAreaContainer = MedalsTab
	SocialFrame = MedalsTab.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg0)
	SocialFrame(CommonIdentityWidgetStreamlinedSafeAreaContainer, f1_local7.LastInput, function(f6_arg0)
		f1_local1:updateElementState(MedalsTab, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	MedalsTab.Tabs.grid:setDataSource("MPMedalTabs")
	MedalsTab:registerEventHandler("list_active_changed", function(element, event)
		local f7_local0 = nil
		SetElementProperty(f1_local1, "_sortFunc", element.sortFunc)
		SetElementProperty(f1_local1, "_category", element.category)
		CoD.PlayerStatsUtility.MedalsTabChanged(self.MedalTabsInternal)
		return f7_local0
	end)
	self:addElement(MedalsTab)
	self.MedalsTab = MedalsTab
	SocialFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SocialFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_8F69F5BDD4F7C26"))
	SocialFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			SocialFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	self:addElement(SocialFrame)
	self.SocialFrame = SocialFrame
	CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	MedalTabsInternal:linkToElementModel(MedalTabsInternal.MedalsGrid, nil, false, function(model)
		MedalTabsInternal.MedalPreviewWidget:setModel(model, f1_arg0)
	end)
	self:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local8 = self
	f1_local7 = self.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local8, f1_local9["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
		return true
	end, false)
	MedalTabsInternal.id = "MedalTabsInternal"
	MedalsTab.id = "MedalsTab"
	SocialFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		SocialFrame.id = "SocialFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = MedalTabsInternal
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.Barracks_Medals.__resetProperties = function(f15_arg0)
	f15_arg0.MedalsTab:completeAnimation()
	f15_arg0.MedalsTab:setAlpha(1)
end
CoD.Barracks_Medals.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Warzone = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.MedalsTab:completeAnimation()
			f17_arg0.MedalsTab:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.MedalsTab)
		end,
	},
}
CoD.Barracks_Medals.__onClose = function(f18_arg0)
	f18_arg0.MedalTabsInternal:close()
	f18_arg0.Background:close()
	f18_arg0.MedalsTab:close()
	f18_arg0.SocialFrame:close()
	f18_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
end
