require("x64:34778f864da9dda")
require("x64:9d92dce1e4291ce")
require("x64:33ec8b4b2fb3c47")
require("x64:3b8c4e45eb2b0d7")
require("x64:64f4965c2a27a0f")
require("x64:2485f9df271d384")
require("x64:583b65a500f0240")
CoD.AmmoWidgetMP_Ultimate_Internal = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_Ultimate_Internal.__defaultWidth = 268
CoD.AmmoWidgetMP_Ultimate_Internal.__defaultHeight = 120
CoD.AmmoWidgetMP_Ultimate_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_Ultimate_Internal)
	self.id = "AmmoWidgetMP_Ultimate_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 79.5, 183.5, 0, 0, 10.5, 120.5)
	Blur:setImage(RegisterImage(0x7C42B938F911DF9))
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local BlurRight = LUI.UIImage.new(0, 0, 181.5, 248.5, 0, 0, 31.5, 98.5)
	BlurRight:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurRight:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurRight)
	self.BlurRight = BlurRight
	local BlurLeft = LUI.UIImage.new(0, 0, 16.5, 85.5, 0, 0, 32, 96)
	BlurLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurLeft:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurLeft)
	self.BlurLeft = BlurLeft
	local PanelRight = LUI.UIImage.new(0, 0, 180, 249, 0, 0, 33.5, 95.5)
	PanelRight:setRGB(0.18, 0.17, 0.16)
	PanelRight:setAlpha(0.94)
	self:addElement(PanelRight)
	self.PanelRight = PanelRight
	local PanelLeft = LUI.UIImage.new(0, 0, 17.5, 86.5, 0, 0, 33.5, 95.5)
	PanelLeft:setRGB(0.18, 0.17, 0.16)
	PanelLeft:setAlpha(0.94)
	self:addElement(PanelLeft)
	self.PanelLeft = PanelLeft
	local Panel = LUI.UIImage.new(0, 0, 79.5, 183.5, 0, 0, 10.5, 120.5)
	Panel:setRGB(0.18, 0.17, 0.16)
	Panel:setAlpha(0.94)
	Panel:setImage(RegisterImage(0x7C42B938F911DF9))
	self:addElement(Panel)
	self.Panel = Panel
	local ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -65, 65, 0, 0, -19, 5)
	ControllerDependentTextBox:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
				if not f2_local0 then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					if not f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xC57360571B0917E])
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseAbility",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseUltimate",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysTrue()
			end,
		},
		{
			stateName = "KeyboardAndMouseScoreStreak",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
	})
	local Frame = ControllerDependentTextBox
	local TankUseString = ControllerDependentTextBox.subscribeToModel
	local GlowHero = Engine[0x4DF5CFBC1771947](f1_arg1)
	TankUseString(Frame, GlowHero["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f7_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	Frame = ControllerDependentTextBox
	TankUseString = ControllerDependentTextBox.subscribeToModel
	GlowHero = Engine[0x4DF5CFBC1771947](f1_arg1)
	TankUseString(Frame, GlowHero["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f8_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	Frame = ControllerDependentTextBox
	TankUseString = ControllerDependentTextBox.subscribeToModel
	GlowHero = Engine[0x4DF5CFBC1771947](f1_arg1)
	TankUseString(Frame, GlowHero["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f9_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
		})
	end, false)
	ControllerDependentTextBox:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ControllerDependentTextBox, f10_arg1)
	end)
	Frame = ControllerDependentTextBox
	TankUseString = ControllerDependentTextBox.subscribeToModel
	GlowHero = Engine[0x4DF5CFBC1771947](f1_arg1)
	TankUseString(Frame, GlowHero.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ControllerDependentTextBox:setAlpha(0)
	ControllerDependentTextBox:setScale(SetCustomScaleDependingOnPlatform(f1_arg1, 1, 1, 0.9, 0.9))
	ControllerDependentTextBox.KBMText:setText(Engine[0xF9F1239CFD921FE](0xEC61C43D90FCF56))
	ControllerDependentTextBox.KBMText:setLetterSpacing(0)
	ControllerDependentTextBox.GamepadText:setText(Engine[0xF9F1239CFD921FE](0x9E6A8D0F83F4FC6))
	ControllerDependentTextBox.GamepadText:setLetterSpacing(-0.2)
	ControllerDependentTextBox.GamepadText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	TankUseString = CoD.AmmoWidget_AbilityText.new(f1_arg0, f1_arg1, 0.5, 0.5, -58, 58, 0, 0, -42.5, -17.5)
	TankUseString:mergeStateConditions({
		{
			stateName = "TankInbound",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "TankReadyForCommands",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "TankEntered",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	GlowHero = TankUseString
	Frame = TankUseString.subscribeToModel
	local LED = Engine[0x4DF5CFBC1771947](f1_arg1)
	Frame(GlowHero, LED["hudItems.smartCoverState"], function(f15_arg0)
		f1_arg0:updateElementState(TankUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "hudItems.smartCoverState",
		})
	end, false)
	GlowHero = TankUseString
	Frame = TankUseString.subscribeToModel
	LED = Engine[0x4DF5CFBC1771947](f1_arg1)
	Frame(GlowHero, LED["hudItems.dogState"], function(f16_arg0)
		f1_arg0:updateElementState(TankUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "hudItems.dogState",
		})
	end, false)
	TankUseString:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(TankUseString, f17_arg1)
	end)
	GlowHero = TankUseString
	Frame = TankUseString.subscribeToModel
	LED = Engine[0x4DF5CFBC1771947](f1_arg1)
	Frame(GlowHero, LED.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(TankUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:addElement(TankUseString)
	self.TankUseString = TankUseString
	Frame = LUI.UIImage.new(0, 0, 0, 268, 0, 0, -10, 140)
	Frame:setImage(RegisterImage(0xF56F1460BB4F637))
	self:addElement(Frame)
	self.Frame = Frame
	GlowHero = LUI.UIImage.new(0, 0, 78.5, 188.5, 0, 0, 13, 125)
	GlowHero:setAlpha(0)
	GlowHero:setImage(RegisterImage(0xD4F7AA0A4512AE0))
	GlowHero:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	GlowHero:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(GlowHero)
	self.GlowHero = GlowHero
	LED = LUI.UIImage.new(0, 0, 79, 183, 0, 0, 11.5, 121.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.3)
	LED:setImage(RegisterImage(0x6A97BE1E61599B6))
	self:addElement(LED)
	self.LED = LED
	local FullBackingDeployed = LUI.UIImage.new(0, 0, 100, 164, 0, 0, 35, 95)
	FullBackingDeployed:setRGB(0.79, 0.55, 0)
	FullBackingDeployed:setAlpha(0)
	FullBackingDeployed:setZRot(180)
	FullBackingDeployed:setScale(1.5, 1.5)
	FullBackingDeployed:setImage(RegisterImage(0x482C522ED478AB1))
	self:addElement(FullBackingDeployed)
	self.FullBackingDeployed = FullBackingDeployed
	local AbilityPulse = CoD.AmmoWidgetMP_Ability_Flash.new(f1_arg0, f1_arg1, 0, 0, 99, 164, 0, 0, 35.5, 94.5)
	AbilityPulse:setAlpha(0)
	AbilityPulse:setScale(1.5, 1.5)
	AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
	AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
	AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
	AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
	AbilityPulse:linkToElementModel(self, nil, false, function(model)
		AbilityPulse:setModel(model, f1_arg1)
	end)
	AbilityPulse:linkToElementModel(self, "powerRatio", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			AbilityPulse:setShaderVector(2, SetVectorComponent(2, 1, SubtractVectorComponentFrom(1, 1, CoD.GetVectorComponentFromString(f20_local0, 1), CoD.GetVectorComponentFromString(f20_local0, 2), CoD.GetVectorComponentFromString(f20_local0, 3), CoD.GetVectorComponentFromString(f20_local0, 4))))
		end
	end)
	self:addElement(AbilityPulse)
	self.AbilityPulse = AbilityPulse
	local AmmoWidgetAbilityContainer = CoD.AmmoWidget_AbilityContainer.new(f1_arg0, f1_arg1, 0, 0, 73, 165, 0, 0, 26.5, 70.5)
	AmmoWidgetAbilityContainer:setAlpha(0)
	AmmoWidgetAbilityContainer:setScale(1.5, 1.5)
	self:addElement(AmmoWidgetAbilityContainer)
	self.AmmoWidgetAbilityContainer = AmmoWidgetAbilityContainer
	local UltimateRadialMeterpath2 = LUI.UIImage.new(0, 0, 80, 188, 0, 0, 11.5, 121.5)
	UltimateRadialMeterpath2:setRGB(0.57, 0.57, 0.57)
	UltimateRadialMeterpath2:setAlpha(0.06)
	UltimateRadialMeterpath2:setImage(RegisterImage(0xDC66F93B7868335))
	UltimateRadialMeterpath2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	UltimateRadialMeterpath2:setShaderVector(0, 6, 0, 0, 0)
	self:addElement(UltimateRadialMeterpath2)
	self.UltimateRadialMeterpath2 = UltimateRadialMeterpath2
	local PowerBasedImageAvailable = LUI.UIImage.new(0, 0, 70, 196, 0, 0, -4.5, 135.5)
	PowerBasedImageAvailable:setScale(0.94, 0.92)
	PowerBasedImageAvailable:linkToElementModel(self, "id", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			PowerBasedImageAvailable:setImage(GetWeaponGadgetIconAvailable(f21_local0))
		end
	end)
	self:addElement(PowerBasedImageAvailable)
	self.PowerBasedImageAvailable = PowerBasedImageAvailable
	local PowerBasedImageUnavailable = LUI.UIImage.new(0, 0, 70, 196, 0, 0, -4.5, 135.5)
	PowerBasedImageUnavailable:setRGB(0.65, 0.65, 0.65)
	PowerBasedImageUnavailable:setAlpha(0)
	PowerBasedImageUnavailable:setScale(0.94, 0.92)
	PowerBasedImageUnavailable:linkToElementModel(self, "id", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			PowerBasedImageUnavailable:setImage(GetWeaponGadgetIconUnavailable(f22_local0))
		end
	end)
	self:addElement(PowerBasedImageUnavailable)
	self.PowerBasedImageUnavailable = PowerBasedImageUnavailable
	local combatEfficiencyActive = LUI.UIImage.new(0, 0, 48, 80, 0, 0, -16, 16)
	combatEfficiencyActive:setAlpha(0)
	combatEfficiencyActive:setImage(RegisterImage(0xC43A727D93CE8E8))
	self:addElement(combatEfficiencyActive)
	self.combatEfficiencyActive = combatEfficiencyActive
	local UltimateRadialMeterWipes = CoD.AmmoWidgetMP_Ultimate_Progress_Fill.new(f1_arg0, f1_arg1, 0.5, 0.5, -56, 56, 0, 0, 11, 123)
	UltimateRadialMeterWipes:linkToElementModel(self, nil, false, function(model)
		UltimateRadialMeterWipes:setModel(model, f1_arg1)
	end)
	self:addElement(UltimateRadialMeterWipes)
	self.UltimateRadialMeterWipes = UltimateRadialMeterWipes
	local HeroAbilityHoldString = CoD.AbilityHoldToActivate.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0, 0, -52, -3)
	HeroAbilityHoldString:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget2", function(model)
		HeroAbilityHoldString:setModel(model, f1_arg1)
	end)
	self:addElement(HeroAbilityHoldString)
	self.HeroAbilityHoldString = HeroAbilityHoldString
	local HeroAbilityHoldStringPC = nil
	HeroAbilityHoldStringPC = CoD.AbilityHoldToActivate.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0, 0, -83.5, -34.5)
	HeroAbilityHoldStringPC:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget2", function(model)
		HeroAbilityHoldStringPC:setModel(model, f1_arg1)
	end)
	self:addElement(HeroAbilityHoldStringPC)
	self.HeroAbilityHoldStringPC = HeroAbilityHoldStringPC
	local GlowRing = LUI.UIImage.new(0, 0, 71.5, 195.5, 0, 0, -4, 134)
	GlowRing:setAlpha(0)
	GlowRing:setImage(RegisterImage(0xCDD8E4DEC7EA034))
	GlowRing:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowRing:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GlowRing)
	self.GlowRing = GlowRing
	local FlareBack = LUI.UIImage.new(0, 0, 32, 232, 0, 0, -10, 138)
	FlareBack:setAlpha(0)
	FlareBack:setScale(1, 0.8)
	FlareBack:setImage(RegisterImage(0x650DB36D4791063))
	FlareBack:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FlareBack)
	self.FlareBack = FlareBack
	local NotAvailable = CoD.AmmoWidget_HeroEmpty.new(f1_arg0, f1_arg1, 0, 0, 85.5, 185.5, 0, 0, 11, 123)
	NotAvailable:setScale(1.2, 1.2)
	NotAvailable:linkToElementModel(self, nil, false, function(model)
		NotAvailable:setModel(model, f1_arg1)
	end)
	NotAvailable:linkToElementModel(self, "id", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			NotAvailable.ImgIcon:setImage(GetWeaponGadgetIconAvailable(f27_local0))
		end
	end)
	NotAvailable:linkToElementModel(self, "id", true, function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			NotAvailable.ImgIconGrow:setImage(GetWeaponGadgetIconAvailable(f28_local0))
		end
	end)
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	self:mergeStateConditions({
		{
			stateName = "HideThroughParentAlpha",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "id")
			end,
		},
		{
			stateName = "Restricted",
			condition = function(menu, element, event)
				return CoD.AmmoWidgetUtility.IsAbilityRestricted(self)
			end,
		},
		{
			stateName = "InUse",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x1873A43E9D1620E])
			end,
		},
		{
			stateName = "Deployed",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "PowerBasedEmptyCharging_CombatEfficiency",
			condition = function(menu, element, event)
				local f33_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x958A6962CA8F9B7])
				if f33_local0 then
					f33_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "powerRatio", 0)
					if f33_local0 then
						f33_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "combatEfficiencyActive", 1)
					end
				end
				return f33_local0
			end,
		},
		{
			stateName = "PowerBasedEmptyCharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x958A6962CA8F9B7]) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "powerRatio", 0)
			end,
		},
		{
			stateName = "PowerBasedCharging_CombatEfficiency",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x958A6962CA8F9B7]) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "combatEfficiencyActive", 1)
			end,
		},
		{
			stateName = "PowerBasedCharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x958A6962CA8F9B7])
			end,
		},
		{
			stateName = "PowerBased",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x29529861EAA8D1C])
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "powerRatio", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "powerRatio",
		})
	end)
	local f1_local25 = self
	local f1_local26 = self.subscribeToModel
	local f1_local27 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local26(f1_local25, f1_local27.combatEfficiencyActive, function(f41_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "combatEfficiencyActive",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local26 = self
	f1_local26 = HeroAbilityHoldString
	if IsPC() then
		HideWidget(self.HeroAbilityHoldString)
	end
	return self
end
CoD.AmmoWidgetMP_Ultimate_Internal.__resetProperties = function(f42_arg0)
	f42_arg0.NotAvailable:completeAnimation()
	f42_arg0.AbilityPulse:completeAnimation()
	f42_arg0.Panel:completeAnimation()
	f42_arg0.ControllerDependentTextBox:completeAnimation()
	f42_arg0.HeroAbilityHoldStringPC:completeAnimation()
	f42_arg0.HeroAbilityHoldString:completeAnimation()
	f42_arg0.UltimateRadialMeterWipes:completeAnimation()
	f42_arg0.PowerBasedImageAvailable:completeAnimation()
	f42_arg0.UltimateRadialMeterpath2:completeAnimation()
	f42_arg0.LED:completeAnimation()
	f42_arg0.TankUseString:completeAnimation()
	f42_arg0.FlareBack:completeAnimation()
	f42_arg0.GlowRing:completeAnimation()
	f42_arg0.PowerBasedImageUnavailable:completeAnimation()
	f42_arg0.FullBackingDeployed:completeAnimation()
	f42_arg0.combatEfficiencyActive:completeAnimation()
	f42_arg0.NotAvailable:setAlpha(1)
	f42_arg0.AbilityPulse:setRGB(1, 1, 1)
	f42_arg0.AbilityPulse:setAlpha(0)
	f42_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
	f42_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
	f42_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
	f42_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
	f42_arg0.Panel:setAlpha(0.94)
	f42_arg0.ControllerDependentTextBox:setRGB(1, 1, 1)
	f42_arg0.ControllerDependentTextBox:setAlpha(0)
	f42_arg0.HeroAbilityHoldStringPC:setAlpha(1)
	f42_arg0.HeroAbilityHoldString:setTopBottom(0, 0, -52, -3)
	f42_arg0.HeroAbilityHoldString:setAlpha(1)
	f42_arg0.UltimateRadialMeterWipes:setAlpha(1)
	f42_arg0.PowerBasedImageAvailable:setAlpha(1)
	f42_arg0.UltimateRadialMeterpath2:setAlpha(0.06)
	f42_arg0.LED:setRGB(0, 0, 0)
	f42_arg0.LED:setAlpha(0.3)
	f42_arg0.TankUseString:setAlpha(1)
	f42_arg0.FlareBack:setAlpha(0)
	f42_arg0.FlareBack:setScale(1, 0.8)
	f42_arg0.GlowRing:setRGB(1, 1, 1)
	f42_arg0.GlowRing:setAlpha(0)
	f42_arg0.GlowRing:setShaderVector(0, 1, 0, 0, 0)
	f42_arg0.PowerBasedImageUnavailable:setAlpha(0)
	f42_arg0.PowerBasedImageUnavailable:setScale(0.94, 0.92)
	f42_arg0.FullBackingDeployed:setAlpha(0)
	f42_arg0.combatEfficiencyActive:setAlpha(0)
end
CoD.AmmoWidgetMP_Ultimate_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(4)
			f43_arg0.Panel:completeAnimation()
			f43_arg0.Panel:setAlpha(0.9)
			f43_arg0.clipFinished(f43_arg0.Panel)
			f43_arg0.ControllerDependentTextBox:completeAnimation()
			f43_arg0.ControllerDependentTextBox:setRGB(1, 1, 1)
			f43_arg0.clipFinished(f43_arg0.ControllerDependentTextBox)
			f43_arg0.AbilityPulse:completeAnimation()
			f43_arg0.AbilityPulse:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.AbilityPulse)
			f43_arg0.NotAvailable:completeAnimation()
			f43_arg0.NotAvailable:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.NotAvailable)
		end,
	},
	HideThroughParentAlpha = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(0)
		end,
	},
	Restricted = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(8)
			f45_arg0.TankUseString:completeAnimation()
			f45_arg0.TankUseString:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.TankUseString)
			f45_arg0.LED:completeAnimation()
			f45_arg0.LED:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.LED)
			f45_arg0.UltimateRadialMeterpath2:completeAnimation()
			f45_arg0.UltimateRadialMeterpath2:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.UltimateRadialMeterpath2)
			f45_arg0.PowerBasedImageAvailable:completeAnimation()
			f45_arg0.PowerBasedImageAvailable:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.PowerBasedImageAvailable)
			f45_arg0.UltimateRadialMeterWipes:completeAnimation()
			f45_arg0.UltimateRadialMeterWipes:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.UltimateRadialMeterWipes)
			f45_arg0.HeroAbilityHoldString:completeAnimation()
			f45_arg0.HeroAbilityHoldString:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.HeroAbilityHoldString)
			f45_arg0.HeroAbilityHoldStringPC:completeAnimation()
			f45_arg0.HeroAbilityHoldStringPC:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.HeroAbilityHoldStringPC)
			f45_arg0.NotAvailable:completeAnimation()
			f45_arg0.NotAvailable:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.NotAvailable)
		end,
	},
	InUse = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(6)
			f46_arg0.AbilityPulse:completeAnimation()
			f46_arg0.AbilityPulse:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.AbilityPulse)
			f46_arg0.PowerBasedImageAvailable:completeAnimation()
			f46_arg0.PowerBasedImageAvailable:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.PowerBasedImageAvailable)
			f46_arg0.PowerBasedImageUnavailable:completeAnimation()
			f46_arg0.PowerBasedImageUnavailable:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.PowerBasedImageUnavailable)
			f46_arg0.GlowRing:completeAnimation()
			f46_arg0.GlowRing:setRGB(1, 0.44, 0)
			f46_arg0.GlowRing:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.GlowRing)
			f46_arg0.FlareBack:completeAnimation()
			f46_arg0.FlareBack:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.FlareBack)
			f46_arg0.NotAvailable:completeAnimation()
			f46_arg0.NotAvailable:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.NotAvailable)
		end,
		DefaultState = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(2)
			f47_arg0.AbilityPulse:completeAnimation()
			f47_arg0.AbilityPulse:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.AbilityPulse)
			local f47_local0 = function(f48_arg0)
				f47_arg0.NotAvailable:beginAnimation(200)
				f47_arg0.NotAvailable:setAlpha(1)
				f47_arg0.NotAvailable:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.NotAvailable:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.NotAvailable:completeAnimation()
			f47_arg0.NotAvailable:setAlpha(0)
			f47_local0(f47_arg0.NotAvailable)
			f47_arg0.nextClip = "DefaultState"
		end,
	},
	Deployed = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			f49_arg0.AbilityPulse:completeAnimation()
			f49_arg0.AbilityPulse:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.AbilityPulse)
			f49_arg0.GlowRing:completeAnimation()
			f49_arg0.GlowRing:setRGB(1, 0.44, 0)
			f49_arg0.GlowRing:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.GlowRing)
			f49_arg0.NotAvailable:completeAnimation()
			f49_arg0.NotAvailable:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.NotAvailable)
		end,
		DefaultState = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(2)
			local f50_local0 = function(f51_arg0)
				f50_arg0.AbilityPulse:beginAnimation(200)
				f50_arg0.AbilityPulse:setAlpha(0)
				f50_arg0.AbilityPulse:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.AbilityPulse:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.AbilityPulse:completeAnimation()
			f50_arg0.AbilityPulse:setAlpha(1)
			f50_local0(f50_arg0.AbilityPulse)
			f50_arg0.NotAvailable:completeAnimation()
			f50_arg0.NotAvailable:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.NotAvailable)
		end,
	},
	PowerBasedEmptyCharging_CombatEfficiency = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(7)
			f52_arg0.Panel:completeAnimation()
			f52_arg0.Panel:setAlpha(0.7)
			f52_arg0.clipFinished(f52_arg0.Panel)
			f52_arg0.FullBackingDeployed:completeAnimation()
			f52_arg0.FullBackingDeployed:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.FullBackingDeployed)
			f52_arg0.AbilityPulse:completeAnimation()
			f52_arg0.AbilityPulse:setAlpha(0)
			f52_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f52_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f52_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f52_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f52_arg0.clipFinished(f52_arg0.AbilityPulse)
			f52_arg0.PowerBasedImageAvailable:completeAnimation()
			f52_arg0.PowerBasedImageAvailable:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.PowerBasedImageAvailable)
			f52_arg0.PowerBasedImageUnavailable:completeAnimation()
			f52_arg0.PowerBasedImageUnavailable:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.PowerBasedImageUnavailable)
			f52_arg0.combatEfficiencyActive:completeAnimation()
			f52_arg0.combatEfficiencyActive:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.combatEfficiencyActive)
			f52_arg0.NotAvailable:completeAnimation()
			f52_arg0.NotAvailable:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.NotAvailable)
		end,
		DefaultState = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(5)
			local f53_local0 = function(f54_arg0)
				f53_arg0.FullBackingDeployed:beginAnimation(200)
				f53_arg0.FullBackingDeployed:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.FullBackingDeployed:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.FullBackingDeployed:completeAnimation()
			f53_arg0.FullBackingDeployed:setAlpha(0)
			f53_local0(f53_arg0.FullBackingDeployed)
			f53_arg0.AbilityPulse:completeAnimation()
			f53_arg0.AbilityPulse:setAlpha(0)
			f53_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f53_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f53_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f53_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f53_arg0.clipFinished(f53_arg0.AbilityPulse)
			local f53_local1 = function(f55_arg0)
				f53_arg0.PowerBasedImageAvailable:beginAnimation(200)
				f53_arg0.PowerBasedImageAvailable:setAlpha(1)
				f53_arg0.PowerBasedImageAvailable:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.PowerBasedImageAvailable:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.PowerBasedImageAvailable:completeAnimation()
			f53_arg0.PowerBasedImageAvailable:setAlpha(0)
			f53_local1(f53_arg0.PowerBasedImageAvailable)
			local f53_local2 = function(f56_arg0)
				f53_arg0.PowerBasedImageUnavailable:beginAnimation(200)
				f53_arg0.PowerBasedImageUnavailable:setAlpha(0)
				f53_arg0.PowerBasedImageUnavailable:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.PowerBasedImageUnavailable:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.PowerBasedImageUnavailable:completeAnimation()
			f53_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f53_local2(f53_arg0.PowerBasedImageUnavailable)
			f53_arg0.NotAvailable:completeAnimation()
			f53_arg0.NotAvailable:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.NotAvailable)
		end,
		PowerBasedCharging = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(6)
			local f57_local0 = function(f58_arg0)
				f57_arg0.Panel:beginAnimation(200)
				f57_arg0.Panel:setAlpha(0.2)
				f57_arg0.Panel:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.Panel:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.Panel:completeAnimation()
			f57_arg0.Panel:setAlpha(0.7)
			f57_local0(f57_arg0.Panel)
			f57_arg0.FullBackingDeployed:completeAnimation()
			f57_arg0.FullBackingDeployed:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.FullBackingDeployed)
			local f57_local1 = function(f59_arg0)
				f57_arg0.AbilityPulse:beginAnimation(200)
				f57_arg0.AbilityPulse:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.AbilityPulse:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.AbilityPulse:completeAnimation()
			f57_arg0.AbilityPulse:setAlpha(0)
			f57_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f57_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f57_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f57_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f57_local1(f57_arg0.AbilityPulse)
			f57_arg0.PowerBasedImageAvailable:completeAnimation()
			f57_arg0.PowerBasedImageAvailable:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.PowerBasedImageAvailable)
			local f57_local2 = function(f60_arg0)
				f57_arg0.PowerBasedImageUnavailable:beginAnimation(200)
				f57_arg0.PowerBasedImageUnavailable:setAlpha(1)
				f57_arg0.PowerBasedImageUnavailable:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.PowerBasedImageUnavailable:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.PowerBasedImageUnavailable:completeAnimation()
			f57_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f57_local2(f57_arg0.PowerBasedImageUnavailable)
			f57_arg0.NotAvailable:completeAnimation()
			f57_arg0.NotAvailable:setAlpha(1)
			f57_arg0.clipFinished(f57_arg0.NotAvailable)
		end,
	},
	PowerBasedEmptyCharging = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(6)
			f61_arg0.Panel:completeAnimation()
			f61_arg0.Panel:setAlpha(0.7)
			f61_arg0.clipFinished(f61_arg0.Panel)
			f61_arg0.FullBackingDeployed:completeAnimation()
			f61_arg0.FullBackingDeployed:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.FullBackingDeployed)
			f61_arg0.AbilityPulse:completeAnimation()
			f61_arg0.AbilityPulse:setAlpha(0)
			f61_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f61_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f61_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f61_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f61_arg0.clipFinished(f61_arg0.AbilityPulse)
			f61_arg0.PowerBasedImageAvailable:completeAnimation()
			f61_arg0.PowerBasedImageAvailable:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.PowerBasedImageAvailable)
			f61_arg0.PowerBasedImageUnavailable:completeAnimation()
			f61_arg0.PowerBasedImageUnavailable:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.PowerBasedImageUnavailable)
			f61_arg0.NotAvailable:completeAnimation()
			f61_arg0.NotAvailable:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.NotAvailable)
		end,
		DefaultState = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(5)
			local f62_local0 = function(f63_arg0)
				f62_arg0.FullBackingDeployed:beginAnimation(200)
				f62_arg0.FullBackingDeployed:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.FullBackingDeployed:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.FullBackingDeployed:completeAnimation()
			f62_arg0.FullBackingDeployed:setAlpha(0)
			f62_local0(f62_arg0.FullBackingDeployed)
			f62_arg0.AbilityPulse:completeAnimation()
			f62_arg0.AbilityPulse:setAlpha(0)
			f62_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f62_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f62_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f62_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f62_arg0.clipFinished(f62_arg0.AbilityPulse)
			local f62_local1 = function(f64_arg0)
				f62_arg0.PowerBasedImageAvailable:beginAnimation(200)
				f62_arg0.PowerBasedImageAvailable:setAlpha(1)
				f62_arg0.PowerBasedImageAvailable:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.PowerBasedImageAvailable:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.PowerBasedImageAvailable:completeAnimation()
			f62_arg0.PowerBasedImageAvailable:setAlpha(0)
			f62_local1(f62_arg0.PowerBasedImageAvailable)
			local f62_local2 = function(f65_arg0)
				f62_arg0.PowerBasedImageUnavailable:beginAnimation(200)
				f62_arg0.PowerBasedImageUnavailable:setAlpha(0)
				f62_arg0.PowerBasedImageUnavailable:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.PowerBasedImageUnavailable:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.PowerBasedImageUnavailable:completeAnimation()
			f62_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f62_local2(f62_arg0.PowerBasedImageUnavailable)
			f62_arg0.NotAvailable:completeAnimation()
			f62_arg0.NotAvailable:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.NotAvailable)
		end,
		PowerBasedCharging = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(6)
			local f66_local0 = function(f67_arg0)
				f66_arg0.Panel:beginAnimation(200)
				f66_arg0.Panel:setAlpha(0.2)
				f66_arg0.Panel:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.Panel:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.Panel:completeAnimation()
			f66_arg0.Panel:setAlpha(0.7)
			f66_local0(f66_arg0.Panel)
			local f66_local1 = function(f68_arg0)
				f66_arg0.FullBackingDeployed:beginAnimation(200)
				f66_arg0.FullBackingDeployed:setAlpha(0)
				f66_arg0.FullBackingDeployed:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.FullBackingDeployed:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.FullBackingDeployed:completeAnimation()
			f66_arg0.FullBackingDeployed:setAlpha(1)
			f66_local1(f66_arg0.FullBackingDeployed)
			local f66_local2 = function(f69_arg0)
				f66_arg0.AbilityPulse:beginAnimation(200)
				f66_arg0.AbilityPulse:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.AbilityPulse:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.AbilityPulse:completeAnimation()
			f66_arg0.AbilityPulse:setAlpha(0)
			f66_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f66_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f66_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f66_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f66_local2(f66_arg0.AbilityPulse)
			f66_arg0.PowerBasedImageAvailable:completeAnimation()
			f66_arg0.PowerBasedImageAvailable:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.PowerBasedImageAvailable)
			local f66_local3 = function(f70_arg0)
				f66_arg0.PowerBasedImageUnavailable:beginAnimation(200)
				f66_arg0.PowerBasedImageUnavailable:setAlpha(1)
				f66_arg0.PowerBasedImageUnavailable:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.PowerBasedImageUnavailable:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.PowerBasedImageUnavailable:completeAnimation()
			f66_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f66_local3(f66_arg0.PowerBasedImageUnavailable)
			f66_arg0.NotAvailable:completeAnimation()
			f66_arg0.NotAvailable:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.NotAvailable)
		end,
	},
	PowerBasedCharging_CombatEfficiency = {
		DefaultClip = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(6)
			f71_arg0.FullBackingDeployed:completeAnimation()
			f71_arg0.FullBackingDeployed:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.FullBackingDeployed)
			f71_arg0.AbilityPulse:completeAnimation()
			f71_arg0.AbilityPulse:setAlpha(0)
			f71_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f71_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f71_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f71_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f71_arg0.clipFinished(f71_arg0.AbilityPulse)
			f71_arg0.PowerBasedImageAvailable:completeAnimation()
			f71_arg0.PowerBasedImageAvailable:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.PowerBasedImageAvailable)
			f71_arg0.PowerBasedImageUnavailable:completeAnimation()
			f71_arg0.PowerBasedImageUnavailable:setAlpha(1)
			f71_arg0.clipFinished(f71_arg0.PowerBasedImageUnavailable)
			f71_arg0.combatEfficiencyActive:completeAnimation()
			f71_arg0.combatEfficiencyActive:setAlpha(1)
			f71_arg0.clipFinished(f71_arg0.combatEfficiencyActive)
			f71_arg0.NotAvailable:completeAnimation()
			f71_arg0.NotAvailable:setAlpha(1)
			f71_arg0.clipFinished(f71_arg0.NotAvailable)
		end,
		DefaultState = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(5)
			f72_arg0.FullBackingDeployed:completeAnimation()
			f72_arg0.FullBackingDeployed:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.FullBackingDeployed)
			local f72_local0 = function(f73_arg0)
				f72_arg0.AbilityPulse:beginAnimation(200)
				f72_arg0.AbilityPulse:setAlpha(0)
				f72_arg0.AbilityPulse:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.AbilityPulse:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
			end
			f72_arg0.AbilityPulse:completeAnimation()
			f72_arg0.AbilityPulse:setAlpha(1)
			f72_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f72_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f72_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f72_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f72_local0(f72_arg0.AbilityPulse)
			local f72_local1 = function(f74_arg0)
				f72_arg0.PowerBasedImageAvailable:beginAnimation(200)
				f72_arg0.PowerBasedImageAvailable:setAlpha(1)
				f72_arg0.PowerBasedImageAvailable:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.PowerBasedImageAvailable:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
			end
			f72_arg0.PowerBasedImageAvailable:completeAnimation()
			f72_arg0.PowerBasedImageAvailable:setAlpha(0)
			f72_local1(f72_arg0.PowerBasedImageAvailable)
			local f72_local2 = function(f75_arg0)
				f72_arg0.PowerBasedImageUnavailable:beginAnimation(200)
				f72_arg0.PowerBasedImageUnavailable:setAlpha(0)
				f72_arg0.PowerBasedImageUnavailable:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.PowerBasedImageUnavailable:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
			end
			f72_arg0.PowerBasedImageUnavailable:completeAnimation()
			f72_arg0.PowerBasedImageUnavailable:setAlpha(1)
			f72_local2(f72_arg0.PowerBasedImageUnavailable)
			f72_arg0.NotAvailable:completeAnimation()
			f72_arg0.NotAvailable:setAlpha(1)
			f72_arg0.clipFinished(f72_arg0.NotAvailable)
		end,
	},
	PowerBasedCharging = {
		DefaultClip = function(f76_arg0, f76_arg1)
			f76_arg0:__resetProperties()
			f76_arg0:setupElementClipCounter(7)
			f76_arg0.ControllerDependentTextBox:completeAnimation()
			f76_arg0.ControllerDependentTextBox:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.ControllerDependentTextBox)
			f76_arg0.FullBackingDeployed:completeAnimation()
			f76_arg0.FullBackingDeployed:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.FullBackingDeployed)
			f76_arg0.AbilityPulse:completeAnimation()
			f76_arg0.AbilityPulse:setAlpha(0)
			f76_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f76_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f76_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f76_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f76_arg0.clipFinished(f76_arg0.AbilityPulse)
			f76_arg0.PowerBasedImageAvailable:completeAnimation()
			f76_arg0.PowerBasedImageAvailable:setAlpha(0)
			f76_arg0.clipFinished(f76_arg0.PowerBasedImageAvailable)
			f76_arg0.PowerBasedImageUnavailable:completeAnimation()
			f76_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f76_arg0.clipFinished(f76_arg0.PowerBasedImageUnavailable)
			f76_arg0.HeroAbilityHoldString:completeAnimation()
			f76_arg0.HeroAbilityHoldString:setTopBottom(0, 0, -52, -3)
			f76_arg0.clipFinished(f76_arg0.HeroAbilityHoldString)
			f76_arg0.NotAvailable:completeAnimation()
			f76_arg0.NotAvailable:setAlpha(1)
			f76_arg0.clipFinished(f76_arg0.NotAvailable)
		end,
		DefaultState = function(f77_arg0, f77_arg1)
			f77_arg0:__resetProperties()
			f77_arg0:setupElementClipCounter(5)
			f77_arg0.FullBackingDeployed:completeAnimation()
			f77_arg0.FullBackingDeployed:setAlpha(0)
			f77_arg0.clipFinished(f77_arg0.FullBackingDeployed)
			local f77_local0 = function(f78_arg0)
				f77_arg0.AbilityPulse:beginAnimation(200)
				f77_arg0.AbilityPulse:setAlpha(0)
				f77_arg0.AbilityPulse:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.AbilityPulse:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
			end
			f77_arg0.AbilityPulse:completeAnimation()
			f77_arg0.AbilityPulse:setAlpha(1)
			f77_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f77_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f77_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f77_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f77_local0(f77_arg0.AbilityPulse)
			local f77_local1 = function(f79_arg0)
				f77_arg0.PowerBasedImageAvailable:beginAnimation(200)
				f77_arg0.PowerBasedImageAvailable:setAlpha(1)
				f77_arg0.PowerBasedImageAvailable:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.PowerBasedImageAvailable:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
			end
			f77_arg0.PowerBasedImageAvailable:completeAnimation()
			f77_arg0.PowerBasedImageAvailable:setAlpha(0)
			f77_local1(f77_arg0.PowerBasedImageAvailable)
			local f77_local2 = function(f80_arg0)
				f77_arg0.PowerBasedImageUnavailable:beginAnimation(200)
				f77_arg0.PowerBasedImageUnavailable:setAlpha(0)
				f77_arg0.PowerBasedImageUnavailable:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.PowerBasedImageUnavailable:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
			end
			f77_arg0.PowerBasedImageUnavailable:completeAnimation()
			f77_arg0.PowerBasedImageUnavailable:setAlpha(1)
			f77_local2(f77_arg0.PowerBasedImageUnavailable)
			f77_arg0.NotAvailable:completeAnimation()
			f77_arg0.NotAvailable:setAlpha(1)
			f77_arg0.clipFinished(f77_arg0.NotAvailable)
		end,
	},
	PowerBased = {
		DefaultClip = function(f81_arg0, f81_arg1)
			f81_arg0:__resetProperties()
			f81_arg0:setupElementClipCounter(8)
			f81_arg0.ControllerDependentTextBox:completeAnimation()
			f81_arg0.ControllerDependentTextBox:setAlpha(1)
			f81_arg0.clipFinished(f81_arg0.ControllerDependentTextBox)
			f81_arg0.LED:completeAnimation()
			f81_arg0.LED:setRGB(0, 0, 0)
			f81_arg0.LED:setAlpha(0.3)
			f81_arg0.clipFinished(f81_arg0.LED)
			f81_arg0.AbilityPulse:completeAnimation()
			f81_arg0.AbilityPulse:setRGB(1, 1, 1)
			f81_arg0.AbilityPulse:setAlpha(0)
			f81_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f81_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f81_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f81_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f81_arg0.clipFinished(f81_arg0.AbilityPulse)
			f81_arg0.PowerBasedImageAvailable:completeAnimation()
			f81_arg0.PowerBasedImageAvailable:setAlpha(1)
			f81_arg0.clipFinished(f81_arg0.PowerBasedImageAvailable)
			f81_arg0.PowerBasedImageUnavailable:completeAnimation()
			f81_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f81_arg0.clipFinished(f81_arg0.PowerBasedImageUnavailable)
			f81_arg0.GlowRing:completeAnimation()
			f81_arg0.GlowRing:setRGB(1, 0.44, 0)
			f81_arg0.GlowRing:setAlpha(1)
			f81_arg0.GlowRing:setShaderVector(0, 2, 0, 0, 0)
			f81_arg0.clipFinished(f81_arg0.GlowRing)
			local f81_local0 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					f83_arg0:beginAnimation(1000)
					f83_arg0:setAlpha(0.1)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
				end
				f81_arg0.FlareBack:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f81_arg0.FlareBack:setAlpha(0.2)
				f81_arg0.FlareBack:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.FlareBack:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f81_arg0.FlareBack:completeAnimation()
			f81_arg0.FlareBack:setAlpha(0.1)
			f81_arg0.FlareBack:setScale(1, 1)
			f81_local0(f81_arg0.FlareBack)
			local f81_local1 = function(f84_arg0)
				f81_arg0.NotAvailable:beginAnimation(50)
				f81_arg0.NotAvailable:setAlpha(1)
				f81_arg0.NotAvailable:registerEventHandler("interrupted_keyframe", f81_arg0.clipInterrupted)
				f81_arg0.NotAvailable:registerEventHandler("transition_complete_keyframe", f81_arg0.clipFinished)
			end
			f81_arg0.NotAvailable:completeAnimation()
			f81_arg0.NotAvailable:setAlpha(0)
			f81_local1(f81_arg0.NotAvailable)
			f81_arg0.nextClip = "DefaultClip"
		end,
		DefaultState = function(f85_arg0, f85_arg1)
			f85_arg0:__resetProperties()
			f85_arg0:setupElementClipCounter(4)
			f85_arg0.AbilityPulse:completeAnimation()
			f85_arg0.AbilityPulse:setAlpha(0)
			f85_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f85_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f85_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f85_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f85_arg0.clipFinished(f85_arg0.AbilityPulse)
			f85_arg0.PowerBasedImageUnavailable:completeAnimation()
			f85_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f85_arg0.clipFinished(f85_arg0.PowerBasedImageUnavailable)
			f85_arg0.FlareBack:completeAnimation()
			f85_arg0.FlareBack:setAlpha(0)
			f85_arg0.clipFinished(f85_arg0.FlareBack)
			f85_arg0.NotAvailable:completeAnimation()
			f85_arg0.NotAvailable:setAlpha(0)
			f85_arg0.clipFinished(f85_arg0.NotAvailable)
			f85_arg0.nextClip = "DefaultState"
		end,
		InUse = function(f86_arg0, f86_arg1)
			f86_arg0:__resetProperties()
			f86_arg0:setupElementClipCounter(8)
			local f86_local0 = function(f87_arg0)
				f86_arg0.ControllerDependentTextBox:beginAnimation(100)
				f86_arg0.ControllerDependentTextBox:setAlpha(0)
				f86_arg0.ControllerDependentTextBox:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.ControllerDependentTextBox:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.ControllerDependentTextBox:completeAnimation()
			f86_arg0.ControllerDependentTextBox:setAlpha(1)
			f86_local0(f86_arg0.ControllerDependentTextBox)
			f86_arg0.LED:completeAnimation()
			f86_arg0.LED:setRGB(0, 0, 0)
			f86_arg0.LED:setAlpha(0.3)
			f86_arg0.clipFinished(f86_arg0.LED)
			local f86_local1 = function(f88_arg0)
				f86_arg0.AbilityPulse:beginAnimation(100)
				f86_arg0.AbilityPulse:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.AbilityPulse:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.AbilityPulse:completeAnimation()
			f86_arg0.AbilityPulse:setRGB(1, 1, 1)
			f86_arg0.AbilityPulse:setAlpha(0)
			f86_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f86_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f86_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f86_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f86_local1(f86_arg0.AbilityPulse)
			local f86_local2 = function(f89_arg0)
				f86_arg0.PowerBasedImageAvailable:beginAnimation(100)
				f86_arg0.PowerBasedImageAvailable:setAlpha(0)
				f86_arg0.PowerBasedImageAvailable:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.PowerBasedImageAvailable:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.PowerBasedImageAvailable:completeAnimation()
			f86_arg0.PowerBasedImageAvailable:setAlpha(1)
			f86_local2(f86_arg0.PowerBasedImageAvailable)
			local f86_local3 = function(f90_arg0)
				local f90_local0 = function(f91_arg0)
					local f91_local0 = function(f92_arg0)
						local f92_local0 = function(f93_arg0)
							f93_arg0:beginAnimation(59, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f93_arg0:setScale(0.94, 0.92)
							f93_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
						end
						f92_arg0:beginAnimation(20, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f92_arg0:setAlpha(1)
						f92_arg0:setScale(0.83, 0.83)
						f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
					end
					f91_arg0:beginAnimation(49)
					f91_arg0:setAlpha(0.9)
					f91_arg0:setScale(0.8, 0.8)
					f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
				end
				f86_arg0.PowerBasedImageUnavailable:beginAnimation(30)
				f86_arg0.PowerBasedImageUnavailable:setAlpha(0.3)
				f86_arg0.PowerBasedImageUnavailable:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.PowerBasedImageUnavailable:registerEventHandler("transition_complete_keyframe", f90_local0)
			end
			f86_arg0.PowerBasedImageUnavailable:completeAnimation()
			f86_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f86_arg0.PowerBasedImageUnavailable:setScale(0.94, 0.92)
			f86_local3(f86_arg0.PowerBasedImageUnavailable)
			local f86_local4 = function(f94_arg0)
				f86_arg0.GlowRing:beginAnimation(100)
				f86_arg0.GlowRing:setAlpha(0)
				f86_arg0.GlowRing:setShaderVector(0, 1, 0, 0, 0)
				f86_arg0.GlowRing:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.GlowRing:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.GlowRing:completeAnimation()
			f86_arg0.GlowRing:setRGB(1, 0.44, 0)
			f86_arg0.GlowRing:setAlpha(1)
			f86_arg0.GlowRing:setShaderVector(0, 2, 0, 0, 0)
			f86_local4(f86_arg0.GlowRing)
			local f86_local5 = function(f95_arg0)
				f86_arg0.FlareBack:beginAnimation(100)
				f86_arg0.FlareBack:setAlpha(0)
				f86_arg0.FlareBack:setScale(1, 0.8)
				f86_arg0.FlareBack:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.FlareBack:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.FlareBack:completeAnimation()
			f86_arg0.FlareBack:setAlpha(0.1)
			f86_arg0.FlareBack:setScale(1, 1)
			f86_local5(f86_arg0.FlareBack)
			f86_arg0.NotAvailable:completeAnimation()
			f86_arg0.NotAvailable:setAlpha(0)
			f86_arg0.clipFinished(f86_arg0.NotAvailable)
			f86_arg0.nextClip = "InUse"
		end,
	},
}
CoD.AmmoWidgetMP_Ultimate_Internal.__onClose = function(f96_arg0)
	f96_arg0.ControllerDependentTextBox:close()
	f96_arg0.TankUseString:close()
	f96_arg0.AbilityPulse:close()
	f96_arg0.AmmoWidgetAbilityContainer:close()
	f96_arg0.PowerBasedImageAvailable:close()
	f96_arg0.PowerBasedImageUnavailable:close()
	f96_arg0.UltimateRadialMeterWipes:close()
	f96_arg0.HeroAbilityHoldString:close()
	f96_arg0.HeroAbilityHoldStringPC:close()
	f96_arg0.NotAvailable:close()
end
