require("x64:ee9671e737af574")
CoD.Voip_Container_EnemiesOnly = InheritFrom(LUI.UIElement)
CoD.Voip_Container_EnemiesOnly.__defaultWidth = 409
CoD.Voip_Container_EnemiesOnly.__defaultHeight = 108
CoD.Voip_Container_EnemiesOnly.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Voip_Container_EnemiesOnly)
	self.id = "Voip_Container_EnemiesOnly"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VoipEntry0 = CoD.Voip_Entry.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 0, 27)
	VoipEntry0:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "status", Enum[0x67D1AB56CFA8F00][0xC827FF88A41C5F9])
			end,
		},
		{
			stateName = "EnemyTalking",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	VoipEntry0:linkToElementModel(VoipEntry0, "status", true, function(model)
		f1_arg0:updateElementState(VoipEntry0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "status",
		})
	end)
	VoipEntry0:subscribeToGlobalModel(f1_arg1, "HUDItems", "voipInfo.voip1", function(model)
		VoipEntry0:setModel(model, f1_arg1)
	end)
	self:addElement(VoipEntry0)
	self.VoipEntry0 = VoipEntry0
	local VoipEntry1 = CoD.Voip_Entry.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 26.5, 53.5)
	VoipEntry1:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "status", Enum[0x67D1AB56CFA8F00][0xC827FF88A41C5F9])
			end,
		},
		{
			stateName = "EnemyTalking",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	VoipEntry1:linkToElementModel(VoipEntry1, "status", true, function(model)
		f1_arg0:updateElementState(VoipEntry1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "status",
		})
	end)
	VoipEntry1:subscribeToGlobalModel(f1_arg1, "HUDItems", "voipInfo.voip2", function(model)
		VoipEntry1:setModel(model, f1_arg1)
	end)
	self:addElement(VoipEntry1)
	self.VoipEntry1 = VoipEntry1
	local VoipEntry2 = CoD.Voip_Entry.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 54.5, 81.5)
	VoipEntry2:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "status", Enum[0x67D1AB56CFA8F00][0xC827FF88A41C5F9])
			end,
		},
		{
			stateName = "EnemyTalking",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	VoipEntry2:linkToElementModel(VoipEntry2, "status", true, function(model)
		f1_arg0:updateElementState(VoipEntry2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "status",
		})
	end)
	VoipEntry2:subscribeToGlobalModel(f1_arg1, "HUDItems", "voipInfo.voip3", function(model)
		VoipEntry2:setModel(model, f1_arg1)
	end)
	self:addElement(VoipEntry2)
	self.VoipEntry2 = VoipEntry2
	local VoipEntry3 = CoD.Voip_Entry.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 80.5, 107.5)
	VoipEntry3:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "status", Enum[0x67D1AB56CFA8F00][0xC827FF88A41C5F9])
			end,
		},
		{
			stateName = "EnemyTalking",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	VoipEntry3:linkToElementModel(VoipEntry3, "status", true, function(model)
		f1_arg0:updateElementState(VoipEntry3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "status",
		})
	end)
	VoipEntry3:subscribeToGlobalModel(f1_arg1, "HUDItems", "voipInfo.voip4", function(model)
		VoipEntry3:setModel(model, f1_arg1)
	end)
	self:addElement(VoipEntry3)
	self.VoipEntry3 = VoipEntry3
	self:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "ShowForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_voip_dock", 1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["factions.isCoDCaster"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.profileSettingsUpdated, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Voip_Container_EnemiesOnly.__resetProperties = function(f22_arg0)
	f22_arg0.VoipEntry3:completeAnimation()
	f22_arg0.VoipEntry2:completeAnimation()
	f22_arg0.VoipEntry1:completeAnimation()
	f22_arg0.VoipEntry0:completeAnimation()
	f22_arg0.VoipEntry3:setAlpha(1)
	f22_arg0.VoipEntry2:setAlpha(1)
	f22_arg0.VoipEntry1:setAlpha(1)
	f22_arg0.VoipEntry0:setAlpha(1)
end
CoD.Voip_Container_EnemiesOnly.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.VoipEntry0:completeAnimation()
			f23_arg0.VoipEntry0:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VoipEntry0)
			f23_arg0.VoipEntry1:completeAnimation()
			f23_arg0.VoipEntry1:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VoipEntry1)
			f23_arg0.VoipEntry2:completeAnimation()
			f23_arg0.VoipEntry2:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VoipEntry2)
			f23_arg0.VoipEntry3:completeAnimation()
			f23_arg0.VoipEntry3:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.VoipEntry3)
		end,
	},
	HudStart = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	ShowForCodCaster = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Voip_Container_EnemiesOnly.__onClose = function(f26_arg0)
	f26_arg0.VoipEntry0:close()
	f26_arg0.VoipEntry1:close()
	f26_arg0.VoipEntry2:close()
	f26_arg0.VoipEntry3:close()
end
