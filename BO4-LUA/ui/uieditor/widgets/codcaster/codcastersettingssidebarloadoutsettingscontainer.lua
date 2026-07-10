require("x64:193addd21eecdda")
require("x64:d5504359f8c0fcd")
CoD.CodCasterSettingsSideBarLoadoutSettingsContainer = InheritFrom(LUI.UIElement)
CoD.CodCasterSettingsSideBarLoadoutSettingsContainer.__defaultWidth = 700
CoD.CodCasterSettingsSideBarLoadoutSettingsContainer.__defaultHeight = 789
CoD.CodCasterSettingsSideBarLoadoutSettingsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 30, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.CodCasterSettingsSideBarLoadoutSettingsContainer)
	self.id = "CodCasterSettingsSideBarLoadoutSettingsContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ButtonList = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0, 0, 0, 700)
	ButtonList:setTopBottom(0, 0, 0, 670)
	ButtonList:setWidgetType(CoD.StartMenu_Options_SettingSlider)
	ButtonList:setVerticalCount(13)
	ButtonList:setSpacing(6)
	ButtonList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		GameSettingsButtonGainFocus(self, element, f1_arg1)
		return f2_local0
	end)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	local OptionDesc = CoD.CodCasterSettingsSideBarSettingsText.new(f1_arg0, f1_arg1, 0, 0, 0, 700, 0, 0, 700, 760)
	self:addElement(OptionDesc)
	self.OptionDesc = OptionDesc
	ButtonList.id = "ButtonList"
	self.__defaultFocus = ButtonList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	SetElementCanBeNavigatedTo(ButtonList, false)
	return self
end
CoD.CodCasterSettingsSideBarLoadoutSettingsContainer.__onClose = function(f3_arg0)
	f3_arg0.ButtonList:close()
	f3_arg0.OptionDesc:close()
end
