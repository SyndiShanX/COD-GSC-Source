require("x64:78b1cdf951f5003")
CoD.ProximityAlarm_Internal = InheritFrom(LUI.UIElement)
CoD.ProximityAlarm_Internal.__defaultWidth = 296
CoD.ProximityAlarm_Internal.__defaultHeight = 76
CoD.ProximityAlarm_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ProximityAlarm_Internal)
	self.id = "ProximityAlarm_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local icon = CoD.ProximityAlarm_Icon.new(f1_arg0, f1_arg1, 0, 0, 0, 76, 0, 0, 0, 76)
	icon:mergeStateConditions({
		{
			stateName = "C4",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEitherValue(f1_arg1, "hudItems.proximityAlarm", 1, 2)
			end,
		},
		{
			stateName = "EnemyDetection",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEitherValue(f1_arg1, "hudItems.proximityAlarm", 3, 4)
			end,
		},
	})
	local f1_local2 = icon
	local text = icon.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	text(f1_local2, f1_local4["hudItems.proximityAlarm"], function(f4_arg0)
		f1_arg0:updateElementState(icon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.proximityAlarm",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(icon, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		UpdateSelfState(self, controller)
	end)
	self:addElement(icon)
	self.icon = icon
	text = LUI.UIText.new(0.27, 0.27, 0, 216, 0.3, 0.3, 0, 30)
	text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"weapon/alarm_set"))
	text:setTTF("ttmussels_demibold")
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(text)
	self.text = text
	self:mergeStateConditions({
		{
			stateName = "HideIcon",
			condition = function(menu, element, event)
				return IsElementInState(self.icon, "DefaultState")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ProximityAlarm_Internal.__resetProperties = function(f7_arg0)
	f7_arg0.icon:completeAnimation()
	f7_arg0.icon:setAlpha(1)
end
CoD.ProximityAlarm_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.icon:completeAnimation()
			f8_arg0.icon:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.icon)
		end,
	},
	HideIcon = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.icon:completeAnimation()
			f9_arg0.icon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.icon)
		end,
	},
}
CoD.ProximityAlarm_Internal.__onClose = function(f10_arg0)
	f10_arg0.icon:close()
end
