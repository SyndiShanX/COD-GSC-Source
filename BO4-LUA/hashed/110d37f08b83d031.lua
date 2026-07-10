require("x64:3f0c583dc4db051")
require("x64:5d80cb371475b19")
require("x64:4cee61320cd1f1b")
CoD.BOPassRedemptionPopup = InheritFrom(CoD.Menu)
LUI.createMenu.BOPassRedemptionPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BOPassRedemptionPopup", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.BOPassRedemptionPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local FullscreenPopupTemplate = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FullscreenPopupTemplate:mergeStateConditions({
		{
			stateName = "WorkingState",
			condition = function(menu, element, event)
				return IsElementInState(element, "WorkingState")
			end,
		},
		{
			stateName = "ErrorState",
			condition = function(menu, element, event)
				return IsElementInState(element, "ErrorState")
			end,
		},
		{
			stateName = "CustomState",
			condition = function(menu, element, event)
				return IsElementInState(element, "CustomState")
			end,
		},
		{
			stateName = "FinishedState",
			condition = function(menu, element, event)
				return IsElementInState(element, "FinishedState")
			end,
		},
	})
	FullscreenPopupTemplate.ButtonList:setWidgetType(CoD.ItemShopButton)
	FullscreenPopupTemplate.Subtitle:setText(LocalizeHash(0xF4F17BBB50E7AF3))
	FullscreenPopupTemplate.ErrorSubtitle:setText(Engine[0xF9F1239CFD921FE](0x5D814FC2D8ED37F))
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(0x67B9487B8B4E09C))
	FullscreenPopupTemplate.Title:setText(LocalizeToUpperString(0xEA03240AB35A0F4))
	FullscreenPopupTemplate.DoneTitle:setText(Engine[0xF9F1239CFD921FE](0xC0C9B30AD418455))
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 341, 445, 0, 0, 23.5, 103.5)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f6_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsElementInState(self.FullscreenPopupTemplate, "FinishedState") and not IsPC() then
			GoBack(self, controller)
			return true
		elseif not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") and CoD.EntitlementUtility.HasSeasonPassToken(controller) then
			CoD.EntitlementUtility.SetWorkingStateAndPurchaseBOPass(self, self.FullscreenPopupTemplate, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "FinishedState") and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
			return true
		elseif not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") and CoD.EntitlementUtility.HasSeasonPassToken(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x867BE59364DD53B, nil, nil)
			return true
		else
			return false
		end
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
	if IsPC() then
		SetMenuProperty(f1_local1, "_closeAndGoBack", true)
		SetMenuProperty(f1_local1, "_openEntitlementPopups", true)
	end
	f1_local4 = FullscreenPopupTemplate
	if IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local4, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
	end
	return self
end
CoD.BOPassRedemptionPopup.__onClose = function(f11_arg0)
	f11_arg0.FullscreenPopupTemplate:close()
	f11_arg0.StartMenuCODpoints:close()
end
