require("x64:75d27055190f173")
require("x64:681f11650a68a6")
CoD.BM_AvailableContractsListContainer = InheritFrom(LUI.UIElement)
CoD.BM_AvailableContractsListContainer.__defaultWidth = 500
CoD.BM_AvailableContractsListContainer.__defaultHeight = 700
CoD.BM_AvailableContractsListContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_AvailableContractsListContainer)
	self.id = "BM_AvailableContractsListContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local AvailableContractsList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, false, false, false, false)
	AvailableContractsList:setLeftRight(0, 0, 0, 418)
	AvailableContractsList:setTopBottom(0, 0, 0, 636)
	AvailableContractsList:setWidgetType(CoD.BM_AvailabeContractItem)
	AvailableContractsList:setHorizontalCount(2)
	AvailableContractsList:setVerticalCount(3)
	AvailableContractsList:setSpacing(18)
	AvailableContractsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AvailableContractsList:setStaggeredIntroTime(1)
	AvailableContractsList:setDataSource("BlackMarketAvailableContracts")
	AvailableContractsList:linkToElementModel(AvailableContractsList, "active", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AvailableContractsList:linkToElementModel(AvailableContractsList, "completed", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AvailableContractsList:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AvailableContractsList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.BlackMarketUtility.IsActiveContractAvailable(controller, element, menu) and not CoD.BlackMarketUtility.IsActiveContractCompleted(controller, element, menu) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "active") then
			OpenOverlay(self, "BlackMarketContractReplacementConfirmation", controller, {
				_model = menu:getModel(),
				_selectedModel = element:getModel(),
				_contractSlot = menu._contractSlot,
			})
			PlaySoundAlias("cac_slide_equip_item")
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "active") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "completed") then
			CoD.BlackMarketUtility.PinContract(controller, element, menu, nil)
			DelayGoBack(menu, controller, 250)
			PlaySoundAlias("cac_slide_equip_item")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.BlackMarketUtility.IsActiveContractAvailable(controller, element, menu) and not CoD.BlackMarketUtility.IsActiveContractCompleted(controller, element, menu) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "active") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "active") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "completed") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	AvailableContractsList:subscribeToGlobalModel(f1_arg1, "PerController", "lootContracts.forceRefresh", function(model)
		CoD.GridAndListUtility.UpdateDataSource(AvailableContractsList, true, true, true)
	end)
	AvailableContractsList:subscribeToGlobalModel(f1_arg1, "PerController", "lootContracts.pinnedContractStatus_1", function(model)
		CoD.GridAndListUtility.UpdateDataSource(AvailableContractsList, true, true, true)
	end)
	AvailableContractsList:subscribeToGlobalModel(f1_arg1, "PerController", "lootContracts.pinnedContractStatus_2", function(model)
		CoD.GridAndListUtility.UpdateDataSource(AvailableContractsList, true, true, true)
	end)
	AvailableContractsList:subscribeToGlobalModel(f1_arg1, "PerController", "Contracts.availableContractsExpired", function(model)
		CoD.GridAndListUtility.UpdateDataSource(AvailableContractsList, true, true, true)
	end)
	self:addElement(AvailableContractsList)
	self.AvailableContractsList = AvailableContractsList
	AvailableContractsList.id = "AvailableContractsList"
	self.__defaultFocus = AvailableContractsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_AvailableContractsListContainer.__onClose = function(f11_arg0)
	f11_arg0.AvailableContractsList:close()
end
