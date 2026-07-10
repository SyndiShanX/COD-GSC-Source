require("x64:8b53d2ba8e4b74c")
require("x64:330d3ffa470e968")
require("x64:81ed9d78c1f64c5")
require("x64:341ce33d59fafd1")
require("x64:190d4212b0e1cb")
require("x64:ec07622a7f2e74e")
require("x64:45111f049e24a81")
require("x64:ec94048bad1fbac")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:2bf3da84e7ff2d3")
require("x64:75e2a524b093c12")
CoD.WeaponAttachmentSelect = InheritFrom(CoD.Menu)
LUI.createMenu.WeaponAttachmentSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WeaponAttachmentSelect", f1_arg0)
	local f1_local1 = self
	SetModelToGlobalDataSource(f1_arg0, self, "AttachmentMenu")
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.WeaponAttachmentSelect)
	self.soundSet = "CAC_PrimaryWeapon"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 150, 650)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackgroundSlidePanel = CoD.cac_background_slide_panel_short.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 639, 1261)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local WeaponAttachmentContainer = CoD.WeaponAttachmentContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -400, 400, 0, 0, 692, 992)
	self:addElement(WeaponAttachmentContainer)
	self.WeaponAttachmentContainer = WeaponAttachmentContainer
	local AttachmentName = LUI.UIText.new(0.5, 0.5, -791, -38, 0, 0, 495, 527)
	AttachmentName:setRGB(0.92, 0.89, 0.72)
	AttachmentName:setTTF("ttmussels_demibold")
	AttachmentName:setLetterSpacing(14)
	AttachmentName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AttachmentName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AttachmentName)
	self.AttachmentName = AttachmentName
	local AttachmentDescription = LUI.UIText.new(0.5, 0.5, -790, -315, 0, 0, 540, 558)
	AttachmentDescription:setRGB(0.8, 0.79, 0.78)
	AttachmentDescription:setTTF("dinnext_regular")
	AttachmentDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AttachmentDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AttachmentDescription)
	self.AttachmentDescription = AttachmentDescription
	local UnlockDescription = CoD.onOffText.new(f1_local1, f1_arg0, 0.5, 0.5, -793, -446, 0, 0, 451, 469)
	UnlockDescription:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsCACAttachmentItemLocked(menu, element, f1_arg0)
			end,
		},
	})
	UnlockDescription:linkToElementModel(UnlockDescription, "itemIndex", true, function(model)
		f1_local1:updateElementState(UnlockDescription, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	UnlockDescription:setRGB(0.39, 0.39, 0.39)
	self:addElement(UnlockDescription)
	self.UnlockDescription = UnlockDescription
	local DirectorDividerWithGradient = CoD.DirectorDividerWithGradient.new(f1_local1, f1_arg0, 0.5, 0.5, -790, -390, 0, 0, 532, 533)
	DirectorDividerWithGradient:setRGB(0.39, 0.39, 0.39)
	self:addElement(DirectorDividerWithGradient)
	self.DirectorDividerWithGradient = DirectorDividerWithGradient
	local CACHeader = CoD.CACHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_7560ECCA7484F00E"))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	CACHeader:linkToElementModel(self, nil, false, function(model)
		CACHeader:setModel(model, f1_arg0)
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f8_local0 = nil
		if element.menuLoaded then
			f8_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f8_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local WeaponLevel = CoD.ItemWeaponLevel.new(f1_local1, f1_arg0, 0.5, 0.5, -790, 790, 0, 0, 650, 662)
	self:addElement(WeaponLevel)
	self.WeaponLevel = WeaponLevel
	local AttachmentFlyoutContainer = CoD.AttachmentFlyoutContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	LUI.OverrideFunction_CallOriginalFirst(AttachmentFlyoutContainer, "close", function(element)
		if not IsBooleanDvarSet("ui_attachmentFlyout") then
			CoD.WeaponAttachmentsUtility.CleanAttachmentDescriptionFlyouts(self, element, f1_arg0, f1_local1)
		end
	end)
	self.__on_menuOpened_AttachmentFlyoutContainer = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		local f10_local0 = AttachmentFlyoutContainer
		if not IsBooleanDvarSet("ui_attachmentFlyout") then
			CoD.WeaponAttachmentsUtility.SetupAttachmentDescriptionFlyouts(self, f10_local0, f10_arg1, f10_arg2)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_AttachmentFlyoutContainer)
	self:addElement(AttachmentFlyoutContainer)
	self.AttachmentFlyoutContainer = AttachmentFlyoutContainer
	local WeaponAttributes = CoD.WeaponAttributes.new(f1_local1, f1_arg0, 0.5, 0.5, 430, 875, 0, 0, 420, 670)
	self:addElement(WeaponAttributes)
	self.WeaponAttributes = WeaponAttributes
	local RestrictedItemWarningText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0.59, 0.59, 0, 30)
	self:addElement(RestrictedItemWarningText)
	self.RestrictedItemWarningText = RestrictedItemWarningText
	AttachmentName:linkToElementModel(WeaponAttachmentContainer.GeneralAttachmentContainer.AttachmentList, "displayName", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			AttachmentName:setText(Engine[@"hash_4F9F1239CFD921FE"](f11_local0))
		end
	end)
	AttachmentDescription:linkToElementModel(WeaponAttachmentContainer.GeneralAttachmentContainer.AttachmentList, "description", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			AttachmentDescription:setText(f12_local0)
		end
	end)
	UnlockDescription:linkToElementModel(WeaponAttachmentContainer.GeneralAttachmentContainer.AttachmentList, nil, false, function(model)
		UnlockDescription:setModel(model, f1_arg0)
	end)
	UnlockDescription:linkToElementModel(WeaponAttachmentContainer.GeneralAttachmentContainer.AttachmentList, "itemIndex", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			UnlockDescription.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.CACUtility.GetAttachmentUnlockDescription(f1_local1, f1_arg0, f14_local0)))
		end
	end)
	WeaponAttributes:linkToElementModel(WeaponAttachmentContainer.GeneralAttachmentContainer.AttachmentList, "weaponAttributes", false, function(model)
		WeaponAttributes:setModel(model, f1_arg0)
	end)
	WeaponAttributes:linkToElementModel(WeaponAttachmentContainer.GeneralAttachmentContainer.AttachmentList, nil, false, function(model)
		WeaponAttributes.MutualExclusiveWarning:setModel(model, f1_arg0)
	end)
	RestrictedItemWarningText:linkToElementModel(WeaponAttachmentContainer.GeneralAttachmentContainer.AttachmentList, nil, false, function(model)
		RestrictedItemWarningText:setModel(model, f1_arg0)
	end)
	self:appendEventHandler("input_source_changed", function(f18_arg0, f18_arg1)
		f18_arg1.menu = f18_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f18_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
	end)
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local17(f1_local16, f1_local18.LastInput, function(f19_arg0, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if not IsPC() then
			PlaySoundAlias("uin_party_ease_slide_back")
			CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
			DelayUnhideFreecursorGoBack(menu, controller, 200)
			return true
		elseif IsPC() then
			PlaySoundAlias("uin_party_ease_slide_back")
			CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "ClosePC")
			DelayGoBack(menu, controller, 70)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], "F10", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.CACUtility.RemoveAllAttachmentsFromClass(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_5E9CED3392B6716C", nil, "F10")
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
		local f24_local0 = self
		CoD.WeaponAttachmentsUtility.CenterAttachmentLayout(self, f24_arg1, f24_arg2, self.WeaponAttachmentContainer)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetPerControllerTableProperty(f1_arg0, "attachmentSlot", nil)
		CoD.CACUtility.UpdateClassWeaponModel(f1_local1, element, f1_arg0)
		ClearMenuSavedState(f1_local1)
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
	f1_local17 = self
	if not IsPC() then
		CoD.CACUtility.UpdateWeaponAttachmentModel(f1_local1, f1_local17, f1_arg0, false)
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.WeaponAttachmentsUtility.SetWeaponInfo(self, f1_arg0, f1_local1)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	elseif IsPC() then
		CoD.CACUtility.UpdateWeaponAttachmentModel(f1_local1, f1_local17, f1_arg0, false)
		CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
		CoD.WeaponAttachmentsUtility.SetWeaponInfo(self, f1_arg0, f1_local1)
		CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "OpenPC", true)
	end
	return self
