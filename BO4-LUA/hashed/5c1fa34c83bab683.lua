require("x64:213d6270090adf7")
require("x64:aaed9cd2ddca5ff")
CoD.HUD_VehiclePrompt = InheritFrom(LUI.UIElement)
CoD.HUD_VehiclePrompt.__defaultWidth = 95
CoD.HUD_VehiclePrompt.__defaultHeight = 65
CoD.HUD_VehiclePrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_VehiclePrompt)
	self.id = "HUD_VehiclePrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(-0.04, 1.04, 0, 0, 1, 1, -13, -3)
	label:setTTF("ttmussels_demibold")
	label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	label:setBackingType(1)
	label:setBackingWidget(CoD.TextBacking, f1_arg0, f1_arg1)
	label:setBackingColor(0, 0, 0)
	label:setBackingXPadding(2)
	label:setBackingYPadding(1)
	label._backingElement.Blur:setAlpha(1)
	label._backingElement.Backing:setRGB(0, 0, 0)
	label:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			label:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(label)
	self.label = label
	local HUDVehiclePromptContainer = CoD.HUD_VehiclePrompt_Container.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.12, 0.88, 7, -7)
	HUDVehiclePromptContainer:linkToElementModel(self, "bind", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HUDVehiclePromptContainer.KBMText:setText(f3_local0)
		end
	end)
	self:addElement(HUDVehiclePromptContainer)
	self.HUDVehiclePromptContainer = HUDVehiclePromptContainer
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "text") and CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "bind")
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
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
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
CoD.HUD_VehiclePrompt.__resetProperties = function(f8_arg0)
	f8_arg0.label:completeAnimation()
	f8_arg0.HUDVehiclePromptContainer:completeAnimation()
	f8_arg0.label:setAlpha(1)
	f8_arg0.HUDVehiclePromptContainer:setAlpha(1)
end
CoD.HUD_VehiclePrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.label:completeAnimation()
			f9_arg0.label:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.label)
			f9_arg0.HUDVehiclePromptContainer:completeAnimation()
			f9_arg0.HUDVehiclePromptContainer:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.HUDVehiclePromptContainer)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.label:completeAnimation()
			f10_arg0.label:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.label)
			f10_arg0.HUDVehiclePromptContainer:completeAnimation()
			f10_arg0.HUDVehiclePromptContainer:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.HUDVehiclePromptContainer)
		end,
	},
}
CoD.HUD_VehiclePrompt.__onClose = function(f11_arg0)
	f11_arg0.label:close()
	f11_arg0.HUDVehiclePromptContainer:close()
end
