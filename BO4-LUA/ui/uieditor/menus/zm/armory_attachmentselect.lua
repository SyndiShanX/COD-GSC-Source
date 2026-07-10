require("x64:f792a7ef58d5981")
require("x64:81ed9d78c1f64c5")
require("x64:190d4212b0e1cb")
require("x64:45111f049e24a81")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:c2f345c8ff5611e")
require("x64:e0fb1c5ee5c0772")
require("x64:75e2a524b093c12")
CoD.Armory_AttachmentSelect = InheritFrom(CoD.Menu)
LUI.createMenu.Armory_AttachmentSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Armory_AttachmentSelect", f1_arg0)
	local f1_local1 = self
	SetModelToGlobalDataSource(f1_arg0, self, "AttachmentMenu")
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "armoryOpticListFocus", false)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "armoryAttachmentUpdated", nil)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "armoryAttachmentListFocus", false)
	self:setClass(CoD.Armory_AttachmentSelect)
	self.soundSet = "CAC_PrimaryWeapon"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0.5, 1.5, -960.5, -960.5, 0, 0, 150, 650)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackgroundSlidePanel = CoD.cac_background_slide_panel.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 670, 1292)
	BackgroundSlidePanel:setZoom(70)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local WeaponAttachmentContainer = CoD.Armory_AttachmentContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -750, 750, 0, 0, 693, 993)
	WeaponAttachmentContainer:setZoom(72)
	self:addElement(WeaponAttachmentContainer)
	self.WeaponAttachmentContainer = WeaponAttachmentContainer
	local CACHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x560ECCA7484F00E))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local AttachmentFlyoutContainer = CoD.AttachmentFlyoutContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	LUI.OverrideFunction_CallOriginalFirst(AttachmentFlyoutContainer, "close", function(element)
		if not IsBooleanDvarSet("ui_attachmentFlyout") then
			CoD.WeaponAttachmentsUtility.CleanAttachmentDescriptionFlyouts(self, element, f1_arg0, f1_local1)
		end
	end)
	self.__on_menuOpened_AttachmentFlyoutContainer = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		local f7_local0 = AttachmentFlyoutContainer
		if not IsBooleanDvarSet("ui_attachmentFlyout") then
			CoD.WeaponAttachmentsUtility.SetupAttachmentDescriptionFlyouts(self, f7_local0, f7_arg1, f7_arg2)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_AttachmentFlyoutContainer)
	self:addElement(AttachmentFlyoutContainer)
	self.AttachmentFlyoutContainer = AttachmentFlyoutContainer
	local WeaponLevel = CoD.ItemWeaponLevel.new(f1_local1, f1_arg0, 0.5, 0.5, -790, 790, 0, 0, 650, 662)
	self:addElement(WeaponLevel)
	self.WeaponLevel = WeaponLevel
	local AttachmentInfo = CoD.Armory_AttachmentInfoContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -790, -37, 0, 0, 463.5, 570.5)
	self:addElement(AttachmentInfo)
	self.AttachmentInfo = AttachmentInfo
	local WeaponAttributes = CoD.WeaponAttributes.new(f1_local1, f1_arg0, 0.5, 0.5, 450, 895, 0, 0, 425, 675)
	WeaponAttributes:setZoom(85)
	self:addElement(WeaponAttributes)
	self.WeaponAttributes = WeaponAttributes
	AttachmentInfo:linkToElementModel(WeaponAttachmentContainer.AttachmentList.Attachments, nil, false, function(model)
		AttachmentInfo.AttachmentInfo:setModel(model, f1_arg0)
	end)
	AttachmentInfo:linkToElementModel(WeaponAttachmentContainer.OpticsList.Optics, nil, false, function(model)
		AttachmentInfo.OpticInfo:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_party_ease_slide_back")
		CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
		DelayGoBack(menu, controller, 200)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	self.__on_menuOpened_self = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		local f12_local0 = self
		if not IsGamepadOrKeyboardNavigation(f12_arg1) then
			CoD.WeaponAttachmentsUtility.CenterAttachmentLayout(self, f12_arg1, f12_arg2, self.WeaponAttachmentContainer)
			CoD.ZMLoadoutUtility.ResetAttachmentListModelForWeaponAttributes(f12_arg2, f12_arg2, f12_arg1)
		else
			CoD.WeaponAttachmentsUtility.CenterAttachmentLayout(self, f12_arg1, f12_arg2, self.WeaponAttachmentContainer)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetPerControllerTableProperty(f1_arg0, "attachmentSlot", nil)
		CoD.CACUtility.UpdateClassWeaponModel(f1_local1, element, f1_arg0)
		ForceNotifyControllerModel(f1_arg0, "WeaponPersonalization.listUpdate")
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	WeaponAttachmentContainer.id = "WeaponAttachmentContainer"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = WeaponAttachmentContainer
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_AttachmentFlyoutContainer)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	CoD.ZMLoadoutUtility.UpdateArmoryAttachmentModel(f1_local1, self, f1_arg0, false)
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, WeaponLevel, f1_local1._weaponItemModel)
	return self
