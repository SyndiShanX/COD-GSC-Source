require("x64:dfb7742075cbb36")
require("x64:52e481f8ee460a4")
require("x64:2d52a11dde9653")
require("x64:f91cf6839d25705")
require("x64:7889ce1e3e2e8a")
CoD.BM_ContractsFrame = InheritFrom(LUI.UIElement)
CoD.BM_ContractsFrame.__defaultWidth = 1920
CoD.BM_ContractsFrame.__defaultHeight = 1080
CoD.BM_ContractsFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f1_arg1, false)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "lootContracts.pinnedContractStatus_1")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "lootContracts.pinnedContractStatus_2")
	self:setClass(CoD.BM_ContractsFrame)
	self.id = "BM_ContractsFrame"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuOptionsBackground = CoD.StartMenuOptionsBackground.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuOptionsBackground)
	self.StartMenuOptionsBackground = StartMenuOptionsBackground
	local f1_local2 = nil
	self.TrayRight = LUI.UIElement.createFake()
	local f1_local3 = nil
	self.TrayLeft = LUI.UIElement.createFake()
	local NoiseBackingRight = LUI.UIImage.new(0, 1, 0, 0, -0, 1, -30, -30)
	NoiseBackingRight:setAlpha(0.1)
	NoiseBackingRight:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseBackingRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseBackingRight:setShaderVector(0, 0, 0, 0, 0)
	NoiseBackingRight:setupNineSliceShader(196, 88)
	self:addElement(NoiseBackingRight)
	self.NoiseBackingRight = NoiseBackingRight
	local Contract2 = CoD.BM_ContractDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, 363, 823, 0.5, 0.5, -340.5, 295.5)
	Contract2:mergeStateConditions({
		{
			stateName = "ContractSlot",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	Contract2:subscribeToGlobalModel(f1_arg1, "Contracts", "contractSlot2", function(model)
		Contract2:setModel(model, f1_arg1)
	end)
	Contract2:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Contract2, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsElementInState(self.Contract2, "ContractSlot") then
			OpenOverlay(self, "BlackMarketContractSelect", controller, {
				_contractSlot = 2,
				_model = element:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.Contract2, "ContractSlot") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(Contract2)
	self.Contract2 = Contract2
	local Contract1 = CoD.BM_ContractDetails.new(f1_arg0, f1_arg1, 0.5, 0.5, -123, 337, 0.5, 0.5, -340.5, 295.5)
	Contract1:mergeStateConditions({
		{
			stateName = "ContractSlot",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	Contract1:subscribeToGlobalModel(f1_arg1, "Contracts", "contractSlot1", function(model)
		Contract1:setModel(model, f1_arg1)
	end)
	Contract1:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Contract1, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsElementInState(self.Contract1, "ContractSlot") then
			OpenOverlay(self, "BlackMarketContractSelect", controller, {
				_contractSlot = 1,
				_model = element:getModel(),
			})
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.Contract1, "ContractSlot") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(Contract1)
	self.Contract1 = Contract1
	local DailyContract = CoD.BM_DailyContract.new(f1_arg0, f1_arg1, 0.5, 0.5, -873, -323, 0.5, 0.5, -531, 549)
	DailyContract:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "displayName", 0x0)
			end,
		},
	})
	DailyContract:linkToElementModel(DailyContract, "displayName", true, function(model)
		f1_arg0:updateElementState(DailyContract, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "displayName",
		})
	end)
	DailyContract:linkToElementModel(DailyContract, "completed", true, function(model)
		f1_arg0:updateElementState(DailyContract, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	DailyContract:subscribeToGlobalModel(f1_arg1, "Contracts", "dailyActive", function(model)
		DailyContract:setModel(model, f1_arg1)
	end)
	self:addElement(DailyContract)
	self.DailyContract = DailyContract
	local DailyContracts = LUI.UIText.new(0.5, 0.5, -874.5, -331.5, 0.5, 0.5, -413.5, -383.5)
	DailyContracts:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	DailyContracts:setText(LocalizeToUpperString(0xB27DDDD116F4EFF))
	DailyContracts:setTTF("ttmussels_demibold")
	DailyContracts:setLetterSpacing(2)
	DailyContracts:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(DailyContracts)
	self.DailyContracts = DailyContracts
	local DailyContractTimer = LUI.UIText.new(0.5, 0.5, -873.5, -330.5, 0.5, 0.5, -383.5, -365.5)
	DailyContractTimer:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	DailyContractTimer:setTTF("ttmussels_regular")
	DailyContractTimer:setLetterSpacing(2)
	DailyContractTimer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DailyContractTimer:subscribeToGlobalModel(f1_arg1, "Contracts", "dailyExpirationTime", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			DailyContractTimer:setText(LocalizeIntoStringIfNotEmpty(0x69797CFAD4CAB0C, f16_local0))
		end
	end)
	self:addElement(DailyContractTimer)
	self.DailyContractTimer = DailyContractTimer
	local DirectorLobbyTierSkipNotification = CoD.DirectorLobbyTierSkipNotification.new(f1_arg0, f1_arg1, 0.5, 0.5, -832.5, -322.5, 0.5, 0.5, 319, 413)
	self:addElement(DirectorLobbyTierSkipNotification)
	self.DirectorLobbyTierSkipNotification = DirectorLobbyTierSkipNotification
	local NewContractsTimer = LUI.UIText.new(0.5, 0.5, -115, 345, 0.5, 0.5, -383.5, -365.5)
	NewContractsTimer:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	NewContractsTimer:setTTF("ttmussels_regular")
	NewContractsTimer:setLetterSpacing(2)
	NewContractsTimer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	NewContractsTimer:subscribeToGlobalModel(f1_arg1, "Contracts", "availableExpirationTime", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			NewContractsTimer:setText(LocalizeIntoStringIfNotEmpty(0xDFF0B6C9E6A2356, f17_local0))
		end
	end)
	self:addElement(NewContractsTimer)
	self.NewContractsTimer = NewContractsTimer
	local Bracket = LUI.UIImage.new(0.5, 0.5, -124, 824, 0.5, 0.5, -394.5, -385.5)
	Bracket:setAlpha(0.5)
	Bracket:setZRot(180)
	Bracket:setImage(RegisterImage(0xC325BED3F226657))
	Bracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Bracket:setShaderVector(0, 0, 0, 0, 0)
	Bracket:setupNineSliceShader(16, 4)
	self:addElement(Bracket)
	self.Bracket = Bracket
	self:subscribeToGlobalModel(f1_arg1, "PerController", "lootContracts.forceRefresh", function(model)
		local f18_local0 = self
		CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f1_arg1, false)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "lootContracts.pinnedContractStatus_1", function(model)
		local f19_local0 = self
		CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f1_arg1, false)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "lootContracts.pinnedContractStatus_2", function(model)
		local f20_local0 = self
		CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f1_arg1, false)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Contracts.dailyContractsExpired", function(model)
		local f21_local0 = self
		CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(f1_arg1, false)
	end)
	Contract2.id = "Contract2"
	Contract1.id = "Contract1"
	self.__defaultFocus = Contract1
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ContractsFrame.__resetProperties = function(f22_arg0)
	f22_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
	f22_arg0.DailyContracts:completeAnimation()
	f22_arg0.DailyContract:completeAnimation()
	f22_arg0.Contract2:completeAnimation()
	f22_arg0.Contract1:completeAnimation()
	f22_arg0.DirectorLobbyTierSkipNotification:setAlpha(1)
	f22_arg0.DailyContracts:setAlpha(1)
	f22_arg0.DailyContract:setAlpha(1)
	f22_arg0.Contract2:setAlpha(1)
	f22_arg0.Contract1:setAlpha(1)
