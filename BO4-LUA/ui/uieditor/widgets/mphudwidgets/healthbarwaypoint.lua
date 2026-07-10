require("x64:27411b1d207dbc8")
require("x64:da622980c9a8593")
CoD.HealthBarWaypoint = InheritFrom(LUI.UIElement)
CoD.HealthBarWaypoint.__defaultWidth = 120
CoD.HealthBarWaypoint.__defaultHeight = 180
CoD.HealthBarWaypoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "interactivePrompt.activeObjectiveID")
	self:setClass(CoD.HealthBarWaypoint)
	self.id = "HealthBarWaypoint"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0.5, 0.5, -143.5, 144.5, 0.5, 0.5, 35, 47)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local BlurTint = LUI.UIImage.new(0.5, 0.5, -143.5, 144.5, 0.5, 0.5, 35, 47)
	BlurTint:setRGB(0, 0, 0)
	BlurTint:setAlpha(0.3)
	self:addElement(BlurTint)
	self.BlurTint = BlurTint
	local ProgressBar = CoD.WaypointProgressBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -140, 140, 0.5, 0.5, 38, 44)
	ProgressBar:linkToElementModel(self, nil, false, function(model)
		ProgressBar:setModel(model, f1_arg1)
	end)
	ProgressBar:linkToElementModel(self, "objId", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBar.ProgressBarBacking:setShaderVector(4, CoD.WaypointUtility.SetHealthMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	ProgressBar:linkToElementModel(self, "objId", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressBar.ProgressBarWhite:setShaderVector(4, CoD.WaypointUtility.SetHealthMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	ProgressBar:linkToElementModel(self, "objId", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ProgressBar.ProgressBarColor:setShaderVector(4, CoD.WaypointUtility.SetHealthMeterSegmentationIfNeeded(f1_arg1, 0.01, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local WaypointCenter = CoD.WaypointCenter.new(f1_arg0, f1_arg1, 0.5, 0.5, -25, 26, 0.5, 0.5, -26, 25)
	WaypointCenter:setAlpha(0.95)
	WaypointCenter:linkToElementModel(self, nil, false, function(model)
		WaypointCenter:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointCenter)
	self.WaypointCenter = WaypointCenter
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldHideWaypoint(element, f1_arg1)
			end,
		},
		{
			stateName = "NoIcon",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "icon")
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
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["interactivePrompt.activeObjectiveID"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.hacked"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.ref, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.activeIndex, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.count, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.secondaryOffhand, function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.secondaryOffhandCount, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	self:linkToElementModel(self, "icon", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "icon",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.WaypointUtility.ShowMessageOnCloseIfNeeded(f1_arg1, self)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.HUDUtility.UseHintTextForActiveButtonPromptText(self, f1_arg1)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointText)
	CoD.HUDUtility.SetWaypointElementToFadeAlpha(self, self.WaypointCenter)
	return self
end
CoD.HealthBarWaypoint.__resetProperties = function(f27_arg0)
	f27_arg0.WaypointCenter:completeAnimation()
	f27_arg0.ProgressBar:completeAnimation()
	f27_arg0.BlurTint:completeAnimation()
	f27_arg0.Blur:completeAnimation()
	f27_arg0.WaypointCenter:setAlpha(0.95)
	f27_arg0.ProgressBar:setAlpha(1)
	f27_arg0.BlurTint:setAlpha(0.3)
	f27_arg0.Blur:setAlpha(1)
end
CoD.HealthBarWaypoint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(4)
			f29_arg0.Blur:completeAnimation()
			f29_arg0.Blur:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.Blur)
			f29_arg0.BlurTint:completeAnimation()
			f29_arg0.BlurTint:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.BlurTint)
			f29_arg0.ProgressBar:completeAnimation()
			f29_arg0.ProgressBar:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ProgressBar)
			f29_arg0.WaypointCenter:completeAnimation()
			f29_arg0.WaypointCenter:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.WaypointCenter)
		end,
	},
	NoIcon = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.Blur:completeAnimation()
			f30_arg0.Blur:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Blur)
			f30_arg0.BlurTint:completeAnimation()
			f30_arg0.BlurTint:setAlpha(0.3)
			f30_arg0.clipFinished(f30_arg0.BlurTint)
			f30_arg0.WaypointCenter:completeAnimation()
			f30_arg0.WaypointCenter:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WaypointCenter)
		end,
	},
}
CoD.HealthBarWaypoint.__onClose = function(f31_arg0)
	f31_arg0.ProgressBar:close()
	f31_arg0.WaypointCenter:close()
end
