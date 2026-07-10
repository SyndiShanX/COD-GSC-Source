require("x64:3b3f564e4b422b")
require("x64:861b15626f96605")
local PostLoadFunc = function(self, controller)
	local f1_local0 = function()
		self.buttonList:updateDataSource(true)
	end
	local f1_local1 = self
	local f1_local2 = self.subscribeToModel
	local f1_local3 = Engine[0x4DF5CFBC1771947](controller)
	f1_local2(f1_local1, f1_local3:create("Clients.clientCount"), function(f3_arg0)
		f1_local0()
	end)
	f1_local1 = self
	f1_local2 = self.subscribeToModel
	f1_local3 = Engine[0x4DF5CFBC1771947](controller)
	f1_local2(f1_local1, f1_local3:create("Clients.clientChangedTeam"), function(f4_arg0)
		f1_local0()
	end)
	f1_local1 = self
	f1_local2 = self.subscribeToModel
	f1_local3 = Engine[0x4DF5CFBC1771947](controller)
	f1_local2(f1_local1, f1_local3:create("CharacterSelection.clientUpdated"), function(f5_arg0)
		f1_local0()
	end)
end
CoD.StartMenu_ChangeTeam = InheritFrom(LUI.UIElement)
CoD.StartMenu_ChangeTeam.__defaultWidth = 1725
CoD.StartMenu_ChangeTeam.__defaultHeight = 780
CoD.StartMenu_ChangeTeam.new = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8, f6_arg9)
	local self = LUI.UIElement.new(f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8, f6_arg9)
	self:setClass(CoD.StartMenu_ChangeTeam)
	self.id = "StartMenu_ChangeTeam"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local playerList = LUI.UIList.new(f6_arg0, f6_arg1, 2, 0, nil, false, false, false, false)
	playerList:setLeftRight(0.5, 0.5, 50, 650)
	playerList:setTopBottom(0, 0, 150, 850)
	playerList:setWidgetType(CoD.InGamePlayerListRow)
	playerList:setVerticalCount(18)
	playerList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	playerList:setDataSource("InGamePlayerListRowData")
	self:addElement(playerList)
	self.playerList = playerList
	local buttonList = LUI.UIList.new(f6_arg0, f6_arg1, 26, 0, nil, false, false, false, false)
	buttonList:setLeftRight(0.5, 0.5, -644, 8)
	buttonList:setTopBottom(0, 0, 150, 576)
	buttonList:setWidgetType(CoD.StartMenu_ChangeTeam_ListWidget)
	buttonList:setHorizontalCount(3)
	buttonList:setVerticalCount(2)
	buttonList:setSpacing(26)
	buttonList:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	buttonList:setDataSource("ChangeTeamOptions")
	buttonList:linkToElementModel(buttonList, "disabled", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f6_arg0, f6_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	buttonList:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f6_arg0, f6_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f6_arg0:AddButtonCallbackFunction(buttonList, f6_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x2641978FD3DC17A, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(buttonList)
	self.buttonList = buttonList
	playerList.id = "playerList"
	buttonList.id = "buttonList"
	self.__defaultFocus = buttonList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f6_arg1, f6_arg0)
	end
	return self
end
CoD.StartMenu_ChangeTeam.__onClose = function(f11_arg0)
	f11_arg0.playerList:close()
	f11_arg0.buttonList:close()
end
