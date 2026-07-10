require("x64:de1e084b1f3792d")
require("x64:62963bd5f35a7f6")
require("x64:7c8f6290ec1890e")
require("x64:63f019e9d0f8956")
require("x64:1ef651f35122631")
require("x64:c401e6131a4e9a5")
CoD.DirectorCommonSafeAreaBottomAndLeft = InheritFrom(LUI.UIElement)
CoD.DirectorCommonSafeAreaBottomAndLeft.__defaultWidth = 1920
CoD.DirectorCommonSafeAreaBottomAndLeft.__defaultHeight = 1080
CoD.DirectorCommonSafeAreaBottomAndLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCommonSafeAreaBottomAndLeft)
	self.id = "DirectorCommonSafeAreaBottomAndLeft"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorBlackMarketButton = CoD.DirectorBlackMarketButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -896, -542, 1, 1, -218, -108)
	DirectorBlackMarketButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsBooleanDvarSet("loot_enableBlackMarket")
			end,
		},
		{
			stateName = "Contract",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties")
			end,
		},
	})
	self:addElement(DirectorBlackMarketButton)
	self.DirectorBlackMarketButton = DirectorBlackMarketButton
	local DirectorLaboratoryButton = CoD.DirectorLaboratoryButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -896, -542, 1, 1, -218, -108)
	DirectorLaboratoryButton:setAlpha(0)
	self:addElement(DirectorLaboratoryButton)
	self.DirectorLaboratoryButton = DirectorLaboratoryButton
	local DirectorContractsButton = CoD.DirectorContractsButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -896, -542, 1, 1, -250, -108)
	DirectorContractsButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsBooleanDvarSet("loot_enableBlackMarket")
			end,
		},
	})
	DirectorContractsButton:setAlpha(0)
	self:addElement(DirectorContractsButton)
	self.DirectorContractsButton = DirectorContractsButton
	local PreGameButtons = CoD.DirectorPreGameButtonContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -505, 478, 1, 1, -178, -108)
	PreGameButtons.LobbyButtons:setFilter(function(f5_arg0)
		return f5_arg0.showPregameButton:get() == true
	end)
	PreGameButtons.LobbyButtons:setDataSource("DirectorPregameButtons")
	PreGameButtons:registerEventHandler("record_curr_focused_elem_id", function(element, event)
		local f6_local0 = nil
		if element.RecordCurrFocusedElemID then
			f6_local0 = element:RecordCurrFocusedElemID(event)
		elseif element.super.RecordCurrFocusedElemID then
			f6_local0 = element.super:RecordCurrFocusedElemID(event)
		end
		UpdateElementState(self, "HintText", f1_arg1)
		return f6_local0
	end)
	PreGameButtons:registerEventHandler("list_item_lose_focus", function(element, event)
		local f7_local0 = nil
		UpdateElementState(self, "HintText", f1_arg1)
		return f7_local0
	end)
	self:addElement(PreGameButtons)
	self.PreGameButtons = PreGameButtons
	local HintText = CoD.onOffTextImageBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, 246, 707, 1, 1, -100, -79)
	HintText:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not IsWidgetInFocus(self, "PreGameButtons", event)
			end,
		},
	})
	HintText:appendEventHandler("record_curr_focused_elem_id", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(HintText, f10_arg1)
	end)
	HintText.TextBox:setTTF("ttmussels_demibold")
	HintText.TextBox:setBackingAlpha(0.8)
	HintText.TextBox:setBackingXPadding(3)
	self:addElement(HintText)
	self.HintText = HintText
	local DirectorAppLoadoutNotification = CoD.DirectorAppLoadoutNotification.new(f1_arg0, f1_arg1, 0.5, 0.5, 237, 487, 1, 1, -222, -192)
	DirectorAppLoadoutNotification:mergeStateConditions({
		{
			stateName = "Available",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShouldShowAppLoadoutAvailable(menu, f1_arg1)
			end,
		},
	})
	local f1_local7 = DirectorAppLoadoutNotification
	local f1_local8 = DirectorAppLoadoutNotification.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(DirectorAppLoadoutNotification, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local7 = DirectorAppLoadoutNotification
	f1_local8 = DirectorAppLoadoutNotification.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9.extLoadoutReady, function(f13_arg0)
		f1_arg0:updateElementState(DirectorAppLoadoutNotification, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "extLoadoutReady",
		})
	end, false)
	self:addElement(DirectorAppLoadoutNotification)
	self.DirectorAppLoadoutNotification = DirectorAppLoadoutNotification
	HintText:linkToElementModel(PreGameButtons.LobbyButtons, "hintText", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			HintText.TextBox:setText(f14_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "ContractsZombies",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[@"lobbymainmode"][@"lobby_mainmode_zm"]) and CoD.LootContractsUtility.IsUIEnabled(f1_arg1)
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[@"lobbymainmode"][@"lobby_mainmode_zm"])
			end,
		},
		{
			stateName = "Contracts",
			condition = function(menu, element, event)
				return CoD.LootContractsUtility.IsUIEnabled(f1_arg1)
			end,
		},
	})
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyMainMode"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorBlackMarketButton.id = "DirectorBlackMarketButton"
	DirectorLaboratoryButton.id = "DirectorLaboratoryButton"
	DirectorContractsButton.id = "DirectorContractsButton"
	PreGameButtons.id = "PreGameButtons"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	SetElementProperty(PreGameButtons, "_preGameType", "public")
	return self
