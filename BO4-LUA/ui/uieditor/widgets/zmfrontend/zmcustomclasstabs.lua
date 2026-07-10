require("x64:1394ae5e9cdcb54")
require("x64:9c626a0110d2a99")
CoD.ZMCustomClassTabs = InheritFrom(LUI.UIElement)
CoD.ZMCustomClassTabs.__defaultWidth = 1920
CoD.ZMCustomClassTabs.__defaultHeight = 98
CoD.ZMCustomClassTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMCustomClassTabs)
	self.id = "ZMCustomClassTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 515, 715, 0, 0, 14, 48)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -715, -515, 0, 0, 14, 48)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	local customClasssList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	customClasssList:setLeftRight(0.5, 0.5, -510, 510)
	customClasssList:setTopBottom(0, 0, 16, 51)
	customClasssList:setWidgetType(CoD.CustomClassListButton)
	customClasssList:setHorizontalCount(6)
	customClasssList:setSpacing(0)
	customClasssList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	customClasssList:setStaggeredIntroTime(50)
	customClasssList:setDataSource("ChooseClassList")
	customClasssList:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		CoD.ZMLoadoutUtility.PreviewBubbleGumPack(element, f1_arg1, f1_arg0)
		CoD.BaseUtility.SetMenuModelToElementModel(f1_arg0, element)
		CoD.CACUtility.UpdateLockedStateForCustomClass(f1_arg0, f1_arg1)
		UpdateButtonPromptState(f1_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		return f2_local0
	end)
	self.__on_menuOpened_customClasssList = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = customClasssList
		CoD.CACUtility.SetActiveListItemToSelectedClass(f3_arg1, f3_arg2, f3_local0)
		CoD.BaseUtility.SetMenuModelToElementModel(f3_arg2, f3_local0)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_customClasssList)
	customClasssList:subscribeToGlobalModel(f1_arg1, "PerController", "selectedZMStory", function(model)
		UpdateDataSource(self, customClasssList, f1_arg1)
	end)
	self:addElement(customClasssList)
	self.customClasssList = customClasssList
	customClasssList.id = "customClasssList"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_customClasssList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	if IsPC() then
		ChangeHorizontalCount(self.customClasssList, 6)
	end
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, customClasssList, f1_arg1)
	return self
end
CoD.ZMCustomClassTabs.__onClose = function(f6_arg0)
	f6_arg0.__on_close_removeOverrides()
	f6_arg0.RB:close()
	f6_arg0.LB:close()
	f6_arg0.customClasssList:close()
end
