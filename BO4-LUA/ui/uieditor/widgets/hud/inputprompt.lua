require("ui/uieditor/widgets/cphudwidgets/waypointcentercp")
require("ui/uieditor/widgets/hud/buttonprompt3dcpzm_usebuttonicon")
require("ui/uieditor/widgets/mphudwidgets/waypoint_textwithbg")
require("ui/uieditor/widgets/mphudwidgets/waypointarrowcontainer")
CoD.InputPrompt = InheritFrom(LUI.UIElement)
CoD.InputPrompt.__defaultWidth = 72
CoD.InputPrompt.__defaultHeight = 72
CoD.InputPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "interactivePrompt.activeObjectiveID")
	self:setClass(CoD.InputPrompt)
	self.id = "InputPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonPromptText = CoD.Waypoint_TextWithBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 0, 0, -38, 0)
	ButtonPromptText:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, @"hash_1BB6EE6EB270DC8", nil)
			end,
		},
	})
	ButtonPromptText:linkToElementModel(ButtonPromptText, "id", true, function(model)
		f1_arg0:updateElementState(ButtonPromptText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	ButtonPromptText:setAlpha(0)
	ButtonPromptText:linkToElementModel(self, "id", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ButtonPromptText.text:setText(ConvertToUpperString(LocalizeWithKeyBinding(f1_arg1, "+activate", GetObjectiveProperty("buttonPromptText", f4_local0))))
		end
	end)
	self:addElement(ButtonPromptText)
	self.ButtonPromptText = ButtonPromptText
	local ButtonPrompt = CoD.ButtonPrompt3dcpzm_UseButtonIcon.new(f1_arg0, f1_arg1, 0, 0, 7, 65, 0, 0, 7, 65)
	ButtonPrompt:setAlpha(0)
	ButtonPrompt:linkToElementModel(self, nil, false, function(model)
		ButtonPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(ButtonPrompt)
	self.ButtonPrompt = ButtonPrompt
	local IconImage = CoD.WaypointCenterCP.new(f1_arg0, f1_arg1, 0, 0, 6, 66, 0, 0, 6, 66)
	IconImage:setRGB(0.93, 0.91, 0.8)
	IconImage:linkToElementModel(self, nil, false, function(model)
		IconImage:setModel(model, f1_arg1)
	end)
	self:addElement(IconImage)
	self.IconImage = IconImage
	local DirectionalArrow = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0, 0, 13, 56, 0, 0, 13, 59)
	DirectionalArrow:linkToElementModel(self, "direction", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			DirectionalArrow:setZRot(Add(90, f7_local0))
		end
	end)
	DirectionalArrow:linkToElementModel(self, nil, false, function(model)
		DirectionalArrow:setModel(model, f1_arg1)
	end)
	self:addElement(DirectionalArrow)
	self.DirectionalArrow = DirectionalArrow
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
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped") and CoD.WaypointUtility.IsObjectiveRequirementLabelHidden(element, f1_arg1)
			end,
		},
		{
			stateName = "HideRequirementLabel",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.IsObjectiveRequirementLabelHidden(element, f1_arg1)
			end,
		},
		{
			stateName = "ClampedInteractable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
		{
			stateName = "OffscreenInteractable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isOffscreen") and CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, @"hash_44AC803636BB2F2", 1)
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
	local f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["interactivePrompt.activeObjectiveID"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.hacked"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.ref, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.activeIndex, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.count, function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.secondaryOffhand, function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.secondaryOffhandCount, function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_spectating_client"]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_spectating_client"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_emp_active"]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_emp_active"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_selecting_locational_killstreak"]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_selecting_locational_killstreak"],
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
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f32_arg2, f32_arg3, f32_arg4)
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
CoD.InputPrompt.__resetProperties = function(f33_arg0)
	f33_arg0.DirectionalArrow:completeAnimation()
	f33_arg0.ButtonPrompt:completeAnimation()
	f33_arg0.IconImage:completeAnimation()
	f33_arg0.ButtonPromptText:completeAnimation()
	f33_arg0.DirectionalArrow:setAlpha(1)
	f33_arg0.ButtonPrompt:setLeftRight(0, 0, 7, 65)
	f33_arg0.ButtonPrompt:setTopBottom(0, 0, 7, 65)
	f33_arg0.ButtonPrompt:setAlpha(0)
	f33_arg0.IconImage:setAlpha(1)
	f33_arg0.ButtonPromptText:setLeftRight(0.5, 0.5, -192, 192)
	f33_arg0.ButtonPromptText:setTopBottom(0, 0, -38, 0)
	f33_arg0.ButtonPromptText:setAlpha(0)
	f33_arg0.ButtonPromptText.text:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