end
CoD.DirectorCommonSafeAreaBottomAndLeft.__resetProperties = function(f20_arg0)
	f20_arg0.DirectorLaboratoryButton:completeAnimation()
	f20_arg0.DirectorBlackMarketButton:completeAnimation()
	f20_arg0.DirectorContractsButton:completeAnimation()
	f20_arg0.DirectorLaboratoryButton:setTopBottom(1, 1, -218, -108)
	f20_arg0.DirectorLaboratoryButton:setAlpha(0)
	f20_arg0.DirectorBlackMarketButton:setTopBottom(1, 1, -218, -108)
	f20_arg0.DirectorBlackMarketButton:setAlpha(1)
	f20_arg0.DirectorContractsButton:setTopBottom(1, 1, -250, -108)
	f20_arg0.DirectorContractsButton:setAlpha(0)
end
CoD.DirectorCommonSafeAreaBottomAndLeft.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	ContractsZombies = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.DirectorBlackMarketButton:completeAnimation()
			f22_arg0.DirectorBlackMarketButton:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.DirectorBlackMarketButton)
			f22_arg0.DirectorLaboratoryButton:completeAnimation()
			f22_arg0.DirectorLaboratoryButton:setTopBottom(1, 1, -372, -262)
			f22_arg0.DirectorLaboratoryButton:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.DirectorLaboratoryButton)
			f22_arg0.DirectorContractsButton:completeAnimation()
			f22_arg0.DirectorContractsButton:setTopBottom(1, 1, -250, -108)
			f22_arg0.DirectorContractsButton:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.DirectorContractsButton)
		end,
	},
	Zombies = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.DirectorBlackMarketButton:completeAnimation()
			f23_arg0.DirectorBlackMarketButton:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.DirectorBlackMarketButton)
			f23_arg0.DirectorLaboratoryButton:completeAnimation()
			f23_arg0.DirectorLaboratoryButton:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.DirectorLaboratoryButton)
		end,
	},
	Contracts = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.DirectorBlackMarketButton:completeAnimation()
			f24_arg0.DirectorBlackMarketButton:setTopBottom(1, 1, -368, -258)
			f24_arg0.clipFinished(f24_arg0.DirectorBlackMarketButton)
			f24_arg0.DirectorContractsButton:completeAnimation()
			f24_arg0.DirectorContractsButton:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.DirectorContractsButton)
		end,
	},
}
CoD.DirectorCommonSafeAreaBottomAndLeft.__onClose = function(f25_arg0)
	f25_arg0.HintText:close()
	f25_arg0.DirectorBlackMarketButton:close()
	f25_arg0.DirectorLaboratoryButton:close()
	f25_arg0.DirectorContractsButton:close()
	f25_arg0.PreGameButtons:close()
	f25_arg0.DirectorAppLoadoutNotification:close()
end
