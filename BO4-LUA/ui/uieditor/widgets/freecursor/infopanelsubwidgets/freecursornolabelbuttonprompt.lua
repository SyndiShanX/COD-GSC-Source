require("x64:4fb5d5732c72812")
CoD.freeCursorNoLabelButtonPrompt = InheritFrom(LUI.UIElement)
CoD.freeCursorNoLabelButtonPrompt.__defaultWidth = 36
CoD.freeCursorNoLabelButtonPrompt.__defaultHeight = 36
CoD.freeCursorNoLabelButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorNoLabelButtonPrompt)
	self.id = "freeCursorNoLabelButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.08, 0.08, 0.08)
	self:addElement(backing)
	self.backing = backing
	local progressRing = CoD.ButtonProgressRingContainer.new(f1_arg0, f1_arg1, 0, 0, -3, 39, 0, 0, -3, 39)
	progressRing:setScale(0.81, 0.81)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f1_arg1)
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local buttonPromptImage = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	self:mergeStateConditions({
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[0xF4865E3551C3835][0x901DFC093ED4187])
				if f3_local0 then
					f3_local0 = IsGamepad(f1_arg1)
					if f3_local0 then
						f3_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3])
					end
				end
				return f3_local0
			end,
		},
	})
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "flags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		if IsInDefaultState(self) then
			HideWidget(self)
		else
			ShowWidget(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.freeCursorNoLabelButtonPrompt.__resetProperties = function(f9_arg0)
	f9_arg0.buttonPromptImage:completeAnimation()
	f9_arg0.buttonPromptImage:setAlpha(1)
end
CoD.freeCursorNoLabelButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.buttonPromptImage:completeAnimation()
			f10_arg0.buttonPromptImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.buttonPromptImage)
		end,
	},
	Enabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.buttonPromptImage:completeAnimation()
			f11_arg0.buttonPromptImage:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.buttonPromptImage)
		end,
	},
}
CoD.freeCursorNoLabelButtonPrompt.__onClose = function(f12_arg0)
	f12_arg0.progressRing:close()
end
