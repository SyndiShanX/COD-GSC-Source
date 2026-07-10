require("x64:1394ae5e9cdcb54")
require("x64:99377e746b9e938")
require("x64:7e4c7adf0efc5a5")
CoD.HubTopTab = InheritFrom(LUI.UIElement)
CoD.HubTopTab.__defaultWidth = 600
CoD.HubTopTab.__defaultHeight = 36
CoD.HubTopTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubTopTab)
	self.id = "HubTopTab"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 103, 303, 0, 0, 17, 51)
	RB:setZoom(4)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -303, -103, 0, 0, 17, 51)
	LB:setZoom(4)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	local positions = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -58, 0, nil, nil, true, true, false, false)
	positions:setLeftRight(0.5, 0.5, -90, 90)
	positions:setTopBottom(0, 0, 16, 46)
	positions:setWidgetType(CoD.HubCharacterTabItem)
	positions:setSpacing(-58)
	positions:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	positions:setHorizontalPips(CoD.CommonScalingListHorizontalPips)
	positions:setFilter(function(f2_arg0)
		return f2_arg0.isBMLocked:get() ~= true
	end)
	positions:setDataSource("PositionLoadoutList")
	positions:registerEventHandler("list_active_changed", function(element, event)
		local f3_local0 = nil
		CoD.PlayerRoleUtility.UpdateSpecialist(f1_arg0, f1_arg1, element)
		CoD.BaseUtility.SetMenuModelToElementModel(f1_arg0, element)
		SetControllerModelValue(f1_arg1, "PositionLoadoutList.SelectedCharacterIndex", element.characterIndex)
		return f3_local0
	end)
	self:addElement(positions)
	self.positions = positions
	positions.id = "positions"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	f1_local4 = positions
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local4, f1_arg1)
	SetElementProperty(f1_local4, "__loopOnSameRow", true)
	SetElementProperty(f1_local4, "__allowCreateOnLoop", true)
	return self
end
CoD.HubTopTab.__onClose = function(f4_arg0)
	f4_arg0.RB:close()
	f4_arg0.LB:close()
	f4_arg0.positions:close()
end
