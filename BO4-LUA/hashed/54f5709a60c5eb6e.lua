require("x64:db806626fb64f10")
require("x64:4578da2409f9269")
require("x64:52e481f8ee460a4")
require("x64:a6067d35a987dd5")
require("x64:7889ce1e3e2e8a")
CoD.BlackMarketContractSelect = InheritFrom(CoD.Menu)
LUI.createMenu.BlackMarketContractSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BlackMarketContractSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	SetMenuProperty(f1_local1, "_contractSlot", f1_arg1._contractSlot)
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "lootContracts.pinnedContractStatus_1")
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "lootContracts.pinnedContractStatus_2")
	CoD.BlackMarketUtility.SetupContractAvailabilityTimers(f1_arg0, f1_local1)
	self:setClass(CoD.BlackMarketContractSelect)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local StartMenuOptionsBackground = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, -0, 1, 0, 0)
	self:addElement(StartMenuOptionsBackground)
	self.StartMenuOptionsBackground = StartMenuOptionsBackground
	local f1_local3 = nil
	self.TrayRight = LUI.UIElement.createFake()
	local f1_local4 = nil
	self.TrayLeft = LUI.UIElement.createFake()
	local NoiseBackingRight = LUI.UIImage.new(-0.12, 1.12, 0, 0, 0, 1, 0, 0)
	NoiseBackingRight:setAlpha(0.1)
	NoiseBackingRight:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseBackingRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseBackingRight:setShaderVector(0, 0, 0, 0, 0)
	NoiseBackingRight:setupNineSliceShader(196, 88)
	self:addElement(NoiseBackingRight)
	self.NoiseBackingRight = NoiseBackingRight
	local BMEmptyContractSlotColumn3 = CoD.BM_EmptyContractSlotColumn.new(f1_local1, f1_arg0, 0.5, 0.5, -514.5, -315.5, 0.5, 0.5, -107.5, 92.5)
	self:addElement(BMEmptyContractSlotColumn3)
	self.BMEmptyContractSlotColumn3 = BMEmptyContractSlotColumn3
	local BMEmptyContractSlotColumn = CoD.BM_EmptyContractSlotColumn.new(f1_local1, f1_arg0, 0.5, 0.5, -514.5, -315.5, 0.5, 0.5, -325.5, -125.5)
	self:addElement(BMEmptyContractSlotColumn)
	self.BMEmptyContractSlotColumn = BMEmptyContractSlotColumn
	local BMEmptyContractSlotColumn2 = CoD.BM_EmptyContractSlotColumn.new(f1_local1, f1_arg0, 0.5, 0.5, -296, -97, 0.5, 0.5, -325.5, -125.5)
	self:addElement(BMEmptyContractSlotColumn2)
	self.BMEmptyContractSlotColumn2 = BMEmptyContractSlotColumn2
	local BMEmptyContractSlotColumn4 = CoD.BM_EmptyContractSlotColumn.new(f1_local1, f1_arg0, 0.5, 0.5, -296, -97, 0.5, 0.5, -107.5, 92.5)
	self:addElement(BMEmptyContractSlotColumn4)
	self.BMEmptyContractSlotColumn4 = BMEmptyContractSlotColumn4
	local BMEmptyContractSlotColumn5 = CoD.BM_EmptyContractSlotColumn.new(f1_local1, f1_arg0, 0.5, 0.5, -296, -97, 0.5, 0.5, 110.5, 310.5)
	self:addElement(BMEmptyContractSlotColumn5)
	self.BMEmptyContractSlotColumn5 = BMEmptyContractSlotColumn5
	local BMEmptyContractSlotColumn6 = CoD.BM_EmptyContractSlotColumn.new(f1_local1, f1_arg0, 0.5, 0.5, -514.5, -315.5, 0.5, 0.5, 110.5, 310.5)
	self:addElement(BMEmptyContractSlotColumn6)
	self.BMEmptyContractSlotColumn6 = BMEmptyContractSlotColumn6
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyMainMode", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(Engine[0xF9F1239CFD921FE](CoD.BlackMarketUtility.GetContractHeaderStringFromLobbyMainMode(f1_arg0, f2_local0)))
		end
	end)
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local BMAvailableContractsListContainer = CoD.BM_AvailableContractsListContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -515, -15, 0.5, 0.5, -326.5, 373.5)
	self:addElement(BMAvailableContractsListContainer)
	self.BMAvailableContractsListContainer = BMAvailableContractsListContainer
	local Contract1 = CoD.BM_ContractDetails.new(f1_local1, f1_arg0, 0.5, 0.5, 97, 557, 0.5, 0.5, -325.5, 310.5)
	Contract1:mergeStateConditions({
		{
			stateName = "ContractSlot",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	Contract1.BMContractDetailsInternal.Lines:setAlpha(0)
	self:addElement(Contract1)
	self.Contract1 = Contract1
	local NewContractsTimer = LUI.UIText.new(0.5, 0.5, -509, -49, 0.5, 0.5, -383.5, -365.5)
	NewContractsTimer:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	NewContractsTimer:setTTF("ttmussels_regular")
	NewContractsTimer:setLetterSpacing(2)
	NewContractsTimer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	NewContractsTimer:subscribeToGlobalModel(f1_arg0, "Contracts", "availableExpirationTime", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			NewContractsTimer:setText(LocalizeIntoStringIfNotEmpty(0xDFF0B6C9E6A2356, f5_local0))
		end
	end)
	self:addElement(NewContractsTimer)
	self.NewContractsTimer = NewContractsTimer
	local Bracket = LUI.UIImage.new(0.5, 0.5, -514, -96, 0.5, 0.5, -394.5, -385.5)
	Bracket:setAlpha(0.5)
	Bracket:setZRot(180)
	Bracket:setImage(RegisterImage(0xC325BED3F226657))
	Bracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Bracket:setShaderVector(0, 0, 0, 0, 0)
	Bracket:setupNineSliceShader(16, 4)
	self:addElement(Bracket)
	self.Bracket = Bracket
	Contract1:linkToElementModel(BMAvailableContractsListContainer.AvailableContractsList, nil, false, function(model)
		Contract1:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.BlackMarketUtility.UpdateActiveContractSlotsModels(controller, false)
		GoBack(self, controller)
		PlaySoundAlias("uin_cmn_backout")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	BMAvailableContractsListContainer.id = "BMAvailableContractsListContainer"
	Contract1.id = "Contract1"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = BMAvailableContractsListContainer
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.BlackMarketContractSelect.__resetProperties = function(f9_arg0)
	f9_arg0.BMAvailableContractsListContainer:completeAnimation()
	f9_arg0.Contract1:completeAnimation()
	f9_arg0.BMAvailableContractsListContainer:setAlpha(1)
	f9_arg0.Contract1:setAlpha(1)
end
CoD.BlackMarketContractSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.BMAvailableContractsListContainer:beginAnimation(110)
				f10_arg0.BMAvailableContractsListContainer:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.BMAvailableContractsListContainer:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.BMAvailableContractsListContainer:completeAnimation()
			f10_arg0.BMAvailableContractsListContainer:setAlpha(0)
			f10_local0(f10_arg0.BMAvailableContractsListContainer)
			local f10_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.Contract1:beginAnimation(210)
				f10_arg0.Contract1:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Contract1:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f10_arg0.Contract1:completeAnimation()
			f10_arg0.Contract1:setAlpha(0)
			f10_local1(f10_arg0.Contract1)
		end,
	},
}
CoD.BlackMarketContractSelect.__onClose = function(f15_arg0)
	f15_arg0.Contract1:close()
	f15_arg0.StartMenuOptionsBackground:close()
	f15_arg0.BMEmptyContractSlotColumn3:close()
	f15_arg0.BMEmptyContractSlotColumn:close()
	f15_arg0.BMEmptyContractSlotColumn2:close()
	f15_arg0.BMEmptyContractSlotColumn4:close()
	f15_arg0.BMEmptyContractSlotColumn5:close()
	f15_arg0.BMEmptyContractSlotColumn6:close()
	f15_arg0.GenericMenuFrameIdentity:close()
	f15_arg0.BMAvailableContractsListContainer:close()
	f15_arg0.NewContractsTimer:close()
end
