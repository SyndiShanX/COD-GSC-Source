require("x64:41193c666b38002")
require("x64:eaa54c63c35ed1c")
CoD.AmmoWidgetMP_ClipInfo = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_ClipInfo.__defaultWidth = 64
CoD.AmmoWidgetMP_ClipInfo.__defaultHeight = 61
CoD.AmmoWidgetMP_ClipInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_ClipInfo)
	self.id = "AmmoWidgetMP_ClipInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Clip = CoD.AmmoWidgetMP_ClipContainerNew.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 3.5, 29.5)
	Clip:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "CurrentWeapon", "weapon", 0) and not IsCampaign()
			end,
		},
		{
			stateName = "LowAmmo",
			condition = function(menu, element, event)
				local f3_local0 = IsLowAmmoClip(f1_arg1)
				if f3_local0 then
					f3_local0 = WeaponHasAmmo(f1_arg1)
					if f3_local0 then
						f3_local0 = not IsSignatureWeaponInUse(f1_arg1)
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "NoAmmo",
			condition = function(menu, element, event)
				local f4_local0
				if not WeaponHasAmmo(f1_arg1) then
					f4_local0 = WeaponUsesAmmo(f1_arg1)
					if f4_local0 then
						f4_local0 = not CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenAmmo(f1_arg1)
					end
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "Hero",
			condition = function(menu, element, event)
				return IsSignatureWeaponInUse(f1_arg1)
			end,
		},
	})
	local ClipHero = Clip
	local ClipDual = Clip.subscribeToModel
	local TotalAmmoLabel = DataSources.CurrentWeapon.getModel(f1_arg1)
	ClipDual(ClipHero, TotalAmmoLabel.weapon, function(f6_arg0)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "weapon",
		})
	end, false)
	ClipHero = Clip
	ClipDual = Clip.subscribeToModel
	TotalAmmoLabel = Engine[@"getglobalmodel"]()
	ClipDual(ClipHero, TotalAmmoLabel["lobbyRoot.lobbyNav"], function(f7_arg0)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ClipHero = Clip
	ClipDual = Clip.subscribeToModel
	TotalAmmoLabel = DataSources.CurrentWeapon.getModel(f1_arg1)
	ClipDual(ClipHero, TotalAmmoLabel.ammoLow, function(f8_arg0)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "ammoLow",
		})
	end, false)
	ClipHero = Clip
	ClipDual = Clip.subscribeToModel
	TotalAmmoLabel = DataSources.CurrentWeapon.getModel(f1_arg1)
	ClipDual(ClipHero, TotalAmmoLabel.weaponHasAmmo, function(f9_arg0)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "weaponHasAmmo",
		})
	end, false)
	ClipHero = Clip
	ClipDual = Clip.subscribeToModel
	TotalAmmoLabel = DataSources.CurrentWeapon.getModel(f1_arg1)
	ClipDual(ClipHero, TotalAmmoLabel.equippedWeaponReference, function(f10_arg0)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "equippedWeaponReference",
		})
	end, false)
	ClipHero = Clip
	ClipDual = Clip.subscribeToModel
	TotalAmmoLabel = DataSources.CurrentWeapon.getModel(f1_arg1)
	ClipDual(ClipHero, TotalAmmoLabel.viewmodelWeaponName, function(f11_arg0)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "viewmodelWeaponName",
		})
	end, false)
	Clip:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Clip:linkToElementModel(self, "ammoInClip", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Clip.Clip.Clip:setText(CoD.BaseUtility.AlreadyLocalized(f12_local0))
		end
	end)
	Clip:linkToElementModel(self, "ammoInClip", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Clip.ClipContainerPress.Clip:setText(CoD.BaseUtility.AlreadyLocalized(f13_local0))
		end
	end)
	self:addElement(Clip)
	self.Clip = Clip
	ClipDual = CoD.AmmoWidgetMP_ClipContainerNew.new(f1_arg0, f1_arg1, 1, 1, -198, -10, 1, 1, -86.5, 30.5)
	ClipDual:mergeStateConditions({
		{
			stateName = "LowAmmo",
			condition = function(menu, element, event)
				return IsLowAmmoDWClip(f1_arg1)
			end,
		},
		{
			stateName = "NoAmmo",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hero",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	TotalAmmoLabel = ClipDual
	ClipHero = ClipDual.subscribeToModel
	local f1_local5 = DataSources.CurrentWeapon.getModel(f1_arg1)
	ClipHero(TotalAmmoLabel, f1_local5.ammoDWLow, function(f17_arg0)
		f1_arg0:updateElementState(ClipDual, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "ammoDWLow",
		})
	end, false)
	ClipDual:setAlpha(0)
	ClipDual:setZoom(3)
	ClipDual:linkToElementModel(self, "ammoInDWClip", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			ClipDual.Clip.Clip:setText(CoD.BaseUtility.AlreadyLocalized(f18_local0))
		end
	end)
	ClipDual:linkToElementModel(self, "ammoInDWClip", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			ClipDual.ClipContainerPress.Clip:setText(CoD.BaseUtility.AlreadyLocalized(f19_local0))
		end
	end)
	self:addElement(ClipDual)
	self.ClipDual = ClipDual
	ClipHero = CoD.AmmoWidgetMP_ClipContainerHero.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ClipHero:mergeStateConditions({
		{
			stateName = "Weapon",
			condition = function(menu, element, event)
				return CoD.HUDUtility.UsingPlayerGadgetWithBar(f1_arg1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PlayerAbilities", "playerGadget3.state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"])
			end,
		},
		{
			stateName = "Ability",
			condition = function(menu, element, event)
				return CoD.HUDUtility.UsingPlayerGadgetWithBar(f1_arg1)
			end,
		},
	})
	f1_local5 = ClipHero
	TotalAmmoLabel = ClipHero.subscribeToModel
	local f1_local6 = DataSources.PlayerAbilities.getModel(f1_arg1)
	TotalAmmoLabel(f1_local5, f1_local6["playerGadget2.state"], function(f22_arg0)
		f1_arg0:updateElementState(ClipHero, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "playerGadget2.state",
		})
	end, false)
	f1_local5 = ClipHero
	TotalAmmoLabel = ClipHero.subscribeToModel
	f1_local6 = DataSources.PlayerAbilities.getModel(f1_arg1)
	TotalAmmoLabel(f1_local5, f1_local6["playerGadget3.state"], function(f23_arg0)
		f1_arg0:updateElementState(ClipHero, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "playerGadget3.state",
		})
	end, false)
	f1_local5 = ClipHero
	TotalAmmoLabel = ClipHero.subscribeToModel
	f1_local6 = DataSources.CurrentWeapon.getModel(f1_arg1)
	TotalAmmoLabel(f1_local5, f1_local6.viewmodelWeaponName, function(f24_arg0)
		f1_arg0:updateElementState(ClipHero, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "viewmodelWeaponName",
		})
	end, false)
	ClipHero:setAlpha(0)
	ClipHero:setZoom(3)
	self:addElement(ClipHero)
	self.ClipHero = ClipHero
	TotalAmmoLabel = LUI.UIText.new(0, 1, 0, 0, 0, 0, 47, 63)
	TotalAmmoLabel:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	TotalAmmoLabel:setAlpha(0)
	TotalAmmoLabel:setTTF("0arame_mono_stencil")
	TotalAmmoLabel:setLetterSpacing(2)
	TotalAmmoLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TotalAmmoLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TotalAmmoLabel:linkToElementModel(self, "ammoStock", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			TotalAmmoLabel:setText(f25_local0)
		end
	end)
	self:addElement(TotalAmmoLabel)
	self.TotalAmmoLabel = TotalAmmoLabel
	self:mergeStateConditions({
		{
			stateName = "DisposableMags",
			condition = function(menu, element, event)
				return IsMultiplayer()
			end,
		},
		{
			stateName = "HiddenGamemodeWeapon",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenAmmo(f1_arg1)
			end,
		},
		{
			stateName = "HeroWeapon",
			condition = function(menu, element, event)
				return CoD.HUDUtility.UsingPlayerGadgetWithBar(f1_arg1)
			end,
		},
		{
			stateName = "WeaponDual",
			condition = function(menu, element, event)
				local f29_local0 = WeaponUsesAmmo(f1_arg1)
				if f29_local0 then
					f29_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "CurrentWeapon", "ammoInDWClip", -1)
					if f29_local0 then
						f29_local0 = not CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenDWAmmo(f1_arg1)
					end
				end
				return f29_local0
			end,
		},
		{
			stateName = "Weapon",
			condition = function(menu, element, event)
				return WeaponUsesAmmo(f1_arg1) and not IsWeaponClipGreaterThanOrEqualTo(f1_arg1, 100)
			end,
		},
		{
			stateName = "Weapon3Digits",
			condition = function(menu, element, event)
				return IsWeaponClipGreaterThanOrEqualTo(f1_arg1, 100)
			end,
		},
	})
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local6, f1_local7["lobbyRoot.lobbyNav"], function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.viewmodelWeaponName, function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "viewmodelWeaponName",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = DataSources.PlayerAbilities.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7["playerGadget2.state"], function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "playerGadget2.state",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = DataSources.PlayerAbilities.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7["playerGadget3.state"], function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "playerGadget3.state",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.weapon, function(f36_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "weapon",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.ammoInDWClip, function(f37_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "ammoInDWClip",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.clipMaxAmmo, function(f38_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "clipMaxAmmo",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetMP_ClipInfo.__resetProperties = function(f39_arg0)
	f39_arg0.ClipHero:completeAnimation()
	f39_arg0.Clip:completeAnimation()
	f39_arg0.TotalAmmoLabel:completeAnimation()
	f39_arg0.ClipDual:completeAnimation()
	f39_arg0.ClipHero:setLeftRight(0, 1, 0, 0)
	f39_arg0.ClipHero:setTopBottom(0, 1, 0, 0)
	f39_arg0.ClipHero:setRGB(1, 1, 1)
	f39_arg0.ClipHero:setAlpha(0)
	f39_arg0.Clip:setLeftRight(0, 1, 0, 0)
	f39_arg0.Clip:setTopBottom(0, 0, 3.5, 29.5)
	f39_arg0.Clip:setAlpha(1)
	f39_arg0.TotalAmmoLabel:setLeftRight(0, 1, 0, 0)
	f39_arg0.TotalAmmoLabel:setTopBottom(0, 0, 47, 63)
	f39_arg0.TotalAmmoLabel:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	f39_arg0.TotalAmmoLabel:setAlpha(0)
	f39_arg0.ClipDual:setLeftRight(1, 1, -198, -10)
	f39_arg0.ClipDual:setTopBottom(1, 1, -86.5, 30.5)
	f39_arg0.ClipDual:setAlpha(0)
end
CoD.AmmoWidgetMP_ClipInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.Clip:completeAnimation()
			f40_arg0.Clip:setTopBottom(0, 0, 17.5, 43.5)
			f40_arg0.clipFinished(f40_arg0.Clip)
			f40_arg0.ClipHero:completeAnimation()
			f40_arg0.ClipHero:setLeftRight(1, 2, -159, -159)
			f40_arg0.ClipHero:setTopBottom(1, 2, -96, -96)
			f40_arg0.clipFinished(f40_arg0.ClipHero)
		end,
	},
	DisposableMags = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(3)
			f41_arg0.Clip:completeAnimation()
			f41_arg0.Clip:setLeftRight(0, 1, 0, 0)
			f41_arg0.Clip:setTopBottom(0, 0, 17.5, 43.5)
			f41_arg0.Clip:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.Clip)
			f41_arg0.ClipHero:completeAnimation()
			f41_arg0.ClipHero:setLeftRight(0, 1, 0, 0)
			f41_arg0.ClipHero:setTopBottom(0, 1, 0, 0)
			f41_arg0.ClipHero:setRGB(1, 1, 1)
			f41_arg0.clipFinished(f41_arg0.ClipHero)
			f41_arg0.TotalAmmoLabel:completeAnimation()
			f41_arg0.TotalAmmoLabel:setRGB(0.8, 0.77, 0.64)
			f41_arg0.TotalAmmoLabel:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.TotalAmmoLabel)
		end,
	},
	HiddenGamemodeWeapon = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(3)
			f42_arg0.Clip:completeAnimation()
			f42_arg0.Clip:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.Clip)
			f42_arg0.ClipHero:completeAnimation()
			f42_arg0.ClipHero:setLeftRight(1, 2, 371, 371)
			f42_arg0.ClipHero:setTopBottom(1, 2, -96, -96)
			f42_arg0.clipFinished(f42_arg0.ClipHero)
			f42_arg0.TotalAmmoLabel:completeAnimation()
			f42_arg0.TotalAmmoLabel:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.TotalAmmoLabel)
		end,
	},
	HeroWeapon = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(3)
			f43_arg0.Clip:completeAnimation()
			f43_arg0.Clip:setLeftRight(0, 1, 0, 0)
			f43_arg0.Clip:setTopBottom(0, 0, 17.5, 43.5)
			f43_arg0.Clip:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.Clip)
			f43_arg0.ClipHero:completeAnimation()
			f43_arg0.ClipHero:setLeftRight(0, 1, 0, 0)
			f43_arg0.ClipHero:setTopBottom(0, 1, 0, 0)
			f43_arg0.ClipHero:setRGB(1, 1, 1)
			f43_arg0.ClipHero:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.ClipHero)
			f43_arg0.TotalAmmoLabel:completeAnimation()
			f43_arg0.TotalAmmoLabel:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.TotalAmmoLabel)
		end,
	},
	WeaponDual = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(3)
			f44_arg0.Clip:completeAnimation()
			f44_arg0.Clip:setLeftRight(0, 0, 32, 64)
			f44_arg0.Clip:setTopBottom(0, 0, 5, 31)
			f44_arg0.Clip:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.Clip)
			f44_arg0.ClipDual:completeAnimation()
			f44_arg0.ClipDual:setLeftRight(0, 0, 0, 32)
			f44_arg0.ClipDual:setTopBottom(0, 0, 5, 31)
			f44_arg0.ClipDual:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.ClipDual)
			f44_arg0.ClipHero:completeAnimation()
			f44_arg0.ClipHero:setLeftRight(1, 1, -218, -30)
			f44_arg0.ClipHero:setTopBottom(1, 1, -78.5, 38.5)
			f44_arg0.clipFinished(f44_arg0.ClipHero)
		end,
		Weapon3Digits = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(1)
			f45_arg0.Clip:completeAnimation()
			f45_arg0.Clip:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.Clip)
		end,
	},
	Weapon = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(3)
			f46_arg0.Clip:completeAnimation()
			f46_arg0.Clip:setLeftRight(0, 1, 0, 0)
			f46_arg0.Clip:setTopBottom(0, 0, 4, 30)
			f46_arg0.Clip:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.Clip)
			f46_arg0.ClipHero:completeAnimation()
			f46_arg0.ClipHero:setLeftRight(0, 1, 0, 0)
			f46_arg0.ClipHero:setTopBottom(0, 1, 0, 0)
			f46_arg0.clipFinished(f46_arg0.ClipHero)
			f46_arg0.TotalAmmoLabel:completeAnimation()
			f46_arg0.TotalAmmoLabel:setLeftRight(-0.48, 0.52, 31, 31)
			f46_arg0.TotalAmmoLabel:setTopBottom(0, 0, 40, 56)
			f46_arg0.clipFinished(f46_arg0.TotalAmmoLabel)
		end,
		Weapon3Digits = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(1)
			f47_arg0.Clip:completeAnimation()
			f47_arg0.Clip:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.Clip)
		end,
	},
	Weapon3Digits = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
			f48_arg0.Clip:completeAnimation()
			f48_arg0.Clip:setLeftRight(0, 1, 0, 0)
			f48_arg0.Clip:setTopBottom(0, 0, 4, 30)
			f48_arg0.Clip:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.Clip)
			f48_arg0.ClipHero:completeAnimation()
			f48_arg0.ClipHero:setLeftRight(1, 2, -248, -248)
			f48_arg0.ClipHero:setTopBottom(1, 2, -96, -96)
			f48_arg0.clipFinished(f48_arg0.ClipHero)
		end,
		HeroWeapon = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(1)
			f49_arg0.ClipHero:completeAnimation()
			f49_arg0.ClipHero:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.ClipHero)
		end,
	},
}
CoD.AmmoWidgetMP_ClipInfo.__onClose = function(f50_arg0)
	f50_arg0.Clip:close()
	f50_arg0.ClipDual:close()
	f50_arg0.ClipHero:close()
	f50_arg0.TotalAmmoLabel:close()
end
