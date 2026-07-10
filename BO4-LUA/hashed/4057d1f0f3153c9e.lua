CoD.PositionDraft_Cooldown = InheritFrom(LUI.UIElement)
CoD.PositionDraft_Cooldown.__defaultWidth = 1725
CoD.PositionDraft_Cooldown.__defaultHeight = 37
CoD.PositionDraft_Cooldown.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_Cooldown)
	self.id = "PositionDraft_Cooldown"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DraftCooldown = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 37)
	DraftCooldown:setTTF("ttmussels_regular")
	DraftCooldown:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	DraftCooldown:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	DraftCooldown:setBackingType(2)
	DraftCooldown:setBackingColor(0, 0, 0)
	DraftCooldown:setBackingAlpha(0.8)
	DraftCooldown:setBackingXPadding(10)
	DraftCooldown:subscribeToGlobalModel(f1_arg1, "PerController", "PositionDraft.cooldown", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DraftCooldown:setText(LocalizeIntoString(0x3E6EF73850D43D7, f2_local0))
		end
	end)
	self:addElement(DraftCooldown)
	self.DraftCooldown = DraftCooldown
	local CannotSwitch = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 37)
	CannotSwitch:setText(Engine[0xF9F1239CFD921FE](0x8C90C4B40C26813))
	CannotSwitch:setTTF("ttmussels_regular")
	CannotSwitch:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CannotSwitch:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CannotSwitch:setBackingType(2)
	CannotSwitch:setBackingColor(0, 0, 0)
	CannotSwitch:setBackingAlpha(0.8)
	CannotSwitch:setBackingXPadding(10)
	self:addElement(CannotSwitch)
	self.CannotSwitch = CannotSwitch
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "PositionDraft.cooldown", 0)
			end,
		},
		{
			stateName = "VisibleNoLethalSwitch",
			condition = function(menu, element, event)
				return CoD.HUDUtility.PositionDraftCharacterUnavailable(self, f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["PositionDraft.cooldown"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "PositionDraft.cooldown",
		})
	end, false)
	self:linkToElementModel(self, "unavailable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unavailable",
		})
	end)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["hudItems.specialistSwitchIsLethal"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.specialistSwitchIsLethal",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_Cooldown.__resetProperties = function(f9_arg0)
	f9_arg0.DraftCooldown:completeAnimation()
	f9_arg0.CannotSwitch:completeAnimation()
	f9_arg0.DraftCooldown:setAlpha(1)
	f9_arg0.CannotSwitch:setAlpha(1)
end
CoD.PositionDraft_Cooldown.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.DraftCooldown:completeAnimation()
			f10_arg0.DraftCooldown:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DraftCooldown)
			f10_arg0.CannotSwitch:completeAnimation()
			f10_arg0.CannotSwitch:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CannotSwitch)
		end,
	},
	Visible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.DraftCooldown:completeAnimation()
			f11_arg0.DraftCooldown:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.DraftCooldown)
			f11_arg0.CannotSwitch:completeAnimation()
			f11_arg0.CannotSwitch:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CannotSwitch)
		end,
	},
	VisibleNoLethalSwitch = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.DraftCooldown:completeAnimation()
			f12_arg0.DraftCooldown:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DraftCooldown)
		end,
	},
}
CoD.PositionDraft_Cooldown.__onClose = function(f13_arg0)
	f13_arg0.DraftCooldown:close()
end
