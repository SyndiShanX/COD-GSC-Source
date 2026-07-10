require("x64:78d9663be3f826")
require("x64:d6ecdf7755aeddc")
require("x64:bc6e2379d2241fb")
require("x64:81a24c5340caa1e")
require("x64:e41af73729601d6")
CoD.StartMenu_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.StartMenu_SafeAreaContainer.__defaultWidth = 1920
CoD.StartMenu_SafeAreaContainer.__defaultHeight = 1080
CoD.StartMenu_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_SafeAreaContainer)
	self.id = "StartMenu_SafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -0.25, 1.25, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x4DC58203AB2DE0))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyMainMode", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f2_local0)))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local TabBar = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 35.5, 96.5)
	TabBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsOfflineOnlyDemo() and InFrontend()
			end,
		},
	})
	TabBar:appendEventHandler("grid_updated", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(TabBar, f4_arg1)
	end)
	TabBar:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(TabBar, f5_arg1)
	end)
	local f1_local5 = TabBar
	local CommonIdentityWidgetStreamlined = TabBar.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	CommonIdentityWidgetStreamlined(f1_local5, f1_local7.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(TabBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	TabBar.Tabs.grid:setDataSource("StartMenuTabs")
	self:addElement(TabBar)
	self.TabBar = TabBar
	CommonIdentityWidgetStreamlined = CoD.CommonIdentityWidgetStreamlined.new(f1_arg0, f1_arg1, 0.5, 0.5, 388, 918, 0, 0, 9, 49)
	CommonIdentityWidgetStreamlined:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlined:setModel(model, f1_arg1)
	end)
	self:addElement(CommonIdentityWidgetStreamlined)
	self.CommonIdentityWidgetStreamlined = CommonIdentityWidgetStreamlined
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
	f1_local7 = self
	f1_local5 = self.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local7, f1_local8["lobbyRoot.lobbyNav"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	TabBar.id = "TabBar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_SafeAreaContainer.__resetProperties = function(f14_arg0)
	f14_arg0.CommonHeader:completeAnimation()
	f14_arg0.TabBacking:completeAnimation()
	f14_arg0.BackingGrayMediumLeft:completeAnimation()
	f14_arg0.TabBar:completeAnimation()
	f14_arg0.CommonHeader:setAlpha(1)
	f14_arg0.CommonHeader.background2:setAlpha(0.9)
	f14_arg0.TabBacking:setTopBottom(0, 0, 52, 89)
	f14_arg0.TabBacking:setAlpha(1)
	f14_arg0.TabBacking:setScale(1, 1)
	f14_arg0.TabBacking.TabBackingBlur:setAlpha(0)
	f14_arg0.TabBacking.TabBackingTint:setAlpha(0)
	f14_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, 0, 42)
	f14_arg0.BackingGrayMediumLeft:setAlpha(1)
	f14_arg0.TabBar:setTopBottom(0, 0, 35.5, 96.5)
end
CoD.StartMenu_SafeAreaContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	IsFrontEnd = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.TabBacking:completeAnimation()
			f16_arg0.TabBacking:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.TabBacking)
			f16_arg0.CommonHeader:completeAnimation()
			f16_arg0.CommonHeader:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.CommonHeader)
			f16_arg0.BackingGrayMediumLeft:completeAnimation()
			f16_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, 0, 42)
			f16_arg0.BackingGrayMediumLeft:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.BackingGrayMediumLeft)
		end,
	},
	Zombies = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.TabBar:completeAnimation()
			f17_arg0.TabBar:setTopBottom(0, 0, 35.5, 96.5)
			f17_arg0.clipFinished(f17_arg0.TabBar)
		end,
	},
	Campaign = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	WZ = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.TabBacking:completeAnimation()
			f19_arg0.TabBacking:setTopBottom(0, 0, -29, 3)
			f19_arg0.TabBacking:setScale(1, 3)
			f19_arg0.clipFinished(f19_arg0.TabBacking)
			f19_arg0.TabBar:completeAnimation()
			f19_arg0.TabBar:setTopBottom(0, 0, -6, 55)
			f19_arg0.clipFinished(f19_arg0.TabBar)
		end,
	},
	Ingame = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.TabBacking:completeAnimation()
			f20_arg0.TabBacking.TabBackingBlur:completeAnimation()
			f20_arg0.TabBacking.TabBackingTint:completeAnimation()
			f20_arg0.TabBacking.TabBackingBlur:setAlpha(1)
			f20_arg0.TabBacking.TabBackingTint:setAlpha(0.64)
			f20_arg0.clipFinished(f20_arg0.TabBacking)
			f20_arg0.CommonHeader:completeAnimation()
			f20_arg0.CommonHeader.background2:completeAnimation()
			f20_arg0.CommonHeader.background2:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.CommonHeader)
		end,
	},
}
CoD.StartMenu_SafeAreaContainer.__onClose = function(f21_arg0)
	f21_arg0.TabBacking:close()
	f21_arg0.CommonHeader:close()
	f21_arg0.BackingGrayMediumLeft:close()
	f21_arg0.TabBar:close()
	f21_arg0.CommonIdentityWidgetStreamlined:close()
end
