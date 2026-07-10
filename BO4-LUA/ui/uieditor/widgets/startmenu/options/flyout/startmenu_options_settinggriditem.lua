require("x64:6e37b4dc09c830f")
require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.StartMenu_Options_SettingGridItem = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SettingGridItem.__defaultWidth = 300
CoD.StartMenu_Options_SettingGridItem.__defaultHeight = 60
CoD.StartMenu_Options_SettingGridItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SettingGridItem)
	self.id = "StartMenu_Options_SettingGridItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.13, 0.12, 0.12)
	Backing:setAlpha(0.6)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 0, 0, 0, 60)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Corner)
	self.Corner = Corner
	local SettingLabel = LUI.UIText.new(0, 0, 15, 275, 0, 0, 17.5, 42.5)
	SettingLabel:setAlpha(0.25)
	SettingLabel:setTTF("ttmussels_regular")
	SettingLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SettingLabel:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	SettingLabel:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SettingLabel:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(SettingLabel)
	self.SettingLabel = SettingLabel
	local CustomSettingsIndicator = CoD.StartMenu_Options_CustomSettingsIndicator.new(f1_arg0, f1_arg1, 0, 0, 3, 7, 0, 0, 3, 57)
	CustomSettingsIndicator:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDefault")
			end,
		},
	})
	CustomSettingsIndicator:linkToElementModel(CustomSettingsIndicator, "isDefault", true, function(model)
		f1_arg0:updateElementState(CustomSettingsIndicator, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isDefault",
		})
	end)
	CustomSettingsIndicator:linkToElementModel(self, nil, false, function(model)
		CustomSettingsIndicator:setModel(model, f1_arg1)
	end)
	self:addElement(CustomSettingsIndicator)
	self.CustomSettingsIndicator = CustomSettingsIndicator
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		if CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BUTTONS) then
			CoD.OptionsUtility.SetButtonLayoutPreview(element, f1_arg1)
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_STICKS) then
			CoD.OptionsUtility.SetStickLayoutPreview(element, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SettingGridItem.__resetProperties = function(f7_arg0)
	f7_arg0.CustomSettingsIndicator:completeAnimation()
	f7_arg0.Backing:completeAnimation()
	f7_arg0.Corner:completeAnimation()
	f7_arg0.Frame:completeAnimation()
	f7_arg0.SettingLabel:completeAnimation()
	f7_arg0.CustomSettingsIndicator:setAlpha(1)
	f7_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f7_arg0.Backing:setAlpha(0.6)
	f7_arg0.Corner:setScale(1, 1)
	f7_arg0.Frame:setAlpha(0.04)
	f7_arg0.SettingLabel:setLeftRight(0, 0, 15, 275)
	f7_arg0.SettingLabel:setTopBottom(0, 0, 17.5, 42.5)
	f7_arg0.SettingLabel:setRGB(1, 1, 1)
	f7_arg0.SettingLabel:setAlpha(0.25)
end
CoD.StartMenu_Options_SettingGridItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.CustomSettingsIndicator:completeAnimation()
			f8_arg0.CustomSettingsIndicator:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CustomSettingsIndicator)
		end,
		Focus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.Backing:completeAnimation()
			f9_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f9_arg0.Backing:setAlpha(0.2)
			f9_arg0.clipFinished(f9_arg0.Backing)
			f9_arg0.Frame:completeAnimation()
			f9_arg0.Frame:setAlpha(0.6)
			f9_arg0.clipFinished(f9_arg0.Frame)
			f9_arg0.Corner:completeAnimation()
			f9_arg0.Corner:setScale(0.96, 0.84)
			f9_arg0.clipFinished(f9_arg0.Corner)
			f9_arg0.CustomSettingsIndicator:completeAnimation()
			f9_arg0.CustomSettingsIndicator:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CustomSettingsIndicator)
		end,
		GainFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			local f10_local0 = function(f11_arg0)
				f10_arg0.Backing:beginAnimation(150)
				f10_arg0.Backing:setAlpha(0.2)
				f10_arg0.Backing:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Backing:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f10_arg0.Backing:setAlpha(0.1)
			f10_local0(f10_arg0.Backing)
			local f10_local1 = function(f12_arg0)
				f10_arg0.Frame:beginAnimation(150)
				f10_arg0.Frame:setAlpha(0.6)
				f10_arg0.Frame:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Frame:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Frame:completeAnimation()
			f10_arg0.Frame:setAlpha(0.04)
			f10_local1(f10_arg0.Frame)
			local f10_local2 = function(f13_arg0)
				f10_arg0.Corner:beginAnimation(150)
				f10_arg0.Corner:setScale(0.96, 0.84)
				f10_arg0.Corner:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Corner:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Corner:completeAnimation()
			f10_arg0.Corner:setScale(1, 1)
			f10_local2(f10_arg0.Corner)
			f10_arg0.CustomSettingsIndicator:completeAnimation()
			f10_arg0.CustomSettingsIndicator:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CustomSettingsIndicator)
		end,
	},
	Active = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.Backing:completeAnimation()
			f14_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f14_arg0.Backing:setAlpha(0.2)
			f14_arg0.clipFinished(f14_arg0.Backing)
			f14_arg0.Frame:completeAnimation()
			f14_arg0.Frame:setAlpha(0.6)
			f14_arg0.clipFinished(f14_arg0.Frame)
			f14_arg0.SettingLabel:completeAnimation()
			f14_arg0.SettingLabel:setLeftRight(0, 0, 15, 275)
			f14_arg0.SettingLabel:setTopBottom(0, 0, 17.5, 42.5)
			f14_arg0.SettingLabel:setRGB(0.78, 0.74, 0.67)
			f14_arg0.SettingLabel:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.SettingLabel)
			f14_arg0.CustomSettingsIndicator:completeAnimation()
			f14_arg0.CustomSettingsIndicator:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.CustomSettingsIndicator)
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.Backing:completeAnimation()
			f15_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f15_arg0.Backing:setAlpha(0.2)
			f15_arg0.clipFinished(f15_arg0.Backing)
			f15_arg0.SettingLabel:completeAnimation()
			f15_arg0.SettingLabel:setLeftRight(0, 0, 15, 275)
			f15_arg0.SettingLabel:setTopBottom(0, 0, 17.5, 42.5)
			f15_arg0.SettingLabel:setRGB(0.78, 0.74, 0.67)
			f15_arg0.SettingLabel:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.SettingLabel)
			f15_arg0.CustomSettingsIndicator:completeAnimation()
			f15_arg0.CustomSettingsIndicator:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.CustomSettingsIndicator)
		end,
	},
}
CoD.StartMenu_Options_SettingGridItem.__onClose = function(f16_arg0)
	f16_arg0.Frame:close()
	f16_arg0.Corner:close()
	f16_arg0.SettingLabel:close()
	f16_arg0.CustomSettingsIndicator:close()
end
