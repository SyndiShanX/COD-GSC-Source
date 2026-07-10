require("x64:db806626fb64f10")
require("x64:d4429bcf6580c74")
require("x64:7889ce1e3e2e8a")
CoD.PurchasedContractsMenu = InheritFrom(CoD.Menu)
LUI.createMenu.PurchasedContractsMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PurchasedContractsMenu", f1_arg0)
	local f1_local1 = self
	SetPerControllerTableProperty(f1_arg0, "_isPurchasedContractMenu", true)
	self:setClass(CoD.PurchasedContractsMenu)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, -0, 1, 0, 0, -0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/contracts"))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local ContractsListContainer = CoD.PurchasedContractsMenuContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(ContractsListContainer)
	self.ContractsListContainer = ContractsListContainer
	self:mergeStateConditions({
		{
			stateName = "NoContracts",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.ContractList)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f4_arg1)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetPerControllerTableProperty(f1_arg0, "_isPurchasedContractMenu", false)
	end)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	ContractsListContainer.id = "ContractsListContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = GenericMenuFrameIdentity
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.PurchasedContractsMenu.__onClose = function(f8_arg0)
	f8_arg0.Background:close()
	f8_arg0.GenericMenuFrameIdentity:close()
	f8_arg0.ContractsListContainer:close()
end
