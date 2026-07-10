require("x64:f65b3780508b5c7")
CoD.VehicleHoldSwitchSeat = InheritFrom(LUI.UIElement)
CoD.VehicleHoldSwitchSeat.__defaultWidth = 200
CoD.VehicleHoldSwitchSeat.__defaultHeight = 48
CoD.VehicleHoldSwitchSeat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleHoldSwitchSeat)
	self.id = "VehicleHoldSwitchSeat"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(0, 0, 46, 200, 0, 0, 17, 31)
	label:setText(LocalizeToUpperString(0xCE3EF50B2B067C3))
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(2)
	label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LUI.OverrideFunction_CallOriginalFirst(label, "setState", function(element, controller, f2_arg2, f2_arg3, f2_arg4)
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
	progressRing:linkToElementModel(self, "progress", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			progressRing.progressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local BtnLabel = LUI.UIText.new(0, 0, 6, 36, 0, 0, 9, 39)
	BtnLabel:setText(LocalizeToUpperString(0x4E0796B86F15082))
	BtnLabel:setTTF("ttmussels_regular")
	BtnLabel:setLetterSpacing(2)
	BtnLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(BtnLabel)
	self.BtnLabel = BtnLabel
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showSwitchToDriverPrompt") and IsGamepad(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "showSwitchToDriverPrompt", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showSwitchToDriverPrompt",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f8_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f10_arg2, f10_arg3, f10_arg4)
		if IsSelfInState(self, "Visible") then
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
CoD.VehicleHoldSwitchSeat.__resetProperties = function(f11_arg0)
	f11_arg0.BtnLabel:completeAnimation()
	f11_arg0.progressRing:completeAnimation()
	f11_arg0.label:completeAnimation()
	f11_arg0.BtnLabel:setAlpha(1)
	f11_arg0.progressRing:setAlpha(1)
	f11_arg0.label:setAlpha(1)
end
CoD.VehicleHoldSwitchSeat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.label:completeAnimation()
			f12_arg0.label:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.label)
			f12_arg0.progressRing:completeAnimation()
			f12_arg0.progressRing:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.progressRing)
			f12_arg0.BtnLabel:completeAnimation()
			f12_arg0.BtnLabel:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BtnLabel)
		end,
	},
	Visible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.VehicleHoldSwitchSeat.__onClose = function(f14_arg0)
	f14_arg0.progressRing:close()
end
