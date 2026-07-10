CoD.CodCasterPortraitPlayerListEntrySpecialistHeadIcon = InheritFrom(LUI.UIElement)
CoD.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.__defaultWidth = 76
CoD.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.__defaultHeight = 55
CoD.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPortraitPlayerListEntrySpecialistHeadIcon)
	self.id = "CodCasterPortraitPlayerListEntrySpecialistHeadIcon"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Healing = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Healing:setAlpha(0)
	Healing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(Healing)
	self.Healing = Healing
	local Wounded = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Wounded:setAlpha(0)
	Wounded:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(Wounded)
	self.Wounded = Wounded
	local Buffed = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Buffed:setAlpha(0)
	Buffed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(Buffed)
	self.Buffed = Buffed
	local Critical = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Critical:setAlpha(0)
	self:addElement(Critical)
	self.Critical = Critical
	local Normal = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -27.5, 27.5)
	Normal:setAlpha(0)
	Normal:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
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
	f1_local7(f1_local6, f1_local8["playerGadget1.state"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "playerGadget1.state",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.__resetProperties = function(f10_arg0)
	f10_arg0.Normal:completeAnimation()
	f10_arg0.Critical:completeAnimation()
	f10_arg0.Wounded:completeAnimation()
	f10_arg0.Buffed:completeAnimation()
	f10_arg0.Healing:completeAnimation()
	f10_arg0.Normal:setAlpha(0)
	f10_arg0.Critical:setRGB(1, 1, 1)
	f10_arg0.Critical:setAlpha(0)
	f10_arg0.Wounded:setRGB(1, 1, 1)
	f10_arg0.Wounded:setAlpha(0)
	f10_arg0.Buffed:setRGB(1, 1, 1)
	f10_arg0.Buffed:setAlpha(0)
	f10_arg0.Healing:setRGB(1, 1, 1)
	f10_arg0.Healing:setAlpha(0)
end
CoD.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Normal:completeAnimation()
			f11_arg0.Normal:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Normal)
		end,
	},
	Critical = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Critical:completeAnimation()
			f12_arg0.Critical:setRGB(1, 1, 1)
			f12_arg0.Critical:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Critical)
		end,
	},
	Wounded = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Wounded:completeAnimation()
			f13_arg0.Wounded:setRGB(1, 1, 1)
			f13_arg0.Wounded:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Wounded)
		end,
	},
	Buffed = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Buffed:completeAnimation()
			f14_arg0.Buffed:setRGB(1, 1, 1)
			f14_arg0.Buffed:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.Buffed)
		end,
	},
	Healing = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.Healing:completeAnimation()
			f15_arg0.Healing:setRGB(1, 1, 1)
			f15_arg0.Healing:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.Healing)
		end,
	},
}
