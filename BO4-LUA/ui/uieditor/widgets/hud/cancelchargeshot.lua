require("x64:e201e7e41431aa7")
CoD.CancelChargeShot = InheritFrom(LUI.UIElement)
CoD.CancelChargeShot.__defaultWidth = 300
CoD.CancelChargeShot.__defaultHeight = 39
CoD.CancelChargeShot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CancelChargeShot)
	self.id = "CancelChargeShot"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NotificationText = LUI.UIText.new(0, 0, 0, 300, 0, 0, 0, 30)
	NotificationText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x3D8A0C512FDAAE))
	NotificationText:setTTF("ttmussels_regular")
	NotificationText:setLetterSpacing(1)
	NotificationText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NotificationText:setBackingType(1)
	NotificationText:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationText:setBackingColor(0, 0, 0)
	NotificationText:setBackingAlpha(0.61)
	NotificationText:setBackingXPadding(12)
	LUI.OverrideFunction_CallOriginalFirst(NotificationText, "setText", function(element, controller)
		ScaleWidgetToLabelCentered(self, self.text, 10)
	end)
	self:addElement(NotificationText)
	self.NotificationText = NotificationText
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "CurrentWeapon", "currentShotCharge", 0)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.currentShotCharge, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "currentShotCharge",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CancelChargeShot.__resetProperties = function(f5_arg0)
	f5_arg0.NotificationText:completeAnimation()
	f5_arg0.NotificationText:setAlpha(1)
end
CoD.CancelChargeShot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.NotificationText:completeAnimation()
			f6_arg0.NotificationText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NotificationText)
		end,
		Visible = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(200)
					f9_arg0:setAlpha(1)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.NotificationText:beginAnimation(2000)
				f7_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.NotificationText:completeAnimation()
			f7_arg0.NotificationText:setAlpha(0)
			f7_local0(f7_arg0.NotificationText)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.NotificationText:completeAnimation()
			f10_arg0.NotificationText:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.NotificationText)
		end,
	},
}
