require("x64:e201e7e41431aa7")
CoD.ContextNotification_SpecialistWeaponHint = InheritFrom(LUI.UIElement)
CoD.ContextNotification_SpecialistWeaponHint.__defaultWidth = 300
CoD.ContextNotification_SpecialistWeaponHint.__defaultHeight = 39
CoD.ContextNotification_SpecialistWeaponHint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContextNotification_SpecialistWeaponHint)
	self.id = "ContextNotification_SpecialistWeaponHint"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NotificationText = LUI.UIText.new(0, 0, 0, 300, 0, 0, 0, 30)
	NotificationText:setTTF("ttmussels_regular")
	NotificationText:setLetterSpacing(1)
	NotificationText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NotificationText:setBackingType(1)
	NotificationText:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationText:setBackingColor(0, 0, 0)
	NotificationText:setBackingAlpha(0.62)
	NotificationText:setBackingXPadding(12)
	NotificationText.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			NotificationText:setText(CoD.HUDUtility.GetSpecialistWeaponHintString(f1_arg1, f2_local0))
		end
	end
	NotificationText:subscribeToGlobalModel(f1_arg1, "HUDItems", "abilityHintIndex", NotificationText.__String_Reference)
	NotificationText.__String_Reference_FullPath = function()
		local f3_local0 = DataSources.HUDItems.getModel(f1_arg1)
		f3_local0 = f3_local0.abilityHintIndex
		if f3_local0 then
			NotificationText.__String_Reference(f3_local0)
		end
	end
	self:addElement(NotificationText)
	self.NotificationText = NotificationText
	local f1_local2 = NotificationText
	local f1_local3 = NotificationText.subscribeToModel
	local f1_local4 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.equippedWeaponReference, NotificationText.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "HUDItems", "abilityHintIndex", CoD.HUDUtility.GagdetHintIndex.GADGET_HINT_INDEX_NONE)
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.abilityHintIndex, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "abilityHintIndex",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContextNotification_SpecialistWeaponHint.__resetProperties = function(f6_arg0)
	f6_arg0.NotificationText:completeAnimation()
	f6_arg0.NotificationText:setAlpha(1)
end
CoD.ContextNotification_SpecialistWeaponHint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.NotificationText:completeAnimation()
			f7_arg0.NotificationText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.NotificationText)
		end,
		Visible = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.NotificationText:beginAnimation(200)
				f8_arg0.NotificationText:setAlpha(1)
				f8_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.NotificationText:completeAnimation()
			f8_arg0.NotificationText:setAlpha(0)
			f8_local0(f8_arg0.NotificationText)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.NotificationText:beginAnimation(200)
				f11_arg0.NotificationText:setAlpha(0)
				f11_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.NotificationText:completeAnimation()
			f11_arg0.NotificationText:setAlpha(1)
			f11_local0(f11_arg0.NotificationText)
		end,
	},
}
CoD.ContextNotification_SpecialistWeaponHint.__onClose = function(f13_arg0)
	f13_arg0.NotificationText:close()
end
