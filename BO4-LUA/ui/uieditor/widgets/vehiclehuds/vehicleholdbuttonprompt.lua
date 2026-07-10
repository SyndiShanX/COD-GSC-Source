require("x64:f65b3780508b5c7")
CoD.VehicleHoldButtonPrompt = InheritFrom(LUI.UIElement)
CoD.VehicleHoldButtonPrompt.__defaultWidth = 200
CoD.VehicleHoldButtonPrompt.__defaultHeight = 48
CoD.VehicleHoldButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleHoldButtonPrompt)
	self.id = "VehicleHoldButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 6, 36, 0, 0, 9, 39)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0, 0, 46, 200, 0, 0, 16, 30)
	label:setText(LocalizeToUpperString(0x0))
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(2)
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(label, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, -35)
	end)
	self:addElement(label)
	self.label = label
	local progressRing = CoD.ButtonProgressRing.new(f1_arg0, f1_arg1, 0, 0, 0, 42, 0, 0, 3, 45)
	progressRing:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "holdToExitProgress")
			end,
		},
	})
	progressRing:linkToElementModel(progressRing, "holdToExitProgress", true, function(model)
		f1_arg0:updateElementState(progressRing, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "holdToExitProgress",
		})
	end)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f1_arg1)
	end)
	progressRing:linkToElementModel(self, "holdToExitProgress", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			progressRing.progressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local KeyboardAction = nil
	KeyboardAction = LUI.UIText.new(0, 0, 4.5, 37.5, 0, 0, 5, 43)
	KeyboardAction:setRGB(1, 1, 0.5)
	KeyboardAction:setAlpha(0)
	KeyboardAction:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F17B1BF58DB2590"))
	KeyboardAction:setTTF("default")
	KeyboardAction:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KeyboardAction:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(KeyboardAction)
	self.KeyboardAction = KeyboardAction
	self:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "enableVehicleExitPrompt") and not IsGamepad(f1_arg1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "enableVehicleExitPrompt")
			end,
		},
	})
	self:linkToElementModel(self, "enableVehicleExitPrompt", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "enableVehicleExitPrompt",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f10_arg1)
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f12_arg2, f12_arg3, f12_arg4)
		if IsSelfInState(self, "Visible") then
			ShowWidget(element)
		elseif IsSelfInState(self, "VisiblePC") then
			ShowWidget(element)
		else
			HideWidget(element)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleHoldButtonPrompt.__resetProperties = function(f13_arg0)
	f13_arg0.label:completeAnimation()
	f13_arg0.buttonPromptImage:completeAnimation()
	f13_arg0.progressRing:completeAnimation()
	f13_arg0.KeyboardAction:completeAnimation()
	f13_arg0.label:setLeftRight(0, 0, 46, 200)
	f13_arg0.label:setTopBottom(0, 0, 16, 30)
	f13_arg0.label:setAlpha(1)
	f13_arg0.buttonPromptImage:setAlpha(1)
	f13_arg0.progressRing:setLeftRight(0, 0, 0, 42)
	f13_arg0.progressRing:setTopBottom(0, 0, 3, 45)
	f13_arg0.progressRing:setAlpha(1)
	f13_arg0.KeyboardAction:setLeftRight(0, 0, 4.5, 37.5)
	f13_arg0.KeyboardAction:setTopBottom(0, 0, 5, 43)
	f13_arg0.KeyboardAction:setAlpha(0)
	f13_arg0.KeyboardAction:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
end
CoD.VehicleHoldButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.buttonPromptImage:completeAnimation()
			f14_arg0.buttonPromptImage:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.buttonPromptImage)
			f14_arg0.label:completeAnimation()
			f14_arg0.label:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.label)
			f14_arg0.progressRing:completeAnimation()
			f14_arg0.progressRing:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.progressRing)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.buttonPromptImage:completeAnimation()
			f15_arg0.buttonPromptImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.buttonPromptImage)
			f15_arg0.label:completeAnimation()
			f15_arg0.label:setLeftRight(0, 0, 19, 173)
			f15_arg0.label:setTopBottom(0, 0, 10, 24)
			f15_arg0.clipFinished(f15_arg0.label)
			f15_arg0.progressRing:completeAnimation()
			f15_arg0.progressRing:setLeftRight(0, 0, -15, 27)
			f15_arg0.progressRing:setTopBottom(0, 0, -2, 40)
			f15_arg0.progressRing:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.progressRing)
			f15_arg0.KeyboardAction:completeAnimation()
			f15_arg0.KeyboardAction:setLeftRight(0, 0, -66, 10)
			f15_arg0.KeyboardAction:setTopBottom(0.5, 0.5, -22.5, 4.5)
			f15_arg0.KeyboardAction:setAlpha(1)
			f15_arg0.KeyboardAction:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f15_arg0.clipFinished(f15_arg0.KeyboardAction)
		end,
	},
	Visible = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
}
if not CoD.isPC then
	CoD.VehicleHoldButtonPrompt.__clipsPerState.VisiblePC.DefaultClip = nil
end
CoD.VehicleHoldButtonPrompt.__onClose = function(f17_arg0)
	f17_arg0.progressRing:close()
end
