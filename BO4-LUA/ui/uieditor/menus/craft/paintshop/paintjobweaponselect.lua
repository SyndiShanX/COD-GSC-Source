require("x64:f792a7ef58d5981")
require("x64:1827e15981384e2")
require("x64:bfdb5df2cebf5b2")
require("x64:317e754536a5528")
require("x64:75e2a524b093c12")
CoD.PaintjobWeaponSelect = InheritFrom(CoD.Menu)
LUI.createMenu.PaintjobWeaponSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PaintjobWeaponSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SetControllerModelValue(f1_arg0, "isInPaintshop", true)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "PaintjobWeaponVariantListShown", false)
	self:setClass(CoD.PaintjobWeaponSelect)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 183, 683)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackgroundSlidePanel = CoD.cac_background_slide_panel.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 672, 1294)
	BackgroundSlidePanel:setZoom(70)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, -792, -292, 0, 0, 451.5, 558.5)
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	local PaintshopWeaponSelectWidget = CoD.PaintshopWeaponSelectWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	PaintshopWeaponSelectWidget:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(PaintshopWeaponSelectWidget)
	self.PaintshopWeaponSelectWidget = PaintshopWeaponSelectWidget
	local PaintjobWeaponSelectSafeAreaContainer = CoD.PaintjobWeaponSelectSafeAreaContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	PaintjobWeaponSelectSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(PaintjobWeaponSelectSafeAreaContainer)
	self.PaintjobWeaponSelectSafeAreaContainer = PaintjobWeaponSelectSafeAreaContainer
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9.PaintjobWeaponVariantListShown, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsControllerModelValueTrue(controller, "PaintjobWeaponVariantListShown") then
			PlaySoundAlias("uin_party_ease_slide_back")
			GoBack(self, controller)
			return true
		elseif CoD.ModelUtility.IsControllerModelValueTrue(controller, "PaintjobWeaponVariantListShown") then
			PlaySoundAlias("uin_party_ease_slide_back")
			CoD.CACUtility.HideWeaponVariantList(menu, controller)
			SetControllerModelValue(controller, "PaintjobWeaponVariantListShown", false)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsControllerModelValueTrue(controller, "PaintjobWeaponVariantListShown") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif CoD.ModelUtility.IsControllerModelValueTrue(controller, "PaintjobWeaponVariantListShown") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.BreadcrumbUtility.UploadBuffer(f1_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		SetControllerModelValue(f1_arg0, "isInPaintshop", false)
		SendClientScriptNotifyForAdjustedClient(f1_arg0, "CustomClass_closed", "")
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		ClearMenuSavedState(f1_local1)
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	PaintshopWeaponSelectWidget.id = "PaintshopWeaponSelectWidget"
	if CoD.isPC then
		PaintjobWeaponSelectSafeAreaContainer.id = "PaintjobWeaponSelectSafeAreaContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = PaintshopWeaponSelectWidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local8 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	return self
end
CoD.PaintjobWeaponSelect.__resetProperties = function(f8_arg0)
	f8_arg0.BackgroundSlidePanel:completeAnimation()
	f8_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
	f8_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.PaintjobWeaponSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.BackgroundSlidePanel:completeAnimation()
			f9_arg0.BackgroundSlidePanel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BackgroundSlidePanel)
		end,
		Open = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f12_arg0:setTopBottom(0, 0, 672, 1294)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.BackgroundSlidePanel:beginAnimation(100)
				f10_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 872, 1494)
				f10_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.BackgroundSlidePanel:completeAnimation()
			f10_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
			f10_arg0.BackgroundSlidePanel:setAlpha(0)
			f10_local0(f10_arg0.BackgroundSlidePanel)
		end,
		Close = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.BackgroundSlidePanel:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f13_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1072, 1694)
				f13_arg0.BackgroundSlidePanel:setAlpha(0)
				f13_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.BackgroundSlidePanel:completeAnimation()
			f13_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 672, 1294)
			f13_arg0.BackgroundSlidePanel:setAlpha(1)
			f13_local0(f13_arg0.BackgroundSlidePanel)
		end,
	},
}
CoD.PaintjobWeaponSelect.__onClose = function(f15_arg0)
	f15_arg0.XCamMouseControl:close()
	f15_arg0.BackgroundSlidePanel:close()
	f15_arg0.ItemInfo:close()
	f15_arg0.PaintshopWeaponSelectWidget:close()
	f15_arg0.PaintjobWeaponSelectSafeAreaContainer:close()
end