end
CoD.InputPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(4)
			f34_arg0.ButtonPromptText:completeAnimation()
			f34_arg0.ButtonPromptText:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.ButtonPromptText)
			f34_arg0.ButtonPrompt:completeAnimation()
			f34_arg0.ButtonPrompt:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.ButtonPrompt)
			f34_arg0.IconImage:completeAnimation()
			f34_arg0.IconImage:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.IconImage)
			f34_arg0.DirectionalArrow:completeAnimation()
			f34_arg0.DirectionalArrow:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DirectionalArrow)
		end,
		HideRequirementLabel = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			local f35_local0 = function(f36_arg0)
				f35_arg0.ButtonPrompt:beginAnimation(70)
				f35_arg0.ButtonPrompt:setAlpha(0)
				f35_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.ButtonPrompt:completeAnimation()
			f35_arg0.ButtonPrompt:setLeftRight(0, 0, 7, 65)
			f35_arg0.ButtonPrompt:setTopBottom(0, 0, 7, 65)
			f35_arg0.ButtonPrompt:setAlpha(1)
			f35_local0(f35_arg0.ButtonPrompt)
			local f35_local1 = function(f37_arg0)
				f35_arg0.IconImage:beginAnimation(70)
				f35_arg0.IconImage:setAlpha(1)
				f35_arg0.IconImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.IconImage:completeAnimation()
			f35_arg0.IconImage:setAlpha(0)
			f35_local1(f35_arg0.IconImage)
		end,
	},
	Hidden = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.IconImage:completeAnimation()
			f38_arg0.IconImage:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.IconImage)
			f38_arg0.DirectionalArrow:completeAnimation()
			f38_arg0.DirectionalArrow:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.DirectionalArrow)
		end,
		HideRequirementLabel = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			local f39_local0 = function(f40_arg0)
				f39_arg0.IconImage:beginAnimation(200)
				f39_arg0.IconImage:setAlpha(1)
				f39_arg0.IconImage:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.IconImage:completeAnimation()
			f39_arg0.IconImage:setAlpha(0.85)
			f39_local0(f39_arg0.IconImage)
		end,
	},
	Clamped = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(0)
		end,
		ClampedInteractable = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(3)
			f42_arg0.ButtonPromptText:beginAnimation(220)
			f42_arg0.ButtonPromptText:setAlpha(0.01)
			f42_arg0.ButtonPromptText:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
			f42_arg0.ButtonPromptText:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			local f42_local0 = function(f43_arg0)
				f42_arg0.ButtonPrompt:beginAnimation(250)
				f42_arg0.ButtonPrompt:setAlpha(1)
				f42_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.ButtonPrompt:completeAnimation()
			f42_arg0.ButtonPrompt:setAlpha(0)
			f42_local0(f42_arg0.ButtonPrompt)
			local f42_local1 = function(f44_arg0)
				f42_arg0.IconImage:beginAnimation(250)
				f42_arg0.IconImage:setAlpha(0)
				f42_arg0.IconImage:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.IconImage:completeAnimation()
			f42_arg0.IconImage:setAlpha(1)
			f42_local1(f42_arg0.IconImage)
		end,
	},
	HideRequirementLabel = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(1)
			f45_arg0.DirectionalArrow:completeAnimation()
			f45_arg0.DirectionalArrow:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.DirectionalArrow)
		end,
		Hidden = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(1)
			f46_arg0.DirectionalArrow:completeAnimation()
			f46_arg0.DirectionalArrow:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.DirectionalArrow)
		end,
		DefaultState = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			local f47_local0 = function(f48_arg0)
				f47_arg0.ButtonPromptText:beginAnimation(250)
				f47_arg0.ButtonPromptText:setAlpha(1)
				f47_arg0.ButtonPromptText:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.ButtonPromptText:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.ButtonPromptText:completeAnimation()
			f47_arg0.ButtonPromptText:setAlpha(0.01)
			f47_local0(f47_arg0.ButtonPromptText)
			local f47_local1 = function(f49_arg0)
				f47_arg0.ButtonPrompt:beginAnimation(250)
				f47_arg0.ButtonPrompt:setAlpha(1)
				f47_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.ButtonPrompt:completeAnimation()
			f47_arg0.ButtonPrompt:setAlpha(0)
			f47_local1(f47_arg0.ButtonPrompt)
			local f47_local2 = function(f50_arg0)
				f47_arg0.IconImage:beginAnimation(250)
				f47_arg0.IconImage:setAlpha(0)
				f47_arg0.IconImage:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.IconImage:completeAnimation()
			f47_arg0.IconImage:setAlpha(1)
			f47_local2(f47_arg0.IconImage)
			f47_arg0.DirectionalArrow:completeAnimation()
			f47_arg0.DirectionalArrow:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.DirectionalArrow)
		end,
		ClampedInteractable = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(3)
			f51_arg0.ButtonPromptText:beginAnimation(200)
			f51_arg0.ButtonPromptText:setAlpha(0.01)
			f51_arg0.ButtonPromptText:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
			f51_arg0.ButtonPromptText:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			local f51_local0 = function(f52_arg0)
				f51_arg0.ButtonPrompt:beginAnimation(250)
				f51_arg0.ButtonPrompt:setAlpha(1)
				f51_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.ButtonPrompt:completeAnimation()
			f51_arg0.ButtonPrompt:setAlpha(0)
			f51_local0(f51_arg0.ButtonPrompt)
			local f51_local1 = function(f53_arg0)
				f51_arg0.IconImage:beginAnimation(250)
				f51_arg0.IconImage:setAlpha(0)
				f51_arg0.IconImage:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.IconImage:completeAnimation()
			f51_arg0.IconImage:setAlpha(1)
			f51_local1(f51_arg0.IconImage)
		end,
	},
	ClampedInteractable = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(3)
			f54_arg0.ButtonPromptText:completeAnimation()
			f54_arg0.ButtonPromptText:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.ButtonPromptText)
			f54_arg0.ButtonPrompt:completeAnimation()
			f54_arg0.ButtonPrompt:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.ButtonPrompt)
			f54_arg0.IconImage:completeAnimation()
			f54_arg0.IconImage:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.IconImage)
		end,
		Hidden = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(1)
			f55_arg0.DirectionalArrow:completeAnimation()
			f55_arg0.DirectionalArrow:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.DirectionalArrow)
		end,
	},
	OffscreenInteractable = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(3)
			f56_arg0.ButtonPromptText:completeAnimation()
			f56_arg0.ButtonPromptText.text:completeAnimation()
			f56_arg0.ButtonPromptText:setLeftRight(0, 0, 173, 373)
			f56_arg0.ButtonPromptText:setTopBottom(0, 0, 21, 51)
			f56_arg0.ButtonPromptText:setAlpha(1)
			f56_arg0.ButtonPromptText.text:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
			f56_arg0.clipFinished(f56_arg0.ButtonPromptText)
			f56_arg0.ButtonPrompt:completeAnimation()
			f56_arg0.ButtonPrompt:setAlpha(1)
			f56_arg0.clipFinished(f56_arg0.ButtonPrompt)
			f56_arg0.IconImage:completeAnimation()
			f56_arg0.IconImage:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.IconImage)
		end,
	},
}
CoD.InputPrompt.__onClose = function(f57_arg0)
	f57_arg0.ButtonPromptText:close()
	f57_arg0.ButtonPrompt:close()
	f57_arg0.IconImage:close()
	f57_arg0.DirectionalArrow:close()
end
