require("x64:8a3543a913958f1")
require("x64:3f0c583dc4db051")
require("x64:5d80cb371475b19")
CoD.BlackMarketContractReplacementConfirmation = InheritFrom(CoD.Menu)
LUI.createMenu.BlackMarketContractReplacementConfirmation = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BlackMarketContractReplacementConfirmation", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	SetMenuProperty(f1_local1, "_contractSlot", f1_arg1._contractSlot)
	SetMenuProperty(f1_local1, "_selectedModel", f1_arg1._selectedModel)
	SetMenuProperty(f1_local1, "__keepPopupButtonListPC", true)
	self:setClass(CoD.BlackMarketContractReplacementConfirmation)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local FullscreenPopupTemplate = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FullscreenPopupTemplate.ButtonList:setWidgetType(CoD.ItemShopButton)
	FullscreenPopupTemplate.ButtonList:setDataSource("ContractReplacementOptions")
	FullscreenPopupTemplate.Subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2A13F0805FDA9620"))
	FullscreenPopupTemplate.ErrorSubtitle:setText(LocalizeToUpperString(0x0))
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(0x0))
	FullscreenPopupTemplate.Title:setText(LocalizeToUpperString(@"hash_223F5EBDD2190849"))
	FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(0x0))
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local BMContractProgress = CoD.BM_ContractProgress.new(f1_local1, f1_arg0, 0.5, 0.5, -832, -432, 0.5, 0.5, -253, 147)
	BMContractProgress:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "completed")
			end,
		},
	})
	BMContractProgress:linkToElementModel(BMContractProgress, "completed", true, function(model)
		f1_local1:updateElementState(BMContractProgress, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	BMContractProgress:setScale(0.9, 0.9)
	BMContractProgress:linkToElementModel(self, nil, false, function(model)
		BMContractProgress:setModel(model, f1_arg0)
	end)
	self:addElement(BMContractProgress)
	self.BMContractProgress = BMContractProgress
	local Name = LUI.UIText.new(0.5, 0.5, -823.5, -443.5, 0.5, 0.5, 115.5, 152.5)
	Name:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	Name:linkToElementModel(self, "displayName", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Description = LUI.UIText.new(0.5, 0.5, -839, -429, 0.5, 0.5, 153.5, 169.5)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Description:linkToElementModel(self, "description", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Description:setText(f6_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
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
	return self
end
CoD.BlackMarketContractReplacementConfirmation.__onClose = function(f9_arg0)
	f9_arg0.FullscreenPopupTemplate:close()
	f9_arg0.BMContractProgress:close()
	f9_arg0.Name:close()
	f9_arg0.Description:close()
end
