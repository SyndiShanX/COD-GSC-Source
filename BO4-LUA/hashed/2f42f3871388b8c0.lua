require("x64:1394ae5e9cdcb54")
require("x64:ffc2c7e4adad795")
require("x64:2d64ca9d3c705ce")
require("x64:877a413a004c441")
require("x64:9e155239e6593c")
require("x64:330e1ef77701a18")
require("x64:9d187b5785a45d7")
require("x64:20a0021e04d224d")
require("x64:4f8e5c53ea98803")
require("x64:3e4f33ba044e8d1")
CoD.BountyHunterPackageSelect = InheritFrom(CoD.Menu)
LUI.createMenu.BountyHunterPackageSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BountyHunterPackageSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetAsPriority(f1_local1, f1_arg0)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.BountyHunterPackageSelect)
	self.soundSet = "CAC_PrimaryWeapon"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local DarkBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DarkBG:setRGB(0, 0, 0)
	DarkBG:setAlpha(0.95)
	self:addElement(DarkBG)
	self.DarkBG = DarkBG
	local CommonCornerBrackets = CoD.CommonCornerBrackets01.new(f1_local1, f1_arg0, 0.5, 0.5, -925, 925, 0, 0, 138, 1008)
	CommonCornerBrackets:setAlpha(0.3)
	self:addElement(CommonCornerBrackets)
	self.CommonCornerBrackets = CommonCornerBrackets
	local LinePattern01 = LUI.UIImage.new(0.5, 0.5, -868.5, 868.5, 1, 1, -82, -70)
	LinePattern01:setAlpha(0.02)
	LinePattern01:setImage(RegisterImage(@"uie_hud_common_stripe_pattern01"))
	LinePattern01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	LinePattern01:setShaderVector(0, 0, 0, 0, 0)
	LinePattern01:setupNineSliceShader(24, 12)
	self:addElement(LinePattern01)
	self.LinePattern01 = LinePattern01
	local HorizAccentBR = LUI.UIImage.new(0.5, 0.5, 874.5, 894.5, 1, 1, -93, -85)
	HorizAccentBR:setAlpha(0.07)
	HorizAccentBR:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentBR:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentBR:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentBR)
	self.HorizAccentBR = HorizAccentBR
	local HorizAccentBL = LUI.UIImage.new(0.5, 0.5, -896, -876, 1, 1, -93, -85)
	HorizAccentBL:setAlpha(0.07)
	HorizAccentBL:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentBL:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentBL:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentBL)
	self.HorizAccentBL = HorizAccentBL
	local HorizAccentBtm = LUI.UIImage.new(0.5, 0.5, -870, 870, 1, 1, -93, -85)
	HorizAccentBtm:setAlpha(0.15)
	HorizAccentBtm:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentBtm:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentBtm:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentBtm:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentBtm)
	self.HorizAccentBtm = HorizAccentBtm
	local HorizAccentTR = LUI.UIImage.new(0.5, 0.5, 874.5, 894.5, 0, 0, 152, 160)
	HorizAccentTR:setAlpha(0.07)
	HorizAccentTR:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentTR:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentTR:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentTR)
	self.HorizAccentTR = HorizAccentTR
	local HorizAccentTL = LUI.UIImage.new(0.5, 0.5, -896, -876, 0, 0, 152, 160)
	HorizAccentTL:setAlpha(0.07)
	HorizAccentTL:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentTL:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentTL:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentTL)
	self.HorizAccentTL = HorizAccentTL
	local HorizAccentTop = LUI.UIImage.new(0.5, 0.5, -870, 870, 0, 0, 152, 160)
	HorizAccentTop:setAlpha(0.15)
	HorizAccentTop:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentTop:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentTop:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentTop)
	self.HorizAccentTop = HorizAccentTop
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -893.5, 893.5, 0, 0, 165.5, 980.5)
	NoiseTiledBacking:setRGB(0.52, 0.52, 0.52)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BarAccentRight = LUI.UIImage.new(0.5, 0.5, 901, 945, 0.5, 0.5, 27.5, 40.5)
	BarAccentRight:setAlpha(0.07)
	BarAccentRight:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	BarAccentRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	BarAccentRight:setShaderVector(0, 0, 0, 0, 0)
	BarAccentRight:setupNineSliceShader(8, 2)
	self:addElement(BarAccentRight)
	self.BarAccentRight = BarAccentRight
	local BarAccentLeft = LUI.UIImage.new(0.5, 0.5, -949, -905, 0.5, 0.5, 27.5, 40.5)
	BarAccentLeft:setAlpha(0.07)
	BarAccentLeft:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	BarAccentLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	BarAccentLeft:setShaderVector(0, 0, 0, 0, 0)
	BarAccentLeft:setupNineSliceShader(8, 2)
	self:addElement(BarAccentLeft)
	self.BarAccentLeft = BarAccentLeft
	local weaponList = LUI.UIList.new(f1_local1, f1_arg0, 10, 0, nil, false, false, false, false)
	weaponList:setLeftRight(0.5, 0.5, -784, 382)
	weaponList:setTopBottom(0, 0, 243, 973)
	weaponList:setWidgetType(CoD.BountyHunterPackageSingleTier)
	weaponList:setHorizontalCount(4)
	weaponList:setVerticalCount(5)
	weaponList:setSpacing(10)
	weaponList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	weaponList:setDataSource("BountyHunterPackages")
	weaponList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(weaponList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.BountyHunterUtility.BuyBountyHunterItem(self, controller, menu, element)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(weaponList)
	self.weaponList = weaponList
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_local1, f1_arg0, 0.5, 0.5, -1005, -805, 0, 0, 180, 214)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_local1, f1_arg0, 0.5, 0.5, 405, 576, 0, 0, 180, 214)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	local f1_local18 = nil
	f1_local18 = LUI.UIElement.createFake()
	self.FooterContainerFrontendRight = f1_local18
	local CommonHeaderBG01 = CoD.CommonHeaderHUDBG01.new(f1_local1, f1_arg0, 0.5, 0.5, -337.5, 337.5, 0, 0, 29, 81)
	self:addElement(CommonHeaderBG01)
	self.CommonHeaderBG01 = CommonHeaderBG01
	local CommonSubheaderBG = CoD.CommonSubHeaderBG01.new(f1_local1, f1_arg0, 0.5, 0.5, -337.5, 337.5, 0, 0, 86, 120)
	self:addElement(CommonSubheaderBG)
	self.CommonSubheaderBG = CommonSubheaderBG
	local StageTitle = LUI.UIText.new(0.5, 0.5, -335, 335, 0, 0, 34, 78)
	StageTitle:setRGB(0, 0, 0)
	StageTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](0xE8E14CAAF997B8))
	StageTitle:setTTF("ttmussels_demibold")
	StageTitle:setLetterSpacing(8)
	StageTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StageTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StageTitle)
	self.StageTitle = StageTitle
	local RadialTimer = CoD.RadialTimer.new(f1_local1, f1_arg0, 0.5, 0.5, 828, 978, 0, 0, -21, 129)
	RadialTimer:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueGreaterThan("BountyHunterLoadout.timeRemaining", 0)
			end,
		},
	})
	local HorizAccentTop2 = RadialTimer
	local Bank = RadialTimer.subscribeToModel
	local weaponCategoryList = Engine[@"getglobalmodel"]()
	Bank(HorizAccentTop2, weaponCategoryList["BountyHunterLoadout.timeRemaining"], function(f6_arg0)
		f1_local1:updateElementState(RadialTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "BountyHunterLoadout.timeRemaining",
		})
	end, false)
	RadialTimer:subscribeToGlobalModel(f1_arg0, "BountyHunterLoadout", "timeRemaining", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RadialTimer.Clock:setShaderVector(0, CoD.BountyHunterUtility.TimeRemainingClockFraction(0, 0, SetVectorComponent(0, 0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))))
		end
	end)
	RadialTimer:subscribeToGlobalModel(f1_arg0, "BountyHunterLoadout", "timeRemaining", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			RadialTimer.TimeText:setText(CoD.BaseUtility.AlreadyLocalized(f8_local0))
		end
	end)
	self:addElement(RadialTimer)
	self.RadialTimer = RadialTimer
	Bank = CoD.BountyHunterBank.new(f1_local1, f1_arg0, 0.5, 0.5, -138.5, 138.5, 0, 0, 86, 119)
	Bank:linkToElementModel(self, nil, false, function(model)
		Bank:setModel(model, f1_arg0)
	end)
	self:addElement(Bank)
	self.Bank = Bank
	HorizAccentTop2 = LUI.UIImage.new(0.5, 0.5, -803, 401, 0, 0, 210, 218)
	HorizAccentTop2:setAlpha(0.15)
	HorizAccentTop2:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentTop2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentTop2:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentTop2:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentTop2)
	self.HorizAccentTop2 = HorizAccentTop2
	weaponCategoryList = LUI.GridLayout.new(f1_local1, f1_arg0, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	weaponCategoryList:setLeftRight(0.5, 0.5, -800, 400)
	weaponCategoryList:setTopBottom(0, 0, 180, 215)
	weaponCategoryList:setWidgetType(CoD.CACTextTab)
	weaponCategoryList:setHorizontalCount(5)
	weaponCategoryList:setSpacing(0)
	weaponCategoryList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	weaponCategoryList:setDataSource("BountyHunterWeaponGroups")
	weaponCategoryList:registerEventHandler("list_active_changed", function(element, event)
		local f10_local0 = nil
		if CoD.BaseUtility.IsWidgetVisible(element) then
			SetStateByElementModel(self, element, f1_arg0, "state")
			SetProperty(self, "_itemGroup", element.category)
			UpdateDataSource(self, self.weaponList, f1_arg0)
		end
		return f10_local0
	end)
	self.__on_menuOpened_weaponCategoryList = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		local f11_local0 = weaponCategoryList
		if not IsElementPropertyValue(f11_local0, "_receivedMenuOpen", true) then
			SetElementProperty(f11_local0, "_receivedMenuOpen", true)
			CoD.BountyHunterUtility.SetActiveListItemForWeaponGroup(f11_arg2, f11_arg1, self.weaponCategoryList)
			UpdateDataSource(self, self.weaponList, f11_arg1)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_weaponCategoryList)
	self:addElement(weaponCategoryList)
	self.weaponCategoryList = weaponCategoryList
	local PackagePreview = CoD.BountyHunterPackagePreview.new(f1_local1, f1_arg0, 0.5, 0.5, 488, 868, 0, 0, 191, 956)
	self:addElement(PackagePreview)
	self.PackagePreview = PackagePreview
	local PCBackButton = nil
	PCBackButton = CoD.PC_BountyHunterBuy_BackButton.new(f1_local1, f1_arg0, 0.5, 0.5, -920, -720, 1, 1, -70, -10)
	PCBackButton.Button.ButtonContainer.Title:setText(LocalizeToUpperString(@"menu/back"))
	PCBackButton.GamepadTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/back"))
	PCBackButton:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCBackButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		LockInput(self, controller, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCBackButton)
	self.PCBackButton = PCBackButton
	PackagePreview:linkToElementModel(weaponList, nil, false, function(model)
		PackagePreview:setModel(model, f1_arg0)
	end)
	self:mergeStateConditions({
		{
			stateName = "NoCategories",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.weaponCategoryList)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f17_arg1)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		LockInput(self, controller, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	weaponList.id = "weaponList"
	f1_local18:setModel(self.buttonModel, f1_arg0)
	weaponCategoryList.id = "weaponCategoryList"
	if CoD.isPC then
		PCBackButton.id = "PCBackButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = weaponList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_weaponCategoryList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local28 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	CoD.GridAndListUtility.AddBumperNavigation(f1_local1, weaponCategoryList, f1_arg0)
	return self
end
CoD.BountyHunterPackageSelect.__resetProperties = function(f21_arg0)
	f21_arg0.weaponCategoryList:completeAnimation()
	f21_arg0.RB:completeAnimation()
	f21_arg0.LB:completeAnimation()
	f21_arg0.weaponCategoryList:setAlpha(1)
	f21_arg0.RB:setAlpha(1)
	f21_arg0.LB:setAlpha(1)
end
CoD.BountyHunterPackageSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	NoCategories = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.LB:completeAnimation()
			f23_arg0.LB:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.LB)
			f23_arg0.RB:completeAnimation()
			f23_arg0.RB:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RB)
			f23_arg0.weaponCategoryList:completeAnimation()
			f23_arg0.weaponCategoryList:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.weaponCategoryList)
		end,
	},
}
CoD.BountyHunterPackageSelect.__onClose = function(f24_arg0)
	f24_arg0.__on_close_removeOverrides()
	f24_arg0.PackagePreview:close()
	f24_arg0.CommonCornerBrackets:close()
	f24_arg0.weaponList:close()
	f24_arg0.LB:close()
	f24_arg0.RB:close()
	f24_arg0.FooterContainerFrontendRight:close()
	f24_arg0.CommonHeaderBG01:close()
	f24_arg0.CommonSubheaderBG:close()
	f24_arg0.RadialTimer:close()
	f24_arg0.Bank:close()
	f24_arg0.weaponCategoryList:close()
	f24_arg0.PCBackButton:close()
end
