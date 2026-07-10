require("x64:12322cb4555c55d")
require("x64:9d92dce1e4291ce")
require("x64:33ec8b4b2fb3c47")
require("x64:2d66cf7384bbe8f")
require("x64:7175f021a6edb5")
require("x64:2e88ac782aef92c")
require("x64:24b789df27433d6")
require("x64:2485f9df271d384")
CoD.AmmoWidgetMP_AbilityItem = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_AbilityItem.__defaultWidth = 72
CoD.AmmoWidgetMP_AbilityItem.__defaultHeight = 59
CoD.AmmoWidgetMP_AbilityItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_AbilityItem)
	self.id = "AmmoWidgetMP_AbilityItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AmmoWidgetAbilityContainer = CoD.AmmoWidget_AbilityContainer.new(f1_arg0, f1_arg1, 0, 0, -23, 69, 0, 0, -9, 35)
	AmmoWidgetAbilityContainer:setAlpha(0)
	AmmoWidgetAbilityContainer:setScale(1.4, 1.4)
	self:addElement(AmmoWidgetAbilityContainer)
	self.AmmoWidgetAbilityContainer = AmmoWidgetAbilityContainer
	local AmmoWidgetMPAbilityFlare = CoD.AmmoWidgetMP_Ability_Flare.new(f1_arg0, f1_arg1, 0, 0, -1394, 352, 0, 0, -973, 101)
	AmmoWidgetMPAbilityFlare:setAlpha(0)
	AmmoWidgetMPAbilityFlare:linkToElementModel(self, nil, false, function(model)
		AmmoWidgetMPAbilityFlare:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoWidgetMPAbilityFlare)
	self.AmmoWidgetMPAbilityFlare = AmmoWidgetMPAbilityFlare
	local LED = LUI.UIImage.new(0, 0, -0.5, 69.5, 0, 0, -4.5, 65.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.3)
	LED:setImage(RegisterImage(0xB7A2AC51B160918))
	self:addElement(LED)
	self.LED = LED
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
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BackingFillAnim:setShaderVector(2, AddToVector(0.15, 0, 0, 0, ScaleVectorComponents(0.7, 1, 1, 1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))))
		end
	end)
	self:addElement(BackingFillAnim)
	self.BackingFillAnim = BackingFillAnim
	local PowerBasedxNum = CoD.AmmoWidget_PowerBasedCount.new(f1_arg0, f1_arg1, 0, 0, 2.5, 66.5, 0, 0, 72, 92)
	PowerBasedxNum:linkToElementModel(self, nil, false, function(model)
		PowerBasedxNum:setModel(model, f1_arg1)
	end)
	self:addElement(PowerBasedxNum)
	self.PowerBasedxNum = PowerBasedxNum
	local FullBackingDeployed = LUI.UIImage.new(0, 0, 8, 64, 0, 0, 2, 58)
	FullBackingDeployed:setRGB(0.84, 0.83, 0.77)
	FullBackingDeployed:setAlpha(0)
	FullBackingDeployed:setZRot(180)
	FullBackingDeployed:setImage(RegisterImage(0x40221656249477))
	FullBackingDeployed:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FullBackingDeployed)
	self.FullBackingDeployed = FullBackingDeployed
	local AbilityPulse = CoD.AmmoWidgetMP_Ability_Flash.new(f1_arg0, f1_arg1, 0, 0, 1.5, 67.5, 0, 0, 2.5, 58.5)
	AbilityPulse:setAlpha(0.5)
	AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
	AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
	AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
	AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
	AbilityPulse:linkToElementModel(self, nil, false, function(model)
		AbilityPulse:setModel(model, f1_arg1)
	end)
	AbilityPulse:linkToElementModel(self, "powerRatio", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			AbilityPulse:setShaderVector(2, SetVectorComponent(2, 1, SubtractVectorComponentFrom(1, 1, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))))
		end
	end)
	self:addElement(AbilityPulse)
	self.AbilityPulse = AbilityPulse
	local Box = LUI.UIImage.new(0, 0, -0.5, 69.5, 0, 0, -4.5, 65.5)
	Box:setImage(RegisterImage(0x2A20E3F9478C322))
	Box:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	Box:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Box)
	self.Box = Box
	local PowerBasedImageUnavailable = LUI.UIImage.new(0, 0, -4.5, 75.5, 0, 0, -10, 70)
	PowerBasedImageUnavailable:setRGB(0.65, 0.65, 0.65)
	PowerBasedImageUnavailable:setAlpha(0)
	PowerBasedImageUnavailable:linkToElementModel(self, "id", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			PowerBasedImageUnavailable:setImage(GetWeaponGadgetIconUnavailable(f7_local0))
		end
	end)
	self:addElement(PowerBasedImageUnavailable)
	self.PowerBasedImageUnavailable = PowerBasedImageUnavailable
	local PowerBasedImageAvailable = LUI.UIImage.new(0, 0, -5.5, 74.5, 0, 0, -9.5, 70.5)
	PowerBasedImageAvailable:linkToElementModel(self, "id", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			PowerBasedImageAvailable:setImage(GetWeaponGadgetIconAvailable(f8_local0))
		end
	end)
	self:addElement(PowerBasedImageAvailable)
	self.PowerBasedImageAvailable = PowerBasedImageAvailable
	local NotAvailable = CoD.AmmoWidget_EquipmentEmpty.new(f1_arg0, f1_arg1, 0.5, 0.5, -27, 25, 0.5, 0.5, -18.5, 23.5)
	NotAvailable:linkToElementModel(self, nil, false, function(model)
		NotAvailable:setModel(model, f1_arg1)
	end)
	NotAvailable:linkToElementModel(self, "id", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			NotAvailable.ImgIcon:setImage(GetWeaponGadgetIconAvailable(f10_local0))
		end
	end)
	NotAvailable:linkToElementModel(self, "id", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			NotAvailable.ImgIconGrow:setImage(GetWeaponGadgetIconAvailable(f11_local0))
		end
	end)
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	local Line = LUI.UIImage.new(0, 0, 1, 67, 0.35, 0.35, -2, 3)
	Line:setRGB(0.89, 0.89, 0.89)
	Line:setAlpha(0)
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Line:setShaderVector(0, 0, 0.41, 0, 0.4)
	Line:linkToElementModel(self, "powerRatio", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Line:setTopPct(Add(0, Multiple(1, Negate(f12_local0))))
		end
	end)
	self:addElement(Line)
	self.Line = Line
	local f1_local13 = nil
	self.HeroAbilityHoldString = LUI.UIElement.createFake()
	local HeroAbilityHoldStringPC = nil
	HeroAbilityHoldStringPC = CoD.AbilityHoldToActivate.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0, 0, -93, -44)
	HeroAbilityHoldStringPC.__Alpha = function()
		HeroAbilityHoldStringPC:setAlpha(CoD.HUDUtility.GetAbilityHoldToActivateAlpha(f1_arg1, self, 1))
	end
	HeroAbilityHoldStringPC.__Alpha()
	HeroAbilityHoldStringPC:linkToElementModel(self, nil, false, function(model)
		HeroAbilityHoldStringPC:setModel(model, f1_arg1)
	end)
	self:addElement(HeroAbilityHoldStringPC)
	self.HeroAbilityHoldStringPC = HeroAbilityHoldStringPC
	local GlowRing = LUI.UIImage.new(0, 0, -5, 75, 0, 0, -9.5, 70.5)
	GlowRing:setRGB(1, 0.44, 0)
	GlowRing:setAlpha(0)
	GlowRing:setImage(RegisterImage(0x7028EB3BEA46612))
	GlowRing:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowRing:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GlowRing)
	self.GlowRing = GlowRing
	local FlareBack = LUI.UIImage.new(0, 0, -45.5, 114.5, 0, 0, -40, 100)
	FlareBack:setAlpha(0)
	FlareBack:setScale(1.16, 1.16)
	FlareBack:setImage(RegisterImage(0x49442D6D518A75D))
	FlareBack:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FlareBack)
	self.FlareBack = FlareBack
	local CodCasterLoadoutSelection = CoD.CodCasterLoadoutSelectionHeal.new(f1_arg0, f1_arg1, 0, 0, -2, 70, 0, 0, 2, 62)
	CodCasterLoadoutSelection:setAlpha(0)
	self:addElement(CodCasterLoadoutSelection)
	self.CodCasterLoadoutSelection = CodCasterLoadoutSelection
	local HeroAbilityUseString = CoD.AmmoWidgetEquipmentText.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, -31, -7)
	HeroAbilityUseString:linkToElementModel(self, nil, false, function(model)
		HeroAbilityUseString:setModel(model, f1_arg1)
	end)
	self:addElement(HeroAbilityUseString)
	self.HeroAbilityUseString = HeroAbilityUseString
	HeroAbilityHoldStringPC:linkToElementModel(self, "powerRatio", true, HeroAbilityHoldStringPC.__Alpha)
	local f1_local19 = HeroAbilityHoldStringPC
	local f1_local20 = HeroAbilityHoldStringPC.subscribeToModel
	local f1_local21 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local20(f1_local19, f1_local21["GameplayFeedbackSettings.hideRadiationHold"], HeroAbilityHoldStringPC.__Alpha)
	self:mergeStateConditions({
		{
			stateName = "Hidden",
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
			stateName = "PowerBasedEmptyCharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x958A6962CA8F9B7]) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "powerRatio", 0)
			end,
		},
		{
			stateName = "PowerBasedChargingAndReady",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x1CF78BFE5F942F1]) and not IsWarzone()
			end,
		},
		{
			stateName = "PowerBasedCharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x958A6962CA8F9B7]) and not IsWarzone()
			end,
		},
		{
			stateName = "PowerBased",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x29529861EAA8D1C])
			end,
		},
		{
			stateName = "Bounty",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1)
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
	f1_local19 = self
	f1_local20 = self.subscribeToModel
	f1_local21 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local19, f1_local21["lobbyRoot.lobbyNav"], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f29_arg2, f29_arg3, f29_arg4)
		if CoD.HUDUtility.ShouldPulseNewAmmo(self) and IsSelfInState(self, "PowerBased") then
			PlayClip(self, "Pulse", controller)
		end
	end)
	self:linkToElementModel(self, "ammo", true, function(model)
		local f30_local0 = self
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
CoD.AmmoWidgetMP_AbilityItem.__resetProperties = function(f31_arg0, f31_arg1)
	f31_arg0.NotAvailable:completeAnimation()
	f31_arg0.AbilityPulse:completeAnimation()
	f31_arg0.Line:completeAnimation()
	f31_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
	f31_arg0.FlareBack:completeAnimation()
	f31_arg0.PowerBasedImageUnavailable:completeAnimation()
	f31_arg0.PowerBasedImageAvailable:completeAnimation()
	f31_arg0.FullBackingDeployed:completeAnimation()
	f31_arg0.PowerBasedxNum:completeAnimation()
	f31_arg0.BackingFillAnim:completeAnimation()
	f31_arg0.AmmoWidgetAbilityContainer:completeAnimation()
	f31_arg0.Box:completeAnimation()
	f31_arg0.LED:completeAnimation()
	f31_arg0.HeroAbilityHoldStringPC:completeAnimation()
	f31_arg0.HeroAbilityHoldString:completeAnimation()
	f31_arg0.GlowRing:completeAnimation()
	f31_arg0.NotAvailable:setAlpha(1)
	f31_arg0.AbilityPulse:setLeftRight(0, 0, 1.5, 67.5)
	f31_arg0.AbilityPulse:setTopBottom(0, 0, 2.5, 58.5)
	f31_arg0.AbilityPulse:setAlpha(0.5)
	f31_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
	f31_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
	f31_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
	f31_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
	f31_arg0.Line:setAlpha(0)
	f31_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
	f31_arg0.FlareBack:setAlpha(0)
	f31_arg0.FlareBack:setScale(1.16, 1.16)
	f31_arg0.PowerBasedImageUnavailable:setAlpha(0)
	f31_arg0.PowerBasedImageAvailable:setRGB(1, 1, 1)
	f31_arg0.PowerBasedImageAvailable:setAlpha(1)
	f31_arg0.FullBackingDeployed:setRGB(0.84, 0.83, 0.77)
	f31_arg0.FullBackingDeployed:setAlpha(0)
	f31_arg0.PowerBasedxNum:setAlpha(1)
	f31_arg0.BackingFillAnim:setAlpha(0)
	f31_arg0.AmmoWidgetAbilityContainer:setAlpha(0)
	f31_arg0.Box:setRGB(1, 1, 1)
	f31_arg0.Box:setAlpha(1)
	f31_arg0.LED:setRGB(0, 0, 0)
	f31_arg0.LED:setAlpha(0.3)
	f31_arg0.HeroAbilityHoldStringPC:setAlpha(CoD.HUDUtility.GetAbilityHoldToActivateAlpha(f31_arg1, f31_arg0, 1))
	f31_arg0.HeroAbilityHoldString:setAlpha(1)
	f31_arg0.GlowRing:setAlpha(0)
end
CoD.AmmoWidgetMP_AbilityItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties(f32_arg1)
			f32_arg0:setupElementClipCounter(5)
			f32_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f32_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.AmmoWidgetMPAbilityFlare)
			f32_arg0.AbilityPulse:completeAnimation()
			f32_arg0.AbilityPulse:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.AbilityPulse)
			f32_arg0.NotAvailable:completeAnimation()
			f32_arg0.NotAvailable:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.NotAvailable)
			f32_arg0.Line:completeAnimation()
			f32_arg0.Line:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Line)
			f32_arg0.FlareBack:completeAnimation()
			f32_arg0.FlareBack:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.FlareBack)
			f32_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties(f33_arg1)
			f33_arg0:setupElementClipCounter(12)
			f33_arg0.AmmoWidgetAbilityContainer:completeAnimation()
			f33_arg0.AmmoWidgetAbilityContainer:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.AmmoWidgetAbilityContainer)
			f33_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f33_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.AmmoWidgetMPAbilityFlare)
			f33_arg0.LED:completeAnimation()
			f33_arg0.LED:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.LED)
			f33_arg0.BackingFillAnim:completeAnimation()
			f33_arg0.BackingFillAnim:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.BackingFillAnim)
			f33_arg0.PowerBasedxNum:completeAnimation()
			f33_arg0.PowerBasedxNum:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.PowerBasedxNum)
			f33_arg0.FullBackingDeployed:completeAnimation()
			f33_arg0.FullBackingDeployed:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.FullBackingDeployed)
			f33_arg0.AbilityPulse:completeAnimation()
			f33_arg0.AbilityPulse:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.AbilityPulse)
			f33_arg0.Box:completeAnimation()
			f33_arg0.Box:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Box)
			f33_arg0.PowerBasedImageUnavailable:completeAnimation()
			f33_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.PowerBasedImageUnavailable)
			f33_arg0.PowerBasedImageAvailable:completeAnimation()
			f33_arg0.PowerBasedImageAvailable:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.PowerBasedImageAvailable)
			f33_arg0.NotAvailable:completeAnimation()
			f33_arg0.NotAvailable:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.NotAvailable)
			f33_arg0.Line:completeAnimation()
			f33_arg0.Line:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Line)
		end,
	},
	Restricted = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties(f34_arg1)
			f34_arg0:setupElementClipCounter(6)
			f34_arg0.LED:completeAnimation()
			f34_arg0.LED:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.LED)
			f34_arg0.PowerBasedxNum:completeAnimation()
			f34_arg0.PowerBasedxNum:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.PowerBasedxNum)
			f34_arg0.AbilityPulse:completeAnimation()
			f34_arg0.AbilityPulse:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.AbilityPulse)
			f34_arg0.PowerBasedImageAvailable:completeAnimation()
			f34_arg0.PowerBasedImageAvailable:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.PowerBasedImageAvailable)
			f34_arg0.NotAvailable:completeAnimation()
			f34_arg0.NotAvailable:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.NotAvailable)
			f34_arg0.HeroAbilityHoldString:completeAnimation()
			f34_arg0.HeroAbilityHoldString:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.HeroAbilityHoldString)
			f34_arg0.HeroAbilityHoldStringPC:completeAnimation()
			f34_arg0.HeroAbilityHoldStringPC:setAlpha(CoD.HUDUtility.GetAbilityHoldToActivateAlpha(f34_arg1, f34_arg0, 0))
			f34_arg0.clipFinished(f34_arg0.HeroAbilityHoldStringPC)
		end,
	},
	InUse = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties(f35_arg1)
			f35_arg0:setupElementClipCounter(4)
			f35_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f35_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.AmmoWidgetMPAbilityFlare)
			f35_arg0.AbilityPulse:completeAnimation()
			f35_arg0.AbilityPulse:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.AbilityPulse)
			f35_arg0.NotAvailable:completeAnimation()
			f35_arg0.NotAvailable:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.NotAvailable)
			f35_arg0.Line:completeAnimation()
			f35_arg0.Line:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.Line)
			f35_arg0.nextClip = "DefaultClip"
		end,
	},
	Deployed = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties(f36_arg1)
			f36_arg0:setupElementClipCounter(4)
			f36_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f36_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.AmmoWidgetMPAbilityFlare)
			f36_arg0.AbilityPulse:completeAnimation()
			f36_arg0.AbilityPulse:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.AbilityPulse)
			f36_arg0.NotAvailable:completeAnimation()
			f36_arg0.NotAvailable:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.NotAvailable)
			f36_arg0.Line:completeAnimation()
			f36_arg0.Line:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.Line)
		end,
	},
	PowerBasedEmptyCharging = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties(f37_arg1)
			f37_arg0:setupElementClipCounter(7)
			f37_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f37_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.AmmoWidgetMPAbilityFlare)
			f37_arg0.FullBackingDeployed:completeAnimation()
			f37_arg0.FullBackingDeployed:setRGB(1, 1, 1)
			f37_arg0.FullBackingDeployed:setAlpha(0.03)
			f37_arg0.clipFinished(f37_arg0.FullBackingDeployed)
			f37_arg0.AbilityPulse:completeAnimation()
			f37_arg0.AbilityPulse:setAlpha(0.5)
			f37_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f37_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f37_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f37_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f37_arg0.clipFinished(f37_arg0.AbilityPulse)
			f37_arg0.PowerBasedImageUnavailable:completeAnimation()
			f37_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f37_arg0.clipFinished(f37_arg0.PowerBasedImageUnavailable)
			f37_arg0.PowerBasedImageAvailable:completeAnimation()
			f37_arg0.PowerBasedImageAvailable:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.PowerBasedImageAvailable)
			f37_arg0.NotAvailable:completeAnimation()
			f37_arg0.NotAvailable:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.NotAvailable)
			f37_arg0.Line:completeAnimation()
			f37_arg0.Line:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.Line)
		end,
	},
	PowerBasedChargingAndReady = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties(f38_arg1)
			f38_arg0:setupElementClipCounter(10)
			f38_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f38_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.AmmoWidgetMPAbilityFlare)
			f38_arg0.LED:completeAnimation()
			f38_arg0.LED:setRGB(0, 0, 0)
			f38_arg0.LED:setAlpha(0.3)
			f38_arg0.clipFinished(f38_arg0.LED)
			f38_arg0.AbilityPulse:completeAnimation()
			f38_arg0.AbilityPulse:setAlpha(0.8)
			f38_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f38_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f38_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f38_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f38_arg0.clipFinished(f38_arg0.AbilityPulse)
			f38_arg0.Box:completeAnimation()
			f38_arg0.Box:setRGB(0, 0, 0)
			f38_arg0.Box:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Box)
			f38_arg0.PowerBasedImageUnavailable:completeAnimation()
			f38_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.PowerBasedImageUnavailable)
			f38_arg0.PowerBasedImageAvailable:completeAnimation()
			f38_arg0.PowerBasedImageAvailable:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.PowerBasedImageAvailable)
			f38_arg0.NotAvailable:completeAnimation()
			f38_arg0.NotAvailable:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.NotAvailable)
			f38_arg0.Line:completeAnimation()
			f38_arg0.Line:setAlpha(0.57)
			f38_arg0.clipFinished(f38_arg0.Line)
			f38_arg0.GlowRing:completeAnimation()
			f38_arg0.GlowRing:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.GlowRing)
			local f38_local0 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(1000)
					f40_arg0:setAlpha(0.1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
				end
				f38_arg0.FlareBack:beginAnimation(1000)
				f38_arg0.FlareBack:setAlpha(0.2)
				f38_arg0.FlareBack:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.FlareBack:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f38_arg0.FlareBack:completeAnimation()
			f38_arg0.FlareBack:setAlpha(0.1)
			f38_arg0.FlareBack:setScale(1, 1)
			f38_local0(f38_arg0.FlareBack)
			f38_arg0.nextClip = "DefaultClip"
		end,
		Pulse = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties(f41_arg1)
			f41_arg0:setupElementClipCounter(9)
			f41_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f41_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.AmmoWidgetMPAbilityFlare)
			f41_arg0.LED:completeAnimation()
			f41_arg0.LED:setRGB(0, 0, 0)
			f41_arg0.LED:setAlpha(0.3)
			f41_arg0.clipFinished(f41_arg0.LED)
			f41_arg0.BackingFillAnim:completeAnimation()
			f41_arg0.BackingFillAnim:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.BackingFillAnim)
			f41_arg0.AbilityPulse:completeAnimation()
			f41_arg0.AbilityPulse:setLeftRight(0, 0, 3, 68)
			f41_arg0.AbilityPulse:setTopBottom(0, 0, 0, 59)
			f41_arg0.AbilityPulse:setAlpha(1)
			f41_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f41_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f41_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f41_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f41_arg0.clipFinished(f41_arg0.AbilityPulse)
			f41_arg0.Box:completeAnimation()
			f41_arg0.Box:setRGB(0, 0, 0)
			f41_arg0.Box:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.Box)
			f41_arg0.PowerBasedImageAvailable:completeAnimation()
			f41_arg0.PowerBasedImageAvailable:setRGB(1, 1, 1)
			f41_arg0.clipFinished(f41_arg0.PowerBasedImageAvailable)
			f41_arg0.NotAvailable:completeAnimation()
			f41_arg0.NotAvailable:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.NotAvailable)
			f41_arg0.GlowRing:completeAnimation()
			f41_arg0.GlowRing:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.GlowRing)
			local f41_local0 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					f43_arg0:beginAnimation(1000)
					f43_arg0:setAlpha(0.1)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
				end
				f41_arg0.FlareBack:beginAnimation(1000)
				f41_arg0.FlareBack:setAlpha(0.2)
				f41_arg0.FlareBack:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FlareBack:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f41_arg0.FlareBack:completeAnimation()
			f41_arg0.FlareBack:setAlpha(0.1)
			f41_arg0.FlareBack:setScale(0.5, 0.5)
			f41_local0(f41_arg0.FlareBack)
			f41_arg0.nextClip = "Pulse"
		end,
	},
	PowerBasedCharging = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties(f44_arg1)
			f44_arg0:setupElementClipCounter(7)
			f44_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f44_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.AmmoWidgetMPAbilityFlare)
			f44_arg0.FullBackingDeployed:completeAnimation()
			f44_arg0.FullBackingDeployed:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.FullBackingDeployed)
			f44_arg0.AbilityPulse:completeAnimation()
			f44_arg0.AbilityPulse:setAlpha(0.5)
			f44_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f44_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f44_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f44_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f44_arg0.clipFinished(f44_arg0.AbilityPulse)
			f44_arg0.PowerBasedImageUnavailable:completeAnimation()
			f44_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f44_arg0.clipFinished(f44_arg0.PowerBasedImageUnavailable)
			f44_arg0.PowerBasedImageAvailable:completeAnimation()
			f44_arg0.PowerBasedImageAvailable:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.PowerBasedImageAvailable)
			f44_arg0.NotAvailable:completeAnimation()
			f44_arg0.NotAvailable:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.NotAvailable)
			f44_arg0.Line:completeAnimation()
			f44_arg0.Line:setAlpha(0.57)
			f44_arg0.clipFinished(f44_arg0.Line)
		end,
	},
	PowerBased = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties(f45_arg1)
			f45_arg0:setupElementClipCounter(10)
			f45_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f45_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.AmmoWidgetMPAbilityFlare)
			f45_arg0.LED:completeAnimation()
			f45_arg0.LED:setRGB(0, 0, 0)
			f45_arg0.LED:setAlpha(0.3)
			f45_arg0.clipFinished(f45_arg0.LED)
			f45_arg0.AbilityPulse:completeAnimation()
			f45_arg0.AbilityPulse:setAlpha(0.8)
			f45_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f45_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f45_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f45_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f45_arg0.clipFinished(f45_arg0.AbilityPulse)
			f45_arg0.Box:completeAnimation()
			f45_arg0.Box:setRGB(0, 0, 0)
			f45_arg0.Box:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.Box)
			f45_arg0.PowerBasedImageUnavailable:completeAnimation()
			f45_arg0.PowerBasedImageUnavailable:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.PowerBasedImageUnavailable)
			f45_arg0.PowerBasedImageAvailable:completeAnimation()
			f45_arg0.PowerBasedImageAvailable:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.PowerBasedImageAvailable)
			f45_arg0.NotAvailable:completeAnimation()
			f45_arg0.NotAvailable:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.NotAvailable)
			f45_arg0.Line:completeAnimation()
			f45_arg0.Line:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.Line)
			f45_arg0.GlowRing:completeAnimation()
			f45_arg0.GlowRing:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.GlowRing)
			local f45_local0 = function(f46_arg0)
				local f46_local0 = function(f47_arg0)
					f47_arg0:beginAnimation(1000)
					f47_arg0:setAlpha(0.1)
					f47_arg0:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
				end
				f45_arg0.FlareBack:beginAnimation(1000)
				f45_arg0.FlareBack:setAlpha(0.2)
				f45_arg0.FlareBack:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.FlareBack:registerEventHandler("transition_complete_keyframe", f46_local0)
			end
			f45_arg0.FlareBack:completeAnimation()
			f45_arg0.FlareBack:setAlpha(0.1)
			f45_arg0.FlareBack:setScale(1, 1)
			f45_local0(f45_arg0.FlareBack)
			f45_arg0.nextClip = "DefaultClip"
		end,
		Pulse = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties(f48_arg1)
			f48_arg0:setupElementClipCounter(9)
			f48_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f48_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.AmmoWidgetMPAbilityFlare)
			f48_arg0.LED:completeAnimation()
			f48_arg0.LED:setRGB(0, 0, 0)
			f48_arg0.LED:setAlpha(0.3)
			f48_arg0.clipFinished(f48_arg0.LED)
			f48_arg0.BackingFillAnim:completeAnimation()
			f48_arg0.BackingFillAnim:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.BackingFillAnim)
			f48_arg0.AbilityPulse:completeAnimation()
			f48_arg0.AbilityPulse:setLeftRight(0, 0, 3, 68)
			f48_arg0.AbilityPulse:setTopBottom(0, 0, 0, 59)
			f48_arg0.AbilityPulse:setAlpha(1)
			f48_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f48_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f48_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f48_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f48_arg0.clipFinished(f48_arg0.AbilityPulse)
			f48_arg0.Box:completeAnimation()
			f48_arg0.Box:setRGB(0, 0, 0)
			f48_arg0.Box:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.Box)
			f48_arg0.PowerBasedImageAvailable:completeAnimation()
			f48_arg0.PowerBasedImageAvailable:setRGB(1, 1, 1)
			f48_arg0.clipFinished(f48_arg0.PowerBasedImageAvailable)
			f48_arg0.NotAvailable:completeAnimation()
			f48_arg0.NotAvailable:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.NotAvailable)
			f48_arg0.GlowRing:completeAnimation()
			f48_arg0.GlowRing:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.GlowRing)
			local f48_local0 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(1000)
					f50_arg0:setAlpha(0.1)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f48_arg0.FlareBack:beginAnimation(1000)
				f48_arg0.FlareBack:setAlpha(0.2)
				f48_arg0.FlareBack:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.FlareBack:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f48_arg0.FlareBack:completeAnimation()
			f48_arg0.FlareBack:setAlpha(0.1)
			f48_arg0.FlareBack:setScale(0.5, 0.5)
			f48_local0(f48_arg0.FlareBack)
			f48_arg0.nextClip = "Pulse"
		end,
	},
	Bounty = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties(f51_arg1)
			f51_arg0:setupElementClipCounter(7)
			f51_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f51_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.AmmoWidgetMPAbilityFlare)
			f51_arg0.FullBackingDeployed:completeAnimation()
			f51_arg0.FullBackingDeployed:setRGB(1, 1, 1)
			f51_arg0.FullBackingDeployed:setAlpha(0.03)
			f51_arg0.clipFinished(f51_arg0.FullBackingDeployed)
			f51_arg0.AbilityPulse:completeAnimation()
			f51_arg0.AbilityPulse:setAlpha(0.5)
			f51_arg0.AbilityPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
			f51_arg0.AbilityPulse:setShaderVector(0, 0, 1, 0, 0)
			f51_arg0.AbilityPulse:setShaderVector(1, 0, 0, 0, 0)
			f51_arg0.AbilityPulse:setShaderVector(3, 0, 0, 0, 0)
			f51_arg0.clipFinished(f51_arg0.AbilityPulse)
			f51_arg0.PowerBasedImageUnavailable:completeAnimation()
			f51_arg0.PowerBasedImageUnavailable:setAlpha(0.4)
			f51_arg0.clipFinished(f51_arg0.PowerBasedImageUnavailable)
			f51_arg0.PowerBasedImageAvailable:completeAnimation()
			f51_arg0.PowerBasedImageAvailable:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.PowerBasedImageAvailable)
			f51_arg0.NotAvailable:completeAnimation()
			f51_arg0.NotAvailable:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.NotAvailable)
			f51_arg0.Line:completeAnimation()
			f51_arg0.Line:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.Line)
		end,
	},
}
CoD.AmmoWidgetMP_AbilityItem.__onClose = function(f52_arg0)
	f52_arg0.AmmoWidgetAbilityContainer:close()
	f52_arg0.AmmoWidgetMPAbilityFlare:close()
	f52_arg0.BackingFillAnim:close()
	f52_arg0.PowerBasedxNum:close()
	f52_arg0.AbilityPulse:close()
	f52_arg0.PowerBasedImageUnavailable:close()
	f52_arg0.PowerBasedImageAvailable:close()
	f52_arg0.NotAvailable:close()
	f52_arg0.Line:close()
	f52_arg0.HeroAbilityHoldString:close()
	f52_arg0.HeroAbilityHoldStringPC:close()
	f52_arg0.CodCasterLoadoutSelection:close()
	f52_arg0.HeroAbilityUseString:close()
end
