require("x64:70c66703d8fc18d")
require("x64:ca1c04ff7a4cf59")
require("x64:277b9247982af5")
require("x64:c796bcbc9e13e7a")
require("x64:c68e35524efc8d1")
CoD.ButtonPrompt3dCPZM = InheritFrom(LUI.UIElement)
CoD.ButtonPrompt3dCPZM.__defaultWidth = 76
CoD.ButtonPrompt3dCPZM.__defaultHeight = 76
CoD.ButtonPrompt3dCPZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "interactivePrompt.activeObjectiveID")
	self:setClass(CoD.ButtonPrompt3dCPZM)
	self.id = "ButtonPrompt3dCPZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local requirementLabel = CoD.requirementLabel.new(f1_arg0, f1_arg1, 0, 0, 36, 285, 0, 0, 51, 95)
	requirementLabel:setAlpha(0)
	requirementLabel:linkToElementModel(self, nil, false, function(model)
		requirementLabel:setModel(model, f1_arg1)
	end)
	requirementLabel:linkToElementModel(self, "id", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			requirementLabel.requirementLabel2:setText(LocalizeWithKeyBinding(f1_arg1, "+activate", GetObjectiveProperty("buttonPromptText", f3_local0)))
		end
	end)
	requirementLabel:linkToElementModel(self, "id", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			requirementLabel.requirementLabel:setText(LocalizeWithKeyBinding(f1_arg1, "+activate", GetObjectiveProperty("buttonPromptText", f4_local0)))
		end
	end)
	self:addElement(requirementLabel)
	self.requirementLabel = requirementLabel
	local nameLabel = CoD.nameLabel.new(f1_arg0, f1_arg1, 0, 0, 36, 194, 0, 0, 21, 51)
	nameLabel:linkToElementModel(self, nil, false, function(model)
		nameLabel:setModel(model, f1_arg1)
	end)
	self:addElement(nameLabel)
	self.nameLabel = nameLabel
	local ButtonPrompt3dcpzmUseButtonIcon = CoD.ButtonPrompt3dcpzm_UseButtonIcon.new(f1_arg0, f1_arg1, 0, 0, 7, 65, 0, 0, 19, 77)
	ButtonPrompt3dcpzmUseButtonIcon:setAlpha(0)
	ButtonPrompt3dcpzmUseButtonIcon:linkToElementModel(self, nil, false, function(model)
		ButtonPrompt3dcpzmUseButtonIcon:setModel(model, f1_arg1)
	end)
	self:addElement(ButtonPrompt3dcpzmUseButtonIcon)
	self.ButtonPrompt3dcpzmUseButtonIcon = ButtonPrompt3dcpzmUseButtonIcon
	local iconImage = CoD.WaypointCenterCP.new(f1_arg0, f1_arg1, 0, 0, 7, 65, 0, 0, 7, 65)
	iconImage:linkToElementModel(self, nil, false, function(model)
		iconImage:setModel(model, f1_arg1)
	end)
	self:addElement(iconImage)
	self.iconImage = iconImage
	local directionalArrow = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0, 0, 7, 69, 0, 0, 12, 60)
	directionalArrow:linkToElementModel(self, "direction", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			directionalArrow:setZRot(Add(90, f8_local0))
		end
	end)
	directionalArrow:linkToElementModel(self, nil, false, function(model)
		directionalArrow:setModel(model, f1_arg1)
	end)
	self:addElement(directionalArrow)
	self.directionalArrow = directionalArrow
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldHideWaypoint(element, f1_arg1)
			end,
		},
		{
			stateName = "Clamped",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
		{
			stateName = "HideRequirementLabel",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.IsObjectiveRequirementLabelHidden(element, f1_arg1)
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
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["interactivePrompt.activeObjectiveID"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.hacked"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.ref, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.activeIndex, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.count, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.secondaryOffhand, function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.secondaryOffhandCount, function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	self:linkToElementModel(self, "clamped", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f30_arg2, f30_arg3, f30_arg4)
		if IsElementInState(element, "DefaultState") then
			SetElementStateByElementName(self, "nameLabel", controller, "Small")
		else
			SetElementStateByElementName(self, "nameLabel", controller, "DefaultState")
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonPrompt3dCPZM.__resetProperties = function(f31_arg0)
	f31_arg0.requirementLabel:completeAnimation()
	f31_arg0.directionalArrow:completeAnimation()
	f31_arg0.ButtonPrompt3dcpzmUseButtonIcon:completeAnimation()
	f31_arg0.iconImage:completeAnimation()
	f31_arg0.nameLabel:completeAnimation()
	f31_arg0.requirementLabel:setAlpha(0)
	f31_arg0.directionalArrow:setLeftRight(0, 0, 7, 69)
	f31_arg0.directionalArrow:setTopBottom(0, 0, 12, 60)
	f31_arg0.directionalArrow:setAlpha(1)
	f31_arg0.ButtonPrompt3dcpzmUseButtonIcon:setLeftRight(0, 0, 7, 65)
	f31_arg0.ButtonPrompt3dcpzmUseButtonIcon:setTopBottom(0, 0, 19, 77)
	f31_arg0.ButtonPrompt3dcpzmUseButtonIcon:setAlpha(0)
	f31_arg0.iconImage:setAlpha(1)
	f31_arg0.nameLabel:setAlpha(1)
end
CoD.ButtonPrompt3dCPZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(5)
			local f32_local0 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(130)
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.requirementLabel:beginAnimation(200)
				f32_arg0.requirementLabel:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.requirementLabel:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f32_arg0.requirementLabel:completeAnimation()
			f32_arg0.requirementLabel:setAlpha(0)
			f32_local0(f32_arg0.requirementLabel)
			f32_arg0.nameLabel:completeAnimation()
			f32_arg0.clipFinished(f32_arg0.nameLabel)
			f32_arg0.ButtonPrompt3dcpzmUseButtonIcon:completeAnimation()
			f32_arg0.ButtonPrompt3dcpzmUseButtonIcon:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ButtonPrompt3dcpzmUseButtonIcon)
			f32_arg0.iconImage:completeAnimation()
			f32_arg0.iconImage:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.iconImage)
			f32_arg0.directionalArrow:completeAnimation()
			f32_arg0.directionalArrow:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.directionalArrow)
		end,
		HideRequirementLabel = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			local f35_local0 = function(f36_arg0)
				f35_arg0.ButtonPrompt3dcpzmUseButtonIcon:beginAnimation(70)
				f35_arg0.ButtonPrompt3dcpzmUseButtonIcon:setAlpha(0)
				f35_arg0.ButtonPrompt3dcpzmUseButtonIcon:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.ButtonPrompt3dcpzmUseButtonIcon:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.ButtonPrompt3dcpzmUseButtonIcon:completeAnimation()
			f35_arg0.ButtonPrompt3dcpzmUseButtonIcon:setLeftRight(0, 0, 7, 65)
			f35_arg0.ButtonPrompt3dcpzmUseButtonIcon:setTopBottom(0, 0, 7, 65)
			f35_arg0.ButtonPrompt3dcpzmUseButtonIcon:setAlpha(1)
			f35_local0(f35_arg0.ButtonPrompt3dcpzmUseButtonIcon)
			local f35_local1 = function(f37_arg0)
				f35_arg0.iconImage:beginAnimation(70)
				f35_arg0.iconImage:setAlpha(1)
				f35_arg0.iconImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.iconImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.iconImage:completeAnimation()
			f35_arg0.iconImage:setAlpha(0)
			f35_local1(f35_arg0.iconImage)
		end,
	},
	Hidden = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(3)
			f38_arg0.nameLabel:completeAnimation()
			f38_arg0.nameLabel:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.nameLabel)
			f38_arg0.iconImage:completeAnimation()
			f38_arg0.iconImage:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.iconImage)
			f38_arg0.directionalArrow:completeAnimation()
			f38_arg0.directionalArrow:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.directionalArrow)
		end,
		HideRequirementLabel = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			local f39_local0 = function(f40_arg0)
				f39_arg0.nameLabel:beginAnimation(200)
				f39_arg0.nameLabel:setAlpha(1)
				f39_arg0.nameLabel:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.nameLabel:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.nameLabel:completeAnimation()
			f39_arg0.nameLabel:setAlpha(0)
			f39_local0(f39_arg0.nameLabel)
			local f39_local1 = function(f41_arg0)
				f39_arg0.iconImage:beginAnimation(200)
				f39_arg0.iconImage:setAlpha(1)
				f39_arg0.iconImage:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.iconImage:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.iconImage:completeAnimation()
			f39_arg0.iconImage:setAlpha(0.85)
			f39_local1(f39_arg0.iconImage)
		end,
	},
	Clamped = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.nameLabel:completeAnimation()
			f42_arg0.nameLabel:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.nameLabel)
			f42_arg0.directionalArrow:completeAnimation()
			f42_arg0.directionalArrow:setLeftRight(0, 0, 7, 69)
			f42_arg0.directionalArrow:setTopBottom(0, 0, 7, 65)
			f42_arg0.clipFinished(f42_arg0.directionalArrow)
		end,
	},
	HideRequirementLabel = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(1)
			f43_arg0.directionalArrow:completeAnimation()
			f43_arg0.directionalArrow:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.directionalArrow)
		end,
		Hidden = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			local f44_local0 = function(f45_arg0)
				f44_arg0.nameLabel:beginAnimation(200)
				f44_arg0.nameLabel:setAlpha(0)
				f44_arg0.nameLabel:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.nameLabel:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.nameLabel:completeAnimation()
			f44_arg0.nameLabel:setAlpha(1)
			f44_local0(f44_arg0.nameLabel)
			f44_arg0.directionalArrow:completeAnimation()
			f44_arg0.directionalArrow:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.directionalArrow)
		end,
	},
}
CoD.ButtonPrompt3dCPZM.__onClose = function(f46_arg0)
	f46_arg0.requirementLabel:close()
	f46_arg0.nameLabel:close()
	f46_arg0.ButtonPrompt3dcpzmUseButtonIcon:close()
	f46_arg0.iconImage:close()
	f46_arg0.directionalArrow:close()
end
