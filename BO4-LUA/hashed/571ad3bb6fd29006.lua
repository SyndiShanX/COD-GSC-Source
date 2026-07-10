require("x64:43a18b0c952dcc0")
require("x64:9fccadd00eb6735")
CoD.SupplyChainFrameContainer = InheritFrom(LUI.UIElement)
CoD.SupplyChainFrameContainer.__defaultWidth = 349
CoD.SupplyChainFrameContainer.__defaultHeight = 700
CoD.SupplyChainFrameContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 13, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.SupplyChainFrameContainer)
	self.id = "SupplyChainFrameContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local StreamList = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	StreamList:setLeftRight(0.5, 0.5, -174.5, 174.5)
	StreamList:setTopBottom(0, 0, 0, 644)
	StreamList:setWidgetType(CoD.SupplyChainStream)
	StreamList:setVerticalCount(4)
	StreamList:setSpacing(4)
	StreamList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StreamList:setDataSource("SupplyChainStreams")
	StreamList:linkToElementModel(StreamList, "isUpsell", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	StreamList:linkToElementModel(StreamList, "isContract", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	StreamList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContract") then
			SetAncestorsElementModelToFocusedElementSubModel(self, f1_arg1, element, "SupplyChainDetails", "contractModels")
			CoD.BlackMarketUtility.ChangeSupplyChainCameraBySelection(f1_arg0, f1_arg1, element)
		end
		return f4_local0
	end)
	StreamList:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(StreamList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isUpsell") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.ContractUtility.OpenSupplyChainContractDetails(self, element, controller)
			PlaySoundAlias("uin_press_generic")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isContract") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.ContractUtility.OpenSupplyChainContractDetails(self, element, controller)
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isUpsell") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x9C695BAD15F589A, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isContract") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x9C695BAD15F589A, nil, nil)
			return true
		else
			return false
		end
	end, false)
	StreamList:subscribeToGlobalModel(f1_arg1, "PerController", "LootStreamProgress", function(model)
		CoD.GridAndListUtility.UpdateDataSource(StreamList, true, true, true)
	end)
	StreamList:subscribeToGlobalModel(f1_arg1, "GlobalModel", "ItemshopRotation.cycled", function(model)
		local f9_local0 = StreamList
		if CoD.ModelUtility.IsGlobalModelValueTrue("ItemshopRotation.cycled") then
			CoD.GridAndListUtility.UpdateDataSource(f9_local0, true, true, true)
		end
	end)
	self:addElement(StreamList)
	self.StreamList = StreamList
	local DupeMeter = CoD.DupeMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -174.5, 174.5, 1, 1, -43, -9)
	DupeMeter:setAlpha(0)
	self:addElement(DupeMeter)
	self.DupeMeter = DupeMeter
	StreamList.id = "StreamList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainFrameContainer.__onClose = function(f10_arg0)
	f10_arg0.StreamList:close()
	f10_arg0.DupeMeter:close()
end
