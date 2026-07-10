CoD.ArmorPortraitBG = InheritFrom(LUI.UIElement)
CoD.ArmorPortraitBG.__defaultWidth = 92
CoD.ArmorPortraitBG.__defaultHeight = 64
CoD.ArmorPortraitBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.armorIsOnCooldown", 0)
	self:setClass(CoD.ArmorPortraitBG)
	self.id = "ArmorPortraitBG"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PanelSlideoutMask = LUI.UIImage.new(0.5, 0.5, -18, 43, 0.5, 0.5, -29.5, 29.5)
	PanelSlideoutMask:setRGB(0, 0, 0)
	PanelSlideoutMask:setScale(1.2, 1.2)
	PanelSlideoutMask:setImage(RegisterImage(@"uie_ui_hud_core_player_panel_slideout_bg_mask"))
	PanelSlideoutMask:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	PanelSlideoutMask:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(PanelSlideoutMask)
	self.PanelSlideoutMask = PanelSlideoutMask
	local backplate = LUI.UIImage.new(0, 0, 0, 92, 0, 0, 0, 64)
	backplate:setAlpha(0)
	backplate:setImage(RegisterImage(@"uie_ui_hud_core_carryitem_backplate2"))
	self:addElement(backplate)
	self.backplate = backplate
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "hasArmorSpecialty", false) and not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[@"emodes"][@"mode_warzone"])
			end,
		},
		{
			stateName = "HaveArmorLeft",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "armor", 0)
			end,
		},
		{
			stateName = "ArmorOffCooldown",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.armorIsOnCooldown", 0) and CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "hasArmorSpecialty", true)
			end,
		},
		{
			stateName = "ArmorOnCooldown",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "hasArmorSpecialty", true)
			end,
		},
	})
	self:linkToElementModel(self, "hasArmorSpecialty", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasArmorSpecialty",
		})
	end)
	self:linkToElementModel(self, "armor", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "armor",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.armorIsOnCooldown"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.armorIsOnCooldown",
		})
	end, false)
	self:linkToElementModel(self, "armorTookDamage", true, function(model)
		local f9_local0 = self
		CoD.HUDUtility.PlayArmorDamageClip(self, model)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.playerSpawned", function(model)
		local f10_local0 = self
		PlayClip(self, "Intro", f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	CoD.HUDUtility.SetupMonitorForClipActive(self)
	CoD.HUDUtility.RegisterArmorDamageStageClip(self, "1", "TookDamageArmorHigh")
	CoD.HUDUtility.RegisterArmorDamageStageClip(self, "2", "TookDamageArmorLow")
	return self
end
CoD.ArmorPortraitBG.__resetProperties = function(f11_arg0)
	f11_arg0.PanelSlideoutMask:completeAnimation()
	f11_arg0.backplate:completeAnimation()
	f11_arg0.PanelSlideoutMask:setAlpha(1)
	f11_arg0.backplate:setAlpha(0)
end
CoD.ArmorPortraitBG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.PanelSlideoutMask:completeAnimation()
			f12_arg0.PanelSlideoutMask:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.PanelSlideoutMask)
			f12_arg0.backplate:completeAnimation()
			f12_arg0.backplate:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.backplate)
		end,
	},
	Invisible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.PanelSlideoutMask:completeAnimation()
			f13_arg0.PanelSlideoutMask:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PanelSlideoutMask)
		end,
	},
	HaveArmorLeft = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.PanelSlideoutMask:completeAnimation()
			f14_arg0.PanelSlideoutMask:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.PanelSlideoutMask)
			f14_arg0.backplate:completeAnimation()
			f14_arg0.backplate:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.backplate)
		end,
	},
	ArmorOffCooldown = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.PanelSlideoutMask:completeAnimation()
			f15_arg0.PanelSlideoutMask:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PanelSlideoutMask)
		end,
	},
	ArmorOnCooldown = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
}
