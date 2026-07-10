CoD.ArmorOverheadName = InheritFrom(LUI.UIElement)
CoD.ArmorOverheadName.__defaultWidth = 30
CoD.ArmorOverheadName.__defaultHeight = 30
CoD.ArmorOverheadName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.armorIsOnCooldown", 0)
	self:setClass(CoD.ArmorOverheadName)
	self.id = "ArmorOverheadName"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local armor = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	armor:setAlpha(0)
	armor:setImage(RegisterImage(0xB5BC23908F1D357))
	self:addElement(armor)
	self.armor = armor
	local armordamage1 = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	armordamage1:setAlpha(0)
	armordamage1:setImage(RegisterImage(0xF27C140343E5BBF))
	self:addElement(armordamage1)
	self.armordamage1 = armordamage1
	local armordamage2 = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	armordamage2:setAlpha(0)
	armordamage2:setImage(RegisterImage(0xF27C240343E5D72))
	self:addElement(armordamage2)
	self.armordamage2 = armordamage2
	local armordamage3 = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	armordamage3:setAlpha(0)
	armordamage3:setImage(RegisterImage(0xF27C340343E5F25))
	self:addElement(armordamage3)
	self.armordamage3 = armordamage3
	local armordamage4 = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	armordamage4:setAlpha(0)
	armordamage4:setImage(RegisterImage(0xF27BC40343E5340))
	self:addElement(armordamage4)
	self.armordamage4 = armordamage4
	self:mergeStateConditions({
		{
			stateName = "HaveArmorLeft",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "armor", 0)
			end,
		},
		{
			stateName = "ArmorDestroyed",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "armor", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "armor",
		})
	end)
	self:linkToElementModel(self, "armorTookDamage", true, function(model)
		local f5_local0 = self
		if AlwaysFalse() then
			CoD.HUDUtility.PlayArmorDamageClip(self, model)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.playerSpawned", function(model)
		local f6_local0 = self
		PlayClip(self, "Intro", f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	CoD.HUDUtility.SetupMonitorForClipActive(self)
	CoD.HUDUtility.RegisterArmorDamageStageClip(self, "1", "TookDamageArmorHigh")
	CoD.HUDUtility.RegisterArmorDamageStageClip(self, "2", "TookDamageArmorLow")
	return self
end
CoD.ArmorOverheadName.__resetProperties = function(f7_arg0)
	f7_arg0.armor:completeAnimation()
	f7_arg0.armordamage4:completeAnimation()
	f7_arg0.armordamage3:completeAnimation()
	f7_arg0.armordamage1:completeAnimation()
	f7_arg0.armor:setAlpha(0)
	f7_arg0.armordamage4:setAlpha(0)
	f7_arg0.armordamage3:setRGB(1, 1, 1)
	f7_arg0.armordamage3:setAlpha(0)
	f7_arg0.armordamage1:setRGB(1, 1, 1)
	f7_arg0.armordamage1:setAlpha(0)
end
CoD.ArmorOverheadName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.armor:completeAnimation()
			f8_arg0.armor:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.armor)
		end,
	},
	HaveArmorLeft = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.armor:completeAnimation()
			f9_arg0.armor:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.armor)
		end,
		ArmorDestroyed = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.armordamage4:beginAnimation(200)
				f10_arg0.armordamage4:setAlpha(0)
				f10_arg0.armordamage4:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.armordamage4:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.armordamage4:completeAnimation()
			f10_arg0.armordamage4:setAlpha(1)
			f10_local0(f10_arg0.armordamage4)
			f10_arg0.nextClip = "ArmorDestroyed"
		end,
		TookDamageArmorLow = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(100)
					f14_arg0:setRGB(1, 1, 1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.armordamage3:beginAnimation(100)
				f12_arg0.armordamage3:setRGB(1, 0, 0)
				f12_arg0.armordamage3:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.armordamage3:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.armordamage3:completeAnimation()
			f12_arg0.armordamage3:setRGB(1, 1, 1)
			f12_arg0.armordamage3:setAlpha(1)
			f12_local0(f12_arg0.armordamage3)
		end,
		TookDamageArmorHigh = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(100)
					f17_arg0:setRGB(1, 1, 1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.armordamage1:beginAnimation(100)
				f15_arg0.armordamage1:setRGB(1, 0, 0)
				f15_arg0.armordamage1:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.armordamage1:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.armordamage1:completeAnimation()
			f15_arg0.armordamage1:setRGB(1, 1, 1)
			f15_arg0.armordamage1:setAlpha(1)
			f15_local0(f15_arg0.armordamage1)
		end,
	},
	ArmorDestroyed = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.armordamage4:completeAnimation()
			f18_arg0.armordamage4:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.armordamage4)
		end,
	},
}
