require("x64:3f0c583dc4db051")
require("x64:94dab3a4d2d79b2")
require("x64:5d80cb371475b19")
require("x64:f035e2b6323687d")
require("x64:a24b28b508f6914")
require("x64:4cee61320cd1f1b")
CoD.DiaDeLosMuertosRedemptionPopup = InheritFrom(CoD.Menu)
LUI.createMenu.DiaDeLosMuertosRedemptionPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DiaDeLosMuertosRedemptionPopup", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, self, f1_arg1._model)
	self:setClass(CoD.DiaDeLosMuertosRedemptionPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
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
	FullscreenPopupTemplate.ErrorSubtitle:setText(Engine[0xF9F1239CFD921FE](0x9768A66571AA0BA))
	FullscreenPopupTemplate.WorkingTitle:setText(LocalizeToUpperString(0x67B9487B8B4E09C))
	FullscreenPopupTemplate.DoneTitle:setText(Engine[0xF9F1239CFD921FE](0xEF90EDFB180B9A2))
	FullscreenPopupTemplate:linkToElementModel(self, nil, false, function(model)
		FullscreenPopupTemplate:setModel(model, f1_arg0)
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			FullscreenPopupTemplate.Subtitle:setText(LocalizeIntoString(0x7A8CE209945317C, f7_local0))
		end
	end)
	FullscreenPopupTemplate:linkToElementModel(self, "name", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			FullscreenPopupTemplate.Title:setText(LocalizeToUpperString(LocalizeIntoString(0x38044C9897FFD7D, f8_local0)))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(FullscreenPopupTemplate, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if IsPC() and IsElementInState(element, "FinishedState") then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		elseif IsPC() then
			CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, controller, element, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		end
	end)
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	local Box = LUI.UIImage.new(0.5, 0.5, -898, -383, 0.5, 0.5, -190, 140)
	Box:setRGB(0.28, 0.34, 0.37)
	Box:setAlpha(0.2)
	self:addElement(Box)
	self.Box = Box
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_local1, f1_arg0, 0.5, 0.5, -897.5, -382.5, 0.5, 0.5, -190, 140)
	DotCorner9Slice:setAlpha(0.1)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local CostText = LUI.UIText.new(0.5, 0.5, -959.5, -329.5, 0.5, 0.5, 166, 196)
	CostText:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	CostText:setTTF("ttmussels_demibold")
	CostText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CostText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CostText:linkToElementModel(self, "price", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CostText:setText(LocalizeIntoString(0x6A3CC7BE3008989, f10_local0))
		end
	end)
	self:addElement(CostText)
	self.CostText = CostText
	local SelfIdentityBadge = CoD.SelfIdentityBadge.new(f1_local1, f1_arg0, 0.5, 0.5, 541, 872, 0, 0, 33.5, 98.5)
	SelfIdentityBadge:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge", function(model)
		SelfIdentityBadge:setModel(model, f1_arg0)
	end)
	self:addElement(SelfIdentityBadge)
	self.SelfIdentityBadge = SelfIdentityBadge
	local StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 341, 445, 0, 0, 23.5, 103.5)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f12_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	local Linker = LUI.UIImage.new(0.5, 0.5, -330, -326, 0.5, 0.5, -192, 205)
	Linker:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Linker:setAlpha(0.35)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local CornerPip = LUI.UIImage.new(0.5, 0.5, -802.5, -786.5, 0.5, 0.5, -187, -171)
	CornerPip:setAlpha(0.4)
	CornerPip:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip)
	self.CornerPip = CornerPip
	local CornerPip2 = LUI.UIImage.new(0.5, 0.5, -494.5, -478.5, 0.5, 0.5, -187, -171)
	CornerPip2:setAlpha(0.4)
	CornerPip2:setZRot(270)
	CornerPip2:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip2)
	self.CornerPip2 = CornerPip2
	local CornerPip3 = LUI.UIImage.new(0.5, 0.5, -803.5, -787.5, 0.5, 0.5, 122, 138)
	CornerPip3:setAlpha(0.4)
	CornerPip3:setZRot(90)
	CornerPip3:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip3)
	self.CornerPip3 = CornerPip3
	local CornerPip4 = LUI.UIImage.new(0.5, 0.5, -494.5, -478.5, 0.5, 0.5, 121, 137)
	CornerPip4:setAlpha(0.4)
	CornerPip4:setZRot(180)
	CornerPip4:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip4)
	self.CornerPip4 = CornerPip4
	local Image = LUI.UIImage.new(0.5, 0.5, -898, -385, 0.5, 0.5, -189, 139)
	Image:setImage(RegisterImage(CoD.EntitlementUtility.GetDOTDImageRedemption(0xC441A414036272D)))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setShaderVector(1, 1, 1, 0, 0)
	Image:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local TabbedScoreboardFuiBox2 = CoD.TabbedScoreboardFuiBox.new(f1_local1, f1_arg0, 0.5, 0.5, -494, -382, 0.5, 0.5, 172, 188)
	TabbedScoreboardFuiBox2:setZRot(180)
	self:addElement(TabbedScoreboardFuiBox2)
	self.TabbedScoreboardFuiBox2 = TabbedScoreboardFuiBox2
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_local1, f1_arg0, 0.5, 0.5, -899, -787, 0.5, 0.5, 172, 188)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	self:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f13_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local17(f1_local16, f1_local18.LastInput, function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
			return true
		elseif IsElementInState(self.FullscreenPopupTemplate, "ErrorState") and not IsMouseOrKeyboard(controller) then
			CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
			return true
		elseif not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			SetElementWorkingStateAndPurchaseDWSKU(self.FullscreenPopupTemplate, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementInState(self.FullscreenPopupTemplate, "FinishedState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
			return true
		elseif IsElementInState(self.FullscreenPopupTemplate, "ErrorState") and not IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif not IsElementInState(self.FullscreenPopupTemplate, "WorkingState") and not IsElementInState(self.FullscreenPopupTemplate, "ErrorState") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x867BE59364DD53B, nil, nil)
			return true
		else
			return false
		end
	end, false)
	FullscreenPopupTemplate.buttons:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.buttonPC:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate.id = "FullscreenPopupTemplate"
	SelfIdentityBadge.id = "SelfIdentityBadge"
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
	if CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg0, "isContract") then
		SetMenuProperty(f1_local1, "_isContract", true)
	elseif IsPC() then
		SetMenuProperty(f1_local1, "_openEntitlementPopups", true)
	end
	return self
end
CoD.DiaDeLosMuertosRedemptionPopup.__onClose = function(f19_arg0)
	f19_arg0.FullscreenPopupTemplate:close()
	f19_arg0.DotCorner9Slice:close()
	f19_arg0.CostText:close()
	f19_arg0.SelfIdentityBadge:close()
	f19_arg0.StartMenuCODpoints:close()
	f19_arg0.TabbedScoreboardFuiBox2:close()
	f19_arg0.TabbedScoreboardFuiBox:close()
end
