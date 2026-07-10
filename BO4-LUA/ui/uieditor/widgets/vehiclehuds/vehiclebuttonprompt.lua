CoD.VehicleButtonPrompt = InheritFrom(LUI.UIElement)
CoD.VehicleButtonPrompt.__defaultWidth = 200
CoD.VehicleButtonPrompt.__defaultHeight = 48
CoD.VehicleButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleButtonPrompt)
	self.id = "VehicleButtonPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(0, 0, 53, 200, 0, 0, 16, 30)
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(2)
	label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	label:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			label:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(label, "setText", function(element, controller)
		if not IsPC() then
			ScaleWidgetToLabel(self, element, -35)
		end
	end)
	self:addElement(label)
	self.label = label
	local BindLabel = LUI.UIText.new(0, 0, 10, 40, 0, 0, 9, 39)
	BindLabel:setTTF("ttmussels_regular")
	BindLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	BindLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	BindLabel:linkToElementModel(self, "bind", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BindLabel:setText(f4_local0)
		end
	end)
	self:addElement(BindLabel)
	self.BindLabel = BindLabel
	self:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "text")
				if f5_local0 then
					f5_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "bind")
					if f5_local0 then
						f5_local0 = IsPC()
						if f5_local0 then
							f5_local0 = IsGamepad(f1_arg1)
						end
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "text")
				if f6_local0 then
					f6_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "bind")
					if f6_local0 then
						f6_local0 = not IsPC()
					end
				end
				return f6_local0
			end,
		},
	})
	self:linkToElementModel(self, "text", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	self:linkToElementModel(self, "bind", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bind",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f11_arg2, f11_arg3, f11_arg4)
		if IsSelfInState(self, "Visible") and not IsPC() then
			ShowWidget(element)
		elseif IsSelfInState(self, "VisiblePC") and IsPC() then
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
CoD.VehicleButtonPrompt.__resetProperties = function(f12_arg0)
	f12_arg0.label:completeAnimation()
	f12_arg0.BindLabel:completeAnimation()
	f12_arg0.label:setAlpha(1)
	f12_arg0.BindLabel:setRGB(1, 1, 1)
	f12_arg0.BindLabel:setAlpha(1)
end
CoD.VehicleButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.label:completeAnimation()
			f13_arg0.label:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.label)
			f13_arg0.BindLabel:completeAnimation()
			f13_arg0.BindLabel:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BindLabel)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.label:completeAnimation()
			f14_arg0.label:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.label)
		end,
	},
	Visible = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.label:completeAnimation()
			f15_arg0.label:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.label)
			f15_arg0.BindLabel:completeAnimation()
			f15_arg0.BindLabel:setRGB(1, 1, 0.5)
			f15_arg0.BindLabel:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.BindLabel)
		end,
	},
}
CoD.VehicleButtonPrompt.__onClose = function(f16_arg0)
	f16_arg0.label:close()
	f16_arg0.BindLabel:close()
end
