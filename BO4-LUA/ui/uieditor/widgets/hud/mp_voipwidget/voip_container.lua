require("ui/uieditor/widgets/hud/mp_voipwidget/voip_entry")
CoD.Voip_Container = InheritFrom(LUI.UIElement)
CoD.Voip_Container.__defaultWidth = 409
CoD.Voip_Container.__defaultHeight = 108
CoD.Voip_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Voip_Container)
	self.id = "Voip_Container"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VoipEntry0 = CoD.Voip_Entry.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 0, 27)
	VoipEntry0:subscribeToGlobalModel(f1_arg1, "HUDItems", "voipInfo.voip1", function(model)
		VoipEntry0:setModel(model, f1_arg1)
	end)
	self:addElement(VoipEntry0)
	self.VoipEntry0 = VoipEntry0
	local VoipEntry1 = CoD.Voip_Entry.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 26.5, 53.5)
	VoipEntry1:subscribeToGlobalModel(f1_arg1, "HUDItems", "voipInfo.voip2", function(model)
		VoipEntry1:setModel(model, f1_arg1)
	end)
	self:addElement(VoipEntry1)
	self.VoipEntry1 = VoipEntry1
	local VoipEntry2 = CoD.Voip_Entry.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 54.5, 81.5)
	VoipEntry2:subscribeToGlobalModel(f1_arg1, "HUDItems", "voipInfo.voip3", function(model)
		VoipEntry2:setModel(model, f1_arg1)
	end)
	self:addElement(VoipEntry2)
	self.VoipEntry2 = VoipEntry2
	local VoipEntry3 = CoD.Voip_Entry.new(f1_arg0, f1_arg1, 0, 0, 0, 410, 0, 0, 80.5, 107.5)
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
	local f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["factions.isCoDCaster"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.profileSettingsUpdated, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Voip_Container.__resetProperties = function(f10_arg0)
	f10_arg0.VoipEntry3:completeAnimation()
	f10_arg0.VoipEntry2:completeAnimation()
	f10_arg0.VoipEntry1:completeAnimation()
	f10_arg0.VoipEntry0:completeAnimation()
	f10_arg0.VoipEntry3:setAlpha(1)
	f10_arg0.VoipEntry2:setAlpha(1)
	f10_arg0.VoipEntry1:setAlpha(1)
	f10_arg0.VoipEntry0:setAlpha(1)
end
CoD.Voip_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.VoipEntry0:completeAnimation()
			f11_arg0.VoipEntry0:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.VoipEntry0)
			f11_arg0.VoipEntry1:completeAnimation()
			f11_arg0.VoipEntry1:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.VoipEntry1)
			f11_arg0.VoipEntry2:completeAnimation()
			f11_arg0.VoipEntry2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.VoipEntry2)
			f11_arg0.VoipEntry3:completeAnimation()
			f11_arg0.VoipEntry3:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.VoipEntry3)
		end,
	},
	HudStart = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	ShowForCodCaster = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Voip_Container.__onClose = function(f14_arg0)
	f14_arg0.VoipEntry0:close()
	f14_arg0.VoipEntry1:close()
	f14_arg0.VoipEntry2:close()
	f14_arg0.VoipEntry3:close()
end
