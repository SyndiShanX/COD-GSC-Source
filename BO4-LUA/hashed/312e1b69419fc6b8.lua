CoD.ArmorPortrait = InheritFrom(LUI.UIElement)
CoD.ArmorPortrait.__defaultWidth = 50
CoD.ArmorPortrait.__defaultHeight = 50
CoD.ArmorPortrait.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.armorIsOnCooldown", 0)
	self:setClass(CoD.ArmorPortrait)
	self.id = "ArmorPortrait"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IntroSound = LUI.UIElement.new(0, 0, 11, 43, 0, 0, 52, 84)
	self:addElement(IntroSound)
	self.IntroSound = IntroSound
	local armor = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	armor:setAlpha(0)
	armor:setImage(RegisterImage(@"hash_4B5BC23908F1D357"))
	self:addElement(armor)
	self.armor = armor
	local armordamage4 = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	armordamage4:setAlpha(0)
	armordamage4:setImage(RegisterImage(@"hash_7F27BC40343E5340"))
	self:addElement(armordamage4)
	self.armordamage4 = armordamage4
	local armordamage3 = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	armordamage3:setAlpha(0)
	armordamage3:setImage(RegisterImage(@"hash_7F27C340343E5F25"))
	self:addElement(armordamage3)
	self.armordamage3 = armordamage3
	local armordamage2 = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	armordamage2:setAlpha(0)
	armordamage2:setImage(RegisterImage(@"hash_7F27C240343E5D72"))
	self:addElement(armordamage2)
	self.armordamage2 = armordamage2
	local armordamage1 = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	armordamage1:setAlpha(0)
	armordamage1:setImage(RegisterImage(@"hash_7F27C140343E5BBF"))
	self:addElement(armordamage1)
	self.armordamage1 = armordamage1
	self:mergeStateConditions({
		{
			stateName = "CodcasterInvisible",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
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
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["factions.isCoDCaster"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
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
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.armorIsOnCooldown"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.armorIsOnCooldown",
		})
	end, false)
	self:linkToElementModel(self, "armorTookDamage", true, function(model)
		local f11_local0 = self
		if AlwaysFalse() then
			CoD.HUDUtility.PlayArmorDamageClip(self, model)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.playerSpawned", function(model)
		local f12_local0 = self
		PlayClip(self, "Intro", f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	CoD.HUDUtility.SetupMonitorForClipActive(self)
	CoD.HUDUtility.RegisterArmorDamageStageClip(self, "1", "TookDamageArmorHigh")
	CoD.HUDUtility.RegisterArmorDamageStageClip(self, "2", "TookDamageArmorLow")
	return self
end
CoD.ArmorPortrait.__resetProperties = function(f13_arg0)
	f13_arg0.armor:completeAnimation()
	f13_arg0.IntroSound:completeAnimation()
	f13_arg0.armordamage4:completeAnimation()
	f13_arg0.armordamage3:completeAnimation()
	f13_arg0.armordamage1:completeAnimation()
	f13_arg0.armor:setAlpha(0)
	f13_arg0.IntroSound:setPlaySoundDirect(false)
	f13_arg0.armordamage4:setAlpha(0)
	f13_arg0.armordamage3:setRGB(1, 1, 1)
	f13_arg0.armordamage3:setAlpha(0)
	f13_arg0.armordamage1:setRGB(1, 1, 1)
	f13_arg0.armordamage1:setAlpha(0)
end
CoD.ArmorPortrait.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.armor:completeAnimation()
			f14_arg0.armor:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.armor)
		end,
	},
	CodcasterInvisible = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	HaveArmorLeft = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.armor:completeAnimation()
			f17_arg0.armor:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.armor)
		end,
		Intro = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.IntroSound:completeAnimation()
			f18_arg0.IntroSound:setPlaySoundDirect(true)
			f18_arg0.IntroSound:playSound("", f18_arg1)
			f18_arg0.clipFinished(f18_arg0.IntroSound)
			f18_arg0.armor:completeAnimation()
			f18_arg0.armor:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.armor)
		end,
		ArmorOffCooldown = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.armordamage4:beginAnimation(200)
				f19_arg0.armordamage4:setAlpha(0)
				f19_arg0.armordamage4:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.armordamage4:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.armordamage4:completeAnimation()
			f19_arg0.armordamage4:setAlpha(1)
			f19_local0(f19_arg0.armordamage4)
		end,
		TookDamageArmorLow = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(100)
					f23_arg0:setRGB(1, 1, 1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.armordamage3:beginAnimation(100)
				f21_arg0.armordamage3:setRGB(1, 0, 0)
				f21_arg0.armordamage3:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.armordamage3:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.armordamage3:completeAnimation()
			f21_arg0.armordamage3:setRGB(1, 1, 1)
			f21_arg0.armordamage3:setAlpha(1)
			f21_local0(f21_arg0.armordamage3)
		end,
		TookDamageArmorHigh = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(100)
					f26_arg0:setRGB(1, 1, 1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.armordamage1:beginAnimation(100)
				f24_arg0.armordamage1:setRGB(1, 0, 0)
				f24_arg0.armordamage1:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.armordamage1:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.armordamage1:completeAnimation()
			f24_arg0.armordamage1:setRGB(1, 1, 1)
			f24_arg0.armordamage1:setAlpha(1)
			f24_local0(f24_arg0.armordamage1)
		end,
	},
	ArmorOffCooldown = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
	},
	ArmorOnCooldown = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
}
