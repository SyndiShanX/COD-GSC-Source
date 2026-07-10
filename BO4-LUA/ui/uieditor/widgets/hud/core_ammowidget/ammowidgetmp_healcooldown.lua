require("x64:12322cb4555c55d")
require("x64:34778f864da9dda")
require("x64:33ec8b4b2fb3c47")
require("x64:2d66cf7384bbe8f")
require("x64:24b789df27433d6")
require("x64:2485f9df271d384")
require("x64:37d12d08b0910b6")
CoD.AmmowidgetMP_HealCooldown = InheritFrom(LUI.UIElement)
CoD.AmmowidgetMP_HealCooldown.__defaultWidth = 72
CoD.AmmowidgetMP_HealCooldown.__defaultHeight = 59
CoD.AmmowidgetMP_HealCooldown.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmowidgetMP_HealCooldown)
	self.id = "AmmowidgetMP_HealCooldown"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LED = LUI.UIImage.new(0, 0, 1, 71, 0, 0, -3.5, 66.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.3)
	LED:setImage(RegisterImage(0xB7A2AC51B160918))
	self:addElement(LED)
	self.LED = LED
	local AmmoWidgetAbilityContainer = CoD.AmmoWidget_AbilityContainer.new(f1_arg0, f1_arg1, 0, 0, -23, 69, 0, 0, -9, 35)
	AmmoWidgetAbilityContainer:setAlpha(0)
	AmmoWidgetAbilityContainer:setScale(1.4, 1.4)
	self:addElement(AmmoWidgetAbilityContainer)
	self.AmmoWidgetAbilityContainer = AmmoWidgetAbilityContainer
	local AmmoWidgetMPAbilityFlare = CoD.AmmoWidgetMP_Ability_Flare.new(f1_arg0, f1_arg1, 0, 0, -1394, 352, 0, 0, -974, 100)
	AmmoWidgetMPAbilityFlare:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "powerRatio", 1)
			end,
		},
	})
	AmmoWidgetMPAbilityFlare:linkToElementModel(AmmoWidgetMPAbilityFlare, "powerRatio", true, function(model)
		f1_arg0:updateElementState(AmmoWidgetMPAbilityFlare, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "powerRatio",
		})
	end)
	AmmoWidgetMPAbilityFlare:setAlpha(0)
	AmmoWidgetMPAbilityFlare:linkToElementModel(self, nil, false, function(model)
		AmmoWidgetMPAbilityFlare:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoWidgetMPAbilityFlare)
	self.AmmoWidgetMPAbilityFlare = AmmoWidgetMPAbilityFlare
	local BackingFillAnim = LUI.UIImage.new(0, 0, 4, 68, 0, 0, 1, 61)
	BackingFillAnim:setRGB(0.13, 0.13, 0.13)
	BackingFillAnim:setAlpha(0)
	BackingFillAnim:setZRot(180)
	BackingFillAnim:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	BackingFillAnim:setShaderVector(0, 1, 0, 0, 0)
	BackingFillAnim:setShaderVector(1, 0, 0, 0, 0)
	BackingFillAnim:setShaderVector(3, 0.05, 0, 0, 0)
	BackingFillAnim:setShaderVector(4, 0, 0, 0, 0)
	BackingFillAnim:linkToElementModel(self, "powerRatio", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			BackingFillAnim:setShaderVector(2, AddToVector(0.15, 0, 0, 0, ScaleVectorComponents(0.7, 1, 1, 1, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))))
		end
	end)
	self:addElement(BackingFillAnim)
	self.BackingFillAnim = BackingFillAnim
	local FullBackingDeployed = LUI.UIImage.new(0, 0, 4, 68, 0, 0, -0.5, 59.5)
	FullBackingDeployed:setRGB(0.79, 0.55, 0)
	FullBackingDeployed:setAlpha(0)
	FullBackingDeployed:setZRot(180)
	FullBackingDeployed:setImage(RegisterImage(0x482C522ED478AB1))
	self:addElement(FullBackingDeployed)
	self.FullBackingDeployed = FullBackingDeployed
	local AbilityPulse = CoD.AmmoWidgetMP_Ability_Flash.new(f1_arg0, f1_arg1, 0, 0, 4, 70, 0, 0, 2.5, 58.5)
	AbilityPulse:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "powerRatio", 1)
			end,
		},
	})
	AbilityPulse:linkToElementModel(AbilityPulse, "powerRatio", true, function(model)
		f1_arg0:updateElementState(AbilityPulse, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "powerRatio",
		})
	end)
	AbilityPulse:linkToElementModel(AbilityPulse, "state", true, function(model)
		f1_arg0:updateElementState(AbilityPulse, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	AbilityPulse:setAlpha(0.5)
	AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
	AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
	AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
	AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
	AbilityPulse:linkToElementModel(self, nil, false, function(model)
		AbilityPulse:setModel(model, f1_arg1)
	end)
	AbilityPulse:linkToElementModel(self, "powerRatio", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			AbilityPulse:setShaderVector(2, SetVectorComponent(2, 1, SubtractVectorComponentFrom(1, 1, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4))))
		end
	end)
	self:addElement(AbilityPulse)
	self.AbilityPulse = AbilityPulse
	local Box = LUI.UIImage.new(0, 0, 2, 72, 0, 0, -3.5, 66.5)
	Box:setImage(RegisterImage(0x2A20E3F9478C322))
	Box:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	Box:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Box)
	self.Box = Box
	local PowerBasedImageAvailable = LUI.UIImage.new(0, 0, -3.5, 76.5, 0, 0, -8.5, 71.5)
	PowerBasedImageAvailable:setImage(RegisterImage(0x2F98C87888D2E0D))
	self:addElement(PowerBasedImageAvailable)
	self.PowerBasedImageAvailable = PowerBasedImageAvailable
	local PowerBasedImageUnavailable = LUI.UIImage.new(0, 0, -5, 75, 0, 0, -10, 70)
	PowerBasedImageUnavailable:setRGB(0.65, 0.65, 0.65)
	PowerBasedImageUnavailable:setAlpha(0)
	PowerBasedImageUnavailable:setImage(RegisterImage(0xDCA29A818A78E8C))
	self:addElement(PowerBasedImageUnavailable)
	self.PowerBasedImageUnavailable = PowerBasedImageUnavailable
	local NotAvailable = CoD.AmmoWidget_EquipmentEmpty.new(f1_arg0, f1_arg1, 0.5, 0.5, -27, 27, 0.5, 0.5, -10.5, 16.5)
	NotAvailable:setScale(0.9, 0.9)
	NotAvailable.ImgIcon:setImage(RegisterImage(0x2F98C87888D2E0D))
	NotAvailable.ImgIconGrow:setImage(RegisterImage(0x2F98C87888D2E0D))
	NotAvailable:linkToElementModel(self, nil, false, function(model)
		NotAvailable:setModel(model, f1_arg1)
	end)
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	local Line = LUI.UIImage.new(0, 0, 4, 70, 0.35, 0.35, -2, 3)
	Line:setRGB(0.89, 0.89, 0.89)
	Line:setAlpha(0)
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Line:setShaderVector(0, 0.01, 0.41, 0.01, 0.41)
	Line:linkToElementModel(self, "powerRatio", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Line:setTopPct(Add(0, Multiple(1, Negate(f12_local0))))
		end
	end)
	self:addElement(Line)
	self.Line = Line
	local HeroAbilityUseString = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -36, 36, 0, 0, -29, -7)
	HeroAbilityUseString:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f13_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
				if not f13_local0 then
					f13_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					if not f13_local0 then
						f13_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xC57360571B0917E])
					end
				end
				return f13_local0
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
				return IsMouseOrKeyboard(f1_arg1) and AlwaysTrue()
			end,
		},
		{
			stateName = "KeyboardAndMouseUltimate",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseScoreStreak",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
	})
	local FlareBack = HeroAbilityUseString
	local GlowRing = HeroAbilityUseString.subscribeToModel
	local BountyHealthCount = Engine[0x4DF5CFBC1771947](f1_arg1)
	GlowRing(FlareBack, BountyHealthCount["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f18_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	FlareBack = HeroAbilityUseString
	GlowRing = HeroAbilityUseString.subscribeToModel
	BountyHealthCount = Engine[0x4DF5CFBC1771947](f1_arg1)
	GlowRing(FlareBack, BountyHealthCount["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f19_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	FlareBack = HeroAbilityUseString
	GlowRing = HeroAbilityUseString.subscribeToModel
	BountyHealthCount = Engine[0x4DF5CFBC1771947](f1_arg1)
	GlowRing(FlareBack, BountyHealthCount["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f20_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
		})
	end, false)
	HeroAbilityUseString:appendEventHandler("input_source_changed", function(f21_arg0, f21_arg1)
		f21_arg1.menu = f21_arg1.menu or f1_arg0
		f1_arg0:updateElementState(HeroAbilityUseString, f21_arg1)
	end)
	FlareBack = HeroAbilityUseString
	GlowRing = HeroAbilityUseString.subscribeToModel
	BountyHealthCount = Engine[0x4DF5CFBC1771947](f1_arg1)
	GlowRing(FlareBack, BountyHealthCount.LastInput, function(f22_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	HeroAbilityUseString:setAlpha(0)
	HeroAbilityUseString.KBMText:setText(Engine[0xF9F1239CFD921FE](0x34175BD548C4C21))
	HeroAbilityUseString.GamepadText:setText(Engine[0xF9F1239CFD921FE](0x34175BD548C4C21))
	HeroAbilityUseString.GamepadText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(HeroAbilityUseString)
	self.HeroAbilityUseString = HeroAbilityUseString
	GlowRing = LUI.UIImage.new(0, 0, -3.5, 76.5, 0, 0, -8.5, 71.5)
	GlowRing:setRGB(1, 0.44, 0)
	GlowRing:setAlpha(0)
	GlowRing:setImage(RegisterImage(0x7028EB3BEA46612))
	GlowRing:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowRing:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GlowRing)
	self.GlowRing = GlowRing
	FlareBack = LUI.UIImage.new(0, 0, -45.5, 114.5, 0, 0, -40, 100)
	FlareBack:setAlpha(0)
	FlareBack:setScale(1.16, 1.16)
	FlareBack:setImage(RegisterImage(0x49442D6D518A75D))
	FlareBack:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FlareBack)
	self.FlareBack = FlareBack
	BountyHealthCount = CoD.BountyHunterHealthCount.new(f1_arg0, f1_arg1, 0, 0, 44.5, 71.5, 0, 0, 39, 63)
	self:addElement(BountyHealthCount)
	self.BountyHealthCount = BountyHealthCount
	local CodCasterLoadoutSelection = CoD.CodCasterLoadoutSelectionHeal.new(f1_arg0, f1_arg1, 0, 0, 1, 73, 0, 0, 2, 62)
	CodCasterLoadoutSelection:setAlpha(0)
	self:addElement(CodCasterLoadoutSelection)
	self.CodCasterLoadoutSelection = CodCasterLoadoutSelection
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "id")
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
			stateName = "BountyEmpty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "powerRatio", 1) and CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1)
			end,
		},
		{
			stateName = "PowerBasedEmptyCharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x958A6962CA8F9B7]) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "powerRatio", 0)
			end,
		},
		{
			stateName = "PowerBasedCharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x958A6962CA8F9B7]) and CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "powerRatio", 1)
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
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f33_arg2, f33_arg3, f33_arg4)
		if CoD.HUDUtility.ShouldPulseNewAmmo(self) and IsSelfInState(self, "PowerBased") then
			PlayClip(self, "Pulse", controller)
		end
	end)
	self:linkToElementModel(self, "ammo", true, function(model)
		local f34_local0 = self
		if IsSelfInState(self, "PowerBased") and CoD.HUDUtility.ShouldPulseNewAmmo(self) then
			PlayClip(self, "Pulse", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmowidgetMP_HealCooldown.__resetProperties = function(f35_arg0)
	f35_arg0.NotAvailable:completeAnimation()
	f35_arg0.AbilityPulse:completeAnimation()
	f35_arg0.HeroAbilityUseString:completeAnimation()
	f35_arg0.Line:completeAnimation()
	f35_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
	f35_arg0.PowerBasedImageUnavailable:completeAnimation()
	f35_arg0.PowerBasedImageAvailable:completeAnimation()
	f35_arg0.FullBackingDeployed:completeAnimation()
	f35_arg0.BackingFillAnim:completeAnimation()
	f35_arg0.AmmoWidgetAbilityContainer:completeAnimation()
	f35_arg0.Box:completeAnimation()
	f35_arg0.LED:completeAnimation()
	f35_arg0.FlareBack:completeAnimation()
	f35_arg0.GlowRing:completeAnimation()
	f35_arg0.NotAvailable:setAlpha(1)
	f35_arg0.AbilityPulse:setLeftRight(0, 0, 4, 70)
	f35_arg0.AbilityPulse:setTopBottom(0, 0, 2.5, 58.5)
	f35_arg0.AbilityPulse:setAlpha(0.5)
	f35_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
	f35_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
	f35_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
	f35_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
	f35_arg0.HeroAbilityUseString:setRGB(1, 1, 1)
	f35_arg0.HeroAbilityUseString:setAlpha(0)
	f35_arg0.Line:setAlpha(0)
	f35_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
	f35_arg0.PowerBasedImageUnavailable:setRGB(0.65, 0.65, 0.65)
	f35_arg0.PowerBasedImageUnavailable:setAlpha(0)
	f35_arg0.PowerBasedImageUnavailable:setImage(RegisterImage(0xDCA29A818A78E8C))
	f35_arg0.PowerBasedImageAvailable:setRGB(1, 1, 1)
	f35_arg0.PowerBasedImageAvailable:setAlpha(1)
	f35_arg0.FullBackingDeployed:setAlpha(0)
	f35_arg0.BackingFillAnim:setAlpha(0)
	f35_arg0.AmmoWidgetAbilityContainer:setAlpha(0)
	f35_arg0.Box:setAlpha(1)
	f35_arg0.LED:setRGB(0, 0, 0)
	f35_arg0.LED:setAlpha(0.3)
	f35_arg0.FlareBack:setAlpha(0)
	f35_arg0.FlareBack:setScale(1.16, 1.16)
	f35_arg0.GlowRing:setAlpha(0)
end
CoD.AmmowidgetMP_HealCooldown.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(5)
			f36_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f36_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.AmmoWidgetMPAbilityFlare)
			f36_arg0.AbilityPulse:completeAnimation()
			f36_arg0.AbilityPulse:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.AbilityPulse)
			f36_arg0.NotAvailable:completeAnimation()
			f36_arg0.NotAvailable:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.NotAvailable)
			f36_arg0.Line:completeAnimation()
			f36_arg0.Line:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Line)
			f36_arg0.HeroAbilityUseString:completeAnimation()
			f36_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f36_arg0.HeroAbilityUseString:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.HeroAbilityUseString)
		end,
	},
	Hidden = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(12)
			f37_arg0.LED:completeAnimation()
			f37_arg0.LED:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.LED)
			f37_arg0.AmmoWidgetAbilityContainer:completeAnimation()
			f37_arg0.AmmoWidgetAbilityContainer:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.AmmoWidgetAbilityContainer)
			f37_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f37_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.AmmoWidgetMPAbilityFlare)
			f37_arg0.BackingFillAnim:completeAnimation()
			f37_arg0.BackingFillAnim:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.BackingFillAnim)
			f37_arg0.FullBackingDeployed:completeAnimation()
			f37_arg0.FullBackingDeployed:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.FullBackingDeployed)
			f37_arg0.AbilityPulse:completeAnimation()
			f37_arg0.AbilityPulse:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.AbilityPulse)
			f37_arg0.Box:completeAnimation()
			f37_arg0.Box:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.Box)
			f37_arg0.PowerBasedImageAvailable:completeAnimation()
			f37_arg0.PowerBasedImageAvailable:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.PowerBasedImageAvailable)
			f37_arg0.PowerBasedImageUnavailable:completeAnimation()
			f37_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.PowerBasedImageUnavailable)
			f37_arg0.NotAvailable:completeAnimation()
			f37_arg0.NotAvailable:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.NotAvailable)
			f37_arg0.Line:completeAnimation()
			f37_arg0.Line:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.Line)
			f37_arg0.HeroAbilityUseString:completeAnimation()
			f37_arg0.HeroAbilityUseString:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.HeroAbilityUseString)
		end,
	},
	InUse = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(6)
			f38_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f38_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.AmmoWidgetMPAbilityFlare)
			f38_arg0.AbilityPulse:completeAnimation()
			f38_arg0.AbilityPulse:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.AbilityPulse)
			f38_arg0.PowerBasedImageAvailable:completeAnimation()
			f38_arg0.PowerBasedImageAvailable:setRGB(1, 1, 1)
			f38_arg0.clipFinished(f38_arg0.PowerBasedImageAvailable)
			f38_arg0.NotAvailable:completeAnimation()
			f38_arg0.NotAvailable:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.NotAvailable)
			f38_arg0.Line:completeAnimation()
			f38_arg0.Line:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Line)
			f38_arg0.HeroAbilityUseString:completeAnimation()
			f38_arg0.HeroAbilityUseString:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.HeroAbilityUseString)
			f38_arg0.nextClip = "DefaultClip"
		end,
	},
	Deployed = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(5)
			f39_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f39_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.AmmoWidgetMPAbilityFlare)
			f39_arg0.AbilityPulse:completeAnimation()
			f39_arg0.AbilityPulse:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.AbilityPulse)
			f39_arg0.NotAvailable:completeAnimation()
			f39_arg0.NotAvailable:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.NotAvailable)
			f39_arg0.Line:completeAnimation()
			f39_arg0.Line:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.Line)
			f39_arg0.HeroAbilityUseString:completeAnimation()
			f39_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f39_arg0.HeroAbilityUseString:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.HeroAbilityUseString)
		end,
	},
	BountyEmpty = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(4)
			f40_arg0.AbilityPulse:completeAnimation()
			f40_arg0.AbilityPulse:setAlpha(0)
			f40_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f40_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f40_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f40_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f40_arg0.clipFinished(f40_arg0.AbilityPulse)
			f40_arg0.PowerBasedImageAvailable:completeAnimation()
			f40_arg0.PowerBasedImageAvailable:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.PowerBasedImageAvailable)
			f40_arg0.PowerBasedImageUnavailable:completeAnimation()
			f40_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f40_arg0.PowerBasedImageUnavailable:setImage(RegisterImage(0xDCA29A818A78E8C))
			f40_arg0.clipFinished(f40_arg0.PowerBasedImageUnavailable)
			f40_arg0.NotAvailable:completeAnimation()
			f40_arg0.NotAvailable:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.NotAvailable)
		end,
	},
	PowerBasedEmptyCharging = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(8)
			f41_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f41_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.AmmoWidgetMPAbilityFlare)
			f41_arg0.FullBackingDeployed:completeAnimation()
			f41_arg0.FullBackingDeployed:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.FullBackingDeployed)
			f41_arg0.AbilityPulse:completeAnimation()
			f41_arg0.AbilityPulse:setAlpha(0.5)
			f41_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f41_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f41_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f41_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f41_arg0.clipFinished(f41_arg0.AbilityPulse)
			f41_arg0.PowerBasedImageAvailable:completeAnimation()
			f41_arg0.PowerBasedImageAvailable:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.PowerBasedImageAvailable)
			f41_arg0.PowerBasedImageUnavailable:completeAnimation()
			f41_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f41_arg0.PowerBasedImageUnavailable:setImage(RegisterImage(0xDCA29A818A78E8C))
			f41_arg0.clipFinished(f41_arg0.PowerBasedImageUnavailable)
			f41_arg0.NotAvailable:completeAnimation()
			f41_arg0.NotAvailable:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.NotAvailable)
			f41_arg0.Line:completeAnimation()
			f41_arg0.Line:setAlpha(0.57)
			f41_arg0.clipFinished(f41_arg0.Line)
			f41_arg0.HeroAbilityUseString:completeAnimation()
			f41_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f41_arg0.HeroAbilityUseString:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.HeroAbilityUseString)
		end,
	},
	PowerBasedCharging = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(8)
			f42_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f42_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.AmmoWidgetMPAbilityFlare)
			f42_arg0.FullBackingDeployed:completeAnimation()
			f42_arg0.FullBackingDeployed:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.FullBackingDeployed)
			f42_arg0.AbilityPulse:completeAnimation()
			f42_arg0.AbilityPulse:setAlpha(0.5)
			f42_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f42_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f42_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f42_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f42_arg0.clipFinished(f42_arg0.AbilityPulse)
			f42_arg0.PowerBasedImageAvailable:completeAnimation()
			f42_arg0.PowerBasedImageAvailable:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.PowerBasedImageAvailable)
			f42_arg0.PowerBasedImageUnavailable:completeAnimation()
			f42_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f42_arg0.PowerBasedImageUnavailable:setImage(RegisterImage(0xDCA29A818A78E8C))
			f42_arg0.clipFinished(f42_arg0.PowerBasedImageUnavailable)
			f42_arg0.NotAvailable:completeAnimation()
			f42_arg0.NotAvailable:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.NotAvailable)
			f42_arg0.Line:completeAnimation()
			f42_arg0.Line:setAlpha(0.57)
			f42_arg0.clipFinished(f42_arg0.Line)
			f42_arg0.HeroAbilityUseString:completeAnimation()
			f42_arg0.HeroAbilityUseString:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.HeroAbilityUseString)
		end,
	},
	PowerBased = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(10)
			f43_arg0.LED:completeAnimation()
			f43_arg0.LED:setRGB(0, 0, 0)
			f43_arg0.LED:setAlpha(0.3)
			f43_arg0.clipFinished(f43_arg0.LED)
			f43_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f43_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.AmmoWidgetMPAbilityFlare)
			f43_arg0.AbilityPulse:completeAnimation()
			f43_arg0.AbilityPulse:setAlpha(0)
			f43_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f43_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f43_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f43_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f43_arg0.clipFinished(f43_arg0.AbilityPulse)
			f43_arg0.Box:completeAnimation()
			f43_arg0.Box:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.Box)
			f43_arg0.PowerBasedImageUnavailable:completeAnimation()
			f43_arg0.PowerBasedImageUnavailable:setRGB(1, 1, 1)
			f43_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.PowerBasedImageUnavailable)
			f43_arg0.NotAvailable:completeAnimation()
			f43_arg0.NotAvailable:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.NotAvailable)
			f43_arg0.Line:completeAnimation()
			f43_arg0.Line:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.Line)
			f43_arg0.HeroAbilityUseString:completeAnimation()
			f43_arg0.HeroAbilityUseString:setRGB(1, 1, 1)
			f43_arg0.HeroAbilityUseString:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.HeroAbilityUseString)
			f43_arg0.GlowRing:completeAnimation()
			f43_arg0.GlowRing:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.GlowRing)
			local f43_local0 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(1000)
					f45_arg0:setAlpha(0.1)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.FlareBack:beginAnimation(1000)
				f43_arg0.FlareBack:setAlpha(0.2)
				f43_arg0.FlareBack:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.FlareBack:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f43_arg0.FlareBack:completeAnimation()
			f43_arg0.FlareBack:setAlpha(0.1)
			f43_arg0.FlareBack:setScale(1, 1)
			f43_local0(f43_arg0.FlareBack)
			f43_arg0.nextClip = "DefaultClip"
		end,
		Pulse = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(8)
			f46_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f46_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.AmmoWidgetMPAbilityFlare)
			f46_arg0.BackingFillAnim:completeAnimation()
			f46_arg0.BackingFillAnim:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.BackingFillAnim)
			f46_arg0.AbilityPulse:completeAnimation()
			f46_arg0.AbilityPulse:setLeftRight(0, 0, 3, 68)
			f46_arg0.AbilityPulse:setTopBottom(0, 0, 0, 59)
			f46_arg0.AbilityPulse:setAlpha(0)
			f46_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f46_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f46_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f46_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f46_arg0.clipFinished(f46_arg0.AbilityPulse)
			f46_arg0.Box:completeAnimation()
			f46_arg0.Box:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.Box)
			f46_arg0.NotAvailable:completeAnimation()
			f46_arg0.NotAvailable:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.NotAvailable)
			f46_arg0.HeroAbilityUseString:completeAnimation()
			f46_arg0.HeroAbilityUseString:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.HeroAbilityUseString)
			f46_arg0.GlowRing:completeAnimation()
			f46_arg0.GlowRing:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.GlowRing)
			local f46_local0 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(1000)
					f48_arg0:setAlpha(0.1)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
				end
				f46_arg0.FlareBack:beginAnimation(1000)
				f46_arg0.FlareBack:setAlpha(0.2)
				f46_arg0.FlareBack:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.FlareBack:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f46_arg0.FlareBack:completeAnimation()
			f46_arg0.FlareBack:setAlpha(0.1)
			f46_arg0.FlareBack:setScale(1, 1)
			f46_local0(f46_arg0.FlareBack)
			f46_arg0.nextClip = "Pulse"
		end,
	},
}
CoD.AmmowidgetMP_HealCooldown.__onClose = function(f49_arg0)
	f49_arg0.AmmoWidgetAbilityContainer:close()
	f49_arg0.AmmoWidgetMPAbilityFlare:close()
	f49_arg0.BackingFillAnim:close()
	f49_arg0.AbilityPulse:close()
	f49_arg0.NotAvailable:close()
	f49_arg0.Line:close()
	f49_arg0.HeroAbilityUseString:close()
	f49_arg0.BountyHealthCount:close()
	f49_arg0.CodCasterLoadoutSelection:close()
end
