require("x64:d4a0e411c595898")
require("x64:48be5c6feaceeb4")
require("x64:f93e6387e9d051")
require("x64:a83717e9f99925a")
CoD.StartMenu_Options_Frame_Graphics = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Frame_Graphics.__defaultWidth = 1920
CoD.StartMenu_Options_Frame_Graphics.__defaultHeight = 890
CoD.StartMenu_Options_Frame_Graphics.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Frame_Graphics)
	self.id = "StartMenu_Options_Frame_Graphics"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OptionInfo = CoD.StartMenu_Options_SettingInfo.new(f1_arg0, f1_arg1, 0, 0, 912, 1812, 0, 0, 40, 144)
	self:addElement(OptionInfo)
	self.OptionInfo = OptionInfo
	local OptionGroups = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	OptionGroups:setLeftRight(0, 0, 100, 800)
	OptionGroups:setTopBottom(0, 0, 0, 998)
	OptionGroups:setWidgetType(CoD.StartMenu_Options_SettingSlider_Wrapper)
	OptionGroups:setVerticalCount(18)
	OptionGroups:setSpacing(10)
	OptionGroups:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionGroups:setDataSource("PlayerSettingsGraphicsList")
	OptionGroups:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		if CoD.OptionsUtility.IsBrightnessSetting(element, f1_arg1) then
			SetState(self, "BrightnessSettings", f1_arg1)
		elseif CoD.OptionsUtility.IsColorblindSetting(element, f1_arg1) then
			SetState(self, "ColorblindSettings", f1_arg1)
		else
			SetState(self, "DefaultState", f1_arg1)
		end
		return f2_local0
	end)
	OptionGroups:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionGroups, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if HasListAction(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasListAction(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(OptionGroups)
	self.OptionGroups = OptionGroups
	local ColorblindPreview = CoD.StartMenu_Options_Graphics_ColorBlindMinimapPreview.new(f1_arg0, f1_arg1, 0, 0, 987, 1737, 0, 0, 303, 703)
	ColorblindPreview:setZoom(40)
	self:addElement(ColorblindPreview)
	self.ColorblindPreview = ColorblindPreview
	local BrightnessPreview = CoD.FirstTimeBrightnessPreview.new(f1_arg0, f1_arg1, 0, 0, 1056, 1668, 0, 0, 183, 823)
	self:addElement(BrightnessPreview)
	self.BrightnessPreview = BrightnessPreview
	self:mergeStateConditions({
		{
			stateName = "BrightnessSettings",
			condition = function(menu, element, event)
				return IsSelfInState(self, "BrightnessSettings")
			end,
		},
		{
			stateName = "ColorblindSettings",
			condition = function(menu, element, event)
				return IsSelfInState(self, "ColorblindSettings")
			end,
		},
	})
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		CoD.OptionsUtility.ResetPlayerSettingsGroupListToDefault(controller, self.OptionGroups)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x5D33EEAEB171341, Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 750 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], nil)
		return true
	end, false)
	OptionGroups.id = "OptionGroups"
	self.__defaultFocus = OptionGroups
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Frame_Graphics.__resetProperties = function(f10_arg0)
	f10_arg0.ColorblindPreview:completeAnimation()
	f10_arg0.BrightnessPreview:completeAnimation()
	f10_arg0.ColorblindPreview:setAlpha(1)
	f10_arg0.BrightnessPreview:setAlpha(1)
end
CoD.StartMenu_Options_Frame_Graphics.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.ColorblindPreview:completeAnimation()
			f11_arg0.ColorblindPreview:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ColorblindPreview)
			f11_arg0.BrightnessPreview:completeAnimation()
			f11_arg0.BrightnessPreview:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BrightnessPreview)
		end,
	},
	BrightnessSettings = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.ColorblindPreview:completeAnimation()
			f12_arg0.ColorblindPreview:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ColorblindPreview)
		end,
	},
	ColorblindSettings = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.BrightnessPreview:completeAnimation()
			f13_arg0.BrightnessPreview:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BrightnessPreview)
		end,
	},
}
CoD.StartMenu_Options_Frame_Graphics.__onClose = function(f14_arg0)
	f14_arg0.OptionInfo:close()
	f14_arg0.OptionGroups:close()
	f14_arg0.ColorblindPreview:close()
	f14_arg0.BrightnessPreview:close()
end
