require("x64:3f0c583dc4db051")
require("x64:ce1e6b6549d478c")
CoD.LaboratoryPlasmaConfirmation = InheritFrom(CoD.Menu)
LUI.createMenu.LaboratoryPlasmaConfirmation = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LaboratoryPlasmaConfirmation", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1._properties)
	SetMenuProperty(f1_local1, "__isPlasmaPurchase", true)
	self:setClass(CoD.LaboratoryPlasmaConfirmation)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local FullscreenPopupTemplate = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FullscreenPopupTemplate.ButtonList:setDataSource("PlasmaConfirmationButtonList")
	FullscreenPopupTemplate.ErrorSubtitle:setText(Engine[0xF9F1239CFD921FE](0x306208DB7BBE129))
	FullscreenPopupTemplate.WorkingTitle:setText(Engine[0xF9F1239CFD921FE](0x9D00A7D3D969F6E))
	FullscreenPopupTemplate.DoneTitle:setText(Engine[0xF9F1239CFD921FE](0x83048BBBD98FC6A))
	FullscreenPopupTemplate:linkToElementModel(self, nil, false, function(model)
		FullscreenPopupTemplate:setModel(model, f1_arg0)
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "price", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FullscreenPopupTemplate.Subtitle:setText(LocalizeIntoString(0x4FD368063324203, f3_local0))
		end
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			FullscreenPopupTemplate.Title:setText(LocalizeIntoString(0x63FCD1B0849669E, f4_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(FullscreenPopupTemplate, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsPC() and IsElementInState(element, "FinishedState") then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		elseif IsPC() then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		end
	end)
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local Image = LUI.UIImage.new(0.5, 0.5, -713, -413, 0.5, 0.5, -170.5, 129.5)
	Image:linkToElementModel(self, "icon", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Image:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local CostText = LUI.UIText.new(0.5, 0.5, -679.5, -446.5, 0.5, 0.5, 142.5, 191.5)
	CostText:setText(Engine[0xF9F1239CFD921FE](0x93F12745A24670F))
	CostText:setTTF("default")
	CostText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CostText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CostText)
	self.CostText = CostText
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f8_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local7(f1_local6, f1_local8.LastInput, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			GoBack(self, controller)
			return true
		elseif IsElementInState(self.FullscreenPopupTemplate, "ErrorState") and IsGamepad(controller) then
			GoBack(self, controller)
			return true
		elseif IsPC() and IsElementInState(self.FullscreenPopupTemplate, "DefaultState") then
			PlaySoundAlias("uin_points_purchase")
			SetElementWorkingStateAndPurchaseDWSKU(self.FullscreenPopupTemplate, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
			return true
		elseif IsElementInState(self.FullscreenPopupTemplate, "ErrorState") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif IsPC() and IsElementInState(self.FullscreenPopupTemplate, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x85952ACC6D0C1B0, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "AutoEvents", "cycled", function(model)
		if IsElementInState(self.FullscreenPopupTemplate, "DefaultState") and CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg0, "offerAssetName") and CoD.ZMLaboratoryUtility.HasOfferExpired(self) then
			GoBack(self, f1_arg0)
		end
	end)
	FullscreenPopupTemplate.buttons:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.buttonPC:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.id = "FullscreenPopupTemplate"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
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
	return self
end
CoD.LaboratoryPlasmaConfirmation.__onClose = function(f15_arg0)
	f15_arg0.FullscreenPopupTemplate:close()
	f15_arg0.Image:close()
	f15_arg0.FooterContainerFrontendRight:close()
end
