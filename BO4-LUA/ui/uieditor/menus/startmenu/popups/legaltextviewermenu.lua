require("ui/uieditor/widgets/footer/footercontainer_frontend_right")
require("ui/uieditor/widgets/startmenu/options/legaltextviewerbody")
require("ui/uieditor/widgets/pc/pc_eula_pages")
require("ui/uieditor/widgets/startmenu/options/flyout/startmenu_options_settingsliderarrow")
CoD.LegalTextViewerMenu = InheritFrom(CoD.Menu)
LUI.createMenu.LegalTextViewerMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LegalTextViewerMenu", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.LegalTextViewerMenu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BlackBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBG:setRGB(0, 0, 0)
	BlackBG:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiply"))
	self:addElement(BlackBG)
	self.BlackBG = BlackBG
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -51, -3)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local Border = CoD.LegalTextViewerBody.new(f1_local1, f1_arg0, 0.5, 0.5, -864, 864, 0.5, 0.5, -450, 450)
	self:addElement(Border)
	self.Border = Border
	local Header = LUI.UIText.new(0.5, 0.5, -864, 864, 0.5, 0.5, -507, -462)
	Header:setTTF("ttmussels_demibold")
	Header:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Header:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	Header:subscribeToGlobalModel(f1_arg0, "CODAccountLegalInfo", "currentLegalTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Header:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Header)
	self.Header = Header
	local SliderArrowLeft = nil
	SliderArrowLeft = CoD.StartMenu_Options_SettingSliderArrow.new(f1_local1, f1_arg0, 0.5, 0.5, 570.5, 630.5, 0.5, 0.5, -522, -462)
	SliderArrowLeft:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.CoDAccountUtility.IsFirstLegalInfoEntry(f1_arg0)
			end,
		},
	})
	local LegalTextViewerPages = SliderArrowLeft
	local SliderArrowRight = SliderArrowLeft.subscribeToModel
	local f1_local9 = DataSources.CODAccountLegalInfo.getModel(f1_arg0)
	SliderArrowRight(LegalTextViewerPages, f1_local9.currentLegalInfoIndex, function(f5_arg0)
		f1_local1:updateElementState(SliderArrowLeft, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "currentLegalInfoIndex",
		})
	end, false)
	SliderArrowLeft:setZRot(270)
	SliderArrowLeft:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(SliderArrowLeft, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		CoD.CoDAccountUtility.PreviousCurrentLegalInfoEntry(f7_arg1, self.LegalTextViewerPages, f7_arg2)
		return true
	end, function(f8_arg0, f8_arg1, f8_arg2)
		CoD.Menu.SetButtonLabel(f8_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(SliderArrowLeft)
	self.SliderArrowLeft = SliderArrowLeft
	SliderArrowRight = nil
	SliderArrowRight = CoD.StartMenu_Options_SettingSliderArrow.new(f1_local1, f1_arg0, 0.5, 0.5, 810, 864, 0.5, 0.5, -522, -462)
	SliderArrowRight:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.CoDAccountUtility.IsLastLegalInfoEntry(f1_arg0)
			end,
		},
	})
	f1_local9 = SliderArrowRight
	LegalTextViewerPages = SliderArrowRight.subscribeToModel
	local f1_local10 = DataSources.CODAccountLegalInfo.getModel(f1_arg0)
	LegalTextViewerPages(f1_local9, f1_local10.currentLegalInfoIndex, function(f10_arg0)
		f1_local1:updateElementState(SliderArrowRight, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "currentLegalInfoIndex",
		})
	end, false)
	SliderArrowRight:setZRot(90)
	SliderArrowRight:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_local1:AddButtonCallbackFunction(SliderArrowRight, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		CoD.CoDAccountUtility.NextCurrentLegalInfoEntry(f12_arg1, self.LegalTextViewerPages, f12_arg2)
		return true
	end, function(f13_arg0, f13_arg1, f13_arg2)
		CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(SliderArrowRight)
	self.SliderArrowRight = SliderArrowRight
	LegalTextViewerPages = nil
	LegalTextViewerPages = CoD.PC_EULA_Pages.new(f1_local1, f1_arg0, 0.5, 0.5, 649.5, 809.5, 0.5, 0.5, -507.5, -477.5)
	self:addElement(LegalTextViewerPages)
	self.LegalTextViewerPages = LegalTextViewerPages
	f1_local10 = self
	f1_local9 = self.subscribeToModel
	local f1_local11 = DataSources.CODAccountLegalInfo.getModel(f1_arg0)
	f1_local9(f1_local10, f1_local11.currentLegalInfoIndex, function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_rb"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		GoBack(self, f15_arg2)
		return true
	end, function(f16_arg0, f16_arg1, f16_arg2)
		CoD.Menu.SetButtonLabel(f16_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_lb"], nil, function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
		if not CoD.CoDAccountUtility.IsFirstLegalInfoEntry(f17_arg2) then
			CoD.CoDAccountUtility.PreviousCurrentLegalInfoEntry(f17_arg1, self.LegalTextViewerPages, f17_arg2)
			UpdateAllMenuButtonPrompts(f17_arg1, f17_arg2)
			return true
		else
		end
	end, function(f18_arg0, f18_arg1, f18_arg2)
		if not CoD.CoDAccountUtility.IsFirstLegalInfoEntry(f18_arg2) then
			CoD.Menu.SetButtonLabel(f18_arg1, Enum.LUIButton[@"lui_key_lb"], @"menu/previous_page", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_rb"], nil, function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
		if not CoD.CoDAccountUtility.IsLastLegalInfoEntry(f19_arg2) then
			CoD.CoDAccountUtility.NextCurrentLegalInfoEntry(f19_arg1, self.LegalTextViewerPages, f19_arg2)
			UpdateAllMenuButtonPrompts(f19_arg1, f19_arg2)
			return true
		else
		end
	end, function(f20_arg0, f20_arg1, f20_arg2)
		if not CoD.CoDAccountUtility.IsLastLegalInfoEntry(f20_arg2) then
			CoD.Menu.SetButtonLabel(f20_arg1, Enum.LUIButton[@"lui_key_rb"], @"menu/next_page", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		MenuUnhideFreeCursor(f1_local1, f1_arg0)
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	if CoD.isPC then
		SliderArrowLeft.id = "SliderArrowLeft"
	end
	if CoD.isPC then
		SliderArrowRight.id = "SliderArrowRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local9 = self
	if IsPC() then
		CoD.CoDAccountUtility.SetupTextViewerPages(self.LegalTextViewerPages, f1_arg0)
	end
	return self
end
CoD.LegalTextViewerMenu.__onClose = function(f22_arg0)
	f22_arg0.FooterContainerFrontendRight:close()
	f22_arg0.Border:close()
	f22_arg0.Header:close()
	f22_arg0.SliderArrowLeft:close()
	f22_arg0.SliderArrowRight:close()
	f22_arg0.LegalTextViewerPages:close()
end
