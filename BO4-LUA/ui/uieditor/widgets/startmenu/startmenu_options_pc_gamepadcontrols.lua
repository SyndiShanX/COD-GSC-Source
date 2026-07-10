require("x64:84662ffcdea628")
require("x64:9882d5cfd382409")
local PostLoadFunc = function(self, controller)
	self:dispatchEventToChildren({
		name = "options_refresh",
		controller = controller,
	})
end
CoD.StartMenu_Options_PC_GamepadControls = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_GamepadControls.__defaultWidth = 1650
CoD.StartMenu_Options_PC_GamepadControls.__defaultHeight = 900
CoD.StartMenu_Options_PC_GamepadControls.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setClass(CoD.StartMenu_Options_PC_GamepadControls)
	self.id = "StartMenu_Options_PC_GamepadControls"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local keybindList = LUI.UIList.new(f2_arg0, f2_arg1, 0, 0, nil, false, false, false, false)
	keybindList:setLeftRight(0, 0, 0, 750)
	keybindList:setTopBottom(0, 0, 45, 402)
	keybindList:setWidgetType(CoD.StartMenu_Options_CheckBoxOption)
	keybindList:setVerticalCount(7)
	keybindList:setSpacing(0)
	keybindList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	keybindList:setDataSource("OptionGamepadSettingsPC")
	self:addElement(keybindList)
	self.keybindList = keybindList
	local optionInfo = CoD.OptionInfoWidget.new(f2_arg0, f2_arg1, 0, 0, 825, 1425, 0, 0, 45, 495)
	self:addElement(optionInfo)
	self.optionInfo = optionInfo
	optionInfo:linkToElementModel(keybindList, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			optionInfo.description:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	optionInfo:linkToElementModel(keybindList, "label", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			optionInfo.title.itemName:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	keybindList.id = "keybindList"
	self.__defaultFocus = keybindList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_GamepadControls.__onClose = function(f5_arg0)
	f5_arg0.optionInfo:close()
	f5_arg0.keybindList:close()
end
