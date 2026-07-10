CoD.AmmoWidget_CharacterPortrait = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_CharacterPortrait.__defaultWidth = 76
CoD.AmmoWidget_CharacterPortrait.__defaultHeight = 55
CoD.AmmoWidget_CharacterPortrait.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_CharacterPortrait)
	self.id = "AmmoWidget_CharacterPortrait"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Healing = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Healing:setAlpha(0)
	Healing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	Healing:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "characterIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Healing:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_HEALING, f2_local0)))
		end
	end)
	self:addElement(Healing)
	self.Healing = Healing
	local Wounded = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Wounded:setAlpha(0)
	Wounded:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	Wounded:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "characterIndex", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Wounded:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_WOUNDED, f3_local0)))
		end
	end)
	self:addElement(Wounded)
	self.Wounded = Wounded
	local Buffed = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Buffed:setAlpha(0)
	Buffed:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	Buffed:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "characterIndex", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Buffed:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_BUFFED, f4_local0)))
		end
	end)
	self:addElement(Buffed)
	self.Buffed = Buffed
	local Critical = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Critical:setAlpha(0)
	Critical:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "characterIndex", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Critical:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_CRITICAL, f5_local0)))
		end
	end)
	self:addElement(Critical)
	self.Critical = Critical
	local Normal = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Normal:setAlpha(0)
	Normal:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	Normal:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "characterIndex", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Normal:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_NORMAL, f6_local0)))
		end
	end)
	self:addElement(Normal)
	self.Normal = Normal
	self:mergeStateConditions({
		{
			stateName = "Critical",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsCharacterInCriticalState(self, f1_arg1)
			end,
		},
		{
			stateName = "Wounded",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsCharacterInWoundedStated(self, f1_arg1)
			end,
		},
		{
			stateName = "Buffed",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsCharacterInBuffedState(self, f1_arg1)
			end,
		},
		{
			stateName = "Healing",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsCharacterInHealingState(self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	self:linkToElementModel(self, "health.maxHealth", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.maxHealth",
		})
	end)
	self:linkToElementModel(self, "health.maxHealthRegen", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.maxHealthRegen",
		})
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.PlayerAbilities.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8["playerGadget1.state"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "playerGadget1.state",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.HUDUtility.SetupCharacterPortrait(self, f1_arg1)
	return self
end
CoD.AmmoWidget_CharacterPortrait.__resetProperties = function(f15_arg0)
	f15_arg0.Normal:completeAnimation()
	f15_arg0.Critical:completeAnimation()
	f15_arg0.Wounded:completeAnimation()
	f15_arg0.Buffed:completeAnimation()
	f15_arg0.Healing:completeAnimation()
	f15_arg0.Normal:setAlpha(0)
	f15_arg0.Critical:setRGB(1, 1, 1)
	f15_arg0.Critical:setAlpha(0)
	f15_arg0.Wounded:setRGB(1, 1, 1)
	f15_arg0.Wounded:setAlpha(0)
	f15_arg0.Buffed:setRGB(1, 1, 1)
	f15_arg0.Buffed:setAlpha(0)
	f15_arg0.Healing:setRGB(1, 1, 1)
	f15_arg0.Healing:setAlpha(0)
end
CoD.AmmoWidget_CharacterPortrait.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Normal:completeAnimation()
			f16_arg0.Normal:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.Normal)
		end,
	},
	Critical = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.Critical:completeAnimation()
			f17_arg0.Critical:setRGB(1, 1, 1)
			f17_arg0.Critical:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.Critical)
		end,
	},
	Wounded = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.Wounded:completeAnimation()
			f18_arg0.Wounded:setRGB(1, 1, 1)
			f18_arg0.Wounded:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Wounded)
		end,
	},
	Buffed = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.Buffed:completeAnimation()
			f19_arg0.Buffed:setRGB(1, 1, 1)
			f19_arg0.Buffed:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Buffed)
		end,
	},
	Healing = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.Healing:completeAnimation()
			f20_arg0.Healing:setRGB(1, 1, 1)
			f20_arg0.Healing:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.Healing)
		end,
	},
}
CoD.AmmoWidget_CharacterPortrait.__onClose = function(f21_arg0)
	f21_arg0.Healing:close()
	f21_arg0.Wounded:close()
	f21_arg0.Buffed:close()
	f21_arg0.Critical:close()
	f21_arg0.Normal:close()
end
