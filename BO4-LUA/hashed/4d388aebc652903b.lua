require("x64:bc6e2379d2241fb")
require("x64:3f0c583dc4db051")
require("x64:68036bda8abbe94")
require("x64:5d80cb371475b19")
require("x64:b175512a7a605a8")
CoD.ReplaceActiveContractOverlay = InheritFrom(CoD.Menu)
LUI.createMenu.ReplaceActiveContractOverlay = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ReplaceActiveContractOverlay", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	SetMenuProperty(f1_local1, "__keepPopupButtonListPC", true)
	self:setClass(CoD.ReplaceActiveContractOverlay)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
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
	FullscreenPopupTemplate.ErrorSubtitle:setText("")
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(@"hash_5A2A39DBF511E376"))
	FullscreenPopupTemplate.Title:setText(LocalizeToUpperString(@"hash_5A2A39DBF511E376"))
	FullscreenPopupTemplate.DoneTitle:setText("")
	FullscreenPopupTemplate:linkToElementModel(self, nil, false, function(model)
		FullscreenPopupTemplate:setModel(model, f1_arg0)
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			FullscreenPopupTemplate.Subtitle:setText(CoD.ContractUtility.GetActivateContractConfirmDesc(self:getModel(), f1_arg0, f7_local0))
		end
	end)
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local Linker = LUI.UIImage.new(0.5, 0.5, -330, -326, 0.5, 0.5, -192, 205)
	Linker:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Linker:setAlpha(0.35)
	Linker:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local CornerPip = LUI.UIImage.new(0.5, 0.5, -804, -788, 0.5, 0.5, -187, -171)
	CornerPip:setAlpha(0.4)
	CornerPip:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip)
	self.CornerPip = CornerPip
	local CornerPip2 = LUI.UIImage.new(0.5, 0.5, -495, -479, 0.5, 0.5, -187, -171)
	CornerPip2:setAlpha(0.4)
	CornerPip2:setZRot(270)
	CornerPip2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip2)
	self.CornerPip2 = CornerPip2
	local CornerPip3 = LUI.UIImage.new(0.5, 0.5, -804, -788, 0.5, 0.5, 122, 138)
	CornerPip3:setAlpha(0.4)
	CornerPip3:setZRot(90)
	CornerPip3:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip3)
	self.CornerPip3 = CornerPip3
	local CornerPip4 = LUI.UIImage.new(0.5, 0.5, -495, -479, 0.5, 0.5, 121, 137)
	CornerPip4:setAlpha(0.4)
	CornerPip4:setZRot(180)
	CornerPip4:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip4)
	self.CornerPip4 = CornerPip4
	local Black = LUI.UIImage.new(0.5, 0.5, -957, -327, 0.5, 0.5, -214.5, 230.5)
	Black:setRGB(0, 0, 0)
	Black:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	Black:setShaderVector(0, 0, 1, 0, 0)
	Black:setShaderVector(1, 0, 0.16, 0, 0)
	Black:setShaderVector(2, 0, 1, 0, 0)
	Black:setShaderVector(3, 0, 0, 0, 0)
	Black:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Black)
	self.Black = Black
	local ContentImage = CoD.PurchaseItemContentImage.new(f1_local1, f1_arg0, 0.5, 0.5, -1244, -412, 0.5, 0.5, -204, 172)
	ContentImage:linkToElementModel(self, nil, false, function(model)
		ContentImage:setModel(model, f1_arg0)
	end)
	self:addElement(ContentImage)
	self.ContentImage = ContentImage
	local ActiveContractProgressBar = CoD.ContractProgressBar.new(f1_local1, f1_arg0, 0.5, 0.5, -814, -470, 0.5, 0.5, 201, 219)
	ActiveContractProgressBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ActiveContractProgressBar:setScale(1.4, 1.4)
	ActiveContractProgressBar:linkToElementModel(self, nil, false, function(model)
		ActiveContractProgressBar:setModel(model, f1_arg0)
	end)
	self:addElement(ActiveContractProgressBar)
	self.ActiveContractProgressBar = ActiveContractProgressBar
	local ContractName = LUI.UIText.new(0.5, 0.5, -957, -327, 0.5, 0.5, 144.5, 183.5)
	ContractName:setTTF("ttmussels_demibold")
	ContractName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ContractName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ContractName:linkToElementModel(self, "name", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ContractName:setText(Engine[@"hash_4F9F1239CFD921FE"](f11_local0))
		end
	end)
	self:addElement(ContractName)
	self.ContractName = ContractName
	local CommonIdentityWidgetStreamlinedPC = nil
	CommonIdentityWidgetStreamlinedPC = CoD.CommonIdentityWidgetStreamlined.new(f1_local1, f1_arg0, 0.5, 0.5, 426, 956, 0.5, 0.5, -282, -242)
	CommonIdentityWidgetStreamlinedPC:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlinedPC:setModel(model, f1_arg0)
	end)
	self:addElement(CommonIdentityWidgetStreamlinedPC)
	self.CommonIdentityWidgetStreamlinedPC = CommonIdentityWidgetStreamlinedPC
	local f1_local13 = nil
	self.CommonIdentityWidgetStreamlinedC = LUI.UIElement.createFake()
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsElementInState(self.FullscreenPopupTemplate, "DefaultState") then
			CoD.ContractUtility.ReplaceActiveContract(self.FullscreenPopupTemplate, menu, controller, 5000)
			PlaySoundAlias("uin_contract_activate")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/contract_activate", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if IsElementInState(self.FullscreenPopupTemplate, "DefaultState") then
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "DefaultState") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
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
	local f1_local14 = self
	f1_local14 = FullscreenPopupTemplate
	if IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local14, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end
	return self
end
CoD.ReplaceActiveContractOverlay.__resetProperties = function(f18_arg0)
	f18_arg0.Black:completeAnimation()
	f18_arg0.Black:setShaderVector(0, 0, 1, 0, 0)
	f18_arg0.Black:setShaderVector(1, 0, 0.16, 0, 0)
	f18_arg0.Black:setShaderVector(2, 0, 1, 0, 0)
	f18_arg0.Black:setShaderVector(3, 0, 0, 0, 0)
	f18_arg0.Black:setShaderVector(4, 0, 0, 0, 0)
end
CoD.ReplaceActiveContractOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.Black:completeAnimation()
			f20_arg0.Black:setShaderVector(0, 0, 1, 0, 0)
			f20_arg0.Black:setShaderVector(1, 0.16, 0.16, 0, 0)
			f20_arg0.Black:setShaderVector(2, 0, 1, 0, 0)
			f20_arg0.Black:setShaderVector(3, 0, 0, 0, 0)
			f20_arg0.Black:setShaderVector(4, 0, 0, 0, 0)
			f20_arg0.clipFinished(f20_arg0.Black)
		end,
	},
}
CoD.ReplaceActiveContractOverlay.__onClose = function(f21_arg0)
	f21_arg0.FullscreenPopupTemplate:close()
	f21_arg0.ContentImage:close()
	f21_arg0.ActiveContractProgressBar:close()
	f21_arg0.ContractName:close()
	f21_arg0.CommonIdentityWidgetStreamlinedPC:close()
	f21_arg0.CommonIdentityWidgetStreamlinedC:close()
end
