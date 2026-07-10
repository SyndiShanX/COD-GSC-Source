require("x64:3f0c583dc4db051")
require("x64:5d80cb371475b19")
CoD.WZTrialUpsellPopup = InheritFrom(CoD.Menu)
LUI.createMenu.WZTrialUpsellPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WZTrialUpsellPopup", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.WZTrialUpsellPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local FullscreenPopupTemplate = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	FullscreenPopupTemplate.ButtonList:setWidgetType(CoD.ItemShopButton)
	FullscreenPopupTemplate.ButtonList:setDataSource("WZTrialUpsellOptions")
	FullscreenPopupTemplate.Subtitle:setText(Engine[0xF9F1239CFD921FE](0xB3101119C59EC6F))
	FullscreenPopupTemplate.ErrorSubtitle:setText("")
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(0x14DA16A525132B2))
	FullscreenPopupTemplate.Title:setText(LocalizeToUpperString(0x14DA16A525132B2))
	FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(0x14DA16A525132B2))
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local PopupImage = LUI.UIImage.new(0.5, 0.5, -960, -324, 0.5, 0.5, -213.5, 230.5)
	PopupImage:setImage(RegisterImage(0xCDD43147C7EA23E))
	self:addElement(PopupImage)
	self.PopupImage = PopupImage
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x6DA4540B4705513, nil, nil)
		return true
	end, false)
	FullscreenPopupTemplate.buttons:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.buttonPC:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.id = "FullscreenPopupTemplate"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FullscreenPopupTemplate
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local4 = self
	f1_local4 = FullscreenPopupTemplate
	if IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local4, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
	end
	return self
end
CoD.WZTrialUpsellPopup.__onClose = function(f4_arg0)
	f4_arg0.FullscreenPopupTemplate:close()
end
