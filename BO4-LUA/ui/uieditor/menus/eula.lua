require("x64:db77c763209214b")
require("x64:796103fd6af5a59")
require("x64:6c3af68af4a6634")
require("x64:2b3a36f75bb6e0e")
CoD.EULA = InheritFrom(CoD.Menu)
LUI.createMenu.EULA = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EULA", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.EULA)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlackBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBG:setRGB(0, 0, 0)
	BlackBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BlackBG)
	self.BlackBG = BlackBG
	local Header = LUI.UIText.new(0.5, 0.5, -864, 864, 0, 0, 166, 211)
	Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_431BE80D5236D780"))
	Header:setTTF("ttmussels_demibold")
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Header)
	self.Header = Header
	local eulaBody = CoD.eulaBody.new(f1_local1, f1_arg0, 0.5, 0.5, -864, 864, 0, 0, 251, 951)
	eulaBody:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		CoD.LobbyUtility.InitializeEULA(element, f1_arg0, f1_local1)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(eulaBody)
	self.eulaBody = eulaBody
	local f1_local5 = nil
	local PCEULAButtons = LUI.UIList.new(f1_local1, f1_arg0, 20, 0, nil, false, false, false, false)
	PCEULAButtons:setLeftRight(0.5, 0.5, -250, 250)
	PCEULAButtons:setTopBottom(0.9, 0.9, 0, 80)
	PCEULAButtons:setWidgetType(CoD.PC_EULA_Buttons)
	PCEULAButtons:setHorizontalCount(2)
	PCEULAButtons:setSpacing(20)
	PCEULAButtons:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PCEULAButtons:setDataSource("PCEULAOptions")
	PCEULAButtons:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCEULAButtons, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCEULAButtons)
	self.PCEULAButtons = PCEULAButtons
	local PCEULAPages = nil
	PCEULAPages = CoD.PC_EULA_Pages.new(f1_local1, f1_arg0, 0.88, 0.88, -80, 80, 0.94, 0.94, 0, 30)
	self:addElement(PCEULAPages)
	self.PCEULAPages = PCEULAPages
	local SliderArrowLeft = nil
	SliderArrowLeft = CoD.StartMenu_Options_SettingSliderArrow.new(f1_local1, f1_arg0, 0.8, 0.8, -2, 58, 0.85, 0.85, 0, 60)
	SliderArrowLeft:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.LobbyUtility.IsFirstEULAPage(f1_arg0)
			end,
		},
	})
	local f1_local9 = SliderArrowLeft
	local SliderArrowRight = SliderArrowLeft.subscribeToModel
	local f1_local11 = DataSources.EULA.getModel(f1_arg0)
	SliderArrowRight(f1_local9, f1_local11.CurrentEULAPage, function(f7_arg0)
		f1_local1:updateElementState(SliderArrowLeft, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "CurrentEULAPage",
		})
	end, false)
	SliderArrowLeft:setZRot(270)
	SliderArrowLeft:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(SliderArrowLeft, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.LobbyUtility.PreviousEULAPage(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(SliderArrowLeft)
	self.SliderArrowLeft = SliderArrowLeft
	SliderArrowRight = nil
	SliderArrowRight = CoD.StartMenu_Options_SettingSliderArrow.new(f1_local1, f1_arg0, 0.91, 0.91, 22.5, 76.5, 0.85, 0.85, 0, 60)
	SliderArrowRight:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.LobbyUtility.IsLastEULAPage(f1_arg0)
			end,
		},
	})
	f1_local11 = SliderArrowRight
	f1_local9 = SliderArrowRight.subscribeToModel
	local f1_local12 = DataSources.EULA.getModel(f1_arg0)
	f1_local9(f1_local11, f1_local12.CurrentEULAPage, function(f12_arg0)
		f1_local1:updateElementState(SliderArrowRight, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "CurrentEULAPage",
		})
	end, false)
	f1_local11 = SliderArrowRight
	f1_local9 = SliderArrowRight.subscribeToModel
	f1_local12 = DataSources.EULA.getModel(f1_arg0)
	f1_local9(f1_local11, f1_local12.MaxEULAPage, function(f13_arg0)
		f1_local1:updateElementState(SliderArrowRight, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "MaxEULAPage",
		})
	end, false)
	SliderArrowRight:setZRot(90)
	SliderArrowRight:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f14_local0
	end)
	f1_local1:AddButtonCallbackFunction(SliderArrowRight, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.LobbyUtility.NextEULAPage(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(SliderArrowRight)
	self.SliderArrowRight = SliderArrowRight
	f1_local9 = nil
	f1_local9 = LUI.UIElement.createFake()
	self.FooterContainerFrontendRight = f1_local9
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local12 = self
	f1_local11 = self.subscribeToModel
	local f1_local13 = DataSources.EULA.getModel(f1_arg0)
	f1_local11(f1_local12, f1_local13.CurrentEULAPage, function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"])
	end, false)
	f1_local12 = self
	f1_local11 = self.subscribeToModel
	f1_local13 = DataSources.EULA.getModel(f1_arg0)
	f1_local11(f1_local12, f1_local13.MaxEULAPage, function(f19_arg0, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsPC() then
			CoD.LobbyUtility.AcceptEULA(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/accept", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if not IsPC() then
			CoD.LobbyUtility.DeclineEULA(self, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/decline", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_lb"], "ui_navleft", function(element, menu, controller, model)
		if not CoD.LobbyUtility.IsFirstEULAPage(controller) then
			CoD.LobbyUtility.PreviousEULAPage(self, self.eulaBody, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_lb"], @"menu/previous_page", nil, "ui_navleft")
		if not CoD.LobbyUtility.IsFirstEULAPage(controller) then
			return true
		else
			return false
		end
	end, true)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rb"], "ui_navright", function(element, menu, controller, model)
		if not CoD.LobbyUtility.IsLastEULAPage(controller) then
			CoD.LobbyUtility.NextEULAPage(self, self.eulaBody, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rb"], @"menu/next_page", nil, "ui_navright")
		if not CoD.LobbyUtility.IsLastEULAPage(controller) then
			return true
		else
			return false
		end
	end, true)
	self:subscribeToGlobalModel(f1_arg0, "EULA", "SawAllPages", function(model)
		local f28_local0 = self
		if IsPC() then
			UpdateElementState(self, "PCEULAButtons", f1_arg0)
		end
	end)
	PCEULAButtons.id = "PCEULAButtons"
	if CoD.isPC then
		SliderArrowLeft.id = "SliderArrowLeft"
	end
	if CoD.isPC then
		SliderArrowRight.id = "SliderArrowRight"
	end
	f1_local9:setModel(self.buttonModel, f1_arg0)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.EULA.__resetProperties = function(f29_arg0)
	f29_arg0.eulaBody:completeAnimation()
	f29_arg0.Header:completeAnimation()
	f29_arg0.PCEULAButtons:completeAnimation()
	f29_arg0.PCEULAPages:completeAnimation()
	f29_arg0.SliderArrowLeft:completeAnimation()
	f29_arg0.SliderArrowRight:completeAnimation()
	f29_arg0.eulaBody:setTopBottom(0, 0, 251, 951)
	f29_arg0.Header:setTopBottom(0, 0, 166, 211)
	f29_arg0.PCEULAButtons:setTopBottom(0.9, 0.9, 0, 80)
	f29_arg0.PCEULAPages:setLeftRight(0.88, 0.88, -80, 80)
	f29_arg0.PCEULAPages:setTopBottom(0.94, 0.94, 0, 30)
	f29_arg0.SliderArrowLeft:setLeftRight(0.8, 0.8, -2, 58)
	f29_arg0.SliderArrowLeft:setTopBottom(0.85, 0.85, 0, 60)
	f29_arg0.SliderArrowRight:setLeftRight(0.91, 0.91, 22.5, 76.5)
	f29_arg0.SliderArrowRight:setTopBottom(0.85, 0.85, 0, 60)
end
CoD.EULA.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(6)
			f31_arg0.Header:completeAnimation()
			f31_arg0.Header:setTopBottom(0.5, 0.5, -410, -365)
			f31_arg0.clipFinished(f31_arg0.Header)
			f31_arg0.eulaBody:completeAnimation()
			f31_arg0.eulaBody:setTopBottom(0.5, 0.5, -350, 350)
			f31_arg0.clipFinished(f31_arg0.eulaBody)
			f31_arg0.PCEULAButtons:completeAnimation()
			f31_arg0.PCEULAButtons:setTopBottom(0.5, 0.5, 370, 450)
			f31_arg0.clipFinished(f31_arg0.PCEULAButtons)
			f31_arg0.PCEULAPages:completeAnimation()
			f31_arg0.PCEULAPages:setLeftRight(0.5, 0.5, 710, 870)
			f31_arg0.PCEULAPages:setTopBottom(0.5, 0.5, 395, 425)
			f31_arg0.clipFinished(f31_arg0.PCEULAPages)
			f31_arg0.SliderArrowLeft:completeAnimation()
			f31_arg0.SliderArrowLeft:setLeftRight(0.5, 0.5, 550, 610)
			f31_arg0.SliderArrowLeft:setTopBottom(0.5, 0.5, 380, 440)
			f31_arg0.clipFinished(f31_arg0.SliderArrowLeft)
			f31_arg0.SliderArrowRight:completeAnimation()
			f31_arg0.SliderArrowRight:setLeftRight(0.5, 0.5, 630, 690)
			f31_arg0.SliderArrowRight:setTopBottom(0.5, 0.5, 380, 440)
			f31_arg0.clipFinished(f31_arg0.SliderArrowRight)
		end,
	},
}
CoD.EULA.__onClose = function(f32_arg0)
	f32_arg0.eulaBody:close()
	f32_arg0.PCEULAButtons:close()
	f32_arg0.PCEULAPages:close()
	f32_arg0.SliderArrowLeft:close()
	f32_arg0.SliderArrowRight:close()
	f32_arg0.FooterContainerFrontendRight:close()
end