end
CoD.WeaponAttachmentSelect.__resetProperties = function(f27_arg0)
	f27_arg0.WeaponAttachmentContainer:completeAnimation()
	f27_arg0.BackgroundSlidePanel:completeAnimation()
	f27_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 692, 992)
	f27_arg0.WeaponAttachmentContainer:setAlpha(1)
	f27_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 639, 1261)
	f27_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.WeaponAttachmentSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.BackgroundSlidePanel:completeAnimation()
			f28_arg0.BackgroundSlidePanel:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.BackgroundSlidePanel)
			f28_arg0.WeaponAttachmentContainer:completeAnimation()
			f28_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 1080, 1380)
			f28_arg0.clipFinished(f28_arg0.WeaponAttachmentContainer)
		end,
		Open = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			local f29_local0 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f31_arg0:setTopBottom(0, 0, 639, 1261)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.BackgroundSlidePanel:beginAnimation(100)
				f29_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 859.5, 1481.5)
				f29_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f29_arg0.BackgroundSlidePanel:completeAnimation()
			f29_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1080, 1702)
			f29_arg0.BackgroundSlidePanel:setAlpha(0)
			f29_local0(f29_arg0.BackgroundSlidePanel)
			local f29_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(49)
					f33_arg0:setTopBottom(0, 0, 692, 992)
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
				end
				f29_arg0.WeaponAttachmentContainer:beginAnimation(200)
				f29_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 705, 1005)
				f29_arg0.WeaponAttachmentContainer:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.WeaponAttachmentContainer:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f29_arg0.WeaponAttachmentContainer:completeAnimation()
			f29_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 1103, 1403)
			f29_arg0.WeaponAttachmentContainer:setAlpha(0)
			f29_local1(f29_arg0.WeaponAttachmentContainer)
		end,
		Close = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			local f34_local0 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f36_arg0:setTopBottom(0, 0, 1090, 1712)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
				end
				f34_arg0.BackgroundSlidePanel:beginAnimation(100)
				f34_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 864.5, 1486.5)
				f34_arg0.BackgroundSlidePanel:setAlpha(0)
				f34_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f34_arg0.BackgroundSlidePanel:completeAnimation()
			f34_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 639, 1261)
			f34_arg0.BackgroundSlidePanel:setAlpha(1)
			f34_local0(f34_arg0.BackgroundSlidePanel)
			local f34_local1 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
					f38_arg0:setTopBottom(0, 0, 1113, 1413)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
				end
				f34_arg0.WeaponAttachmentContainer:beginAnimation(100)
				f34_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 902.5, 1202.5)
				f34_arg0.WeaponAttachmentContainer:setAlpha(0)
				f34_arg0.WeaponAttachmentContainer:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.WeaponAttachmentContainer:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f34_arg0.WeaponAttachmentContainer:completeAnimation()
			f34_arg0.WeaponAttachmentContainer:setTopBottom(0, 0, 692, 992)
			f34_arg0.WeaponAttachmentContainer:setAlpha(1)
			f34_local1(f34_arg0.WeaponAttachmentContainer)
		end,
		OpenPC = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			local f39_local0 = function(f40_arg0)
				f39_arg0.BackgroundSlidePanel:beginAnimation(70)
				f39_arg0.BackgroundSlidePanel:setAlpha(1)
				f39_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.BackgroundSlidePanel:completeAnimation()
			f39_arg0.BackgroundSlidePanel:setAlpha(0)
			f39_local0(f39_arg0.BackgroundSlidePanel)
			local f39_local1 = function(f41_arg0)
				f39_arg0.WeaponAttachmentContainer:beginAnimation(70)
				f39_arg0.WeaponAttachmentContainer:setAlpha(1)
				f39_arg0.WeaponAttachmentContainer:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.WeaponAttachmentContainer:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.WeaponAttachmentContainer:completeAnimation()
			f39_arg0.WeaponAttachmentContainer:setAlpha(0)
			f39_local1(f39_arg0.WeaponAttachmentContainer)
		end,
		ClosePC = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			local f42_local0 = function(f43_arg0)
				f42_arg0.BackgroundSlidePanel:beginAnimation(40)
				f42_arg0.BackgroundSlidePanel:setAlpha(0)
				f42_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.BackgroundSlidePanel:completeAnimation()
			f42_arg0.BackgroundSlidePanel:setAlpha(1)
			f42_local0(f42_arg0.BackgroundSlidePanel)
			local f42_local1 = function(f44_arg0)
				f42_arg0.WeaponAttachmentContainer:beginAnimation(40)
				f42_arg0.WeaponAttachmentContainer:setAlpha(0)
				f42_arg0.WeaponAttachmentContainer:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.WeaponAttachmentContainer:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.WeaponAttachmentContainer:completeAnimation()
			f42_arg0.WeaponAttachmentContainer:setAlpha(1)
			f42_local1(f42_arg0.WeaponAttachmentContainer)
		end,
	},
}
CoD.WeaponAttachmentSelect.__onClose = function(f45_arg0)
	f45_arg0.__on_close_removeOverrides()
	f45_arg0.AttachmentName:close()
	f45_arg0.AttachmentDescription:close()
	f45_arg0.UnlockDescription:close()
	f45_arg0.WeaponAttributes:close()
	f45_arg0.RestrictedItemWarningText:close()
	f45_arg0.XCamMouseControl:close()
	f45_arg0.BackgroundSlidePanel:close()
	f45_arg0.WeaponAttachmentContainer:close()
	f45_arg0.DirectorDividerWithGradient:close()
	f45_arg0.CACHeader:close()
	f45_arg0.BackingGrayMediumLeft:close()
	f45_arg0.FooterContainerFrontendRight:close()
	f45_arg0.WeaponLevel:close()
	f45_arg0.AttachmentFlyoutContainer:close()
end
