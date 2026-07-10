require("x64:34778f864da9dda")
CoD.AmmoWidgetEquipmentText = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetEquipmentText.__defaultWidth = 72
CoD.AmmoWidgetEquipmentText.__defaultHeight = 24
CoD.AmmoWidgetEquipmentText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.hawkActive", 0)
	self:setClass(CoD.AmmoWidgetEquipmentText)
	self.id = "AmmoWidgetEquipmentText"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeroAbilityUseString = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -36, 36, 0, 0, 0, 24)
	HeroAbilityUseString:mergeStateConditions({
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
	local ExtraTextPC = HeroAbilityUseString
	local f1_local3 = HeroAbilityUseString.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(ExtraTextPC, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f7_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	ExtraTextPC = HeroAbilityUseString
	f1_local3 = HeroAbilityUseString.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(ExtraTextPC, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f8_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	ExtraTextPC = HeroAbilityUseString
	f1_local3 = HeroAbilityUseString.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(ExtraTextPC, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f9_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
		})
	end, false)
	HeroAbilityUseString:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(HeroAbilityUseString, f10_arg1)
	end)
	ExtraTextPC = HeroAbilityUseString
	f1_local3 = HeroAbilityUseString.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(ExtraTextPC, f1_local4.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(HeroAbilityUseString, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	HeroAbilityUseString.KBMText:setText(Engine[0xF9F1239CFD921FE](0xEC61C43D90FCF56))
	HeroAbilityUseString.GamepadText:setText(Engine[0xF9F1239CFD921FE](0x9E6A8D0F83F4FC6))
	HeroAbilityUseString.GamepadText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(HeroAbilityUseString)
	self.HeroAbilityUseString = HeroAbilityUseString
	f1_local3 = nil
	self.ExtraText = LUI.UIElement.createFake()
	ExtraTextPC = nil
	ExtraTextPC = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -59, -41)
	ExtraTextPC:setAlpha(0)
	ExtraTextPC:setText(Engine[0xF9F1239CFD921FE](0xE5D33208E8D6267))
	ExtraTextPC:setTTF("ttmussels_regular")
	ExtraTextPC:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ExtraTextPC:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(ExtraTextPC)
	self.ExtraTextPC = ExtraTextPC
	self:mergeStateConditions({
		{
			stateName = "HawkDeployed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hawkActive", 0)
			end,
		},
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
	local f1_local5 = self
	f1_local4 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local5, f1_local6["hudItems.hawkActive"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "hudItems.hawkActive",
		})
	end, false)
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
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.lobbyNav"], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetEquipmentText.__resetProperties = function(f27_arg0)
	f27_arg0.HeroAbilityUseString:completeAnimation()
	f27_arg0.ExtraText:completeAnimation()
	f27_arg0.ExtraTextPC:completeAnimation()
	f27_arg0.HeroAbilityUseString:setRGB(1, 1, 1)
	f27_arg0.HeroAbilityUseString:setAlpha(1)
	f27_arg0.ExtraText:setAlpha(0)
	f27_arg0.ExtraTextPC:setAlpha(0)
end
CoD.AmmoWidgetEquipmentText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.HeroAbilityUseString:completeAnimation()
			f28_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f28_arg0.HeroAbilityUseString:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.HeroAbilityUseString)
			f28_arg0.nextClip = "DefaultClip"
		end,
	},
	HawkDeployed = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.ExtraText:completeAnimation()
			f29_arg0.ExtraText:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.ExtraText)
			f29_arg0.ExtraTextPC:completeAnimation()
			f29_arg0.ExtraTextPC:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.ExtraTextPC)
		end,
	},
	Hidden = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			f30_arg0.HeroAbilityUseString:completeAnimation()
			f30_arg0.HeroAbilityUseString:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.HeroAbilityUseString)
		end,
	},
	Restricted = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			f31_arg0.HeroAbilityUseString:completeAnimation()
			f31_arg0.HeroAbilityUseString:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.HeroAbilityUseString)
		end,
	},
	InUse = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.HeroAbilityUseString:completeAnimation()
			f32_arg0.HeroAbilityUseString:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.HeroAbilityUseString)
			f32_arg0.nextClip = "DefaultClip"
		end,
	},
	Deployed = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.HeroAbilityUseString:completeAnimation()
			f33_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f33_arg0.HeroAbilityUseString:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.HeroAbilityUseString)
		end,
	},
	PowerBasedEmptyCharging = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.HeroAbilityUseString:completeAnimation()
			f34_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f34_arg0.HeroAbilityUseString:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.HeroAbilityUseString)
		end,
	},
	PowerBasedChargingAndReady = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.HeroAbilityUseString:completeAnimation()
			f35_arg0.HeroAbilityUseString:setRGB(1, 1, 1)
			f35_arg0.HeroAbilityUseString:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.HeroAbilityUseString)
			f35_arg0.nextClip = "DefaultClip"
		end,
	},
	PowerBasedCharging = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.HeroAbilityUseString:completeAnimation()
			f36_arg0.HeroAbilityUseString:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.HeroAbilityUseString)
		end,
	},
	PowerBased = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			f37_arg0.HeroAbilityUseString:completeAnimation()
			f37_arg0.HeroAbilityUseString:setRGB(1, 1, 1)
			f37_arg0.HeroAbilityUseString:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.HeroAbilityUseString)
			f37_arg0.nextClip = "DefaultClip"
		end,
	},
	Bounty = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.HeroAbilityUseString:completeAnimation()
			f38_arg0.HeroAbilityUseString:setRGB(0.47, 0.47, 0.47)
			f38_arg0.HeroAbilityUseString:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.HeroAbilityUseString)
		end,
	},
}
CoD.AmmoWidgetEquipmentText.__onClose = function(f39_arg0)
	f39_arg0.HeroAbilityUseString:close()
end
