require("x64:52cca38de53819f")
CoD.MOTD_BannerContainer = InheritFrom(LUI.UIElement)
CoD.MOTD_BannerContainer.__defaultWidth = 328
CoD.MOTD_BannerContainer.__defaultHeight = 679
CoD.MOTD_BannerContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MOTD_BannerContainer)
	self.id = "MOTD_BannerContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local MOTDBanners = LUI.UIList.new(f1_arg0, f1_arg1, 13, 0, nil, false, false, false, false)
	MOTDBanners:setLeftRight(0, 0, 0, 328)
	MOTDBanners:setTopBottom(0, 0, 0, 679)
	MOTDBanners:setWidgetType(CoD.MOTD_BannerImage)
	MOTDBanners:setVerticalCount(4)
	MOTDBanners:setSpacing(13)
	MOTDBanners:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MOTDBanners:setDataSource("MOTDBannerList")
	MOTDBanners:linkToElementModel(MOTDBanners, "action", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	MOTDBanners:appendEventHandler("record_curr_focused_elem_id", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local2 = MOTDBanners
	local f1_local3 = MOTDBanners.subscribeToModel
	local f1_local4 = DataSources.MOTDVoDPreview.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.frame, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	MOTDBanners:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.MOTDUtility.MOTD_MarkAsViewed(self, f1_arg1, self.MOTDBanners)
		return f5_local0
	end)
	MOTDBanners:registerEventHandler("list_item_lose_focus", function(element, event)
		local f6_local0 = nil
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "action", "vod") then
			CoD.ModelUtility.SetGlobalDatasourceModelValue(f1_arg1, "MOTDVoDPreview", "frame", "CoD.VoDPreviewWidgetImage")
		end
		return f6_local0
	end)
	MOTDBanners:registerEventHandler("list_active_changed", function(element, event)
		local f7_local0 = nil
		if IsPC() then
			UpdateParentElementDataSource(self, "ButtonsList")
		end
		return f7_local0
	end)
	MOTDBanners:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MOTDBanners, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "store") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "registration") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "depot") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "shop") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.BaseUtility.IsDvarEnabled("motd_inPlaceVODEnabled") and CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "vod") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "MOTDVoDPreview", "frame", "CoD.VoDPreviewWidgetVideo") then
			return true
		elseif CoD.BaseUtility.IsDvarEnabled("motd_inPlaceVODEnabled") and CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "vod") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.ModelUtility.SetGlobalDatasourceModelValue(controller, "MOTDVoDPreview", "frame", "CoD.VoDPreviewWidgetVideo")
			CoD.MOTDUtility.MOTD_MarkAsClicked(self, controller, self.MOTDBanners)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "bj_reserves") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "crate_purchase") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "inventory") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "crate_bundle") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "challenge_status") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.MOTDUtility.MOTD_IsContractAction(self, controller, element) and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		elseif CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.MOTDUtility.MOTD_AcceptAction(self, controller, menu, self.MOTDBanners)
			ResetThumbnailViewer(controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "store") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x191CDDA584B4408, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "registration") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x977A022B8323362, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "depot") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x29C903C6DF90D6F, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "shop") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x90379DA9EEC8DB9, nil, nil)
			return true
		elseif CoD.BaseUtility.IsDvarEnabled("motd_inPlaceVODEnabled") and CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "vod") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "MOTDVoDPreview", "frame", "CoD.VoDPreviewWidgetVideo") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		elseif CoD.BaseUtility.IsDvarEnabled("motd_inPlaceVODEnabled") and CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "vod") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xDDDA371285672BD, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "bj_reserves") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x655207CC013B5BD, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "crate_purchase") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xAF6650B811A502B, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "inventory") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xFF19F036B1F8248, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "crate_bundle") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xE1FEFD9287CA008, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, controller, "action", "challenge_status") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x33A50A66558D623, nil, nil)
			return true
		elseif CoD.MOTDUtility.MOTD_IsContractAction(self, controller, element) and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xE07AF27BEA3B907, nil, nil)
			return true
		elseif CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "MOTDBanners") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xAC3B80C833B60E1, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(MOTDBanners)
	self.MOTDBanners = MOTDBanners
	self:registerEventHandler("input_source_changed", function(self, event)
		local f11_local0 = nil
		if IsPC() then
			CoD.GridAndListUtility.SetListActiveOnFocusPCBehavior(self.MOTDBanners, f1_arg1)
		end
		if not f11_local0 then
			f11_local0 = self:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	self.__on_menuOpened_self = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		if IsElementReceivingMenuOpenEventForTheFirstTime(self) and IsPC() then
			CoD.GridAndListUtility.ActivateListPCSelectionBehavior(self.MOTDBanners)
			CoD.GridAndListUtility.SetListActiveOnFocusPCBehavior(self.MOTDBanners, f12_arg1)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	MOTDBanners.id = "MOTDBanners"
	self.__defaultFocus = MOTDBanners
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_BannerContainer.__onClose = function(f14_arg0)
	f14_arg0.__on_close_removeOverrides()
	f14_arg0.MOTDBanners:close()
end
