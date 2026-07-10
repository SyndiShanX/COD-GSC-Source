require("x64:70c66703d8fc18d")
require("x64:c796bcbc9e13e7a")
require("x64:e8c9585bd4d7a5e")
require("x64:c68e35524efc8d1")
CoD.CarryInputPrompt = InheritFrom(LUI.UIElement)
CoD.CarryInputPrompt.__defaultWidth = 72
CoD.CarryInputPrompt.__defaultHeight = 72
CoD.CarryInputPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "interactivePrompt.activeObjectiveID")
	self:setClass(CoD.CarryInputPrompt)
	self.id = "CarryInputPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonPromptText = CoD.Waypoint_TextWithBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -120, 120, 0, 0, -38, 0)
	ButtonPromptText:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, 0x1BB6EE6EB270DC8, nil)
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
	local ObjectiveWaypointText = CoD.Waypoint_TextWithBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -120, 120, 0, 0, -38, 0)
	ObjectiveWaypointText:setAlpha(0)
	ObjectiveWaypointText:linkToElementModel(self, nil, false, function(model)
		ObjectiveWaypointText:setModel(model, f1_arg1)
	end)
	ObjectiveWaypointText:linkToElementModel(self, "text", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ObjectiveWaypointText.text:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	self:addElement(ObjectiveWaypointText)
	self.ObjectiveWaypointText = ObjectiveWaypointText
	local IconImage = CoD.WaypointCenterCP.new(f1_arg0, f1_arg1, 0, 0, 6, 66, 0, 0, 6, 66)
	IconImage:setRGB(0.93, 0.91, 0.8)
	IconImage:linkToElementModel(self, nil, false, function(model)
		IconImage:setModel(model, f1_arg1)
	end)
	self:addElement(IconImage)
	self.IconImage = IconImage
	local DirectionalArrow = CoD.WaypointArrowContainer.new(f1_arg0, f1_arg1, 0, 0, 13, 56, 0, 0, 13, 59)
	DirectionalArrow:linkToElementModel(self, "direction", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			DirectionalArrow:setZRot(Add(90, f9_local0))
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
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isOffscreen") and CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, 0x44AC803636BB2F2, 1)
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
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["interactivePrompt.activeObjectiveID"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.hacked"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.ref, function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "ref",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.LethalOffhands.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.activeIndex, function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "activeIndex",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentPrimaryOffhand.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.count, function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "count",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.secondaryOffhand, function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "secondaryOffhand",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentSecondaryOffhand.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.secondaryOffhandCount, function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "secondaryOffhandCount",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
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
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f34_arg2, f34_arg3, f34_arg4)
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
CoD.CarryInputPrompt.__resetProperties = function(f35_arg0)
	f35_arg0.DirectionalArrow:completeAnimation()
	f35_arg0.ButtonPrompt:completeAnimation()
	f35_arg0.IconImage:completeAnimation()
	f35_arg0.ButtonPromptText:completeAnimation()
	f35_arg0.ObjectiveWaypointText:completeAnimation()
	f35_arg0.DirectionalArrow:setAlpha(1)
	f35_arg0.ButtonPrompt:setLeftRight(0, 0, 7, 65)
	f35_arg0.ButtonPrompt:setTopBottom(0, 0, 7, 65)
	f35_arg0.ButtonPrompt:setAlpha(0)
	f35_arg0.IconImage:setAlpha(1)
	f35_arg0.ButtonPromptText:setLeftRight(0.5, 0.5, -120, 120)
	f35_arg0.ButtonPromptText:setTopBottom(0, 0, -38, 0)
	f35_arg0.ButtonPromptText:setAlpha(0)
	f35_arg0.ButtonPromptText.text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	f35_arg0.ObjectiveWaypointText:setAlpha(0)
end
CoD.CarryInputPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(4)
			f36_arg0.ButtonPromptText:completeAnimation()
			f36_arg0.ButtonPromptText:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.ButtonPromptText)
			f36_arg0.ButtonPrompt:completeAnimation()
			f36_arg0.ButtonPrompt:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.ButtonPrompt)
			f36_arg0.IconImage:completeAnimation()
			f36_arg0.IconImage:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.IconImage)
			f36_arg0.DirectionalArrow:completeAnimation()
			f36_arg0.DirectionalArrow:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.DirectionalArrow)
		end,
		HideRequirementLabel = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			local f37_local0 = function(f38_arg0)
				f37_arg0.ButtonPrompt:beginAnimation(70)
				f37_arg0.ButtonPrompt:setAlpha(0)
				f37_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.ButtonPrompt:completeAnimation()
			f37_arg0.ButtonPrompt:setLeftRight(0, 0, 7, 65)
			f37_arg0.ButtonPrompt:setTopBottom(0, 0, 7, 65)
			f37_arg0.ButtonPrompt:setAlpha(1)
			f37_local0(f37_arg0.ButtonPrompt)
			local f37_local1 = function(f39_arg0)
				f37_arg0.ObjectiveWaypointText:beginAnimation(70)
				f37_arg0.ObjectiveWaypointText:setAlpha(1)
				f37_arg0.ObjectiveWaypointText:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.ObjectiveWaypointText:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.ObjectiveWaypointText:completeAnimation()
			f37_arg0.ObjectiveWaypointText:setAlpha(0)
			f37_local1(f37_arg0.ObjectiveWaypointText)
			local f37_local2 = function(f40_arg0)
				f37_arg0.IconImage:beginAnimation(70)
				f37_arg0.IconImage:setAlpha(1)
				f37_arg0.IconImage:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.IconImage:completeAnimation()
			f37_arg0.IconImage:setAlpha(0)
			f37_local2(f37_arg0.IconImage)
		end,
	},
	Hidden = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			f41_arg0.IconImage:completeAnimation()
			f41_arg0.IconImage:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.IconImage)
			f41_arg0.DirectionalArrow:completeAnimation()
			f41_arg0.DirectionalArrow:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.DirectionalArrow)
		end,
		HideRequirementLabel = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.ObjectiveWaypointText:completeAnimation()
			f42_arg0.ObjectiveWaypointText:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.ObjectiveWaypointText)
			local f42_local0 = function(f43_arg0)
				f42_arg0.IconImage:beginAnimation(200)
				f42_arg0.IconImage:setAlpha(1)
				f42_arg0.IconImage:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.IconImage:completeAnimation()
			f42_arg0.IconImage:setAlpha(0.85)
			f42_local0(f42_arg0.IconImage)
		end,
	},
	Clamped = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(0)
		end,
		ClampedInteractable = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(4)
			f45_arg0.ButtonPromptText:beginAnimation(220)
			f45_arg0.ButtonPromptText:setAlpha(0.01)
			f45_arg0.ButtonPromptText:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
			f45_arg0.ButtonPromptText:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			local f45_local0 = function(f46_arg0)
				f45_arg0.ButtonPrompt:beginAnimation(250)
				f45_arg0.ButtonPrompt:setAlpha(1)
				f45_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.ButtonPrompt:completeAnimation()
			f45_arg0.ButtonPrompt:setAlpha(0)
			f45_local0(f45_arg0.ButtonPrompt)
			local f45_local1 = function(f47_arg0)
				f45_arg0.ObjectiveWaypointText:beginAnimation(220)
				f45_arg0.ObjectiveWaypointText:setAlpha(0)
				f45_arg0.ObjectiveWaypointText:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.ObjectiveWaypointText:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.ObjectiveWaypointText:completeAnimation()
			f45_arg0.ObjectiveWaypointText:setAlpha(1)
			f45_local1(f45_arg0.ObjectiveWaypointText)
			local f45_local2 = function(f48_arg0)
				f45_arg0.IconImage:beginAnimation(250)
				f45_arg0.IconImage:setAlpha(0)
				f45_arg0.IconImage:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.IconImage:completeAnimation()
			f45_arg0.IconImage:setAlpha(1)
			f45_local2(f45_arg0.IconImage)
		end,
	},
	HideRequirementLabel = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(2)
			f49_arg0.ObjectiveWaypointText:completeAnimation()
			f49_arg0.ObjectiveWaypointText:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.ObjectiveWaypointText)
			f49_arg0.DirectionalArrow:completeAnimation()
			f49_arg0.DirectionalArrow:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.DirectionalArrow)
		end,
		Hidden = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(2)
			f50_arg0.ObjectiveWaypointText:completeAnimation()
			f50_arg0.ObjectiveWaypointText:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveWaypointText)
			f50_arg0.DirectionalArrow:completeAnimation()
			f50_arg0.DirectionalArrow:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.DirectionalArrow)
		end,
		DefaultState = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(5)
			local f51_local0 = function(f52_arg0)
				f51_arg0.ButtonPromptText:beginAnimation(250)
				f51_arg0.ButtonPromptText:setAlpha(1)
				f51_arg0.ButtonPromptText:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.ButtonPromptText:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.ButtonPromptText:completeAnimation()
			f51_arg0.ButtonPromptText:setAlpha(0.01)
			f51_local0(f51_arg0.ButtonPromptText)
			local f51_local1 = function(f53_arg0)
				f51_arg0.ButtonPrompt:beginAnimation(250)
				f51_arg0.ButtonPrompt:setAlpha(1)
				f51_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.ButtonPrompt:completeAnimation()
			f51_arg0.ButtonPrompt:setAlpha(0)
			f51_local1(f51_arg0.ButtonPrompt)
			local f51_local2 = function(f54_arg0)
				f51_arg0.ObjectiveWaypointText:beginAnimation(250)
				f51_arg0.ObjectiveWaypointText:setAlpha(0)
				f51_arg0.ObjectiveWaypointText:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.ObjectiveWaypointText:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.ObjectiveWaypointText:completeAnimation()
			f51_arg0.ObjectiveWaypointText:setAlpha(1)
			f51_local2(f51_arg0.ObjectiveWaypointText)
			local f51_local3 = function(f55_arg0)
				f51_arg0.IconImage:beginAnimation(250)
				f51_arg0.IconImage:setAlpha(0)
				f51_arg0.IconImage:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.IconImage:completeAnimation()
			f51_arg0.IconImage:setAlpha(1)
			f51_local3(f51_arg0.IconImage)
			f51_arg0.DirectionalArrow:completeAnimation()
			f51_arg0.DirectionalArrow:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.DirectionalArrow)
		end,
		ClampedInteractable = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(4)
			f56_arg0.ButtonPromptText:beginAnimation(200)
			f56_arg0.ButtonPromptText:setAlpha(0.01)
			f56_arg0.ButtonPromptText:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
			f56_arg0.ButtonPromptText:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			local f56_local0 = function(f57_arg0)
				f56_arg0.ButtonPrompt:beginAnimation(250)
				f56_arg0.ButtonPrompt:setAlpha(1)
				f56_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.ButtonPrompt:completeAnimation()
			f56_arg0.ButtonPrompt:setAlpha(0)
			f56_local0(f56_arg0.ButtonPrompt)
			local f56_local1 = function(f58_arg0)
				f56_arg0.ObjectiveWaypointText:beginAnimation(200)
				f56_arg0.ObjectiveWaypointText:setAlpha(0)
				f56_arg0.ObjectiveWaypointText:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.ObjectiveWaypointText:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.ObjectiveWaypointText:completeAnimation()
			f56_arg0.ObjectiveWaypointText:setAlpha(1)
			f56_local1(f56_arg0.ObjectiveWaypointText)
			local f56_local2 = function(f59_arg0)
				f56_arg0.IconImage:beginAnimation(250)
				f56_arg0.IconImage:setAlpha(0)
				f56_arg0.IconImage:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.IconImage:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.IconImage:completeAnimation()
			f56_arg0.IconImage:setAlpha(1)
			f56_local2(f56_arg0.IconImage)
		end,
	},
	ClampedInteractable = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(3)
			f60_arg0.ButtonPromptText:completeAnimation()
			f60_arg0.ButtonPromptText:setAlpha(1)
			f60_arg0.clipFinished(f60_arg0.ButtonPromptText)
			f60_arg0.ButtonPrompt:completeAnimation()
			f60_arg0.ButtonPrompt:setAlpha(1)
			f60_arg0.clipFinished(f60_arg0.ButtonPrompt)
			f60_arg0.IconImage:completeAnimation()
			f60_arg0.IconImage:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.IconImage)
		end,
		Hidden = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(1)
			f61_arg0.DirectionalArrow:completeAnimation()
			f61_arg0.DirectionalArrow:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.DirectionalArrow)
		end,
	},
	OffscreenInteractable = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(3)
			f62_arg0.ButtonPromptText:completeAnimation()
			f62_arg0.ButtonPromptText.text:completeAnimation()
			f62_arg0.ButtonPromptText:setLeftRight(0, 0, 135, 335)
			f62_arg0.ButtonPromptText:setTopBottom(0, 0, 21, 51)
			f62_arg0.ButtonPromptText:setAlpha(1)
			f62_arg0.ButtonPromptText.text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
			f62_arg0.clipFinished(f62_arg0.ButtonPromptText)
			f62_arg0.ButtonPrompt:completeAnimation()
			f62_arg0.ButtonPrompt:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.ButtonPrompt)
			f62_arg0.IconImage:completeAnimation()
			f62_arg0.IconImage:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.IconImage)
		end,
	},
}
CoD.CarryInputPrompt.__onClose = function(f63_arg0)
	f63_arg0.ButtonPromptText:close()
	f63_arg0.ButtonPrompt:close()
	f63_arg0.ObjectiveWaypointText:close()
	f63_arg0.IconImage:close()
	f63_arg0.DirectionalArrow:close()
end