end
CoD.BM_ContractsFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(5)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(320, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.Contract2:beginAnimation(300)
				f24_arg0.Contract2:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Contract2:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.Contract2:completeAnimation()
			f24_arg0.Contract2:setAlpha(0)
			f24_local0(f24_arg0.Contract2)
			local f24_local1 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(320, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f28_arg0:setAlpha(1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.Contract1:beginAnimation(190)
				f24_arg0.Contract1:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Contract1:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f24_arg0.Contract1:completeAnimation()
			f24_arg0.Contract1:setAlpha(0)
			f24_local1(f24_arg0.Contract1)
			local f24_local2 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(280, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f30_arg0:setAlpha(1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.DailyContract:beginAnimation(130)
				f24_arg0.DailyContract:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DailyContract:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f24_arg0.DailyContract:completeAnimation()
			f24_arg0.DailyContract:setAlpha(0)
			f24_local2(f24_arg0.DailyContract)
			local f24_local3 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(280, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.DailyContracts:beginAnimation(130)
				f24_arg0.DailyContracts:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DailyContracts:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f24_arg0.DailyContracts:completeAnimation()
			f24_arg0.DailyContracts:setAlpha(0)
			f24_local3(f24_arg0.DailyContracts)
			local f24_local4 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(310, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.DirectorLobbyTierSkipNotification:beginAnimation(420)
				f24_arg0.DirectorLobbyTierSkipNotification:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DirectorLobbyTierSkipNotification:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f24_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
			f24_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
			f24_local4(f24_arg0.DirectorLobbyTierSkipNotification)
		end,
	},
}
CoD.BM_ContractsFrame.__onClose = function(f35_arg0)
	f35_arg0.StartMenuOptionsBackground:close()
	f35_arg0.Contract2:close()
	f35_arg0.Contract1:close()
	f35_arg0.DailyContract:close()
	f35_arg0.DailyContractTimer:close()
	f35_arg0.DirectorLobbyTierSkipNotification:close()
	f35_arg0.NewContractsTimer:close()
end
