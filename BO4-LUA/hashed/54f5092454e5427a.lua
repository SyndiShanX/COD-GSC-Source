require("x64:34778f864da9dda")
require("x64:2d66cf7384bbe8f")
require("x64:24b789df27433d6")
require("x64:6e5d082bb780458")
require("x64:2bf3da84e7ff2d3")
CoD.HealCooldown = InheritFrom(LUI.UIElement)
CoD.HealCooldown.__defaultWidth = 72
CoD.HealCooldown.__defaultHeight = 40
CoD.HealCooldown.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealCooldown)
	self.id = "HealCooldown"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HealButtonTextImageReplacement = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0, 0, -8.5, 80.5, 0, 0, 53.5, 75.5)
	HealButtonTextImageReplacement.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_234175BD548C4C21"))
	HealButtonTextImageReplacement.GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_234175BD548C4C21"))
	HealButtonTextImageReplacement.GamepadText:setLetterSpacing(-2)
	HealButtonTextImageReplacement.GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(HealButtonTextImageReplacement)
	self.HealButtonTextImageReplacement = HealButtonTextImageReplacement
	local BackingFill = LUI.UIImage.new(0, 0, -5, 67, 0, 0, -15, 45)
	BackingFill:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	BackingFill:setAlpha(0)
	BackingFill:setZRot(180)
	BackingFill:setImage(RegisterImage(@"hash_216FB6BFD381E066"))
	BackingFill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	BackingFill:setShaderVector(0, 1, 0, 0, 0)
	BackingFill:setShaderVector(1, 0, 0, 0, 0)
	BackingFill:setShaderVector(3, 0.05, 0, 0, 0)
	BackingFill:setShaderVector(4, 0, 0, 0, 0)
	BackingFill:linkToElementModel(self, "powerRatio", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BackingFill:setShaderVector(2, AddToVector(0.12, 0, 0, 0, ScaleVectorComponents(0.9, 1, 1, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))))
		end
	end)
	self:addElement(BackingFill)
	self.BackingFill = BackingFill
	local ReadyBox = LUI.UIImage.new(0, 0, 0, 72, 0, 0, -27.5, 62.5)
	ReadyBox:setRGB(1, 0.68, 0)
	ReadyBox:setImage(RegisterImage(@"hash_628081B8F637C9BD"))
	ReadyBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ReadyBox)
	self.ReadyBox = ReadyBox
	local ReadyGlow = LUI.UIImage.new(0, 0, 10, 62, 0, 0, -19.5, 62.5)
	ReadyGlow:setImage(RegisterImage(@"hash_3560FE2D650E06A5"))
	ReadyGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ReadyGlow)
	self.ReadyGlow = ReadyGlow
	local ReadyGlow2 = LUI.UIImage.new(0, 0, 10, 62, 0, 0, -19.5, 62.5)
	ReadyGlow2:setImage(RegisterImage(@"hash_3560FE2D650E06A5"))
	ReadyGlow2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ReadyGlow2)
	self.ReadyGlow2 = ReadyGlow2
	local ReadyPulse = LUI.UIImage.new(0, 0, 9, 61, 0, 0, -18.5, 63.5)
	ReadyPulse:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ReadyPulse:setImage(RegisterImage(@"hash_349F3334F5ECEF5"))
	ReadyPulse:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ReadyPulse:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(ReadyPulse)
	self.ReadyPulse = ReadyPulse
	local HealEmpty = CoD.AmmoWidget_EquipmentEmpty.new(f1_arg0, f1_arg1, 0, 0, 3.5, 65.5, 0, 0, -5, 35)
	HealEmpty.ImgIcon:setImage(RegisterImage(@"blacktransparent"))
	HealEmpty.ImgIconGrow:setImage(RegisterImage(@"blacktransparent"))
	HealEmpty:linkToElementModel(self, nil, false, function(model)
		HealEmpty:setModel(model, f1_arg1)
	end)
	self:addElement(HealEmpty)
	self.HealEmpty = HealEmpty
	local BackingPulse = CoD.AmmoWidgetMP_EquipmentLethal_Flash.new(f1_arg0, f1_arg1, 0, 0, 16.5, 55.5, 0, 0, 0.5, 39.5)
	BackingPulse:setYRot(180)
	BackingPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_51DE43899593E67E"))
	BackingPulse:setShaderVector(0, 0, 1, 0, 0)
	BackingPulse:setShaderVector(1, 0, 0, 0, 0)
	BackingPulse:setShaderVector(3, 0, 0, 0, 0)
	BackingPulse.Backing:setYRot(180)
	BackingPulse.Backing:setZRot(0)
	BackingPulse.BackingMask:setYRot(180)
	BackingPulse.BackingMask:setZRot(0)
	BackingPulse:linkToElementModel(self, nil, false, function(model)
		BackingPulse:setModel(model, f1_arg1)
	end)
	BackingPulse:linkToElementModel(self, "powerRatio", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			BackingPulse:setShaderVector(2, SetVectorComponent(2, 1, SubtractVectorComponentFrom(1, 1, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))))
		end
	end)
	self:addElement(BackingPulse)
	self.BackingPulse = BackingPulse
	local HealIcon = LUI.UIImage.new(0, 0, 12.5, 58.5, 0, 0, -3, 43)
	HealIcon:setRGB(0.29, 0.29, 0.29)
	HealIcon:setScale(0.7, 0.7)
	HealIcon:linkToElementModel(self, "id", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HealIcon:setImage(GetWeaponGadgetIconAvailable(f6_local0))
		end
	end)
	self:addElement(HealIcon)
	self.HealIcon = HealIcon
	local LocalHealIcon = LUI.UIImage.new(0, 0, 12.5, 58.5, 0, 0, -3, 43)
	LocalHealIcon:setRGB(0, 0, 0)
	LocalHealIcon:setAlpha(0)
	LocalHealIcon:setScale(0.7, 0.7)
	LocalHealIcon:setImage(RegisterImage(@"hash_40A4F8228AC959"))
	self:addElement(LocalHealIcon)
	self.LocalHealIcon = LocalHealIcon
	local AmmoWidgetMPAbilityFlare = CoD.AmmoWidgetMP_Ability_Flare.new(f1_arg0, f1_arg1, 0, 0, -275, 1463, 0, 0, -986.5, 87.5)
	AmmoWidgetMPAbilityFlare:setYRot(180)
	AmmoWidgetMPAbilityFlare:linkToElementModel(self, nil, false, function(model)
		AmmoWidgetMPAbilityFlare:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoWidgetMPAbilityFlare)
	self.AmmoWidgetMPAbilityFlare = AmmoWidgetMPAbilityFlare
	local Line = LUI.UIImage.new(0, 0, 16, 55, 0.35, 0.35, -1, 1)
	Line:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Line:setAlpha(0)
	Line:linkToElementModel(self, "powerRatio", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Line:setTopPct(Negate(f8_local0))
		end
	end)
	self:addElement(Line)
	self.Line = Line
	local Box = LUI.UIImage.new(0, 0, 11, 61, 0, 0, -5.5, 44.5)
	Box:setAlpha(0.5)
	Box:setImage(RegisterImage(@"hash_61361B633E108517"))
	Box:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Box)
	self.Box = Box
	local WZAmmoNumber = CoD.onOffText.new(f1_arg0, f1_arg1, 0, 0, 45.5, 65.5, 0, 0, 13, 50)
	WZAmmoNumber:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not IsWarzone()
			end,
		},
	})
	local f1_local15 = WZAmmoNumber
	local f1_local16 = WZAmmoNumber.subscribeToModel
	local f1_local17 = Engine[@"getglobalmodel"]()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(WZAmmoNumber, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	WZAmmoNumber:linkToElementModel(self, "ammo", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			WZAmmoNumber.TextBox:setText(f11_local0)
		end
	end)
	self:addElement(WZAmmoNumber)
	self.WZAmmoNumber = WZAmmoNumber
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsWarzone()
			end,
		},
		{
			stateName = "LocalHealingActive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "localHealActive", 1)
			end,
		},
		{
			stateName = "InUse",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"])
			end,
		},
		{
			stateName = "Charging",
			condition = function(menu, element, event)
				return IsSecondaryOffhandGadgetPowerBased(f1_arg1) and CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "powerRatio", 1)
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "ammo", 0) and IsWarzone()
			end,
		},
	})
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[@"getglobalmodel"]()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local16(f1_local15, f1_local17.localHealActive, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "localHealActive",
		})
	end, false)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
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
	self:linkToElementModel(self, "ammo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammo",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "HUDItems", "pulseNoTactical", function(model)
		if CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "powerRatio", 1) then
			PlayClipOnElement(self, {
				elementName = "HealEmpty",
				clipName = "Empty",
			}, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HealCooldown.__resetProperties = function(f24_arg0)
	f24_arg0.BackingPulse:completeAnimation()
	f24_arg0.BackingFill:completeAnimation()
	f24_arg0.HealEmpty:completeAnimation()
	f24_arg0.ReadyBox:completeAnimation()
	f24_arg0.Line:completeAnimation()
	f24_arg0.HealIcon:completeAnimation()
	f24_arg0.ReadyGlow2:completeAnimation()
	f24_arg0.ReadyGlow:completeAnimation()
	f24_arg0.ReadyPulse:completeAnimation()
	f24_arg0.HealButtonTextImageReplacement:completeAnimation()
	f24_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
	f24_arg0.Box:completeAnimation()
	f24_arg0.WZAmmoNumber:completeAnimation()
	f24_arg0.LocalHealIcon:completeAnimation()
	f24_arg0.BackingPulse:setLeftRight(0, 0, 16.5, 55.5)
	f24_arg0.BackingPulse:setTopBottom(0, 0, 0.5, 39.5)
	f24_arg0.BackingPulse:setAlpha(1)
	f24_arg0.BackingFill:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f24_arg0.BackingFill:setAlpha(0)
	f24_arg0.HealEmpty:setLeftRight(0, 0, 3.5, 65.5)
	f24_arg0.HealEmpty:setTopBottom(0, 0, -5, 35)
	f24_arg0.HealEmpty:setAlpha(1)
	f24_arg0.HealEmpty:setScale(1, 1)
	f24_arg0.ReadyBox:setRGB(1, 0.68, 0)
	f24_arg0.ReadyBox:setAlpha(1)
	f24_arg0.Line:setTopBottom(0, 0, -1, 1)
	f24_arg0.Line:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f24_arg0.Line:setAlpha(0)
	f24_arg0.HealIcon:setRGB(0.29, 0.29, 0.29)
	f24_arg0.HealIcon:setAlpha(1)
	f24_arg0.ReadyGlow2:setAlpha(1)
	f24_arg0.ReadyGlow:setAlpha(1)
	f24_arg0.ReadyPulse:setLeftRight(0, 0, 9, 61)
	f24_arg0.ReadyPulse:setTopBottom(0, 0, -18.5, 63.5)
	f24_arg0.ReadyPulse:setAlpha(1)
	f24_arg0.HealButtonTextImageReplacement:setAlpha(1)
	f24_arg0.AmmoWidgetMPAbilityFlare:setAlpha(1)
	f24_arg0.Box:setAlpha(0.5)
	f24_arg0.WZAmmoNumber:setAlpha(1)
	f24_arg0.LocalHealIcon:setAlpha(0)
end
CoD.HealCooldown.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(9)
			f25_arg0.BackingFill:completeAnimation()
			f25_arg0.BackingFill:setRGB(1, 0.7, 0)
			f25_arg0.BackingFill:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.BackingFill)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(1000)
					f27_arg0:setAlpha(0.8)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.ReadyBox:beginAnimation(1000)
				f25_arg0.ReadyBox:setAlpha(1)
				f25_arg0.ReadyBox:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ReadyBox:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.ReadyBox:completeAnimation()
			f25_arg0.ReadyBox:setAlpha(0.8)
			f25_local0(f25_arg0.ReadyBox)
			local f25_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(1000)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.ReadyGlow:beginAnimation(1000)
				f25_arg0.ReadyGlow:setAlpha(0)
				f25_arg0.ReadyGlow:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ReadyGlow:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f25_arg0.ReadyGlow:completeAnimation()
			f25_arg0.ReadyGlow:setAlpha(1)
			f25_local1(f25_arg0.ReadyGlow)
			local f25_local2 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(1000)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.ReadyGlow2:beginAnimation(1000)
				f25_arg0.ReadyGlow2:setAlpha(0)
				f25_arg0.ReadyGlow2:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ReadyGlow2:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f25_arg0.ReadyGlow2:completeAnimation()
			f25_arg0.ReadyGlow2:setAlpha(1)
			f25_local2(f25_arg0.ReadyGlow2)
			local f25_local3 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(1000)
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.ReadyPulse:beginAnimation(1000)
				f25_arg0.ReadyPulse:setAlpha(0)
				f25_arg0.ReadyPulse:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ReadyPulse:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f25_arg0.ReadyPulse:completeAnimation()
			f25_arg0.ReadyPulse:setAlpha(1)
			f25_local3(f25_arg0.ReadyPulse)
			f25_arg0.HealEmpty:completeAnimation()
			f25_arg0.HealEmpty:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.HealEmpty)
			f25_arg0.BackingPulse:completeAnimation()
			f25_arg0.BackingPulse:setLeftRight(0, 0, 3, 68)
			f25_arg0.BackingPulse:setTopBottom(0, 0, 0, 59)
			f25_arg0.BackingPulse:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.BackingPulse)
			f25_arg0.HealIcon:completeAnimation()
			f25_arg0.HealIcon:setRGB(0.95, 0.93, 0.86)
			f25_arg0.clipFinished(f25_arg0.HealIcon)
			f25_arg0.Line:completeAnimation()
			f25_arg0.Line:setRGB(0.92, 0.92, 0.92)
			f25_arg0.Line:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Line)
			f25_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(11)
			f34_arg0.HealButtonTextImageReplacement:completeAnimation()
			f34_arg0.HealButtonTextImageReplacement:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.HealButtonTextImageReplacement)
			f34_arg0.ReadyBox:completeAnimation()
			f34_arg0.ReadyBox:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ReadyBox)
			f34_arg0.ReadyGlow:completeAnimation()
			f34_arg0.ReadyGlow:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ReadyGlow)
			f34_arg0.ReadyGlow2:completeAnimation()
			f34_arg0.ReadyGlow2:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ReadyGlow2)
			f34_arg0.ReadyPulse:completeAnimation()
			f34_arg0.ReadyPulse:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ReadyPulse)
			f34_arg0.HealEmpty:completeAnimation()
			f34_arg0.HealEmpty:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.HealEmpty)
			f34_arg0.BackingPulse:completeAnimation()
			f34_arg0.BackingPulse:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.BackingPulse)
			f34_arg0.HealIcon:completeAnimation()
			f34_arg0.HealIcon:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.HealIcon)
			f34_arg0.AmmoWidgetMPAbilityFlare:completeAnimation()
			f34_arg0.AmmoWidgetMPAbilityFlare:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.AmmoWidgetMPAbilityFlare)
			f34_arg0.Box:completeAnimation()
			f34_arg0.Box:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Box)
			f34_arg0.WZAmmoNumber:completeAnimation()
			f34_arg0.WZAmmoNumber:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.WZAmmoNumber)
		end,
	},
	LocalHealingActive = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(8)
			f35_arg0.HealButtonTextImageReplacement:completeAnimation()
			f35_arg0.HealButtonTextImageReplacement:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.HealButtonTextImageReplacement)
			f35_arg0.BackingFill:completeAnimation()
			f35_arg0.BackingFill:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.BackingFill)
			f35_arg0.ReadyBox:completeAnimation()
			f35_arg0.ReadyBox:setRGB(1, 1, 1)
			f35_arg0.ReadyBox:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.ReadyBox)
			f35_arg0.HealEmpty:completeAnimation()
			f35_arg0.HealEmpty:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.HealEmpty)
			f35_arg0.BackingPulse:completeAnimation()
			f35_arg0.BackingPulse:setLeftRight(0, 0, 3, 68)
			f35_arg0.BackingPulse:setTopBottom(0, 0, 0, 59)
			f35_arg0.BackingPulse:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.BackingPulse)
			f35_arg0.HealIcon:completeAnimation()
			f35_arg0.HealIcon:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.HealIcon)
			f35_arg0.LocalHealIcon:completeAnimation()
			f35_arg0.LocalHealIcon:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.LocalHealIcon)
			f35_arg0.Line:completeAnimation()
			f35_arg0.Line:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.Line)
		end,
	},
	InUse = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(10)
			f36_arg0.HealButtonTextImageReplacement:completeAnimation()
			f36_arg0.HealButtonTextImageReplacement:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.HealButtonTextImageReplacement)
			f36_arg0.BackingFill:completeAnimation()
			f36_arg0.BackingFill:setRGB(0.36, 0.36, 0.36)
			f36_arg0.clipFinished(f36_arg0.BackingFill)
			f36_arg0.ReadyBox:completeAnimation()
			f36_arg0.ReadyBox:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ReadyBox)
			f36_arg0.ReadyGlow:completeAnimation()
			f36_arg0.ReadyGlow:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ReadyGlow)
			f36_arg0.ReadyGlow2:completeAnimation()
			f36_arg0.ReadyGlow2:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ReadyGlow2)
			f36_arg0.ReadyPulse:completeAnimation()
			f36_arg0.ReadyPulse:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ReadyPulse)
			f36_arg0.HealEmpty:completeAnimation()
			f36_arg0.HealEmpty:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.HealEmpty)
			f36_arg0.BackingPulse:completeAnimation()
			f36_arg0.BackingPulse:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.BackingPulse)
			f36_arg0.HealIcon:completeAnimation()
			f36_arg0.HealIcon:setRGB(0.97, 0.97, 0.84)
			f36_arg0.HealIcon:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.HealIcon)
			f36_arg0.Line:completeAnimation()
			f36_arg0.Line:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Line)
		end,
	},
	Charging = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(10)
			f37_arg0.HealButtonTextImageReplacement:completeAnimation()
			f37_arg0.HealButtonTextImageReplacement:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.HealButtonTextImageReplacement)
			f37_arg0.BackingFill:completeAnimation()
			f37_arg0.BackingFill:setRGB(0.36, 0.36, 0.36)
			f37_arg0.clipFinished(f37_arg0.BackingFill)
			f37_arg0.ReadyBox:completeAnimation()
			f37_arg0.ReadyBox:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ReadyBox)
			f37_arg0.ReadyGlow:completeAnimation()
			f37_arg0.ReadyGlow:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ReadyGlow)
			f37_arg0.ReadyGlow2:completeAnimation()
			f37_arg0.ReadyGlow2:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ReadyGlow2)
			f37_arg0.ReadyPulse:completeAnimation()
			f37_arg0.ReadyPulse:setLeftRight(0, 0, 10, 62)
			f37_arg0.ReadyPulse:setTopBottom(0, 0, -9.5, 72.5)
			f37_arg0.ReadyPulse:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ReadyPulse)
			f37_arg0.HealEmpty:completeAnimation()
			f37_arg0.HealEmpty:setLeftRight(0, 0, 4, 66)
			f37_arg0.HealEmpty:setTopBottom(0, 0, 0.5, 40.5)
			f37_arg0.HealEmpty:setAlpha(1)
			f37_arg0.HealEmpty:setScale(0.61, 0.67)
			f37_arg0.clipFinished(f37_arg0.HealEmpty)
			f37_arg0.BackingPulse:completeAnimation()
			f37_arg0.BackingPulse:setAlpha(0.8)
			f37_arg0.clipFinished(f37_arg0.BackingPulse)
			f37_arg0.HealIcon:completeAnimation()
			f37_arg0.HealIcon:setRGB(0.32, 0.32, 0.32)
			f37_arg0.HealIcon:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.HealIcon)
			f37_arg0.Line:completeAnimation()
			f37_arg0.Line:setTopBottom(0, 0, -1, 1)
			f37_arg0.Line:setAlpha(0.5)
			f37_arg0.clipFinished(f37_arg0.Line)
		end,
	},
	Empty = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(10)
			f38_arg0.HealButtonTextImageReplacement:completeAnimation()
			f38_arg0.HealButtonTextImageReplacement:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.HealButtonTextImageReplacement)
			f38_arg0.BackingFill:completeAnimation()
			f38_arg0.BackingFill:setRGB(0.36, 0.36, 0.36)
			f38_arg0.clipFinished(f38_arg0.BackingFill)
			f38_arg0.ReadyBox:completeAnimation()
			f38_arg0.ReadyBox:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ReadyBox)
			f38_arg0.ReadyGlow:completeAnimation()
			f38_arg0.ReadyGlow:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ReadyGlow)
			f38_arg0.ReadyGlow2:completeAnimation()
			f38_arg0.ReadyGlow2:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ReadyGlow2)
			f38_arg0.ReadyPulse:completeAnimation()
			f38_arg0.ReadyPulse:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ReadyPulse)
			f38_arg0.HealEmpty:completeAnimation()
			f38_arg0.HealEmpty:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.HealEmpty)
			f38_arg0.BackingPulse:completeAnimation()
			f38_arg0.BackingPulse:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.BackingPulse)
			f38_arg0.HealIcon:completeAnimation()
			f38_arg0.HealIcon:setRGB(0.97, 0.97, 0.84)
			f38_arg0.HealIcon:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.HealIcon)
			f38_arg0.Line:completeAnimation()
			f38_arg0.Line:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.Line)
		end,
	},
}
CoD.HealCooldown.__onClose = function(f39_arg0)
	f39_arg0.HealButtonTextImageReplacement:close()
	f39_arg0.BackingFill:close()
	f39_arg0.HealEmpty:close()
	f39_arg0.BackingPulse:close()
	f39_arg0.HealIcon:close()
	f39_arg0.AmmoWidgetMPAbilityFlare:close()
	f39_arg0.Line:close()
	f39_arg0.WZAmmoNumber:close()
end
