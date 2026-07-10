require("x64:8b53d2ba8e4b74c")
require("x64:8a564360a773656")
require("x64:4bb610f0602df09")
require("x64:8904074a6536944")
require("x64:f88675da04d26fd")
require("x64:2136d2b295cb55e")
require("x64:ce1e6b6549d478c")
require("x64:75e2a524b093c12")
CoD.WeaponPersonalization = InheritFrom(CoD.Menu)
LUI.createMenu.WeaponPersonalization = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WeaponPersonalization", f1_arg0)
	local f1_local1 = self
	SetModelToGlobalDataSource(f1_arg0, self, "WeaponPersonalization")
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SetControllerModelValue(f1_arg0, "WeaponPersonalization.listUpdate", 0)
	CoD.WeaponOptionsUtility.SetWeaponOptionsCategory(f1_local1, f1_arg0)
	CoD.WeaponOptionsUtility.SetupWeaponPersonalizationMenuModels(f1_local1, f1_arg0)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "armoryAttachmentUpdated")
	CoD.WeaponOptionsUtility.InitPaintCansCountModel(f1_arg0)
	self:setClass(CoD.WeaponPersonalization)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 146, 646)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackgroundSlidePanel = CoD.cac_background_slide_panel_short.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 0.5, 75, 697)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local WeaponOptionInfo = CoD.WeaponOptionInfo.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -76, 68)
	WeaponOptionInfo:linkToElementModel(self, nil, false, function(model)
		WeaponOptionInfo:setModel(model, f1_arg0)
	end)
	self:addElement(WeaponOptionInfo)
	self.WeaponOptionInfo = WeaponOptionInfo
	local HeaderContainer = CoD.WeaponPersonalizationHeaderContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	HeaderContainer:linkToElementModel(self, nil, false, function(model)
		HeaderContainer:setModel(model, f1_arg0)
	end)
	HeaderContainer:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(HeaderContainer)
	self.HeaderContainer = HeaderContainer
	local PaintCanCount = CoD.PaintCanCount.new(f1_local1, f1_arg0, 0.5, 0.5, -798, -618, 0, 0, 115.5, 247.5)
	self:addElement(PaintCanCount)
	self.PaintCanCount = PaintCanCount
	local PrestigeAttachmentGrid = CoD.PrestigeAttachmentGrid.new(f1_local1, f1_arg0, 0.5, 0.5, 390, 790, 0, 0, 131.5, 231.5)
	PrestigeAttachmentGrid:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.IsCurrentLootSeasonAtLeast(4)
			end,
		},
	})
	local f1_local9 = PrestigeAttachmentGrid
	local OptionsContainer = PrestigeAttachmentGrid.subscribeToModel
	local f1_local11 = DataSources.AutoEvents.getModel(f1_arg0)
	OptionsContainer(f1_local9, f1_local11.cycled, function(f7_arg0)
		f1_local1:updateElementState(PrestigeAttachmentGrid, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	self:addElement(PrestigeAttachmentGrid)
	self.PrestigeAttachmentGrid = PrestigeAttachmentGrid
	OptionsContainer = CoD.WeaponPersonalizationOptionsContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -842.5, 902.5, 0.5, 0.5, 143, 413)
	OptionsContainer:linkToElementModel(self, nil, false, function(model)
		OptionsContainer:setModel(model, f1_arg0)
	end)
	self:addElement(OptionsContainer)
	self.OptionsContainer = OptionsContainer
	WeaponOptionInfo:linkToElementModel(HeaderContainer.CategoryList.Tabs.grid, nil, false, function(model)
		WeaponOptionInfo.CamoOriginWidget:setModel(model, f1_arg0)
	end)
	OptionsContainer:linkToElementModel(OptionsContainer.CamoOptions.CamoFilterList, "frameWidget", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			OptionsContainer.CamoListFrame:changeFrameWidget(f10_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
		DelayGoBack(menu, controller, 200)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_778D439E1B360368", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		PaintshopWeaponList_Back(self, element, f1_arg0)
		ClearMenuSavedState(f1_local1)
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	HeaderContainer.id = "HeaderContainer"
	PrestigeAttachmentGrid.id = "PrestigeAttachmentGrid"
	OptionsContainer.id = "OptionsContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = OptionsContainer
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local9 = self
	CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	CoD.WeaponOptionsUtility.ResetWeaponOptions(f1_local1, f1_arg0)
	UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
	CoD.BreadcrumbUtility.UpdateWeaponAccessoryBreadcrumbs(f1_local1, f1_arg0)
	CoD.BreadcrumbUtility.UpdateWeaponDeathFxBreadcrumbs(f1_local1, f1_arg0)
	CoD.BreadcrumbUtility.UpdateWeaponCamoBreadcrumbs(f1_local1, f1_arg0)
	return self
end
CoD.WeaponPersonalization.__resetProperties = function(f14_arg0)
	f14_arg0.BackgroundSlidePanel:completeAnimation()
	f14_arg0.BackgroundSlidePanel:setTopBottom(0.5, 0.5, 75, 697)
	f14_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.WeaponPersonalization.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.BackgroundSlidePanel:completeAnimation()
			f15_arg0.BackgroundSlidePanel:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.BackgroundSlidePanel)
		end,
		Open = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f18_arg0:setTopBottom(0.5, 0.5, 75, 697)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.BackgroundSlidePanel:beginAnimation(100)
				f16_arg0.BackgroundSlidePanel:setTopBottom(0.5, 0.5, 275, 897)
				f16_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.BackgroundSlidePanel:completeAnimation()
			f16_arg0.BackgroundSlidePanel:setTopBottom(0.5, 0.5, 475, 1097)
			f16_arg0.BackgroundSlidePanel:setAlpha(0)
			f16_local0(f16_arg0.BackgroundSlidePanel)
		end,
		Close = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f20_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
				f20_arg0:setTopBottom(0.5, 0.5, 275, 897)
				f20_arg0:setAlpha(0)
				f20_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.BackgroundSlidePanel:beginAnimation(50)
			f19_arg0.BackgroundSlidePanel:setTopBottom(0.5, 0.5, 75, 697)
			f19_arg0.BackgroundSlidePanel:setAlpha(1)
			f19_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
			f19_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f19_local0)
		end,
	},
}
CoD.WeaponPersonalization.__onClose = function(f21_arg0)
	f21_arg0.WeaponOptionInfo:close()
	f21_arg0.OptionsContainer:close()
	f21_arg0.XCamMouseControl:close()
	f21_arg0.BackgroundSlidePanel:close()
	f21_arg0.FooterContainerFrontendRight:close()
	f21_arg0.HeaderContainer:close()
	f21_arg0.PaintCanCount:close()
	f21_arg0.PrestigeAttachmentGrid:close()
end
