require("x64:c68e35524efc8d1")
require("x64:7a2e403287c6522")
CoD.Waypoint_NoBackplate = InheritFrom(LUI.UIElement)
CoD.Waypoint_NoBackplate.__defaultWidth = 120
CoD.Waypoint_NoBackplate.__defaultHeight = 180
CoD.Waypoint_NoBackplate.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Waypoint_NoBackplate)
	self.id = "Waypoint_NoBackplate"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WaypointArrowDownNotClampedContainer = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -23, 23)
	WaypointArrowDownNotClampedContainer:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f2_local0
				if not ParentObjectivePropertyIsTrue(element, "hide_arrow") and not CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, 0x129B22B0CDE96B, 1) then
					f2_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	WaypointArrowDownNotClampedContainer:linkToElementModel(WaypointArrowDownNotClampedContainer, "id", true, function(model)
		f1_arg0:updateElementState(WaypointArrowDownNotClampedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	WaypointArrowDownNotClampedContainer:linkToElementModel(WaypointArrowDownNotClampedContainer, "clamped", true, function(model)
		f1_arg0:updateElementState(WaypointArrowDownNotClampedContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	WaypointArrowDownNotClampedContainer:setAlpha(0.95)
	WaypointArrowDownNotClampedContainer:linkToElementModel(self, nil, false, function(model)
		WaypointArrowDownNotClampedContainer:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointArrowDownNotClampedContainer)
	self.WaypointArrowDownNotClampedContainer = WaypointArrowDownNotClampedContainer
	local WaypointArrowContainer = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -23, 23)
	WaypointArrowContainer:setAlpha(0.95)
	WaypointArrowContainer:linkToElementModel(self, "direction", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			WaypointArrowContainer:setZRot(Add(90, f6_local0))
		end
	end)
	WaypointArrowContainer:linkToElementModel(self, nil, false, function(model)
		WaypointArrowContainer:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointArrowContainer)
	self.WaypointArrowContainer = WaypointArrowContainer
	local WaypointCenterIcon = CoD.WaypointCenterSimple.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	WaypointCenterIcon:linkToElementModel(self, nil, false, function(model)
		WaypointCenterIcon:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointCenterIcon)
	self.WaypointCenterIcon = WaypointCenterIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldHideWaypoint(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "team", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	self:linkToElementModel(self, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "teamMask", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "teamMask",
		})
	end)
	self:linkToElementModel(self, "isOffscreen", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOffscreen",
		})
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["interactivePrompt.activeObjectiveID"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.hacked"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.ref, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.activeIndex, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.count, function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.secondaryOffhand, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.secondaryOffhandCount, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.WaypointUtility.ShowMessageOnCloseIfNeeded(f1_arg1, self)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.HUDUtility.UseHintTextForActiveButtonPromptText(self, f1_arg1)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointText)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointCenter)
	return self
end
CoD.Waypoint_NoBackplate.__resetProperties = function(f27_arg0)
	f27_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
	f27_arg0.WaypointCenterIcon:completeAnimation()
	f27_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
	f27_arg0.WaypointCenterIcon:setAlpha(1)
end
CoD.Waypoint_NoBackplate.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f29_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.WaypointArrowDownNotClampedContainer)
			f29_arg0.WaypointCenterIcon:completeAnimation()
			f29_arg0.WaypointCenterIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.WaypointCenterIcon)
		end,
	},
}
CoD.Waypoint_NoBackplate.__onClose = function(f30_arg0)
	f30_arg0.WaypointArrowDownNotClampedContainer:close()
	f30_arg0.WaypointArrowContainer:close()
	f30_arg0.WaypointCenterIcon:close()
end
