require("x64:78d9663be3f826")
require("x64:81a24c5340caa1e")
require("x64:c7ee4ce0a7a0397")
require("x64:4cee61320cd1f1b")
CoD.ItemShopTabBarContainer = InheritFrom(LUI.UIElement)
CoD.ItemShopTabBarContainer.__defaultWidth = 1920
CoD.ItemShopTabBarContainer.__defaultHeight = 1080
CoD.ItemShopTabBarContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopTabBarContainer)
	self.id = "ItemShopTabBarContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	TabBacking:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local FETabBar = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 36, 97)
	FETabBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsOfflineOnlyDemo() and InFrontend()
			end,
		},
	})
	FETabBar:appendEventHandler("grid_updated", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FETabBar, f4_arg1)
	end)
	FETabBar:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FETabBar, f5_arg1)
	end)
	local f1_local3 = FETabBar
	local StartMenuCODpoints = FETabBar.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	StartMenuCODpoints(f1_local3, f1_local5.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(FETabBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	FETabBar.Tabs.grid:setWidgetType(CoD.QuarterMasterTab)
	FETabBar.Tabs.grid:setDataSource("QuarterMasterCategoryList")
	self:addElement(FETabBar)
	self.FETabBar = FETabBar
	StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_arg0, f1_arg1, 0.5, 0.5, 550, 654, 0, 0, -11, 69)
	StartMenuCODpoints:setAlpha(0)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "codPoints", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f7_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not AreCodPointsEnabled(f1_arg1)
			end,
		},
	})
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local5, f1_local6["lobbyRoot.lobbyNetworkMode"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	FETabBar.id = "FETabBar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	DisableKeyboardNavigationByElement(FETabBar)
	return self
end
CoD.ItemShopTabBarContainer.__resetProperties = function(f10_arg0)
	f10_arg0.FETabBar:completeAnimation()
	f10_arg0.TabBacking:completeAnimation()
	f10_arg0.FETabBar:setAlpha(1)
	f10_arg0.TabBacking:setAlpha(1)
end
CoD.ItemShopTabBarContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.TabBacking:completeAnimation()
			f11_arg0.TabBacking:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.TabBacking)
			f11_arg0.FETabBar:completeAnimation()
			f11_arg0.FETabBar:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FETabBar)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.TabBacking:completeAnimation()
			f12_arg0.TabBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TabBacking)
			f12_arg0.FETabBar:completeAnimation()
			f12_arg0.FETabBar:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.FETabBar)
		end,
	},
}
CoD.ItemShopTabBarContainer.__onClose = function(f13_arg0)
	f13_arg0.TabBacking:close()
	f13_arg0.FETabBar:close()
	f13_arg0.StartMenuCODpoints:close()
end
