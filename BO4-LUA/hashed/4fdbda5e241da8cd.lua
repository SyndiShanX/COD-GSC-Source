require("x64:ffc2c7e4adad795")
require("x64:78d9663be3f826")
require("x64:d6ecdf7755aeddc")
require("x64:81a24c5340caa1e")
require("x64:e41af73729601d6")
CoD.WeaponPersonalizationHeaderContainer = InheritFrom(LUI.UIElement)
CoD.WeaponPersonalizationHeaderContainer.__defaultWidth = 1920
CoD.WeaponPersonalizationHeaderContainer.__defaultHeight = 1080
CoD.WeaponPersonalizationHeaderContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPersonalizationHeaderContainer)
	self.id = "WeaponPersonalizationHeaderContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, 0, 0, -192, 2112, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(Engine[0xF9F1239CFD921FE](CoD.WeaponOptionsUtility.GetWeaponPersonalizationHeader(f1_arg0, f1_arg1, 0xF5D230DCF3311CC)))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local CategoryList = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 35.5, 96.5)
	CategoryList.Tabs.grid:setWidgetType(CoD.CACTextTab)
	CategoryList.Tabs.grid:setDataSource("WeaponOptionsGroups")
	CategoryList:registerEventHandler("list_active_changed", function(element, event)
		local f3_local0 = nil
		if CoD.BaseUtility.IsWidgetVisible(element) and IsPC() then
			CoD.WeaponOptionsUtility.SetWeaponOptionsFilterFromTab(f1_arg0, element)
			DelayForceNotifyControllerModel(element, f1_arg1, "WeaponPersonalization.listUpdate", 0)
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_arg0, f1_arg0, f1_arg1)
			ForceCheckDefaultPCFocus(f1_arg0, f1_arg0, f1_arg1)
		elseif CoD.BaseUtility.IsWidgetVisible(element) then
			CoD.WeaponOptionsUtility.SetWeaponOptionsFilterFromTab(f1_arg0, element)
			ForceNotifyControllerModel(f1_arg1, "WeaponPersonalization.listUpdate")
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_arg0, f1_arg0, f1_arg1)
		end
		return f3_local0
	end)
	self.__on_menuOpened_CategoryList = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		local f4_local0 = CategoryList
		if not IsElementPropertyValue(f4_local0, "_receivedMenuOpen", true) then
			SetElementProperty(f4_local0, "_receivedMenuOpen", true)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_CategoryList)
	self:addElement(CategoryList)
	self.CategoryList = CategoryList
	CategoryList.id = "CategoryList"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_CategoryList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPersonalizationHeaderContainer.__onClose = function(f6_arg0)
	f6_arg0.__on_close_removeOverrides()
	f6_arg0.TabBacking:close()
	f6_arg0.CommonHeader:close()
	f6_arg0.BackingGrayMediumLeft:close()
	f6_arg0.CategoryList:close()
end
