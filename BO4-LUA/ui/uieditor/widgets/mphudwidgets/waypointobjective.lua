require("x64:b3cb3de9a683c02")
require("x64:c68e35524efc8d1")
require("x64:27411b1d207dbc8")
CoD.WaypointObjective = InheritFrom(LUI.UIElement)
CoD.WaypointObjective.__defaultWidth = 120
CoD.WaypointObjective.__defaultHeight = 180
CoD.WaypointObjective.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointObjective)
	self.id = "WaypointObjective"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressMeterFrame = LUI.UIImage.new(0.5, 0.5, -63, 65, 0.5, 0.5, -64, 64)
	ProgressMeterFrame:setImage(RegisterImage(@"hash_128E3C0049FF4CC9"))
	self:addElement(ProgressMeterFrame)
	self.ProgressMeterFrame = ProgressMeterFrame
	local WaypointArrowDownNotClampedContainer = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -25, 21)
	WaypointArrowDownNotClampedContainer:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f2_local0
				if not ParentObjectivePropertyIsTrue(element, "hide_arrow") then
					f2_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
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
	local WaypointArrowContainer = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -25, 21)
	WaypointArrowContainer:setAlpha(0.95)
	WaypointArrowContainer:linkToElementModel(self, "direction", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			WaypointArrowContainer:setZRot(Add(90, f5_local0))
		end
	end)
	WaypointArrowContainer:linkToElementModel(self, nil, false, function(model)
		WaypointArrowContainer:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointArrowContainer)
	self.WaypointArrowContainer = WaypointArrowContainer
	local progressMeter = LUI.UIImage.new(0.5, 0.5, -63, 65, 0.5, 0.5, -65, 63)
	progressMeter:setAlpha(0.9)
	progressMeter:setImage(RegisterImage(@"hash_7E72D91F1F5D8EA4"))
	progressMeter:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	progressMeter:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeter:setShaderVector(2, 0.43, 0, 0, 0)
	progressMeter:setShaderVector(3, 0, 0, 0, 0)
	progressMeter:setShaderVector(4, 1, 0.1, 0, 0)
	progressMeter:linkToElementModel(self, "progress", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			progressMeter:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	self:addElement(progressMeter)
	self.progressMeter = progressMeter
	local progressMeterContested = LUI.UIImage.new(0.5, 0.5, -34, 36, 0.5, 0.5, -36, 34)
	progressMeterContested:setRGB(1, 0.4, 0)
	progressMeterContested:setAlpha(0)
	progressMeterContested:setImage(RegisterImage(@"uie_t7_hud_interact_meter_diamond"))
	progressMeterContested:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	progressMeterContested:setShaderVector(0, 1.03, 0.13, 0, 0)
	progressMeterContested:setShaderVector(1, 0.5, 0, 0, 0)
	progressMeterContested:setShaderVector(2, 0.5, 0, 0, 0)
	progressMeterContested:setShaderVector(3, 0, 0, 0, 0)
	progressMeterContested:setShaderVector(4, 3, 0.07, 0, 0)
	self:addElement(progressMeterContested)
	self.progressMeterContested = progressMeterContested
	local WaypointText = CoD.Waypoint_TextBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -60, 60, 0.5, 0.5, -68, -36)
	WaypointText:linkToElementModel(self, nil, false, function(model)
		WaypointText:setModel(model, f1_arg1)
	end)
	WaypointText:linkToElementModel(self, "text", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			WaypointText.WaypointTextWithBG.text:setText(Engine[@"hash_4F9F1239CFD921FE"](f9_local0))
		end
	end)
	WaypointText:linkToElementModel(self, "distanceText", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			WaypointText.DistanceTextWithBG.text:setText(LocalizeIntoStringIfNotEmpty(@"hash_37235825812D46C6", f10_local0))
		end
	end)
	self:addElement(WaypointText)
	self.WaypointText = WaypointText
	local WaypointCenter = CoD.WaypointCenter.new(f1_arg0, f1_arg1, 0.5, 0.5, -31.5, 32.5, 0.5, 0.5, -32.5, 31.5)
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
		{
			stateName = "NoFrame",
			condition = function(menu, element, event)
				return not CoD.WaypointUtility.ShouldShowWaypointFrame(f1_arg1, self)
			end,
		},
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointAsContested(f1_arg1, self)
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
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["interactivePrompt.activeObjectiveID"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.hacked"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.ref, function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.activeIndex, function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.count, function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.secondaryOffhand, function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.secondaryOffhandCount, function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
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
	self:linkToElementModel(self, "progress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "progress",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	CoD.HUDUtility.UseHintTextForActiveButtonPromptText(self, f1_arg1)
	return self
end
CoD.WaypointObjective.__resetProperties = function(f34_arg0)
	f34_arg0.WaypointArrowContainer:completeAnimation()
	f34_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
	f34_arg0.WaypointCenter:completeAnimation()
	f34_arg0.WaypointText:completeAnimation()
	f34_arg0.progressMeter:completeAnimation()
	f34_arg0.ProgressMeterFrame:completeAnimation()
	f34_arg0.progressMeterContested:completeAnimation()
	f34_arg0.WaypointArrowContainer:setAlpha(0.95)
	f34_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0.95)
	f34_arg0.WaypointCenter:setLeftRight(0.5, 0.5, -31.5, 32.5)
	f34_arg0.WaypointCenter:setTopBottom(0.5, 0.5, -32.5, 31.5)
	f34_arg0.WaypointCenter:setAlpha(0.95)
	f34_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
	f34_arg0.WaypointText:setTopBottom(0.5, 0.5, -68, -36)
	f34_arg0.WaypointText:setAlpha(1)
	f34_arg0.progressMeter:setAlpha(0.9)
	f34_arg0.ProgressMeterFrame:setAlpha(1)
	f34_arg0.progressMeterContested:setAlpha(0)
	f34_arg0.progressMeterContested:setImage(RegisterImage(@"uie_t7_hud_interact_meter_diamond"))
	f34_arg0.progressMeterContested:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	f34_arg0.progressMeterContested:setShaderVector(0, 1.03, 0.13, 0, 0)
	f34_arg0.progressMeterContested:setShaderVector(1, 0.5, 0, 0, 0)
	f34_arg0.progressMeterContested:setShaderVector(2, 0.5, 0, 0, 0)
	f34_arg0.progressMeterContested:setShaderVector(3, 0, 0, 0, 0)
	f34_arg0.progressMeterContested:setShaderVector(4, 3, 0.07, 0, 0)
end
CoD.WaypointObjective.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(3)
			f35_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f35_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.WaypointArrowDownNotClampedContainer)
			f35_arg0.WaypointArrowContainer:completeAnimation()
			f35_arg0.WaypointArrowContainer:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.WaypointArrowContainer)
			f35_arg0.WaypointCenter:completeAnimation()
			f35_arg0.WaypointCenter:setLeftRight(0.5, 0.5, -31.5, 32.5)
			f35_arg0.WaypointCenter:setTopBottom(0.5, 0.5, -32.5, 31.5)
			f35_arg0.clipFinished(f35_arg0.WaypointCenter)
		end,
	},
	Hidden = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(6)
			f36_arg0.ProgressMeterFrame:completeAnimation()
			f36_arg0.ProgressMeterFrame:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ProgressMeterFrame)
			f36_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f36_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.WaypointArrowDownNotClampedContainer)
			f36_arg0.WaypointArrowContainer:completeAnimation()
			f36_arg0.WaypointArrowContainer:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.WaypointArrowContainer)
			f36_arg0.progressMeter:completeAnimation()
			f36_arg0.progressMeter:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.progressMeter)
			f36_arg0.WaypointText:completeAnimation()
			f36_arg0.WaypointText:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.WaypointText)
			f36_arg0.WaypointCenter:completeAnimation()
			f36_arg0.WaypointCenter:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.WaypointCenter)
		end,
	},
	NoIcon = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			f37_arg0.ProgressMeterFrame:completeAnimation()
			f37_arg0.ProgressMeterFrame:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ProgressMeterFrame)
			f37_arg0.progressMeter:completeAnimation()
			f37_arg0.progressMeter:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.progressMeter)
			f37_arg0.WaypointText:completeAnimation()
			f37_arg0.WaypointText:setLeftRight(0.5, 0.5, -60, 60)
			f37_arg0.WaypointText:setTopBottom(0.5, 0.5, -14, 18)
			f37_arg0.clipFinished(f37_arg0.WaypointText)
			f37_arg0.WaypointCenter:completeAnimation()
			f37_arg0.WaypointCenter:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.WaypointCenter)
		end,
	},
	NoFrame = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.ProgressMeterFrame:completeAnimation()
			f38_arg0.ProgressMeterFrame:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ProgressMeterFrame)
			f38_arg0.progressMeter:completeAnimation()
			f38_arg0.progressMeter:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.progressMeter)
		end,
	},
	Contested = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(4)
			f39_arg0.WaypointArrowDownNotClampedContainer:completeAnimation()
			f39_arg0.WaypointArrowDownNotClampedContainer:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.WaypointArrowDownNotClampedContainer)
			f39_arg0.WaypointArrowContainer:completeAnimation()
			f39_arg0.WaypointArrowContainer:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.WaypointArrowContainer)
			f39_arg0.progressMeter:completeAnimation()
			f39_arg0.progressMeter:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.progressMeter)
			f39_arg0.progressMeterContested:completeAnimation()
			f39_arg0.progressMeterContested:setAlpha(0.9)
			f39_arg0.progressMeterContested:setImage(RegisterImage(@"uie_hud_mp_waypoint_objective_diamond"))
			f39_arg0.progressMeterContested:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
			f39_arg0.progressMeterContested:setShaderVector(0, 1.03, 0.13, 0, 0)
			f39_arg0.progressMeterContested:setShaderVector(1, 0.5, 0, 0, 0)
			f39_arg0.progressMeterContested:setShaderVector(2, 0.5, 0, 0, 0)
			f39_arg0.progressMeterContested:setShaderVector(3, 0, 0, 0, 0)
			f39_arg0.progressMeterContested:setShaderVector(4, 0, 0.07, 0, 0)
			f39_arg0.clipFinished(f39_arg0.progressMeterContested)
		end,
	},
}
CoD.WaypointObjective.__onClose = function(f40_arg0)
	f40_arg0.WaypointArrowDownNotClampedContainer:close()
	f40_arg0.WaypointArrowContainer:close()
	f40_arg0.progressMeter:close()
	f40_arg0.WaypointText:close()
	f40_arg0.WaypointCenter:close()
end
