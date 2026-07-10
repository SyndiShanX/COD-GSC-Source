require("x64:213d6270090adf7")
require("x64:aaed9cd2ddca5ff")
CoD.HUD_VehiclePrompt_Hold = InheritFrom(LUI.UIElement)
CoD.HUD_VehiclePrompt_Hold.__defaultWidth = 95
CoD.HUD_VehiclePrompt_Hold.__defaultHeight = 65
CoD.HUD_VehiclePrompt_Hold.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_VehiclePrompt_Hold)
	self.id = "HUD_VehiclePrompt_Hold"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(0, 1, 0, 0, 1, 1, -13, -3)
	label:setText(LocalizeToUpperString(0x0))
	label:setTTF("ttmussels_demibold")
	label:setLetterSpacing(2)
	label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	label:setBackingType(1)
	label:setBackingWidget(CoD.TextBacking, f1_arg0, f1_arg1)
	label:setBackingColor(0, 0, 0)
	label:setBackingXPadding(2)
	label:setBackingYPadding(1)
	self:addElement(label)
	self.label = label
	local HUDVehiclePromptContainer = nil
	HUDVehiclePromptContainer = CoD.HUD_VehiclePrompt_Container.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.11, 0.89, 7, -7)
	HUDVehiclePromptContainer.KBMText:setText(Engine[0xF9F1239CFD921FE](0xF17B1BF58DB2590))
	self:addElement(HUDVehiclePromptContainer)
	self.HUDVehiclePromptContainer = HUDVehiclePromptContainer
	local HoldArrow = LUI.UIImage.new(0.5, 0.5, -10, 10, 0, 0, -7, 13)
	HoldArrow:setAlpha(0)
	HoldArrow:setImage(RegisterImage(0xCB30D895D0912D1))
	self:addElement(HoldArrow)
	self.HoldArrow = HoldArrow
	self:mergeStateConditions({
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
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
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
CoD.HUD_VehiclePrompt_Hold.__resetProperties = function(f5_arg0)
	f5_arg0.label:completeAnimation()
	f5_arg0.HUDVehiclePromptContainer:completeAnimation()
	f5_arg0.HoldArrow:completeAnimation()
	f5_arg0.label:setAlpha(1)
	f5_arg0.HUDVehiclePromptContainer:setAlpha(1)
	f5_arg0.HoldArrow:setAlpha(0)
end
CoD.HUD_VehiclePrompt_Hold.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.label:completeAnimation()
			f6_arg0.label:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.label)
			f6_arg0.HUDVehiclePromptContainer:completeAnimation()
			f6_arg0.HUDVehiclePromptContainer:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.HUDVehiclePromptContainer)
			f6_arg0.HoldArrow:completeAnimation()
			f6_arg0.HoldArrow:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.HoldArrow)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.HUD_VehiclePrompt_Hold.__onClose = function(f8_arg0)
	f8_arg0.HUDVehiclePromptContainer:close()
end
