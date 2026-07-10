require("x64:db806626fb64f10")
require("x64:d017063fe3d07bc")
require("x64:7889ce1e3e2e8a")
require("x64:30e9af8d72f4642")
CoD.BlackMarketContracts = InheritFrom(CoD.Menu)
LUI.createMenu.BlackMarketContracts = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BlackMarketContracts", f1_arg0)
	local f1_local1 = self
	CoD.BlackMarketUtility.SetupContractAvailabilityTimers(f1_arg0, f1_local1)
	SetControllerModelValue(f1_arg0, "Contracts.contractsAvailable", true)
	self:setClass(CoD.BlackMarketContracts)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local StartMenuOptionsBackground = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	StartMenuOptionsBackground:setAlpha(0)
	self:addElement(StartMenuOptionsBackground)
	self.StartMenuOptionsBackground = StartMenuOptionsBackground
	local DailyContracts = LUI.UIText.new(0.5, 0.5, -960.5, 959.5, 0.5, 0.5, -85.5, -35.5)
	DailyContracts:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	DailyContracts:setAlpha(0)
	DailyContracts:setText(LocalizeToUpperString(@"hash_1CE4BBA3DD91278"))
	DailyContracts:setTTF("ttmussels_demibold")
	DailyContracts:setLetterSpacing(2)
	DailyContracts:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(DailyContracts)
	self.DailyContracts = DailyContracts
	local BMContractsFrame = CoD.BM_ContractsFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BMContractsFrame)
	self.BMContractsFrame = BMContractsFrame
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyMainMode", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.GetContractHeaderStringFromLobbyMainMode(f1_arg0, f2_local0)))
		end
	end)
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local Spinner = CoD.StoreSpinner.new(f1_local1, f1_arg0, 0.5, 0.5, -48, 48, 0.5, 0.5, -8, 88)
	Spinner:setAlpha(0)
	self:addElement(Spinner)
	self.Spinner = Spinner
	self:mergeStateConditions({
		{
			stateName = "ContractsUnavailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "Contracts.contractsAvailable")
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["Contracts.contractsAvailable"], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "Contracts.contractsAvailable",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		ForceNotifyControllerModel(controller, "Contracts.updateActiveContracts")
		GoBack(self, controller)
		PlaySoundAlias("uin_cmn_backout")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.BlackMarketUtility.ClearContractModeOverride(f1_arg0)
	end)
	self.__on_menuOpened_self = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		local f9_local0 = self
		CoD.BlackMarketUtility.ClearCompletedActiveContracts(f9_arg1, f9_arg2)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "Contracts.contractsAvailable", function(model)
		local f10_local0 = self
		if not CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "Contracts.contractsAvailable") then
			CoD.BlackMarketUtility.SetupContractRetryTimer(f1_arg0, f1_local1)
		elseif CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "Contracts.contractsAvailable") then
			CoD.BlackMarketUtility.ClearContractRetryTimer(f1_arg0, f1_local1)
		end
	end)
	BMContractsFrame.id = "BMContractsFrame"
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = BMContractsFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.BlackMarketContracts.__resetProperties = function(f12_arg0)
	f12_arg0.BMContractsFrame:completeAnimation()
	f12_arg0.StartMenuOptionsBackground:completeAnimation()
	f12_arg0.DailyContracts:completeAnimation()
	f12_arg0.Spinner:completeAnimation()
	f12_arg0.BMContractsFrame:setAlpha(1)
	f12_arg0.StartMenuOptionsBackground:setAlpha(0)
	f12_arg0.DailyContracts:setAlpha(0)
	f12_arg0.Spinner:setAlpha(0)
end
CoD.BlackMarketContracts.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	ContractsUnavailable = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.StartMenuOptionsBackground:completeAnimation()
			f14_arg0.StartMenuOptionsBackground:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.StartMenuOptionsBackground)
			f14_arg0.DailyContracts:completeAnimation()
			f14_arg0.DailyContracts:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.DailyContracts)
			f14_arg0.BMContractsFrame:completeAnimation()
			f14_arg0.BMContractsFrame:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BMContractsFrame)
			f14_arg0.Spinner:completeAnimation()
			f14_arg0.Spinner:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.Spinner)
		end,
	},
}
CoD.BlackMarketContracts.__onClose = function(f15_arg0)
	f15_arg0.__on_close_removeOverrides()
	f15_arg0.StartMenuOptionsBackground:close()
	f15_arg0.BMContractsFrame:close()
	f15_arg0.GenericMenuFrameIdentity:close()
	f15_arg0.Spinner:close()
end
