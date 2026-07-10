CoD.CodCasterPortraitPlayerListEntryEquipment = InheritFrom(LUI.UIElement)
CoD.CodCasterPortraitPlayerListEntryEquipment.__defaultWidth = 26
CoD.CodCasterPortraitPlayerListEntryEquipment.__defaultHeight = 26
CoD.CodCasterPortraitPlayerListEntryEquipment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPortraitPlayerListEntryEquipment)
	self.id = "CodCasterPortraitPlayerListEntryEquipment"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local equipmentInactive = LUI.UIImage.new(0, 0, 0, 26, 0, 0, 0, 26)
	equipmentInactive:setAlpha(0.4)
	equipmentInactive:setImage(RegisterImage(@"hash_4A06A85AEEF6215F"))
	self:addElement(equipmentInactive)
	self.equipmentInactive = equipmentInactive
	local EquipmentActive = LUI.UIImage.new(0, 0, 0, 26, 0, 0, 0, 26)
	EquipmentActive:setAlpha(0)
	EquipmentActive:setImage(RegisterImage(@"hash_5D4CD91D5CB3A9BC"))
	self:addElement(EquipmentActive)
	self.EquipmentActive = EquipmentActive
	self:mergeStateConditions({
		{
			stateName = "PlayerDead",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
			end,
		},
		{
			stateName = "Ready",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "equipmentReady")
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_show_equipment", 0)
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
	self:linkToElementModel(self, "equipmentReady", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "equipmentReady",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.profileSettingsUpdated, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPortraitPlayerListEntryEquipment.__resetProperties = function(f8_arg0)
	f8_arg0.equipmentInactive:completeAnimation()
	f8_arg0.EquipmentActive:completeAnimation()
	f8_arg0.equipmentInactive:setAlpha(0.4)
	f8_arg0.EquipmentActive:setAlpha(0)
end
CoD.CodCasterPortraitPlayerListEntryEquipment.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	PlayerDead = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.equipmentInactive:completeAnimation()
			f10_arg0.equipmentInactive:setAlpha(0.02)
			f10_arg0.clipFinished(f10_arg0.equipmentInactive)
		end,
	},
	Ready = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.equipmentInactive:completeAnimation()
			f11_arg0.equipmentInactive:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.equipmentInactive)
			f11_arg0.EquipmentActive:completeAnimation()
			f11_arg0.EquipmentActive:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.EquipmentActive)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.equipmentInactive:completeAnimation()
			f12_arg0.equipmentInactive:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.equipmentInactive)
		end,
	},
}