end
CoD.Armory_AttachmentSelect.__resetProperties = function(f15_arg0)
	f15_arg0.WeaponAttachmentContainer:completeAnimation()
	f15_arg0.BackgroundSlidePanel:completeAnimation()
	f15_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 693, 993)
	f15_arg0.WeaponAttachmentContainer:setAlpha(1)
	f15_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 670, 1292)
	f15_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.Armory_AttachmentSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.BackgroundSlidePanel:completeAnimation()
			f16_arg0.BackgroundSlidePanel:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.BackgroundSlidePanel)
			f16_arg0.WeaponAttachmentContainer:completeAnimation()
			f16_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 1080, 1380)
			f16_arg0.clipFinished(f16_arg0.WeaponAttachmentContainer)
		end,
		Open = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f19_arg0:setTopBottom(0, 0, 670, 1292)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.BackgroundSlidePanel:beginAnimation(100)
				f17_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 875, 1497)
				f17_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.BackgroundSlidePanel:completeAnimation()
			f17_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1080, 1702)
			f17_arg0.BackgroundSlidePanel:setAlpha(0)
			f17_local0(f17_arg0.BackgroundSlidePanel)
			local f17_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(49)
					f21_arg0:setTopBottom(0, 0, 693, 993)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.WeaponAttachmentContainer:beginAnimation(200)
				f17_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 705, 1005)
				f17_arg0.WeaponAttachmentContainer:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.WeaponAttachmentContainer:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f17_arg0.WeaponAttachmentContainer:completeAnimation()
			f17_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 1103, 1403)
			f17_arg0.WeaponAttachmentContainer:setAlpha(0)
			f17_local1(f17_arg0.WeaponAttachmentContainer)
		end,
		Close = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f24_arg0:setTopBottom(0, 0, 1090, 1712)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.BackgroundSlidePanel:beginAnimation(100)
				f22_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 880, 1502)
				f22_arg0.BackgroundSlidePanel:setAlpha(0)
				f22_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.BackgroundSlidePanel:completeAnimation()
			f22_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 670, 1292)
			f22_arg0.BackgroundSlidePanel:setAlpha(1)
			f22_local0(f22_arg0.BackgroundSlidePanel)
			local f22_local1 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f26_arg0:setTopBottom(0, 0, 1113, 1413)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.WeaponAttachmentContainer:beginAnimation(100)
				f22_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 903, 1203)
				f22_arg0.WeaponAttachmentContainer:setAlpha(0)
				f22_arg0.WeaponAttachmentContainer:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.WeaponAttachmentContainer:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f22_arg0.WeaponAttachmentContainer:completeAnimation()
			f22_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 693, 993)
			f22_arg0.WeaponAttachmentContainer:setAlpha(1)
			f22_local1(f22_arg0.WeaponAttachmentContainer)
		end,
	},
}
CoD.Armory_AttachmentSelect.__onClose = function(f27_arg0)
	f27_arg0.__on_close_removeOverrides()
	f27_arg0.AttachmentInfo:close()
	f27_arg0.XCamMouseControl:close()
	f27_arg0.BackgroundSlidePanel:close()
	f27_arg0.WeaponAttachmentContainer:close()
	f27_arg0.CACHeader:close()
	f27_arg0.BackingGrayMediumLeft:close()
	f27_arg0.FooterContainerFrontendRight:close()
	f27_arg0.AttachmentFlyoutContainer:close()
	f27_arg0.WeaponLevel:close()
	f27_arg0.WeaponAttributes:close()
end
