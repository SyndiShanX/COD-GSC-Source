require("x64:f00a10fc8301da2")
require("x64:52e481f8ee460a4")
CoD.AARContractsTabInternal = InheritFrom(LUI.UIElement)
CoD.AARContractsTabInternal.__defaultWidth = 1920
CoD.AARContractsTabInternal.__defaultHeight = 900
CoD.AARContractsTabInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BlackMarketUtility.SetupDailyContractTimer(f1_arg1, f1_arg0)
	self:setClass(CoD.AARContractsTabInternal)
	self.id = "AARContractsTabInternal"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0, 0, -40, 1960, 0, 0, 51, 887)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local Daily = CoD.BM_ContractDetails.new(f1_arg0, f1_arg1, 0, 0, 220, 680, 0, 0, 151, 787)
	Daily:subscribeToGlobalModel(f1_arg1, "Contracts", "dailyActive", function(model)
		Daily:setModel(model, f1_arg1)
	end)
	self:addElement(Daily)
	self.Daily = Daily
	local Contract1 = CoD.BM_ContractDetails.new(f1_arg0, f1_arg1, 0, 0, 730, 1190, 0, 0, 151, 787)
	Contract1:subscribeToGlobalModel(f1_arg1, "Contracts", "contractSlot1", function(model)
		Contract1:setModel(model, f1_arg1)
	end)
	self:addElement(Contract1)
	self.Contract1 = Contract1
	local Contract2 = CoD.BM_ContractDetails.new(f1_arg0, f1_arg1, 0, 0, 1240, 1700, 0, 0, 151, 787)
	Contract2:subscribeToGlobalModel(f1_arg1, "Contracts", "contractSlot2", function(model)
		Contract2:setModel(model, f1_arg1)
	end)
	self:addElement(Contract2)
	self.Contract2 = Contract2
	local DailyContracts = LUI.UIText.new(0.5, 0.5, -740, -280, 0.5, 0.5, -361.5, -331.5)
	DailyContracts:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	DailyContracts:setText(LocalizeToUpperString(0xB27DDDD116F4EFF))
	DailyContracts:setTTF("ttmussels_demibold")
	DailyContracts:setLetterSpacing(2)
	DailyContracts:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(DailyContracts)
	self.DailyContracts = DailyContracts
	local DailyContractTimer = LUI.UIText.new(0.5, 0.5, -740, -280, 0.5, 0.5, -325.5, -307.5)
	DailyContractTimer:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	DailyContractTimer:setTTF("ttmussels_regular")
	DailyContractTimer:setLetterSpacing(2)
	DailyContractTimer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	DailyContractTimer:subscribeToGlobalModel(f1_arg1, "Contracts", "dailyExpirationTime", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DailyContractTimer:setText(LocalizeIntoStringIfNotEmpty(0x69797CFAD4CAB0C, f5_local0))
		end
	end)
	self:addElement(DailyContractTimer)
	self.DailyContractTimer = DailyContractTimer
	Daily.id = "Daily"
	Contract1.id = "Contract1"
	Contract2.id = "Contract2"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARContractsTabInternal.__onClose = function(f6_arg0)
	f6_arg0.AarMpBacking:close()
	f6_arg0.Daily:close()
	f6_arg0.Contract1:close()
	f6_arg0.Contract2:close()
	f6_arg0.DailyContractTimer:close()
end
